import { NextResponse } from "next/server";
import { verifyAccess } from "@/app/utils/jwt";
import { prisma } from "@/app/utils/db";

function getAuthHeader(req: Request) {
  const h = req.headers.get("authorization") || "";
  const m = h.match(/^Bearer\s+(.+)$/i);
  return m?.[1];
}

export async function GET(req: Request) {
  try {
    const token = getAuthHeader(req);
    if (!token) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

    const { id } = verifyAccess(token);

    // First get basic user data
    const basicUser = await prisma.user.findUnique({
      where: { id },
      select: {
        id: true,
        name: true,
        email: true,
        emailVerified: true,
        image: true,
        userType: true,
        adminRole: true,
        jobCount: true,
        aiJobApplyCount: true,
        createdAt: true,
        updatedAt: true,
        referralCode: true,
        referredBy: true,
        resetToken: true,
        resetTokenExpiry: true,
      },
    });

    if (!basicUser) return NextResponse.json({ error: "Not found" }, { status: 404 });

    // Get candidate profile if user is a candidate
    let candidateProfile = null;
    if (basicUser.userType === 'CANDIDATE') {
      const candidate = await prisma.candidate.findUnique({
        where: { userId: id },
        select: {
          profile: true,
        },
      });
      candidateProfile = candidate?.profile || null;
    }

    // Get recruiter profile if user is a recruiter
    let recruiterProfile = null;
    if (basicUser.userType === 'RECRUITER') {
      recruiterProfile = await prisma.recruiter.findUnique({
        where: { userId: id },
        select: {
          id: true,
          companyName: true,
          contactPersonName: true,
          phone: true,
        },
      });
    }

    // Get owner profile if user is an admin
    let ownerProfile = null;
    if (basicUser.userType === 'ADMIN') {
      ownerProfile = await prisma.owner.findUnique({
        where: { userId: id },
        select: {
          id: true,
          phone: true,
        },
      });
    }

    // Get subscription information
    const subscription = await prisma.subscription.findFirst({
      where: { userId: id },
      select: {
        plan: true,
        status: true,
        startDate: true,
        endDate: true,
        autoRenew: true,
      },
      orderBy: { createdAt: 'desc' },
    });

    // Get admin permissions (for admin users)
    let adminPermissions = [];
    if (basicUser.userType === 'ADMIN') {
      const permissions = await prisma.adminPermissionAssignment.findMany({
        where: { userId: id },
        select: { permission: true },
      });
      adminPermissions = permissions.map(p => p.permission);
    }

    // Get payment statistics
    const [paymentsCount, totalAmount] = await Promise.all([
      prisma.payment.count({
        where: {
          userId: id,
          status: 'COMPLETED',
        },
      }),
      prisma.payment.aggregate({
        where: {
          userId: id,
          status: 'COMPLETED',
        },
        _sum: { amount: true },
      }),
    ]);

    // Get job statistics (for recruiters and owners)
    let jobStats = null;
    if (basicUser.userType === 'RECRUITER') {
      const recruiter = await prisma.recruiter.findUnique({
        where: { userId: id },
        select: { id: true },
      });
      if (recruiter) {
        const [totalJobs, activeJobs, applicationsReceived] = await Promise.all([
          prisma.job.count({ where: { recruiterId: recruiter.id } }),
          prisma.job.count({ where: { recruiterId: recruiter.id, status: 'ACTIVE' } }),
          prisma.jobApplication.count({
            where: { Job: { recruiterId: recruiter.id } },
          }),
        ]);
        jobStats = { totalJobs, activeJobs, applicationsReceived };
      }
    } else if (basicUser.userType === 'ADMIN') {
      const owner = await prisma.owner.findUnique({
        where: { userId: id },
        select: { id: true },
      });
      if (owner) {
        const [totalJobs, activeJobs, applicationsReceived] = await Promise.all([
          prisma.job.count({ where: { ownerId: owner.id } }),
          prisma.job.count({ where: { ownerId: owner.id, status: 'ACTIVE' } }),
          prisma.jobApplication.count({
            where: { Job: { ownerId: owner.id } },
          }),
        ]);
        jobStats = { totalJobs, activeJobs, applicationsReceived };
      }
    }

    // Get connected social accounts
    const connectedAccounts = await prisma.account.findMany({
      where: { userId: id },
      select: {
        provider: true,
        createdAt: true,
      },
    });

    // Get AI resume statistics (for candidates)
    let aiResumeStats = null;
    if (basicUser.userType === 'CANDIDATE') {
      const candidate = await prisma.candidate.findUnique({
        where: { userId: id },
        select: { id: true },
      });
      if (candidate) {
        const [totalAiResumes, draftAiResumes, inProgressAiResumes, completedAiResumes] = await Promise.all([
          prisma.aiResume.count({ where: { candidateId: candidate.id } }),
          prisma.aiResume.count({ where: { candidateId: candidate.id, status: 'DRAFT' } }),
          prisma.aiResume.count({ where: { candidateId: candidate.id, status: 'IN_PROGRESS' } }),
          prisma.aiResume.count({ where: { candidateId: candidate.id, status: 'COMPLETED' } }),
        ]);
        aiResumeStats = {
          total: totalAiResumes,
          draft: draftAiResumes,
          inProgress: inProgressAiResumes,
          completed: completedAiResumes,
        };
      }
    }

    // Get active sessions count
    const activeSessions = await prisma.session.count({
      where: { userId: id },
    });

    // Get counts
    const [resumesCount, applicationsCount, savedJobsCount] = await Promise.all([
      prisma.resume.count({ where: { candidate: { userId: id } } }),
      prisma.jobApplication.count({ where: { userId: id } }),
      prisma.savedJobPost.count({ where: { userId: id } }),
    ]);

    // Get application status breakdown
    const [inReviewCount, interviewCount, offerCount, rejectedCount] = await Promise.all([
      prisma.jobApplication.count({ where: { userId: id, status: 'IN_REVIEW' } }),
      prisma.jobApplication.count({ where: { userId: id, status: 'INTERVIEW' } }),
      prisma.jobApplication.count({ where: { userId: id, status: 'OFFER' } }),
      prisma.jobApplication.count({ where: { userId: id, status: 'REJECTED' } }),
    ]);

    const counts = {
      totalResumes: resumesCount,
      totalApplications: applicationsCount,
      savedJobs: savedJobsCount,
      applicationsByStatus: {
        inReview: inReviewCount,
        interview: interviewCount,
        offer: offerCount,
        rejected: rejectedCount,
      },
    };

    // Prepare enhanced response
    const paymentStats = {
      totalPayments: paymentsCount,
      totalAmountSpent: totalAmount._sum.amount || 0,
      currency: 'AED',
    };

    return NextResponse.json({
      user: basicUser,
      candidateProfile,
      recruiterProfile,
      ownerProfile,
      counts,
      subscription,
      adminPermissions,
      paymentStats,
      jobStats,
      connectedAccounts,
      aiResumeStats,
      security: {
        activeSessions,
        hasResetToken: !!basicUser.resetToken,
        resetTokenExpiry: basicUser.resetTokenExpiry,
      },
    });
  } catch (error) {
    console.error('Profile error:', error);
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
}

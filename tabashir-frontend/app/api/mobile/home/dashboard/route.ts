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

    // Get user basic info with candidate profile
    const user = await prisma.user.findUnique({
      where: { id },
      select: {
        id: true,
        name: true,
        email: true,
        image: true,
        userType: true,
        createdAt: true,
        updatedAt: true,
        candidate: {
          include: {
            profile: true,
          },
        },
      },
    });

    if (!user) return NextResponse.json({ error: "Not found" }, { status: 404 });

    // Get application counts
    const [
      totalApplications,
      savedJobs,
      inReview,
      interview,
      offer,
      rejected,
    ] = await Promise.all([
      prisma.jobApplication.count({ where: { userId: id } }),
      prisma.savedJobPost.count({ where: { userId: id } }),
      prisma.jobApplication.count({ where: { userId: id, status: 'IN_REVIEW' } }),
      prisma.jobApplication.count({ where: { userId: id, status: 'INTERVIEW' } }),
      prisma.jobApplication.count({ where: { userId: id, status: 'OFFER' } }),
      prisma.jobApplication.count({ where: { userId: id, status: 'REJECTED' } }),
    ]);

    // Get recent activity (last application, profile update, job view)
    const lastApplication = await prisma.jobApplication.findFirst({
      where: { userId: id },
      orderBy: { appliedAt: 'desc' },
      select: { appliedAt: true, id: true },
    });

    const recentActivity = {
      lastApplicationDate: lastApplication?.appliedAt?.toISOString() || null,
      lastProfileUpdate: user.updatedAt?.toISOString() || user.createdAt.toISOString(),
      lastJobViewDate: null, // Could be tracked with a separate table if needed
    };

    // Get upcoming interviews (next 7 days)
    const sevenDaysFromNow = new Date();
    sevenDaysFromNow.setDate(sevenDaysFromNow.getDate() + 7);

    const upcomingInterviews = await prisma.jobApplication.findMany({
      where: {
        userId: id,
        status: 'INTERVIEW',
        appliedAt: {
          gte: new Date(),
          lte: sevenDaysFromNow,
        },
      },
      select: {
        id: true,
        appliedAt: true,
        Job: {
          select: {
            title: true,
            company: true,
            location: true,
          },
        },
      },
      orderBy: { appliedAt: 'asc' },
      take: 5,
    });

    // Get recent offers (last 30 days)
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

    const recentOffers = await prisma.jobApplication.findMany({
      where: {
        userId: id,
        status: 'OFFER',
        appliedAt: {
          gte: thirtyDaysAgo,
        },
      },
      select: {
        id: true,
        matchedScore: true,
        appliedAt: true,
        Job: {
          select: {
            title: true,
            company: true,
            salaryMin: true,
            salaryMax: true,
            location: true,
          },
        },
      },
      orderBy: { appliedAt: 'desc' },
      take: 3,
    });

    const stats = {
      totalApplications,
      savedJobs,
      inReview,
      interview,
      offer,
      rejected,
    };

    // Calculate Profile Completion Percentage
    let profileCompletionPercentage = 0;
    if (user.candidate?.profile) {
      const profile = user.candidate.profile;
      const requiredFields = [
        'phone',
        'nationality',
        'gender',
        'jobType',
        'experience',
        'education',
        'skills',
      ];
      let completedFields = 0;

      requiredFields.forEach(field => {
        const value = (profile as any)[field];
        if (value !== null && value !== undefined && value !== '') {
          if (Array.isArray(value) && value.length > 0) {
            completedFields++;
          } else if (!Array.isArray(value)) {
            completedFields++;
          }
        }
      });

      profileCompletionPercentage = Math.round((completedFields / requiredFields.length) * 100);
    }

    // Calculate Application Success Rate
    const successfulApplications = interview + offer;
    const applicationSuccessRate = totalApplications > 0
      ? Math.round((successfulApplications / totalApplications) * 100)
      : 0;

    const metrics = {
      profileCompletionPercentage,
      applicationSuccessRate,
    };

    return NextResponse.json({
      user,
      stats,
      metrics,
      recentActivity,
      upcomingInterviews,
      recentOffers,
    });
  } catch (error) {
    console.error('Home dashboard error:', error);
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
}

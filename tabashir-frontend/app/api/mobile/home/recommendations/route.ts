import { NextRequest, NextResponse } from "next/server";
import { verifyAccess } from "@/app/utils/jwt";
import { prisma } from "@/app/utils/db";

function getAuthHeader(req: Request) {
  const h = req.headers.get("authorization") || "";
  const m = h.match(/^Bearer\s+(.+)$/i);
  return m?.[1];
}

export async function GET(req: NextRequest) {
  try {
    const token = getAuthHeader(req);
    if (!token) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

    const { id } = verifyAccess(token);

    // Get user's profile and skills
    const candidate = await prisma.candidate.findUnique({
      where: { userId: id },
      select: {
        profile: {
          select: {
            skills: true,
            experience: true,
            jobType: true,
            location: true,
          },
        },
      },
    });

    // Get active jobs
    const jobs = await prisma.job.findMany({
      where: { status: 'ACTIVE' },
      take: 50,
      orderBy: { createdAt: 'desc' },
    });

    // Calculate match scores and recommendations
    const profile = candidate?.profile;
    const jobsWithMatches = jobs.map(job => {
      let matchScore = 0;
      const reasons: string[] = [];

      // Job type match
      if (profile?.jobType && job.jobType === profile.jobType) {
        matchScore += 30;
        reasons.push(`Matches your ${job.jobType.toLowerCase()} preference`);
      }

      // Skills match
      if (profile?.skills && job.description) {
        const userSkills = profile.skills.map(s => s.toLowerCase());
        const jobDescription = job.description.toLowerCase();

        const matchingSkills = userSkills.filter(skill =>
          jobDescription.includes(skill.toLowerCase())
        );

        matchScore += matchingSkills.length * 10;

        if (matchingSkills.length > 0) {
          reasons.push(`Matches your ${matchingSkills.slice(0, 2).join(' and ')} experience`);
        }
      }

      // Experience level match
      if (profile?.experience && job.title) {
        const exp = profile.experience.toLowerCase();
        const title = job.title.toLowerCase();

        if ((exp.includes('senior') || exp.includes('lead')) &&
            (title.includes('senior') || title.includes('lead'))) {
          matchScore += 20;
          reasons.push('Matches your senior-level experience');
        } else if ((exp.includes('junior') || exp.includes('entry')) &&
                   (title.includes('junior') || title.includes('entry'))) {
          matchScore += 20;
          reasons.push('Matches your junior-level experience');
        } else if (exp.includes('mid') || exp.includes('intermediate')) {
          matchScore += 15;
          reasons.push('Matches your mid-level experience');
        }
      }

      // Location match
      if (profile?.location && job.location) {
        if (job.location.toLowerCase().includes(profile.location.toLowerCase()) ||
            profile.location.toLowerCase().includes(job.location.toLowerCase())) {
          matchScore += 15;
          reasons.push(`Near your location (${profile.location})`);
        } else if (job.location.toLowerCase().includes('remote')) {
          matchScore += 10;
          reasons.push('Remote-friendly');
        }
      }

      // Add some randomness for variety
      matchScore += Math.floor(Math.random() * 10);

      // Cap at 100
      matchScore = Math.min(matchScore, 100);

      return {
        ...job,
        matchScore,
        reasons,
      };
    });

    // Sort by match score and take top 10
    const recommendedJobs = jobsWithMatches
      .sort((a, b) => b.matchScore - a.matchScore)
      .slice(0, 10);

    // Get similar jobs (based on applied jobs)
    const userApplications = await prisma.jobApplication.findMany({
      where: { userId: id },
      select: {
        Job: {
          select: {
            title: true,
            jobType: true,
          },
        },
      },
      take: 5,
      orderBy: { appliedAt: 'desc' },
    });

    let similarJobs: any[] = [];
    if (userApplications.length > 0) {
      const appliedJobTypes = [...new Set(userApplications.map(a => a.Job?.jobType).filter(Boolean))];
      const appliedTitles = userApplications.map(a => a.Job?.title || '');

      similarJobs = jobsWithMatches
        .filter(job => {
          const hasSimilarType = appliedJobTypes.includes(job.jobType);
          const hasSimilarTitle = appliedTitles.some(title =>
            title && job.title && (
              title.toLowerCase().includes(job.title.toLowerCase().split(' ')[0]) ||
              job.title.toLowerCase().includes(title.toLowerCase().split(' ')[0])
            )
          );
          return (hasSimilarType || hasSimilarTitle) && job.matchScore < 90;
        })
        .slice(0, 5);
    }

    // Prepare why recommended explanations
    const whyRecommended: string[] = [];
    if (profile?.skills && profile.skills.length > 0) {
      whyRecommended.push(`Based on your ${profile.skills.slice(0, 3).join(', ')} skills`);
    }
    if (profile?.experience) {
      whyRecommended.push(`Your ${profile.experience} level experience`);
    }
    if (profile?.jobType) {
      whyRecommended.push(`Looking for ${profile.jobType.toLowerCase()} positions`);
    }
    if (profile?.location) {
      whyRecommended.push(`Jobs in/near ${profile.location}`);
    }

    // Profile summary
    const basedOnProfile = {
      skills: profile?.skills || [],
      experience: profile?.experience || 'Not specified',
      location: profile?.location || 'Not specified',
    };

    return NextResponse.json({
      recommendedJobs,
      whyRecommended,
      similarJobs,
      basedOnProfile,
    });
  } catch (error) {
    console.error('Enhanced recommendations error:', error);
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
}

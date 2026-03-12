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

    // Get user's profile and skills for recommendations
    const candidate = await prisma.candidate.findUnique({
      where: { userId: id },
      select: {
        skills: true,
        experience: true,
        jobType: true,
      },
    });

    // Get active jobs
    const jobs = await prisma.job.findMany({
      where: { status: 'ACTIVE' },
      take: 20,
      orderBy: { createdAt: 'desc' },
    });

    // Simple recommendation algorithm
    // In a real implementation, this would use AI/ML for better matching
    const recommendedJobs = jobs.map(job => {
      let matchScore = 0;

      // Check if job type matches
      if (candidate?.jobType && job.jobType === candidate.jobType) {
        matchScore += 30;
      }

      // Check if skills match (simple keyword matching)
      if (candidate?.skills && job.jobDescription) {
        const userSkills = candidate.skills.map(s => s.toLowerCase());
        const jobDescription = job.jobDescription.toLowerCase();

        const matchingSkills = userSkills.filter(skill =>
          jobDescription.includes(skill.toLowerCase())
        );

        matchScore += matchingSkills.length * 10; // 10 points per matching skill
      }

      // Add some randomness to ensure variety
      matchScore += Math.floor(Math.random() * 20);

      return {
        ...job,
        matchScore: Math.min(matchScore, 100), // Cap at 100
      };
    });

    // Sort by match score and take top 10
    const topJobs = recommendedJobs
      .sort((a, b) => b.matchScore - a.matchScore)
      .slice(0, 10);

    return NextResponse.json({
      jobs: topJobs,
      total: topJobs.length,
    });
  } catch (error) {
    console.error('Recommended jobs error:', error);
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
}

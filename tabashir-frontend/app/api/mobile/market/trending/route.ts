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

    verifyAccess(token);

    // Get recent jobs to analyze trends
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

    const recentJobs = await prisma.job.findMany({
      where: {
        createdAt: {
          gte: thirtyDaysAgo,
        },
        status: 'ACTIVE',
      },
      select: {
        jobTitle: true,
        jobType: true,
        jobDescription: true,
        createdAt: true,
      },
    });

    // Analyze trending technologies/skills from job descriptions
    const techKeywords = [
      'Flutter', 'React', 'Angular', 'Vue', 'Node.js', 'Python', 'Java',
      'TypeScript', 'JavaScript', 'Go', 'Rust', 'Swift', 'Kotlin',
      'AWS', 'Azure', 'GCP', 'Docker', 'Kubernetes', 'DevOps',
      'AI', 'ML', 'Machine Learning', 'Data Science', 'Blockchain',
    ];

    const technologyTrends: { [key: string]: number } = {};

    // Count mentions of each technology
    recentJobs.forEach(job => {
      const description = (job.jobDescription || '').toLowerCase();
      techKeywords.forEach(tech => {
        if (description.includes(tech.toLowerCase())) {
          technologyTrends[tech] = (technologyTrends[tech] || 0) + 1;
        }
      });
    });

    // Get top trending technologies
    const trendingTechnologies = Object.entries(technologyTrends)
      .sort((a, b) => b[1] - a[1])
      .slice(0, 5)
      .map(([tech, count]) => ({
        technology: tech,
        jobCount: count,
        growthPercentage: Math.floor(Math.random() * 30) + 5, // Mock growth percentage
      }));

    // Generate a featured trending item
    const topTech = trendingTechnologies[0];
    const trendingItem = topTech ? {
      title: `${topTech.technology} roles are trending`,
      growthPercentage: topTech.growthPercentage,
      jobCount: topTech.jobCount,
      message: `${topTech.technology} and related technologies are in high demand this week.`,
    } : {
      title: 'Tech jobs are on the rise',
      growthPercentage: 12,
      jobCount: recentJobs.length,
      message: 'Technology roles are seeing increased demand across the region.',
    };

    return NextResponse.json({
      trending: trendingItem,
      technologies: trendingTechnologies,
      totalRecentJobs: recentJobs.length,
      period: '7 days',
    });
  } catch (error) {
    console.error('Trending jobs error:', error);
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
}

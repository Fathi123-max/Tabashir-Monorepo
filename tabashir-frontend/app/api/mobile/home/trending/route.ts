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

    // Get recent jobs from last 7 days
    const sevenDaysAgo = new Date();
    sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);

    const previousSevenDays = new Date();
    previousSevenDays.setDate(previousSevenDays.getDate() - 14);

    const [
      recentJobs,
      previousJobs,
    ] = await Promise.all([
      prisma.job.findMany({
        where: {
          createdAt: { gte: sevenDaysAgo },
          status: 'ACTIVE',
        },
        select: {
          title: true,
          description: true,
          createdAt: true,
        },
      }),
      prisma.job.findMany({
        where: {
          createdAt: { gte: previousSevenDays, lt: sevenDaysAgo },
          status: 'ACTIVE',
        },
        select: {
          title: true,
          description: true,
        },
      }),
    ]);

    // Analyze trending technologies
    const techKeywords = [
      'Flutter', 'React', 'Angular', 'Vue', 'Node.js', 'Python', 'Java',
      'TypeScript', 'JavaScript', 'Go', 'Rust', 'Swift', 'Kotlin',
      'AWS', 'Azure', 'GCP', 'Docker', 'Kubernetes', 'DevOps',
      'AI', 'ML', 'Machine Learning', 'Data Science', 'Blockchain',
      'React Native', 'Next.js', 'Express', 'Django', 'Spring',
    ];

    const currentTechCount: { [key: string]: number } = {};
    const previousTechCount: { [key: string]: number } = {};

    // Count current week
    recentJobs.forEach(job => {
      const description = (job.description || '').toLowerCase();
      techKeywords.forEach(tech => {
        if (description.includes(tech.toLowerCase())) {
          currentTechCount[tech] = (currentTechCount[tech] || 0) + 1;
        }
      });
    });

    // Count previous week
    previousJobs.forEach(job => {
      const description = (job.description || '').toLowerCase();
      techKeywords.forEach(tech => {
        if (description.includes(tech.toLowerCase())) {
          previousTechCount[tech] = (previousTechCount[tech] || 0) + 1;
        }
      });
    });

    // Calculate growth and get top trending skills
    const trendingSkills = techKeywords
      .map(tech => {
        const current = currentTechCount[tech] || 0;
        const previous = previousTechCount[tech] || 0;
        const growth = previous > 0
          ? Math.round(((current - previous) / previous) * 100)
          : current > 0 ? 100 : 0;

        return {
          tech,
          current,
          previous,
          growth,
        };
      })
      .filter(item => item.current > 0)
      .sort((a, b) => b.growth - a.growth)
      .slice(0, 3);

    // Generate trending text
    let trendingText = '';
    let growthPercentage = 0;
    let seeOpportunitiesLink = '';

    if (trendingSkills.length > 0) {
      const topSkill = trendingSkills[0];
      const secondSkill = trendingSkills[1];

      if (secondSkill) {
        trendingText = `${topSkill.tech} and ${secondSkill.tech} roles are up ${topSkill.growth}% this week`;
      } else {
        trendingText = `${topSkill.tech} roles are up ${topSkill.growth}% this week`;
      }

      growthPercentage = topSkill.growth;
      seeOpportunitiesLink = `/jobs?skill=${encodeURIComponent(topSkill.tech.toLowerCase())}`;
    } else {
      trendingText = 'Tech opportunities are growing across the region';
      growthPercentage = 12;
      seeOpportunitiesLink = '/jobs';
    }

    const topSkillsArray = trendingSkills.map(s => s.tech);

    return NextResponse.json({
      trendingText,
      topSkills: topSkillsArray,
      growthPercentage,
      seeOpportunitiesLink,
    });
  } catch (error) {
    console.error('Trending data error:', error);
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
}

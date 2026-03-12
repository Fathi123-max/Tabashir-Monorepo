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

    // Get application status distribution for pie chart
    const [pending, inReview, interview, offer, rejected] = await Promise.all([
      prisma.jobApplication.count({ where: { userId: id, status: 'PENDING' } }),
      prisma.jobApplication.count({ where: { userId: id, status: 'IN_REVIEW' } }),
      prisma.jobApplication.count({ where: { userId: id, status: 'INTERVIEW' } }),
      prisma.jobApplication.count({ where: { userId: id, status: 'OFFER' } }),
      prisma.jobApplication.count({ where: { userId: id, status: 'REJECTED' } }),
    ]);

    const applicationStatusChart = [
      { name: 'Pending', value: pending, color: '#FFA500' },
      { name: 'In Review', value: inReview, color: '#0D56E1' },
      { name: 'Interview', value: interview, color: '#34D399' },
      { name: 'Offer', value: offer, color: '#10B981' },
      { name: 'Rejected', value: rejected, color: '#EF4444' },
    ].filter(item => item.value > 0);

    // Get match score distribution
    const applications = await prisma.jobApplication.findMany({
      where: { userId: id },
      select: { matchedScore: true },
      orderBy: { matchedScore: 'desc' },
    });

    const matchScoreRanges = [
      { range: '0-20%', min: 0, max: 20, count: 0 },
      { range: '21-40%', min: 21, max: 40, count: 0 },
      { range: '41-60%', min: 41, max: 60, count: 0 },
      { range: '61-80%', min: 61, max: 80, count: 0 },
      { range: '81-100%', min: 81, max: 100, count: 0 },
    ];

    applications.forEach(app => {
      if (app.matchedScore !== null) {
        const range = matchScoreRanges.find(
          r => app.matchedScore >= r.min && app.matchedScore <= r.max
        );
        if (range) range.count++;
      }
    });

    const matchScoreDistribution = matchScoreRanges.filter(r => r.count > 0);

    // Get monthly application trends (last 6 months)
    const sixMonthsAgo = new Date();
    sixMonthsAgo.setMonth(sixMonthsAgo.getMonth() - 6);

    const sixMonthApplications = await prisma.jobApplication.findMany({
      where: {
        userId: id,
        appliedAt: { gte: sixMonthsAgo },
      },
      select: { appliedAt: true },
      orderBy: { appliedAt: 'asc' },
    });

    const monthlyData: { [key: string]: number } = {};
    const now = new Date();

    // Initialize last 6 months with 0
    for (let i = 5; i >= 0; i--) {
      const month = new Date(now.getFullYear(), now.getMonth() - i, 1);
      const monthKey = month.toLocaleDateString('en-US', { month: 'short', year: '2-digit' });
      monthlyData[monthKey] = 0;
    }

    // Count applications per month
    sixMonthApplications.forEach(app => {
      const monthKey = app.appliedAt.toLocaleDateString('en-US', { month: 'short', year: '2-digit' });
      if (monthlyData.hasOwnProperty(monthKey)) {
        monthlyData[monthKey]++;
      }
    });

    const monthlyApplications = Object.entries(monthlyData).map(([month, count]) => ({
      month,
      count,
    }));

    // Get skills demand (based on user's applications vs market)
    const userApplications = await prisma.jobApplication.findMany({
      where: { userId: id },
      select: {
        Job: {
          select: {
            description: true,
          },
        },
      },
      take: 50,
    });

    const skillKeywords = [
      'Flutter', 'React', 'Angular', 'Vue', 'Node.js', 'Python', 'Java',
      'TypeScript', 'JavaScript', 'AWS', 'Docker', 'Kubernetes',
      'AI', 'ML', 'Machine Learning', 'Data Science',
    ];

    const skillsDemand: { [key: string]: number } = {};

    userApplications.forEach(app => {
      const description = (app.Job?.description || '').toLowerCase();
      skillKeywords.forEach(skill => {
        if (description.includes(skill.toLowerCase())) {
          skillsDemand[skill] = (skillsDemand[skill] || 0) + 1;
        }
      });
    });

    const skillsDemandArray = Object.entries(skillsDemand)
      .sort((a, b) => b[1] - a[1])
      .slice(0, 10)
      .map(([skill, demand]) => ({ skill, demand }));

    return NextResponse.json({
      applicationStatusChart,
      matchScoreDistribution,
      monthlyApplications,
      skillsDemand: skillsDemandArray,
    });
  } catch (error) {
    console.error('Home analytics error:', error);
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
}

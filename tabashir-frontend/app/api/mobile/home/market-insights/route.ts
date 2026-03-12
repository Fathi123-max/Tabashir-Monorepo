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

    // Get jobs from last 30 days for trending analysis
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

    const sevenDaysAgo = new Date();
    sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);

    const [
      recentJobs,
      newJobsThisWeek,
      totalActiveJobs,
      totalApplications,
      totalJobsWithApplications,
    ] = await Promise.all([
      prisma.job.findMany({
        where: {
          createdAt: { gte: thirtyDaysAgo },
          status: 'ACTIVE',
        },
        select: {
          title: true,
          description: true,
          location: true,
          salaryMin: true,
          salaryMax: true,
          createdAt: true,
        },
      }),
      prisma.job.count({
        where: {
          createdAt: { gte: sevenDaysAgo },
          status: 'ACTIVE',
        },
      }),
      prisma.job.count({
        where: { status: 'ACTIVE' },
      }),
      prisma.jobApplication.count(),
      prisma.job.count({
        where: {
          applicants: {
            some: {},
          },
        },
      }),
    ]);

    // Analyze trending skills from job descriptions
    const skillKeywords = [
      'Flutter', 'React', 'Angular', 'Vue', 'Node.js', 'Python', 'Java',
      'TypeScript', 'JavaScript', 'Go', 'Rust', 'Swift', 'Kotlin',
      'AWS', 'Azure', 'GCP', 'Docker', 'Kubernetes', 'DevOps',
      'AI', 'ML', 'Machine Learning', 'Data Science', 'Blockchain',
      'React Native', 'Next.js', 'Express', 'Django', 'Spring',
      'PostgreSQL', 'MongoDB', 'Redis', 'GraphQL', 'REST',
      'CI/CD', 'Terraform', 'Jenkins', 'Git', 'Agile',
    ];

    const skillsCount: { [key: string]: number } = {};
    const skillsGrowth: { [key: string]: number } = {};

    recentJobs.forEach(job => {
      const description = (job.description || '').toLowerCase();
      skillKeywords.forEach(skill => {
        if (description.includes(skill.toLowerCase())) {
          skillsCount[skill] = (skillsCount[skill] || 0) + 1;

          // Calculate growth (jobs in last 7 days vs previous 7 days)
          const isRecent = job.createdAt >= sevenDaysAgo;
          if (isRecent) {
            skillsGrowth[skill] = (skillsGrowth[skill] || 0) + 1;
          }
        }
      });
    });

    // Get top trending skills with growth percentage
    const trendingSkills = Object.entries(skillsCount)
      .sort((a, b) => b[1] - a[1])
      .slice(0, 8)
      .map(([skill, count]) => {
        const recent = skillsGrowth[skill] || 0;
        const previous = count - recent;
        const growthPercentage = previous > 0
          ? Math.round(((recent - previous) / previous) * 100)
          : recent > 0 ? 100 : 0;

        return {
          skill,
          count,
          growth: Math.max(growthPercentage, 0),
        };
      });

    // Get top locations
    const locationCounts: { [key: string]: number } = {};
    recentJobs.forEach(job => {
      if (job.location) {
        locationCounts[job.location] = (locationCounts[job.location] || 0) + 1;
      }
    });

    const topLocations = Object.entries(locationCounts)
      .sort((a, b) => b[1] - a[1])
      .slice(0, 5)
      .map(([location, count]) => ({ location, count }));

    // Calculate salary insights by role type
    const salaryByRole: { [key: string]: { min: number; max: number; count: number } } = {};

    recentJobs.forEach(job => {
      if (job.salaryMin && job.salaryMax) {
        // Infer role type from title
        let roleType = 'Other';
        const title = job.title.toLowerCase();

        if (title.includes('senior') || title.includes('lead')) {
          roleType = 'Senior';
        } else if (title.includes('junior') || title.includes('entry')) {
          roleType = 'Junior';
        } else if (title.includes('manager') || title.includes('director')) {
          roleType = 'Manager';
        } else if (title.includes('intern')) {
          roleType = 'Intern';
        }

        if (!salaryByRole[roleType]) {
          salaryByRole[roleType] = { min: job.salaryMin, max: job.salaryMax, count: 1 };
        } else {
          salaryByRole[roleType].min = Math.min(salaryByRole[roleType].min, job.salaryMin);
          salaryByRole[roleType].max = Math.max(salaryByRole[roleType].max, job.salaryMax);
          salaryByRole[roleType].count++;
        }
      }
    });

    const salaryInsights = Object.entries(salaryByRole).map(([role, data]) => ({
      role,
      min: data.min,
      max: data.max,
      count: data.count,
    }));

    // Industry growth (based on job types)
    const jobTypeCounts: { [key: string]: number } = {};
    recentJobs.forEach(job => {
      if (job.title) {
        const title = job.title.toLowerCase();
        let industry = 'Other';

        if (title.includes('frontend') || title.includes('frontend')) {
          industry = 'Frontend Development';
        } else if (title.includes('backend') || title.includes('api')) {
          industry = 'Backend Development';
        } else if (title.includes('full stack') || title.includes('fullstack')) {
          industry = 'Full Stack Development';
        } else if (title.includes('mobile') || title.includes('ios') || title.includes('android')) {
          industry = 'Mobile Development';
        } else if (title.includes('data') || title.includes('analyst') || title.includes('scientist')) {
          industry = 'Data & Analytics';
        } else if (title.includes('devops') || title.includes('cloud') || title.includes('aws')) {
          industry = 'DevOps & Cloud';
        } else if (title.includes('ui') || title.includes('ux') || title.includes('design')) {
          industry = 'Design & UX';
        }

        jobTypeCounts[industry] = (jobTypeCounts[industry] || 0) + 1;
      }
    });

    const industryGrowth = Object.entries(jobTypeCounts)
      .sort((a, b) => b[1] - a[1])
      .slice(0, 5)
      .map(([industry, count]) => {
        // Calculate growth percentage (mock calculation)
        const total = recentJobs.length;
        const percentage = Math.round((count / total) * 100);
        return { industry, percentage };
      });

    // Calculate average applications per job
    const averageApplicationsPerJob = totalJobsWithApplications > 0
      ? Math.round((totalApplications / totalJobsWithApplications) * 10) / 10
      : 0;

    const jobMarketTrends = {
      totalJobs: totalActiveJobs,
      newJobsThisWeek,
      averageApplicationsPerJob,
      totalApplications,
      topLocations,
      salaryInsights,
    };

    return NextResponse.json({
      trendingSkills,
      jobMarketTrends,
      industryGrowth,
    });
  } catch (error) {
    console.error('Market insights error:', error);
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
}

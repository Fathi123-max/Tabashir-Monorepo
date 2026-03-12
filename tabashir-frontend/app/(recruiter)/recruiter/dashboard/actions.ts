"use server"

import { auth } from "@/app/utils/auth"
import { prisma } from "@/lib/prisma"

export async function getRecruiterDashboardStats() {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      return { success: false, error: "Unauthorized" }
    }

    // Check if user is a recruiter
    const recruiter = await prisma.recruiter.findUnique({
      where: { userId: session.user.id }
    })

    if (!recruiter) {
      return { success: false, error: "Recruiter not found" }
    }

    // Get stats in parallel
    const [
      activeJobs,
      totalApplications,
      totalViews,
      recentJobs
    ] = await Promise.all([
      // Active jobs count
      prisma.job.count({
        where: {
          recruiterId: recruiter.id,
          isActive: true
        }
      }),
      
      // Total applications across all recruiter's jobs
      prisma.jobApplication.count({
        where: {
          Job: {
            recruiterId: recruiter.id
          }
        }
      }),
      
      // Total views across all recruiter's jobs
      prisma.job.aggregate({
        where: {
          recruiterId: recruiter.id
        },
        _sum: {
          views: true
        }
      }),
      
      // Recent jobs with applications count
      prisma.job.findMany({
        where: {
          recruiterId: recruiter.id
        },
        include: {
          applicants: {
            select: { id: true }
          }
        },
        orderBy: {
          createdAt: 'desc'
        },
        take: 5
      })
    ])

    // Calculate some basic change indicators (these could be improved with actual historical data)
    const stats = {
      activeJobs: {
        value: activeJobs,
        change: "+2 from last month" // Placeholder - you could implement actual comparison
      },
      totalApplications: {
        value: totalApplications,
        change: "+18% from last month" // Placeholder
      },
      totalViews: {
        value: totalViews._sum.views || 0,
        change: "+12% from last month" // Placeholder
      },
      scheduledInterviews: {
        value: Math.floor(totalApplications * 0.1), // Rough estimate
        change: "+6 this week" // Placeholder
      }
    }

    // Format recent jobs
    const formattedRecentJobs = recentJobs.map(job => ({
      id: job.id,
      title: job.title,
      company: job.company,
      location: job.location || "Not specified",
      type: job.jobType,
      applications: job.applicants.length,
      views: job.views,
      status: job.isActive ? "Active" : "Paused",
      postedDate: job.createdAt.toISOString(),
    }))

    return {
      success: true,
      stats,
      recentJobs: formattedRecentJobs
    }
  } catch (error) {
    console.error("Error fetching dashboard stats:", error)
    return { success: false, error: "Failed to fetch dashboard data" }
  }
}

export async function getRecruiterJobsCount() {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      return { success: false, error: "Unauthorized" }
    }

    const recruiter = await prisma.recruiter.findUnique({
      where: { userId: session.user.id }
    })

    if (!recruiter) {
      return { success: false, error: "Recruiter not found" }
    }

    const jobsCount = await prisma.job.count({
      where: { recruiterId: recruiter.id }
    })

    return { success: true, count: jobsCount }
  } catch (error) {
    console.error("Error fetching jobs count:", error)
    return { success: false, error: "Failed to fetch jobs count" }
  }
} 
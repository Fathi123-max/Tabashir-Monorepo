"use server"

import { auth } from "@/app/utils/auth"
import { prisma } from "@/lib/prisma"

interface DashboardStats {
  activeJobs: { value: number; change: string }
  totalApplications: { value: number; change: string }
  scheduledInterviews: { value: number; change: string }
  totalUsers: { value: number; change: string }
}

interface JobData {
  id: string
  title: string
  company: string
  location: string
  type: string
  applications: number
  views: number
  status: string
  postedDate: string
  createdBy: string
}

interface ApplicationStatusData {
  name: string
  value: number
  color: string
}

export async function getAdminDashboardStats(): Promise<
  { success: true; stats: DashboardStats; recentJobs: JobData[]; applicationStatusData: ApplicationStatusData[]; jobStatusData: ApplicationStatusData[] } |
  { success: false; error: string }
> {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      return { success: false, error: "Unauthorized" } as { success: false; error: string }
    }

    // Check if user is an admin/owner
    // const owner = await prisma.owner.findFirst({
    //   where: { userId: session.user.id }
    // })

    // if (!owner) {
    //   return { success: false, error: "Unauthorized - Admin access required" } as { success: false; error: string }
    // }

    // Get comprehensive stats in parallel
    const [
      totalActiveJobs,
      totalApplications,
      totalInterviews,
      totalUsers,
      recentJobs,
      applicationsByStatus,
      jobsByStatus
    ] = await Promise.all([
      // Total active jobs across all owners and recruiters
      prisma.job.count({
        where: {
          isActive: true,
          status: "ACTIVE"
        }
      }),
      
      // Total applications across all jobs
      prisma.jobApplication.count(),
      
      // Estimate interviews (applications with specific status or percentage)
      prisma.jobApplication.count({
        where: {
          status: {
            in: ["interviewed", "interview_scheduled", "shortlisted"]
          }
        }
      }),
      
      // Total users registered
      prisma.user.count(),
      
      // Recent jobs with applications count
      prisma.job.findMany({
        include: {
          applicants: {
            select: { id: true, status: true }
          },
          owner: {
            select: { user: { select: { name: true } } }
          },
          recruiter: {
            select: { companyName: true }
          }
        },
        orderBy: {
          createdAt: 'desc'
        },
        take: 10
      }),
      
      // Application status distribution
      prisma.jobApplication.groupBy({
        by: ['status'],
        _count: {
          id: true
        }
      }),
      
      // Job status distribution
      prisma.job.groupBy({
        by: ['status'],
        _count: {
          id: true
        }
      })
    ])

    // Calculate stats
    const stats = {
      activeJobs: {
        value: totalActiveJobs,
        change: "+5% from last month" // Placeholder - could implement actual comparison
      },
      totalApplications: {
        value: totalApplications,
        change: "+23% from last month" // Placeholder
      },
      scheduledInterviews: {
        value: totalInterviews,
        change: "+12% from last month" // Placeholder
      },
      totalUsers: {
        value: totalUsers,
        change: "+8% from last month" // Placeholder
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
      status: job.status,
      postedDate: job.createdAt.toISOString(),
      createdBy: job.owner?.user?.name || job.recruiter?.companyName || "Unknown"
    }))

    // Format application status data for charts
    const formattedApplicationStatus = applicationsByStatus.map(item => ({
      name: item.status.charAt(0).toUpperCase() + item.status.slice(1).replace('_', ' '),
      value: item._count.id,
      color: getStatusColor(item.status)
    }))

    // Format job status data
    const formattedJobStatus = jobsByStatus.map(item => ({
      name: item.status.charAt(0).toUpperCase() + item.status.slice(1),
      value: item._count.id,
      color: getJobStatusColor(item.status)
    }))

    return {
      success: true,
      stats,
      recentJobs: formattedRecentJobs,
      applicationStatusData: formattedApplicationStatus,
      jobStatusData: formattedJobStatus
    } as {
      success: true
      stats: DashboardStats
      recentJobs: JobData[]
      applicationStatusData: ApplicationStatusData[]
      jobStatusData: ApplicationStatusData[]
    }
  } catch (error) {
    console.error("Error fetching admin dashboard stats:", error)
    return { success: false, error: "Failed to fetch dashboard data" } as { success: false; error: string }
  }
}

function getStatusColor(status: string): string {
  const colorMap: { [key: string]: string } = {
    'pending': '#FFA500',
    'shortlisted': '#50C878',
    'interviewed': '#3B82F6',
    'interview_scheduled': '#9333EA',
    'rejected': '#FF5A5A',
    'hired': '#22C55E'
  }
  return colorMap[status] || '#6B7280'
}

function getJobStatusColor(status: string): string {
  const colorMap: { [key: string]: string } = {
    'ACTIVE': '#22C55E',
    'PAUSED': '#FFA500',
    'CLOSED': '#FF5A5A'
  }
  return colorMap[status] || '#6B7280'
}

export async function getAdminJobsOverview() {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      return { success: false, error: "Unauthorized" }
    }

    // Check if user is an admin/owner
    // const owner = await prisma.owner.findFirst({
    //   where: { userId: session.user.id }
    // })

    // if (!owner) {

    //   return { success: false, error: "Unauthorized - Admin access required" }
    // }

    // Get jobs with detailed stats
    const jobs = await prisma.job.findMany({
      include: {
        applicants: {
          select: { 
            id: true, 
            status: true,
            matchedScore: true
          }
        },
        owner: {
          select: { user: { select: { name: true } } }
        },
        recruiter: {
          select: { companyName: true }
        }
      },
      orderBy: {
        createdAt: 'desc'
      }
    })

    const jobsWithStats = jobs.map(job => {
      const applicants = job.applicants
      const shortlistedCount = applicants.filter(app => app.status === 'shortlisted').length
      const interviewedCount = applicants.filter(app => app.status === 'interviewed').length
      const averageMatch = applicants.length > 0 
        ? Math.round(applicants.reduce((sum, app) => sum + app.matchedScore, 0) / applicants.length)
        : 0

      return {
        id: job.id,
        title: job.title,
        company: job.company,
        location: job.location || "Not specified",
        type: job.jobType,
        totalApplications: applicants.length,
        shortlistedCount,
        interviewedCount,
        averageMatch,
        views: job.views,
        status: job.status,
        isActive: job.isActive,
        postedDate: job.createdAt.toISOString(),
        lastUpdated: job.updatedAt.toISOString(),
        createdBy: job.owner?.user?.name || job.recruiter?.companyName || "Unknown",
        salaryRange: `${job.salaryMin} - ${job.salaryMax} AED`
      }
    })

    return {
      success: true,
      jobs: jobsWithStats
    }
  } catch (error) {
    console.error("Error fetching jobs overview:", error)
    return { success: false, error: "Failed to fetch jobs overview" }
  }
} 
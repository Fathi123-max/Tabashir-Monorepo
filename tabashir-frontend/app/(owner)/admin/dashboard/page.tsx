"use client"

import { useState, useEffect } from "react"
import StatCard from "../../_components/stat-card"
import ApplicationStatusChart from "../../_components/application-status-chart"
import SkillTrendsChart from "../../_components/skill-trends-chart"
import JobsTable from "../../_components/jobs-table"
import { Button } from "@/components/ui/button"
import { getAdminDashboardStats } from "./actions"
import { Loader2 } from "lucide-react"
import Link from "next/link"

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

export default function OwnerDashboard() {
  const [selectedJob, setSelectedJob] = useState("All Jobs")
  const [stats, setStats] = useState<DashboardStats | null>(null)
  const [jobsData, setJobsData] = useState<JobData[]>([])
  const [applicationStatusData, setApplicationStatusData] = useState<ApplicationStatusData[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  // Fetch dashboard data
  useEffect(() => {
    const fetchDashboardData = async () => {
      try {
        setLoading(true)
        const result = await getAdminDashboardStats()

        if (result.success) {
          setStats(result.stats)
          setJobsData(result.recentJobs)
          setApplicationStatusData(result.applicationStatusData)
        } else {
          setError(result.error)
        }
      } catch (err) {
        setError("An unexpected error occurred")
        console.error("Dashboard error:", err)
      } finally {
        setLoading(false)
      }
    }

    fetchDashboardData()
  }, [])

  // Loading state
  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <Loader2 className="h-8 w-8 animate-spin text-blue-500" />
        <span className="ml-2 text-lg">Loading dashboard...</span>
      </div>
    )
  }

  // Error state
  if (error) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="text-center">
          <p className="text-red-500 text-lg mb-4">{error}</p>
          <Button onClick={() => window.location.reload()}>
            Try Again
          </Button>
        </div>
      </div>
    )
  }

  // Transform stats for StatCard components
  const statsCards = [
    {
      title: "Active Jobs",
      value: stats?.activeJobs.value?.toString() || "0",
      icon: "briefcase",
      color: "bg-amber-100",
      iconColor: "text-amber-500",
      change: stats?.activeJobs.change
    },
    {
      title: "Total Applications",
      value: stats?.totalApplications.value?.toLocaleString() || "0",
      icon: "grid",
      color: "bg-emerald-100",
      iconColor: "text-emerald-500",
      change: stats?.totalApplications.change
    },
    {
      title: "Scheduled Interviews",
      value: stats?.scheduledInterviews.value?.toString() || "0",
      icon: "check",
      color: "bg-blue-100",
      iconColor: "text-blue-500",
      change: stats?.scheduledInterviews.change
    },
    {
      title: "Total Users",
      value: stats?.totalUsers.value?.toLocaleString() || "0",
      icon: "users",
      color: "bg-purple-100",
      iconColor: "text-purple-500",
      change: stats?.totalUsers.change
    }
  ]

  // Transform jobs data for the table
  const transformedJobsData = jobsData.map(job => ({
    id: job.id,
    title: job.title,
    company: job.company,
    postedOn: new Date(job.postedDate).toLocaleDateString('en-GB', {
      day: '2-digit',
      month: 'short',
      year: 'numeric'
    }),
    type: job.type,
    applicants: job.applications,
    views: job.views,
    status: job.status === 'ACTIVE' ? 'Open' :
      job.status === 'PAUSED' ? 'Paused' : 'Closed',
    createdBy: job.createdBy,
    location: job.location
  }))

  // Get unique job titles for filter dropdown
  const uniqueJobTitles = Array.from(new Set(jobsData.map(job => job.title)))

  return (
    <div className="p-6 text-gray-900">
      {/* Stats Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
        {statsCards.map((stat, index) => (
          <StatCard key={index} {...stat} />
        ))}
      </div>

      {/* Charts */}
      <div className="flex flex-col lg:flex-row gap-6 mb-6">
        <div className="bg-white rounded-lg shadow-sm p-6 w-full lg:w-[40%]">
          <div className="flex justify-between items-center mb-4">
            <h2 className="text-xl font-semibold">Application Status</h2>
            <select
              value={selectedJob}
              onChange={(e) => setSelectedJob(e.target.value)}
              className="border rounded-md px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
            >
              <option value="All Jobs">All Jobs</option>
              {uniqueJobTitles.map(title => (
                <option key={title} value={title}>{title}</option>
              ))}
            </select>
          </div>
          {applicationStatusData.length > 0 ? (
            <ApplicationStatusChart data={applicationStatusData} />
          ) : (
            <div className="flex items-center justify-center h-64 text-gray-500">
              No application data available
            </div>
          )}
        </div>

        <div className="bg-white rounded-lg shadow-sm p-6 w-full lg:w-[60%]">
          <div className="flex justify-between items-center mb-4">
            <h2 className="text-xl font-semibold">Performance Overview</h2>
            <div className="text-sm text-gray-500">
              Last 30 days
            </div>
          </div>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4 h-64">
            <div className="bg-gray-50 rounded-lg p-4 flex flex-col items-center justify-center">
              <div className="text-2xl font-bold text-blue-600">
                {((stats?.totalApplications.value || 0) / Math.max(stats?.activeJobs.value || 1, 1)).toFixed(1)}
              </div>
              <div className="text-sm text-gray-600 text-center">Avg Applications per Job</div>
            </div>
            <div className="bg-gray-50 rounded-lg p-4 flex flex-col items-center justify-center">
              <div className="text-2xl font-bold text-green-600">
                {((stats?.scheduledInterviews.value || 0) / Math.max(stats?.totalApplications.value || 1, 1) * 100).toFixed(1)}%
              </div>
              <div className="text-sm text-gray-600 text-center">Interview Rate</div>
            </div>
            <div className="bg-gray-50 rounded-lg p-4 flex flex-col items-center justify-center">
              <div className="text-2xl font-bold text-purple-600">
                {jobsData.reduce((sum, job) => sum + job.views, 0).toLocaleString()}
              </div>
              <div className="text-sm text-gray-600 text-center">Total Views</div>
            </div>
            <div className="bg-gray-50 rounded-lg p-4 flex flex-col items-center justify-center">
              <div className="text-2xl font-bold text-amber-600">
                {jobsData.filter(job => job.status === 'ACTIVE').length}
              </div>
              <div className="text-sm text-gray-600 text-center">Active Jobs</div>
            </div>
          </div>
        </div>
      </div>

      {/* Jobs Table */}
      <div className="bg-white rounded-lg shadow-sm p-6">
        <div className="flex justify-between items-center mb-6">
          <h2 className="text-xl font-semibold">Recent Jobs</h2>
          <div className="flex gap-3">
            <Link href="/admin/jobs">
              <Button variant="outline">
                View All Jobs
              </Button>
            </Link>
            <Link href="/admin/jobs/new">
              <Button className="bg-gradient-to-r from-[#042052] to-[#0D57E1] hover:from-[#0D57E1] hover:to-[#042052] text-white">
                Create New Job
              </Button>
            </Link>
          </div>
        </div>
        {transformedJobsData.length > 0 ? (
          <JobsTable jobs={transformedJobsData} />
        ) : (
          <div className="text-center py-8 text-gray-500">
            No jobs found. Create your first job to get started.
          </div>
        )}
      </div>
    </div>
  )
}

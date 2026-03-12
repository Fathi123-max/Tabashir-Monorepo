"use client"

import { useState, useEffect } from "react"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import {
  Briefcase,
  Users,
  Eye,
  Calendar,
  Plus,
  MoreHorizontal,
  Edit,
  Trash2,
  Loader2
} from "lucide-react"
import Link from "next/link"
import { getRecruiterDashboardStats } from "./actions"
import { toast } from "sonner"

export default function RecruiterDashboard() {
  const [isLoading, setIsLoading] = useState(true)
  const [dashboardData, setDashboardData] = useState<any>(null)

  useEffect(() => {
    const fetchDashboardData = async () => {
      try {
        const result = await getRecruiterDashboardStats()
        if (result.success) {
          setDashboardData(result)
        } else {
          toast.error("Error loading dashboard", {
            description: result.error || "Failed to load dashboard data",
            className: "bg-red-500 text-white",
          })
        }
      } catch (error) {
        console.error("Error fetching dashboard data:", error)
        toast.error("Error loading dashboard", {
          description: "Failed to load dashboard data. Please try again.",
          className: "bg-red-500 text-white",
        })
      } finally {
        setIsLoading(false)
      }
    }

    fetchDashboardData()
  }, [])

  // Stats data structure for rendering
  const getStatsData = () => {
    if (!dashboardData?.stats) return []

    return [
      {
        title: "Active Jobs",
        value: dashboardData.stats.activeJobs.value.toString(),
        icon: Briefcase,
        color: "bg-blue-100",
        iconColor: "text-blue-500",
        change: dashboardData.stats.activeJobs.change,
      },
    ]
  }

  const getStatusColor = (status: string) => {
    switch (status) {
      case "Active":
        return "bg-green-100 text-green-800"
      case "Paused":
        return "bg-yellow-100 text-yellow-800"
      case "Closed":
        return "bg-red-100 text-red-800"
      default:
        return "bg-gray-100 text-gray-800"
    }
  }

  if (isLoading) {
    return (
      <div className="p-6 space-y-6">
        <div className="flex items-center justify-center min-h-[400px]">
          <div className="text-center">
            <Loader2 className="h-8 w-8 animate-spin mx-auto mb-4" />
            <p className="text-gray-600">Loading dashboard...</p>
          </div>
        </div>
      </div>
    )
  }

  const statsData = getStatsData()
  const recentJobs = dashboardData?.recentJobs || []

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Dashboard</h1>
          <p className="text-gray-600">Welcome back! Here's what's happening with your jobs.</p>
        </div>
        <Link href="/recruiter/jobs/new">
          <Button className="bg-gradient-to-r from-[#042052] to-[#0D57E1] hover:from-[#0D57E1] hover:to-[#042052] text-white">
            <Plus className="h-4 w-4 mr-2" />
            Create New Job
          </Button>
        </Link>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {statsData.map((stat: any, index: number) => (
          <Card key={index} className="border-l-4 border-l-blue-500">
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium text-gray-600">
                {stat.title}
              </CardTitle>
              <div className={`p-2 rounded-full ${stat.color}`}>
                <stat.icon className={`h-4 w-4 ${stat.iconColor}`} />
              </div>
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-gray-900">{stat.value}</div>
              <p className="text-xs text-gray-500 mt-1">{stat.change}</p>
            </CardContent>
          </Card>
        ))}
      </div>

      {/* Recent Jobs */}
      <Card>
        <CardHeader>
          <div className="flex justify-between items-center">
            <div>
              <CardTitle>Recent Jobs</CardTitle>
              <CardDescription>
                Your recently posted job listings and their performance
              </CardDescription>
            </div>
            <Link href="/recruiter/jobs">
              <Button variant="outline" size="sm">
                View All Jobs
              </Button>
            </Link>
          </div>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {recentJobs.length === 0 ? (
              <div className="text-center py-8">
                <p className="text-gray-500">No jobs posted yet</p>
                <Link href="/recruiter/jobs/new">
                  <Button className="mt-4">
                    <Plus className="h-4 w-4 mr-2" />
                    Create Your First Job
                  </Button>
                </Link>
              </div>
            ) : (
              recentJobs.map((job: any) => (
                <div
                  key={job.id}
                  className="flex items-center justify-between p-4 border rounded-lg hover:bg-gray-50 transition-colors"
                >
                  <div className="flex-1">
                    <div className="flex items-center gap-3">
                      <h3 className="font-semibold text-gray-900">{job.title}</h3>
                      <Badge className={getStatusColor(job.status)}>
                        {job.status}
                      </Badge>
                    </div>
                    <p className="text-sm text-gray-600 mt-1">
                      {job.company} • {job.location} • {job.type}
                    </p>
                    <div className="flex items-center gap-4 mt-2 text-sm text-gray-500">
                      <span className="flex items-center gap-1">
                        <Users className="h-3 w-3" />
                        {job.applications} applications
                      </span>
                      <span className="flex items-center gap-1">
                        <Eye className="h-3 w-3" />
                        {job.views} views
                      </span>
                      <span>Posted {new Date(job.postedDate).toLocaleDateString()}</span>
                    </div>
                  </div>
                  <div className="flex items-center gap-2">
                    <Link href={`/recruiter/jobs/${job.id}/edit`}>
                      <Button variant="ghost" size="sm">
                        <Edit className="h-4 w-4" />
                      </Button>
                    </Link>
                    <Button variant="ghost" size="sm">
                      <MoreHorizontal className="h-4 w-4" />
                    </Button>
                  </div>
                </div>
              ))
            )}
          </div>
        </CardContent>
      </Card>
    </div>
  )
} 
"use client"

import { useEffect, useState } from "react"
import { useParams, useRouter } from "next/navigation"
import { getJobById } from "@/lib/api"
import { JobDetails } from "../../jobs/_components/job-details"
import type { Job } from "../../jobs/_components/types"
import { useSession } from "next-auth/react"
import { getAiJobApplyStatus } from "@/actions/ai-resume"
import { toast } from "sonner"
import { ArrowLeft, Loader2 } from "lucide-react"
import { transformJob } from "@/lib/transformJobs"
import { useTranslation } from "@/lib/use-translation"

export default function JobDetailsPage() {
  const params = useParams()
  const router = useRouter()
  const session = useSession()
  const [job, setJob] = useState<Job | null>(null)
  const [loading, setLoading] = useState(true)
  const [jobApplyCount, setJobApplyCount] = useState(0)
  const { isRTL } = useTranslation()
  const jobId = params.id as string

  useEffect(() => {
    const fetchJob = async () => {
      if (!jobId) return

      try {
        setLoading(true)
        const response = await getJobById(jobId, isRTL ? "ar" : "en")

        if (response.success && response.data) {
          // Transform API data to match Job interface
          const transformedJob: Job = transformJob(response.data)
          setJob(transformedJob)
        } else {
          toast.error("Job not found")
          router.back()
        }
      } catch (error) {
        console.error("Error fetching job:", error)
        toast.error("Failed to load job details")
        router.back()
      } finally {
        setLoading(false)
      }
    }

    fetchJob()
  }, [jobId, router])

  useEffect(() => {
    const fetchJobApplyCount = async () => {
      try {
        const jobs = await getAiJobApplyStatus()
        if (!jobs.error) {
          setJobApplyCount(jobs.data?.jobCount || 0)
        }
      } catch (error) {
        console.error("Error fetching job apply count:", error)
      }
    }

    fetchJobApplyCount()
  }, [])

  const handleJobApplied = () => {
    // Refresh the job apply count
    getAiJobApplyStatus().then((jobs) => {
      if (!jobs.error) {
        setJobApplyCount(jobs.data?.jobCount || 0)
      }
    })
  }

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="flex flex-col items-center gap-4">
          <Loader2 className="h-8 w-8 animate-spin text-blue-500" />
          <p className="text-gray-600">Loading job details...</p>
        </div>
      </div>
    )
  }

  if (!job) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <h1 className="text-2xl font-bold text-gray-900 mb-2">Job Not Found</h1>
          <p className="text-gray-600 mb-4">The job you're looking for doesn't exist.</p>
          <button
            onClick={() => router.back()}
            className="inline-flex items-center gap-2 px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition-colors"
          >
            <ArrowLeft size={16} />
            Go Back
          </button>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen">
      <div className="container mx-auto px-4 py-6 max-w-4xl">
        {/* Header with back button */}
        <div className="mb-6">
          <button
            onClick={() => router.back()}
            className="inline-flex items-center gap-2 text-gray-600 hover:text-gray-900 transition-colors mb-4"
          >
            <ArrowLeft size={20} />
            Back
          </button>
          <h1 className="text-2xl font-bold text-gray-900">Job Details</h1>
        </div>

        {/* Job Details */}
        <div className="bg-white rounded-lg shadow-sm">
          <JobDetails
            job={job}
            onClose={() => router.back()}
            jobApplyCount={jobApplyCount}
            onJobApplied={handleJobApplied}
            userId={session.data?.user?.id || ""}
          />
        </div>
      </div>
    </div>
  )
} 
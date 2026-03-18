"use client"

import { useEffect, useState } from "react"
import { SearchPreferences } from "./_components/search-preferences"
import { JobListings } from "./_components/job-listings"
import { JobDetails } from "./_components/job-details"
import type { Job } from "./_components/types"
import { getJobs } from "@/lib/api"
import { toast } from "sonner"
import { useSearchParams, useRouter } from "next/navigation"
import { getAiJobApplyStatus } from "@/actions/ai-resume"
import { useSession } from "next-auth/react"
import { transformJobs } from "@/lib/transformJobs"
import { useTranslation } from "@/lib/use-translation"
import { useHasResume } from "@/hooks/use-has-resume"
import { CVRequiredBlur } from "@/components/shared/cv-required-blur"

export default function JobsPage() {
  const session = useSession();
  const searchParams = useSearchParams()
  const router = useRouter()
  const [selectedJob, setSelectedJob] = useState<Job | null>(null)
  const [jobs, setJobs] = useState<Job[]>([])
  const [loading, setLoading] = useState(true)
  const [showFilters, setShowFilters] = useState(false)
  const { hasResume, loading: resumeLoading } = useHasResume()
  const [location, setLocation] = useState(searchParams.get("location") || "")
// ... (rest of states)
  const { t, isRTL, loading: translationLoading } = useTranslation()

  // Pagination
  const [page, setPage] = useState(parseInt(searchParams.get("page") || "1"))
  const [limit, setLimit] = useState(60)
  const [totalPages, setTotalPages] = useState(0)

  const fetchJobs = async () => {
    setLoading(true)
    const jobs = await getJobs(session.data?.user?.email || "", location, jobType, salaryMin, salaryMax, experience, attendance, query, sort, page, limit, isRTL ? "ar" : "en")

    if (jobs.success) {
      if (jobs.pagination) {
        setTotalPages(jobs.pagination.pages)
      }

      // Transform the API data to match the frontend's Job type
      const transformedJobs = transformJobs(jobs.data)
      setJobs(transformedJobs)
      setLoading(false)
    } else {
      setLoading(false)
      toast.error(t('error'), {
        description: t('failedToLoadJobs')
      })
    }
  }

  const fetchJobApplyStatus = async () => {
    if (session.data?.user?.email) {
      const result = await getAiJobApplyStatus()
      if (!result.error) {
        setJobApplyCount(result.data?.jobCount || 0)
      }
    }
  }

  useEffect(() => {
    if (session.status === "loading") return
    if (translationLoading) return
    if (resumeLoading) return

    fetchJobs()
    fetchJobApplyStatus()
  }, [session.status, location, jobType, salaryMin, salaryMax, experience, attendance, query, sort, page, translationLoading, resumeLoading])

  useEffect(() => {
    const params = new URLSearchParams()
    if (location) params.set("location", location)
    if (jobType) params.set("jobType", jobType)
    if (salaryMin) params.set("salaryMin", salaryMin)
    if (salaryMax) params.set("salaryMax", salaryMax)
    if (experience) params.set("experience", experience)
    if (attendance) params.set("attendance", attendance)
    if (query) params.set("query", query)
    if (sort) params.set("sort", sort)
    if (page > 1) params.set("page", page.toString())

    const newUrl = params.toString() ? `?${params.toString()}` : ""
    router.replace(`/jobs${newUrl}`, { scroll: false })
  }, [location, jobType, salaryMin, salaryMax, experience, attendance, query, sort, page])

  const handleJobSelect = (job: Job) => {
    setSelectedJob(job)
  }

  const handlePageChange = (newPage: number) => {
    setPage(newPage)
  }

  const handleFilters = (filters: any) => {
    setLocation(filters.location || "")
    setJobType(filters.jobType || "")
    setSalaryMin(filters.salaryMin || "")
    setSalaryMax(filters.salaryMax || "")
    setExperience(filters.experience || "")
    setAttendance(filters.attendance || "")
    setSort(filters.sort || "job_date_desc")
    setPage(1) // Reset to first page when applying filters
  }

  const handleSearch = (searchQuery: string) => {
    setQuery(searchQuery)
    setPage(1) // Reset to first page when searching
  }

  const handleFilterToggle = () => {
    setShowFilters(!showFilters)
  }

  if (resumeLoading) {
    return (
      <div className={`flex items-center justify-center min-h-[400px] ${isRTL ? 'text-right' : ''}`}>
        <p className="text-gray-500">{t('loading')}</p>
      </div>
    )
  }

  return (
    <div className={`flex gap-6 h-[calc(100vh-35px)] max-md:flex-col max-w-[90vw] ${isRTL ? 'flex-row-reverse' : ''}`}>
      {/* First column: Search preferences */}
      <div className={`w-80 bg-white rounded-lg shadow-sm overflow-y-auto ${showFilters ? 'block' : 'hidden '}`}>
        <SearchPreferences
          onFilterChange={handleFilters}
          location={location}
          jobType={jobType}
          salaryMin={salaryMin}
          salaryMax={salaryMax}
          experience={experience}
          attendance={attendance}
        />
      </div>

      {/* Second column: Job listings */}
      <div className="flex-1 bg-white rounded-lg shadow-sm overflow-y-auto">
        <CVRequiredBlur hasResume={hasResume}>
          <JobListings
            jobs={jobs}
            selectedJob={selectedJob as any}
            onSelectJob={handleJobSelect}
            loading={loading}
            showFilters={showFilters}
            setShowFilter={handleFilterToggle}
            currentPage={page}
            totalPages={totalPages}
            onPageChange={handlePageChange}
            query={query}
            onQueryChange={handleSearch}
            sort={sort}
            onSortChange={setSort}
          />
        </CVRequiredBlur>
      </div>

      {/* Third column: Job details (conditionally rendered) */}
      {selectedJob && (
        <div className={`!sticky !top-[5px] inset-0 lg:relative lg:inset-auto lg:w-[400px] bg-white rounded-lg shadow-sm overflow-y-auto flex-shrink-0 animate-in slide-in-from-right duration-300 z-50 lg:z-auto max-h-[calc(100vh-35px)] ${isRTL ? 'slide-in-from-left' : 'slide-in-from-right'}`}>
          <JobDetails
            job={selectedJob}
            onClose={() => setSelectedJob(null)}
            jobApplyCount={jobApplyCount}
            onJobApplied={() => {
              // Refresh the page after successful job application
              window.location.reload()
            }}
            userId={session.data?.user?.id || ""}
          />
        </div>
      )}
    </div>
  )
}

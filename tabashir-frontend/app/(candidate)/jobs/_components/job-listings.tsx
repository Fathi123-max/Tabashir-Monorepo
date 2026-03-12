"use client";

import { Filter, Search } from "lucide-react";
import type { Job } from "./types";
import JobCard from "@/components/job-card";
import { useTranslation } from "@/lib/use-translation";

interface JobListingsProps {
  jobs: Job[]
  onSelectJob: (job: Job) => void
  selectedJobId?: string
  setShowFilter: () => void
  showFilters: boolean
  selectedJob: boolean
  loading: boolean
  query: string
  onQueryChange: (value: string) => void
  sort: "job_date_desc" | "job_date_asc" | "salary_asc" | "salary_desc"
  onSortChange: (value: "job_date_desc" | "job_date_asc" | "salary_asc" | "salary_desc") => void
  currentPage: number
  totalPages: number
  onPageChange: (page: number) => void
}

export function JobListings({
  jobs,
  onSelectJob,
  selectedJobId,
  setShowFilter,
  loading,
  query,
  onQueryChange,
  sort,
  onSortChange,
  currentPage,
  totalPages,
  onPageChange
}: JobListingsProps) {
  const { t, isRTL } = useTranslation()

  return (
    <div className={`h-full flex flex-col ${isRTL ? 'text-right' : ''}`}>
      {/* Header */}
      <div className="p-4 sm:p-6 border-b">
        <div className={`flex flex-col gap-2 space-y-4 lg:flex-row lg:items-center lg:justify-between lg:space-y-0 ${isRTL ? 'lg:flex-row-reverse' : ''}`}>
          <div className={`flex flex-col space-y-3 sm:flex-row sm:items-center sm:gap-4 sm:space-y-0 ${isRTL ? 'sm:flex-row-reverse' : ''}`}>
            <button
              onClick={setShowFilter}
              className={`flex items-center justify-center sm:justify-start gap-2 text-gray-600 hover:text-gray-900 py-2 px-3 rounded-lg hover:bg-gray-50 transition-colors ${isRTL ? 'flex-row-reverse' : ''}`}
            >
              <Filter className="w-4 h-4" />
            </button>
            <div className="relative flex-1 sm:flex-initial">
              <input
                type="text"
                placeholder={t("searchJobs")}
                className={`w-full ${isRTL ? 'pr-10 pl-4' : 'pl-10 pr-4'} py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm ${isRTL ? 'text-right' : ''}`}
                value={query}
                onChange={(e) => onQueryChange(e.target.value)}
              />
              <Search className={`w-4 h-4 absolute ${isRTL ? 'right-3' : 'left-3'} top-1/2 transform -translate-y-1/2 text-gray-400`} />
            </div>
          </div>
          <div className={`flex ${isRTL ? 'justify-start lg:justify-end' : 'justify-end lg:justify-start'}`}>
            <select
              className={`w-full sm:w-auto border rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm bg-white text-black ${isRTL ? 'text-right' : ''}`}
              value={sort}
              onChange={(e) => onSortChange(e.target.value as "job_date_desc" | "job_date_asc" | "salary_asc" | "salary_desc")}
            >
              <option value="job_date_desc">{t("newest")}</option>
              <option value="job_date_asc">{t("oldest")}</option>
              <option value="salary_asc">{t("salaryAsc")}</option>
              <option value="salary_desc">{t("salaryDesc")}</option>
            </select>
          </div>
        </div>
      </div>

      {/* Job List */}
      <div className="flex-1 overflow-y-auto">
        {loading ? (
          // Skeleton loading state
          <div className="p-6 space-y-4">
            {[...Array(5)].map((_, i) => (
              <div key={i} className="animate-pulse">
                <div className="h-24 bg-gray-200 rounded-lg"></div>
              </div>
            ))}
          </div>
        ) : jobs.length === 0 ? (
          // No jobs found state
          <div className="flex flex-col items-center justify-center h-full text-gray-500">
            <Search className="w-12 h-12 mb-4" />
            <p className="text-lg font-medium">No jobs found</p>
            <p className="text-sm">Try adjusting your search criteria</p>
          </div>
        ) : (
          // Job cards
          <div className="p-6 space-y-4">
            {jobs.map((job) => (
              <JobCard
                key={job.id}
                job={job}
                onClick={() => onSelectJob(job)}
                isSelected={job.id === selectedJobId}
              />
            ))}
          </div>
        )}
      </div>

      {/* Pagination */}
      {totalPages > 1 && (
        <div className="p-4 border-t bg-white">
          <JobPagination
            currentPage={currentPage}
            totalPages={totalPages}
            onPageChange={onPageChange}
          />
        </div>
      )}
    </div>
  );
}

// Job Pagination Component
interface JobPaginationProps {
  currentPage: number
  totalPages: number
  onPageChange: (page: number) => void
}

function JobPagination({ currentPage, totalPages, onPageChange }: JobPaginationProps) {
  const getPageNumbers = (isMobile: boolean = false) => {
    const pages = []
    // Reduce visible pages on mobile
    const maxVisiblePages = isMobile ? 3 : 5
    let startPage = Math.max(1, currentPage - Math.floor(maxVisiblePages / 2))
    let endPage = Math.min(totalPages, startPage + maxVisiblePages - 1)

    if (endPage - startPage + 1 < maxVisiblePages) {
      startPage = Math.max(1, endPage - maxVisiblePages + 1)
    }

    for (let i = startPage; i <= endPage; i++) {
      pages.push(i)
    }
    return pages
  }

  return (
    <div className="flex flex-col space-y-3 sm:flex-row sm:items-center sm:justify-between sm:space-y-0">
      {/* Page info - hidden on mobile, shown on larger screens */}
      <div className="hidden sm:block text-sm text-gray-700">
        Page {currentPage} of {totalPages}
      </div>

      {/* Mobile: Simple page info */}
      <div className="sm:hidden text-center text-sm text-gray-700">
        {currentPage} / {totalPages}
      </div>

      {/* Desktop Navigation */}
      <div className="hidden sm:flex items-center space-x-2">
        {/* Previous Button */}
        <button
          onClick={() => onPageChange(currentPage - 1)}
          disabled={currentPage <= 1}
          className="px-3 py-2 text-sm rounded-md border disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-50 transition-colors"
        >
          Previous
        </button>

        {/* Page Numbers */}
        <div className="flex space-x-1">
          {currentPage > 3 && (
            <>
              <button
                onClick={() => onPageChange(1)}
                className="px-3 py-2 text-sm rounded-md border hover:bg-gray-50 transition-colors"
              >
                1
              </button>
              {currentPage > 4 && <span className="px-2 py-2 text-sm text-gray-500">...</span>}
            </>
          )}

          {getPageNumbers().map((page) => (
            <button
              key={page}
              onClick={() => onPageChange(page)}
              className={`px-3 py-2 text-sm rounded-md border transition-colors ${page === currentPage
                ? "bg-blue-500 text-white border-blue-500"
                : "hover:bg-gray-50"
                }`}
            >
              {page}
            </button>
          ))}

          {currentPage < totalPages - 2 && (
            <>
              {currentPage < totalPages - 3 && <span className="px-2 py-2 text-sm text-gray-500">...</span>}
              <button
                onClick={() => onPageChange(totalPages)}
                className="px-3 py-2 text-sm rounded-md border hover:bg-gray-50 transition-colors"
              >
                {totalPages}
              </button>
            </>
          )}
        </div>

        {/* Next Button */}
        <button
          onClick={() => onPageChange(currentPage + 1)}
          disabled={currentPage >= totalPages}
          className="px-3 py-2 text-sm rounded-md border disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-50 transition-colors"
        >
          Next
        </button>
      </div>

      {/* Mobile Navigation */}
      <div className="sm:hidden">
        <div className="flex items-center justify-center space-x-4">
          {/* Previous Button */}
          <button
            onClick={() => onPageChange(currentPage - 1)}
            disabled={currentPage <= 1}
            className="flex-1 px-4 py-2 text-sm rounded-md border disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-50 transition-colors text-center"
          >
            Previous
          </button>

          {/* Mobile Page Numbers - only show current and adjacent */}
          <div className="flex items-center space-x-1">
            {getPageNumbers(true).map((page) => (
              <button
                key={page}
                onClick={() => onPageChange(page)}
                className={`w-10 h-10 text-sm rounded-md border transition-colors ${page === currentPage
                  ? "bg-blue-500 text-white border-blue-500"
                  : "hover:bg-gray-50"
                  }`}
              >
                {page}
              </button>
            ))}
          </div>

          {/* Next Button */}
          <button
            onClick={() => onPageChange(currentPage + 1)}
            disabled={currentPage >= totalPages}
            className="flex-1 px-4 py-2 text-sm rounded-md border disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-50 transition-colors text-center"
          >
            Next
          </button>
        </div>
      </div>
    </div>
  )
}
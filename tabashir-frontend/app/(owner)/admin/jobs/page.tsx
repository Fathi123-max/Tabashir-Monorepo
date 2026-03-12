"use client"

import { useState, useEffect } from "react"
import Link from "next/link"
import { ChevronLeft, ChevronRight, Plus } from "lucide-react"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { Button } from "@/components/ui/button"
import AdminJobCard from "../../_components/admin-job-card"
import CreateJobCard from "../../_components/create-job-card"
import { getJobs } from "./actions"
import Loading from "./loading"
import { useTranslation } from "@/lib/use-translation"

export default function JobsPage() {
  const [currentPage, setCurrentPage] = useState(1)
  const [itemsPerPage, setItemsPerPage] = useState(10)
  const [jobs, setJobs] = useState<any[]>([])
  const [totalJobs, setTotalJobs] = useState(0)
  const [totalPages, setTotalPages] = useState(0)
  const [loading, setLoading] = useState(true)
  const { t, isRTL } = useTranslation()

  useEffect(() => {
    const fetchJobs = async () => {
      try {
        const result = await getJobs(currentPage, itemsPerPage)

        console.log(result)

        setJobs(result.jobs)
        setTotalJobs(result.total)
        setTotalPages(result.totalPages)
      } catch (error) {
        console.error('Error fetching jobs:', error)
      } finally {
        setLoading(false)
      }
    }

    fetchJobs()
  }, [currentPage, itemsPerPage])

  if (loading) {
    return <Loading />
  }

  return (
    <div className={`p-6 text-gray-900 ${isRTL ? 'text-right' : ''}`}>
      <div className={`flex justify-between items-center mb-6 ${isRTL ? 'flex-row-reverse' : ''}`}>
        <h1 className="text-2xl font-bold">{t('jobsManagement')}</h1>
        <Link href="/admin/jobs/new">
          <Button className="bg-gradient-to-r from-[#042052] to-[#0D57E1]">
            <Plus className={`h-4 w-4 ${isRTL ? 'ml-2' : 'mr-2'}`} /> {t('createNewJob')}
          </Button>
        </Link>
      </div>

      <div className={`mb-6 flex justify-between items-center ${isRTL ? 'flex-row-reverse' : ''}`}>
        <div className={`text-sm text-gray-500 ${isRTL ? 'text-right' : ''}`}>
          {t('showing')} {(currentPage - 1) * itemsPerPage + 1} {t('to')} {Math.min(currentPage * itemsPerPage, totalJobs)} {t('of')} {totalJobs} {t('results')}
        </div>
        <div className={`flex items-center gap-2 ${isRTL ? 'flex-row-reverse' : ''}`}>
          <span className="text-sm text-gray-500">{t('itemsPerPage')}:</span>
          <Select value={itemsPerPage.toString()} onValueChange={(value) => setItemsPerPage(Number(value))}>
            <SelectTrigger className="w-20">
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="5">5</SelectItem>
              <SelectItem value="10">10</SelectItem>
              <SelectItem value="20">20</SelectItem>
              <SelectItem value="50">50</SelectItem>
            </SelectContent>
          </Select>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6 mb-6">
        <CreateJobCard />
        {jobs.map((job) => (
          <AdminJobCard key={job.id} externalApiJobId={job.externalApiJobId} {...job} />
        ))}
      </div>

      {totalPages > 1 && (
        <div className={`flex justify-center items-center gap-2 ${isRTL ? 'flex-row-reverse' : ''}`}>
          <Button
            variant="outline"
            size="sm"
            onClick={() => setCurrentPage(Math.max(1, currentPage - 1))}
            disabled={currentPage === 1}
            className={`flex items-center gap-1 ${isRTL ? 'flex-row-reverse' : ''}`}
          >
            <ChevronLeft className="h-4 w-4" />
            {t('previous')}
          </Button>

          <div className={`flex items-center gap-1 ${isRTL ? 'flex-row-reverse' : ''}`}>
            {Array.from({ length: Math.min(5, totalPages) }, (_, i) => {
              const pageNumber = i + 1
              const isActive = pageNumber === currentPage
              return (
                <Button
                  key={pageNumber}
                  variant={isActive ? "default" : "outline"}
                  size="sm"
                  onClick={() => setCurrentPage(pageNumber)}
                  className="w-8 h-8 p-0"
                >
                  {pageNumber}
                </Button>
              )
            })}
          </div>

          <Button
            variant="outline"
            size="sm"
            onClick={() => setCurrentPage(Math.min(totalPages, currentPage + 1))}
            disabled={currentPage === totalPages}
            className={`flex items-center gap-1 ${isRTL ? 'flex-row-reverse' : ''}`}
          >
            {t('next')}
            <ChevronRight className="h-4 w-4" />
          </Button>
        </div>
      )}
    </div>
  )
}

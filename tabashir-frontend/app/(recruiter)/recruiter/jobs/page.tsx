"use client"

import { useState, useEffect } from "react"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Badge } from "@/components/ui/badge"
import { Plus, MapPin, Clock, DollarSign, Users, Edit, Trash2 } from "lucide-react"
import Link from "next/link"
import { useSession } from "next-auth/react"
import { getRecruiterJobs } from "@/actions/job"
import { useTranslation } from "@/lib/use-translation"

interface Job {
  id: string
  title: string
  company: string
  location: string | null
  jobType: string
  salaryMin: number
  salaryMax: number
  createdAt: Date
  applicants?: { id: string }[]
}

export default function RecruiterJobsPage() {
  const [jobs, setJobs] = useState<Job[]>([])
  const [isLoading, setIsLoading] = useState(true)
  const { data: session } = useSession()
  const { t, isRTL } = useTranslation()

  useEffect(() => {
    const fetchJobs = async () => {
      try {
        const result = await getRecruiterJobs()
        if (result.success) {
          setJobs(result.jobs || [])
        } else {
          console.error("Error fetching jobs:", result.error)
        }
      } catch (error) {
        console.error("Error fetching jobs:", error)
      } finally {
        setIsLoading(false)
      }
    }

    if (session?.user) {
      fetchJobs()
    }
  }, [session])

  const formatSalary = (min: number, max: number) => {
    return `${min.toLocaleString()} - ${max.toLocaleString()} AED`
  }

  const getJobTypeColor = (jobType: string) => {
    switch (jobType) {
      case "Full Time":
        return "bg-green-100 text-green-800"
      case "Part Time":
        return "bg-blue-100 text-blue-800"
      case "Contract":
        return "bg-purple-100 text-purple-800"
      case "Internship":
        return "bg-orange-100 text-orange-800"
      default:
        return "bg-gray-100 text-gray-800"
    }
  }

  if (isLoading) {
    return (
      <div className={`p-6 ${isRTL ? 'text-right' : ''}`}>
        <div className={`flex justify-between items-center mb-6 ${isRTL ? 'flex-row-reverse' : ''}`}>
          <h1 className="text-2xl font-bold">{t('myJobs')}</h1>
          <Link href="/recruiter/jobs/new">
            <Button className="bg-gradient-to-r from-[#042052] to-[#0D57E1] hover:from-[#0D57E1] hover:to-[#042052] text-white">
              <Plus className={`h-4 w-4 ${isRTL ? 'ml-2' : 'mr-2'}`} />
              {t('createNewJob')}
            </Button>
          </Link>
        </div>
        <div className="grid gap-4">
          {[1, 2, 3].map((i) => (
            <Card key={i} className="animate-pulse">
              <CardContent className="p-6">
                <div className="h-4 bg-gray-200 rounded w-3/4 mb-2"></div>
                <div className="h-3 bg-gray-200 rounded w-1/2 mb-4"></div>
                <div className={`flex gap-2 ${isRTL ? 'flex-row-reverse' : ''}`}>
                  <div className="h-6 bg-gray-200 rounded w-16"></div>
                  <div className="h-6 bg-gray-200 rounded w-20"></div>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    )
  }

  return (
    <div className={`p-6 ${isRTL ? 'text-right' : ''}`}>
      <div className={`flex justify-between items-center mb-6 ${isRTL ? 'flex-row-reverse' : ''}`}>
        <div>
          <h1 className="text-2xl font-bold">{t('myJobs')}</h1>
          <p className="text-gray-600">{t('manageJobPostings')}</p>
        </div>
        <Link href="/recruiter/jobs/new">
          <Button className="bg-gradient-to-r from-[#042052] to-[#0D57E1] hover:from-[#0D57E1] hover:to-[#042052] text-white">
            <Plus className={`h-4 w-4 ${isRTL ? 'ml-2' : 'mr-2'}`} />
            {t('createNewJob')}
          </Button>
        </Link>
      </div>

      {jobs.length === 0 ? (
        <Card>
          <CardContent className={`flex flex-col items-center justify-center py-12 ${isRTL ? 'text-right' : ''}`}>
            <div className="text-center">
              <div className="mx-auto w-24 h-24 bg-gray-100 rounded-full flex items-center justify-center mb-4">
                <Users className="h-12 w-12 text-gray-400" />
              </div>
              <h3 className="text-lg font-semibold mb-2">{t('noJobsPosted')}</h3>
              <p className="text-gray-600 mb-4">
                {t('startByCreating')}
              </p>
              <Link href="/recruiter/jobs/new">
                <Button className="bg-gradient-to-r from-[#042052] to-[#0D57E1] hover:from-[#0D57E1] hover:to-[#042052] text-white">
                  <Plus className={`h-4 w-4 ${isRTL ? 'ml-2' : 'mr-2'}`} />
                  {t('createFirstJob')}
                </Button>
              </Link>
            </div>
          </CardContent>
        </Card>
      ) : (
        <div className="grid gap-4">
          {jobs.map((job) => (
            <Card key={job.id} className="hover:shadow-md transition-shadow">
              <CardContent className="p-6">
                <div className={`flex justify-between items-start mb-4 ${isRTL ? 'flex-row-reverse' : ''}`}>
                  <div className={isRTL ? 'text-right' : ''}>
                    <h3 className="text-lg font-semibold mb-1">{job.title}</h3>
                    <p className="text-gray-600 mb-2">{job.company}</p>
                    <div className={`flex items-center gap-4 text-sm text-gray-500 ${isRTL ? 'flex-row-reverse' : ''}`}>
                      <span className={`flex items-center gap-1 ${isRTL ? 'flex-row-reverse' : ''}`}>
                        <MapPin className="h-4 w-4" />
                        {job.location || t('notSpecified')}
                      </span>
                      <span className={`flex items-center gap-1 ${isRTL ? 'flex-row-reverse' : ''}`}>
                        <Clock className="h-4 w-4" />
                        {new Date(job.createdAt).toLocaleDateString()}
                      </span>
                      <span className={`flex items-center gap-1 ${isRTL ? 'flex-row-reverse' : ''}`}>
                        <DollarSign className="h-4 w-4" />
                        {formatSalary(job.salaryMin, job.salaryMax)}
                      </span>
                    </div>
                  </div>
                  <div className={`flex gap-2 ${isRTL ? 'flex-row-reverse' : ''}`}>
                    <Link href={`/recruiter/jobs/${job.id}/edit`}>
                      <Button variant="outline" size="sm">
                        <Edit className={`h-4 w-4 ${isRTL ? 'ml-1' : 'mr-1'}`} />
                        {t('edit')}
                      </Button>
                    </Link>
                    <Button variant="outline" size="sm" className="text-red-600 hover:text-red-700">
                      <Trash2 className={`h-4 w-4 ${isRTL ? 'ml-1' : 'mr-1'}`} />
                      {t('delete')}
                    </Button>
                  </div>
                </div>

                <div className={`flex items-center justify-between ${isRTL ? 'flex-row-reverse' : ''}`}>
                  <div className={`flex gap-2 ${isRTL ? 'flex-row-reverse' : ''}`}>
                    <Badge className={getJobTypeColor(job.jobType)}>
                      {t(job.jobType.replace(' ', '').toLowerCase())}
                    </Badge>
                    <Badge variant="outline" className={`flex items-center gap-1 ${isRTL ? 'flex-row-reverse' : ''}`}>
                      <Users className="h-3 w-3" />
                      {job.applicants?.length || 0} {t('applications')}
                    </Badge>
                  </div>
                  <Button variant="outline" size="sm">
                    {t('viewApplications')}
                  </Button>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      )}
    </div>
  )
} 
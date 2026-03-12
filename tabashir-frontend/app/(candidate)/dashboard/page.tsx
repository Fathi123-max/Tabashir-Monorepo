"use client"

import { MatchedJobs } from "./_components/matched-jobs"
import { SkillTrendsChart } from "./_components/skill-trends-chart"
import { MatchingJobsChart } from "./_components/matching-jobs-chart"
import { GlobalDemandList } from "./_components/global-demand-list"
import { InterviewScheduleCard } from "./_components/interview-schedule-card"
import { JobOffersCard } from "./_components/job-offers-card"
import { useTranslation } from "@/lib/use-translation"
import { useSession } from "next-auth/react"
import { useEffect, useState } from "react"
import { getUsersSkills, onGetUserProfile } from "@/actions/auth"

export default function Dashboard() {
  const { t, isRTL } = useTranslation()
  const { data: session } = useSession()
  const [user, setUser] = useState<any>(null)
  const [skills, setSkills] = useState<string[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    const fetchData = async () => {
      try {
        const [userProfile, userSkills] = await Promise.all([
          onGetUserProfile(),
          getUsersSkills()
        ])
        setUser(userProfile)
        setSkills(userSkills || [])
      } catch (error) {
        console.error('Error fetching dashboard data:', error)
      } finally {
        setLoading(false)
      }
    }

    if (session) {
      fetchData()
    }
  }, [session])

  if (loading) {
    return (
      <div className={`flex items-center justify-center min-h-[400px] ${isRTL ? 'text-right' : ''}`}>
        <p className="text-gray-500">{t('loading')}</p>
      </div>
    )
  }

  return (
    <div className={`space-y-6 ${isRTL ? 'text-right' : ''}`}>
      <MatchedJobs jobType={user?.jobType || ""} />

      <div className="bg-white rounded-lg p-6 shadow-sm">
        <SkillTrendsChart jobTitle={user?.jobType || "Developer"} skills={skills} />
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <div className="bg-white rounded-lg p-6 shadow-sm">
          <MatchingJobsChart />
        </div>
        <div className="bg-white rounded-lg p-6 shadow-sm text-gray-900">
          <GlobalDemandList jobTitle={user?.jobType || "Developer"} skills={skills} />
        </div>
        <div className="bg-white rounded-lg p-6 shadow-sm space-y-6">
          <div className="relative h-full">
            <InterviewScheduleCard />
            <JobOffersCard />
            {/* Coming Soon Overlay */}
            <div className="absolute inset-0 bg-black/20 backdrop-blur-sm flex items-center justify-center rounded-lg pointer-events-none h-full">
              <div className="bg-gradient-to-r from-blue-500 to-purple-600 text-white px-6 py-3 rounded-full shadow-lg">
                <span className="text-sm font-semibold">🚀 {t('comingSoon')}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

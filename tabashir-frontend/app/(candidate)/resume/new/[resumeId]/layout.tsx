"use client"

import type React from "react"

import { useEffect, useState, use } from "react"
import { Info } from "lucide-react"
import { Card } from "@/components/ui/card"
import { Progress } from "@/components/ui/progress"
import { Button } from "@/components/ui/button"
import { ResumeSidebar } from "../_components/resume-sidebar"
import { useResumeStore } from "../store/resume-store"
import { cn } from "@/lib/utils"
import { getResumeGeneratedStatus, getResumeScore as getResumeScoreAction } from "@/actions/ai-resume"
import { getResumePaymentStatus as getResumePaymentStatusAction } from "@/actions/ai-resume"
import Link from "next/link"
import { useTranslation } from "@/lib/use-translation"

export default function ResumeLayout({
  children,
  params,
}: {
  children: React.ReactNode
  params: Promise<{ resumeId: string }>
}) {
  const { resumeId } = use(params)
  const [resumeScore, setResumeScore] = useState(0)
  const { setFormCompleted, completedForms, getResumeScore, resetForms, setPaymentCompleted, setResumeGenerated, isResumeGenerated, editorMode } = useResumeStore()
  const { t, isRTL } = useTranslation()

  const calculateScore = async () => {
    resetForms();
    const score = await getResumeScoreAction(resumeId)
    if (!score.error) {

      if (score.data?.personalDetails) {
        setFormCompleted("personal-details")
      }
      if (score.data?.professionalSummary) {
        setFormCompleted("professional-summary")
      }
      if (score.data?.employmentHistory) {
        setFormCompleted("employment-history")
      }
      if (score.data?.education) {
        setFormCompleted("education")
      }
      if (score.data?.skills) {
        setFormCompleted("skills")
      }
    }
    else {
      setResumeScore(0)
    }

    const resumePaymentStatus = await getResumePaymentStatusAction(resumeId)

    if (resumePaymentStatus.data?.paymentStatus) {
      setPaymentCompleted(true)
      const resumeScore = getResumeScore();
      setResumeScore(resumeScore)
    }

    const resumeGenerated = await getResumeGeneratedStatus(resumeId);

    if (resumeGenerated.data?.formatedUrl) {
      console.log("resumeGenerated", resumeGenerated.data?.formatedUrl)
      setResumeGenerated(true)
      const resumeScore = getResumeScore();
      setResumeScore(resumeScore)
    }
  }

  // Update score whenever relevant state changes
  useEffect(() => {
    // Force re-calculation of score by directly calling the function
    calculateScore()
  }, [])

  useEffect(() => {
    const score = getResumeScore()
    setResumeScore(score)
  }, [completedForms])

  // Get score color based on value
  const getScoreColor = (score: number) => {
    if (score < 30) return "bg-red-500"
    if (score < 60) return "bg-yellow-500"
    if (score < 100) return "bg-blue-500"
    return "bg-green-500"
  }

  return (
    <>
      <div className="max-w-[1300px] mb-[100px] mx-auto ">
        {/* Full width header card */}
        <div className={`flex flex-wrap justify-between items-center mb-1 ${isRTL ? 'flex-row-reverse' : ''}`}>
          <div className="px-4 text-[#000000] font-medium">
            {t('generateNewResume')}
          </div>
          {isResumeGenerated && <Button variant="outline" size="sm" className="h-8 gap-1 text-gray-700 mt-2 sm:mt-0" asChild>
            <Link href={`/resume/new/${resumeId}/download`}>{t('checkGeneratedResume')}</Link>
          </Button>}
        </div>
        <Card className="rounded-[6px] bg-white py-4 px-6 mb-[50px]" style={{ boxShadow: "0px 4px 4px 0px #00000040" }}>
          <div className="mx-auto">
            <div className={`flex flex-col sm:flex-row justify-between items-start sm:items-center ${isRTL ? 'sm:flex-row-reverse' : ''}`}>
              <div className={`flex items-center gap-2 ${isRTL ? 'flex-row-reverse' : ''}`}>
                <div className={`${getScoreColor(resumeScore)} text-gray-50 text-xs px-4 py-0.5 rounded`}>
                  {resumeScore}%
                </div>
                <span className="text-md font-medium text-gray-700">{t('resumeScore')}</span>
              </div>
              <Button variant="link" size="sm" className="h-8 gap-1 text-gray-700 mt-2 sm:mt-0">
                <Info size={16} />
                <span>{t('tips')}</span>
              </Button>
            </div>
            <Progress value={resumeScore} className="h-2 w-full mt-1 bg-gray-200" indicatorClassName={getScoreColor(resumeScore)} />
          </div>
        </Card>

        {/* Sidebar and content area */}
        <div className={`flex gap-[50px] max-lg:flex-col max-lg:gap-[20px] ${isRTL ? 'flex-row-reverse' : ''}`}>
          {/* Sidebar - always visible when no CV exists, or when editor mode is enabled */}
          {(!isResumeGenerated || editorMode) && <ResumeSidebar resumeId={resumeId} />}

          {/* Main content - takes full width when sidebar is hidden */}
          <div className={cn("flex-1 transition-all duration-300")}>
            {/* Main Content with spacing */}
            <div>
              <div
                className="bg-white p-6 rounded-md"
                style={{ boxShadow: "0px 4px 4px 0px #00000040" }}
              >
                {children}
              </div>
            </div>
          </div>
        </div>
      </div>
    </>
  )
}

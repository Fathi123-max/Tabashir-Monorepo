"use client"

import { useSearchParams } from "next/navigation"
import { Suspense } from "react"
import EnhancedResumeDisplay from "./enhanced-resume-display"

function EnhancedResumeContent() {
  const searchParams = useSearchParams()
  const resumeId = searchParams.get('id')

  if (!resumeId) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="text-center">
          <h1 className="text-2xl font-bold text-gray-900 mb-4">Resume ID Not Found</h1>
          <p className="text-gray-600">Please go back and try viewing your resume again.</p>
        </div>
      </div>
    )
  }

  return <EnhancedResumeDisplay resumeId={resumeId} />
}

export default function EnhancedResumePage() {
  return (
    <Suspense fallback={
      <div className="flex items-center justify-center min-h-screen">
        <div className="text-center">
          <div className="w-8 h-8 border-4 border-blue-200 border-t-blue-500 rounded-full animate-spin mx-auto mb-4"></div>
          <p className="text-gray-600">Loading your enhanced resume...</p>
        </div>
      </div>
    }>
      <EnhancedResumeContent />
    </Suspense>
  )
} 
"use client"

import { useState, useEffect } from "react"
import { Card } from "@/components/ui/card"
import { Progress } from "@/components/ui/progress"
import { Button } from "@/components/ui/button"
import { Info, CheckCircle2 } from "lucide-react"

interface ResumeGenerationViewProps {
  resumeName: string
  resumeScore: number
  onComplete: () => void
}

export function ResumeGenerationView({ resumeName, resumeScore, onComplete }: ResumeGenerationViewProps) {
  const [progress, setProgress] = useState(0)
  const [currentStep, setCurrentStep] = useState(0)

  const steps = [
    "Analyzing your information...",
    "Formatting your resume...",
    "Optimizing for ATS...",
    "Finalizing your resume...",
  ]

  useEffect(() => {
    const interval = setInterval(() => {
      setProgress((prevProgress) => {
        if (prevProgress >= 100) {
          clearInterval(interval)
          return 100
        }
        const newProgress = prevProgress + 1

        // Update step based on progress
        if (newProgress < 25) setCurrentStep(0)
        else if (newProgress < 50) setCurrentStep(1)
        else if (newProgress < 75) setCurrentStep(2)
        else setCurrentStep(3)

        return newProgress
      })
    }, 50)

    return () => clearInterval(interval)
  }, [])

  useEffect(() => {
    if (progress === 100) {
      const timer = setTimeout(() => {
        onComplete()
      }, 1000)
      return () => clearTimeout(timer)
    }
  }, [progress, onComplete])

  return (
    <div className="max-w-2xl mx-auto">
      {/* Header with resume name and score */}
      <Card className="mb-6 p-4 shadow-sm">
        <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center">
          <h1 className="text-lg font-semibold text-gray-900 mb-2 sm:mb-0">{resumeName}</h1>
          <div className="flex items-center gap-2">
            <div className="flex flex-col">
              <div className="flex items-center gap-2">
                <div className="bg-[#FF6B6B] text-white text-xs px-2 py-0.5 rounded">{resumeScore}%</div>
                <span className="text-sm font-medium text-gray-700">Resume Score</span>
              </div>
              <Progress value={resumeScore} className="h-2 w-40 mt-1" />
            </div>
            <Button variant="outline" size="sm" className="ml-2 h-8 gap-1 text-gray-700">
              <Info size={16} />
              <span>Tips</span>
            </Button>
          </div>
        </div>
      </Card>

      {/* Generation progress */}
      <Card className="p-8 shadow-sm">
        <h2 className="text-xl font-semibold text-center text-gray-800 mb-8">Generating Your Resume</h2>

        <div className="mb-8">
          <div className="flex justify-between mb-2">
            <span className="text-sm font-medium text-gray-700">Progress</span>
            <span className="text-sm font-medium text-gray-700">{progress}%</span>
          </div>
          <Progress value={progress} className="h-2" />
        </div>

        <div className="space-y-4 mb-8">
          {steps.map((step, index) => (
            <div key={index} className="flex items-center gap-3">
              {index < currentStep ? (
                <CheckCircle2 className="h-5 w-5 text-green-500" />
              ) : index === currentStep ? (
                <div className="h-5 w-5 rounded-full bg-blue-500 animate-pulse"></div>
              ) : (
                <div className="h-5 w-5 rounded-full border-2 border-gray-300"></div>
              )}
              <span className={`${index <= currentStep ? "text-gray-900" : "text-gray-500"}`}>{step}</span>
            </div>
          ))}
        </div>

        <p className="text-center text-gray-600 text-sm">
          Please wait while we generate your professional resume. This may take a moment.
        </p>
      </Card>
    </div>
  )
}

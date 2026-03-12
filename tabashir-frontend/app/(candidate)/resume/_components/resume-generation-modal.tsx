"use client"

import { useEffect, useState } from "react"
import { Sparkles } from "lucide-react"
import { Card } from "@/components/ui/card"
import { Progress } from "@/components/ui/progress"

interface ResumeGenerationModalProps {
  isOpen: boolean
  onClose: () => void
  resumeName: string
  resumeScore: number
}

export function ResumeGenerationModal({ isOpen, onClose, resumeName, resumeScore }: ResumeGenerationModalProps) {
  const [progress, setProgress] = useState(0)

  useEffect(() => {
    if (!isOpen) return

    // Reset progress when modal opens
    setProgress(0)

    // Simulate progress
    const interval = setInterval(() => {
      setProgress((prev) => {
        if (prev >= 100) {
          clearInterval(interval)
          setTimeout(() => {
            onClose()
          }, 1000)
          return 100
        }
        return prev + 5
      })
    }, 300)

    return () => clearInterval(interval)
  }, [isOpen, onClose])

  if (!isOpen) return null

  return (
    <div className="fixed inset-0 bg-[#F5F5F5] flex flex-col items-center justify-start pt-8 z-50">
      <div className="w-full max-w-6xl mx-auto px-4">
        <h1 className="text-2xl font-bold mb-6 text-black">TABASHIR</h1>

        {/* Resume score card */}
        <Card className="mb-6 p-4 shadow-sm">
          <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center">
            <h2 className="text-lg font-medium text-gray-900 mb-2 sm:mb-0">{resumeName}</h2>
            <div className="flex items-center gap-2">
              <div className="flex flex-col">
                <div className="flex items-center gap-2">
                  <div className="bg-[#FF6B6B] text-white text-xs px-2 py-0.5 rounded">{resumeScore}%</div>
                  <span className="text-sm font-medium">Resume Score</span>
                </div>
                <Progress value={resumeScore} className="h-2 w-40 mt-1" />
              </div>
              <button className="ml-2 h-8 flex items-center gap-1 px-2 py-1 border border-gray-300 rounded-md text-sm">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path
                    d="M12 16V12M12 8H12.01M22 12C22 17.5228 17.5228 22 12 22C6.47715 22 2 17.5228 2 12C2 6.47715 6.47715 2 12 2C17.5228 2 22 6.47715 22 12Z"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                </svg>
                <span>Tips</span>
              </button>
            </div>
          </div>
        </Card>

        {/* Generation card */}
        <div className="max-w-2xl mx-auto">
          <Card className="p-16 shadow-sm flex flex-col items-center justify-center min-h-[300px]">
            <h3 className="text-2xl font-medium text-gray-900 mb-8">Generating Resume</h3>
            <div className="relative">
              <Sparkles size={64} className="text-yellow-400" />
            </div>
          </Card>
        </div>
      </div>
    </div>
  )
}

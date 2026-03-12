"use client"

import { useState, useRef } from "react"
import { Info, ZoomIn, ZoomOut, ChevronLeft, ChevronRight, Download, X } from "lucide-react"
import { Card } from "@/components/ui/card"
import { Progress } from "@/components/ui/progress"
import { Button } from "@/components/ui/button"

interface ResumePreviewModalProps {
  isOpen: boolean
  onClose: () => void
  resumeName: string
  resumeScore: number
}

export function ResumePreviewModal({ isOpen, onClose, resumeName, resumeScore }: ResumePreviewModalProps) {
  const [currentPage, setCurrentPage] = useState(1)
  const [totalPages] = useState(3)
  const [zoomLevel, setZoomLevel] = useState(1)
  const resumeContainerRef = useRef<HTMLDivElement>(null)

  if (!isOpen) return null

  const handleZoomIn = () => {
    setZoomLevel((prev) => Math.min(prev + 0.1, 1.5))
  }

  const handleZoomOut = () => {
    setZoomLevel((prev) => Math.max(prev - 0.1, 0.5))
  }

  const handlePrevPage = () => {
    setCurrentPage((prev) => Math.max(prev - 1, 1))
  }

  const handleNextPage = () => {
    setCurrentPage((prev) => Math.min(prev + 1, totalPages))
  }

  const handleDownload = () => {
    // In a real implementation, this would trigger the resume download
    console.log("Downloading resume...")
  }

  return (
    <div className="w-full max-w-6xl mx-auto px-4 py-8">
      {/* Header */}
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold text-black">TABASHIR</h1>
        <button onClick={onClose} className="p-2 hover:bg-gray-200 rounded-full transition-colors" aria-label="Close">
          <X size={24} />
        </button>
      </div>

      {/* Resume score card */}
      <Card className="mb-6 p-4 shadow-sm">
        <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center">
          <h2 className="text-lg font-medium text-gray-900 mb-2 sm:mb-0">{resumeName}</h2>
          <div className="flex items-center gap-2">
            <div className="flex flex-col">
              <div className="flex items-center gap-2">
                <div
                  className={`${resumeScore === 100 ? "bg-green-500" : "bg-[#FF6B6B]"} text-white text-xs px-2 py-0.5 rounded`}
                >
                  {resumeScore}%
                </div>
                <span className="text-sm font-medium">Resume Score</span>
              </div>
              <Progress value={resumeScore} className="h-2 w-40 mt-1" />
            </div>
            <Button variant="outline" size="sm" className="ml-2 h-8 gap-1">
              <Info size={16} />
              <span>Tips</span>
            </Button>
          </div>
        </div>
      </Card>

      {/* Controls */}
      <div className="flex justify-between items-center mb-4">
        <div className="flex items-center gap-2">
          <div className="bg-white rounded-full p-1 shadow-sm">
            <Button
              variant="ghost"
              size="icon"
              onClick={handleZoomOut}
              disabled={zoomLevel <= 0.5}
              className="h-8 w-8 rounded-full"
            >
              <ZoomOut size={16} />
            </Button>
            <Button
              variant="ghost"
              size="icon"
              onClick={handleZoomIn}
              disabled={zoomLevel >= 1.5}
              className="h-8 w-8 rounded-full"
            >
              <ZoomIn size={16} />
            </Button>
          </div>
        </div>

        <div className="flex items-center gap-2">
          <div className="bg-white rounded-full shadow-sm flex items-center">
            <label className="px-3 text-sm text-gray-600">Editor Mode</label>
            <div className="w-12 h-6 bg-gray-200 rounded-full p-1 cursor-pointer">
              <div className="w-4 h-4 bg-white rounded-full"></div>
            </div>
          </div>

          <div className="relative">
            <Button className="bg-[#002B6B] hover:bg-[#042052] text-white gap-2" onClick={handleDownload}>
              Export Resume
            </Button>
          </div>
        </div>
      </div>

      {/* Resume Preview */}
      <div className="flex-1 overflow-hidden bg-white rounded-lg shadow-md mx-auto max-w-4xl">
        <div
          ref={resumeContainerRef}
          className="h-full overflow-auto p-8"
          style={{ transform: `scale(${zoomLevel})`, transformOrigin: "top center" }}
        >
          {/* Resume Content */}
          <div className="max-w-[800px] mx-auto">
            <h1 className="text-4xl font-bold text-center mb-4">Sami Haider</h1>

            <div className="flex justify-center items-center gap-4 text-sm text-gray-600 mb-8">
              <span>New York City, USA</span>
              <span className="w-1 h-1 bg-gray-400 rounded-full"></span>
              <span>Samihaider@gmail.com</span>
              <span className="w-1 h-1 bg-gray-400 rounded-full"></span>
              <span>+01-799-2233</span>
              <span className="w-1 h-1 bg-gray-400 rounded-full"></span>
              <span>sami/linkedin.com</span>
            </div>

            <div className="mb-6">
              <h2 className="text-xl font-bold border-b border-gray-300 pb-1 mb-3">Career objective</h2>
              <p className="text-sm text-gray-700">
                Creative and detail-oriented UI/UX Designer with expertise in Figma, Adobe XD, and front-end development
                principles. Passionate about designing user-centered interfaces that enhance engagement and usability.
                Strong ability to conduct user research, create wireframes, and develop interactive prototypes. Proven
                experience in delivering intuitive digital experiences for e-commerce and SaaS platforms.
              </p>
            </div>

            <div>
              <h2 className="text-xl font-bold border-b border-gray-300 pb-1 mb-3">Professional Experience</h2>

              <div className="mb-4">
                <h3 className="font-bold">CEO & Founder</h3>
                <p className="text-sm text-gray-700">
                  Creative and detail-oriented UI/UX Designer with expertise in Figma, Adobe XD, and front-end
                  development principles. Passionate about designing user-centered interfaces that enhance engagement
                  and usability. Strong ability to conduct user research, create wireframes, and develop interactive
                  prototypes. Proven experience in delivering intuitive digital experiences for e-commerce and SaaS
                  platforms.
                </p>
              </div>

              <div className="mb-4">
                <h3 className="font-bold">CEO & Founder</h3>
                <p className="text-sm text-gray-700">
                  Creative and detail-oriented UI/UX Designer with expertise in Figma, Adobe XD, and front-end
                  development principles. Passionate about designing user-centered interfaces that enhance engagement
                  and usability. Strong ability to conduct user research, create wireframes, and develop interactive
                  prototypes. Proven experience in delivering intuitive digital experiences for e-commerce and SaaS
                  platforms.
                </p>
              </div>

              <div>
                <h3 className="font-bold">CEO & Founder</h3>
                <p className="text-sm text-gray-700">
                  Creative and detail-oriented UI/UX Designer with expertise in Figma, Adobe XD, and front-end
                  development principles. Passionate about designing user-centered interfaces that enhance engagement
                  and usability. Strong ability to conduct user research, create wireframes, and develop interactive
                  prototypes. Proven experience in delivering intuitive digital experiences for e-commerce and SaaS
                  platforms.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Pagination */}
      <div className="flex justify-center items-center gap-4 mt-6">
        <Button
          variant="outline"
          size="icon"
          onClick={handlePrevPage}
          disabled={currentPage === 1}
          className="h-8 w-8 rounded-full"
        >
          <ChevronLeft size={16} />
        </Button>

        <div className="flex items-center gap-2">
          {Array.from({ length: totalPages }).map((_, index) => (
            <button
              key={index}
              className={`w-2 h-2 rounded-full ${currentPage === index + 1 ? "bg-[#002B6B]" : "bg-gray-300"}`}
              onClick={() => setCurrentPage(index + 1)}
              aria-label={`Go to page ${index + 1}`}
            />
          ))}
        </div>

        <Button
          variant="outline"
          size="icon"
          onClick={handleNextPage}
          disabled={currentPage === totalPages}
          className="h-8 w-8 rounded-full"
        >
          <ChevronRight size={16} />
        </Button>
      </div>

      {/* Download Button */}
      <div className="flex justify-center mt-6">
        <Button
          className="bg-gradient-to-r from-[#042052] to-[#0D57E1] hover:opacity-90 text-white gap-2 px-6"
          onClick={handleDownload}
        >
          <Download size={18} />
          Download Resume
        </Button>
      </div>
    </div>
  )
}

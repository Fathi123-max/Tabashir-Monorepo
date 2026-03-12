"use client"

import type React from "react"
import { useState, useRef } from "react"
import { X, Upload } from "lucide-react"
import { Sparkles } from "lucide-react"
import { useRouter } from "next/navigation"
import { onCandidateResumeUpload, onUploadResume, processResumeWithAIAfterUpload } from "@/actions/resume"
import { useTranslation } from "@/lib/use-translation"

interface ResumeUploadModalProps {
  isOpen: boolean
  onClose: () => void
  onUploadSuccess: (newResume: { id: string; filename: string; createdAt: Date; formatedUrl: string | null; originalUrl: string; formatedContent: string | null; }) => void;
  onAiEnhance: () => void;
}

export function ResumeUploadModal({ isOpen, onClose, onUploadSuccess, onAiEnhance }: ResumeUploadModalProps) {
  const { t } = useTranslation()
  const router = useRouter()
  const [isDragging, setIsDragging] = useState(false)
  const [isLoading, setIsLoading] = useState(false)
  const [uploadStatus, setUploadStatus] = useState<"idle" | "success" | "error">("idle")
  const [errorMessage, setErrorMessage] = useState("")
  const fileInputRef = useRef<HTMLInputElement>(null)

  if (!isOpen) return null

  const handleDragOver = (e: React.DragEvent) => {
    e.preventDefault()
    setIsDragging(true)
  }

  const handleDragLeave = () => {
    setIsDragging(false)
  }

  const handleDrop = async (e: React.DragEvent) => {
    e.preventDefault()
    setIsDragging(false)

    const file = e.dataTransfer.files?.[0]
    if (file) {
      await handleFileUpload(file)
    }
  }

  const handleFileSelect = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0]
    if (file) {
      await handleFileUpload(file)
    }
  }

  const handleFileUpload = async (file: File) => {
    try {
      setIsLoading(true)
      setUploadStatus("idle")
      setErrorMessage("")

      // First step: Upload the file
      const uploadResult = await onUploadResume(file)

      if (uploadResult.error) {
        setUploadStatus("error")
        setErrorMessage(uploadResult.message)
        return
      }

      // Show success message for upload and close modal
      setUploadStatus("success")
      if (uploadResult.newResume) {
        onUploadSuccess(uploadResult.newResume)
      }

      setTimeout(() => {
        setUploadStatus("idle")
        onClose()
      }, 1000)

      // Second step: Process with AI in the background after modal closes
      if (uploadResult.originalFile) {
        try {
          const processResult = await processResumeWithAIAfterUpload(uploadResult.originalFile.id)

          if (processResult.error) {
            console.error("AI Processing Error:", processResult.message)
            return
          }
        } catch (error) {
          console.error("Background AI Processing Error:", error)
        }
      }
    } catch (error) {
      setUploadStatus("error")
      setErrorMessage(error instanceof Error ? error.message : t("failedToUploadResume"))
    } finally {
      setIsLoading(false)
    }
  }

  const handleCreateWithAI = () => {
    onClose()
    router.push("/resume/new")
  }

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
      <div className="bg-white rounded-lg w-full max-w-md relative">
        {/* Close button */}
        <button
          onClick={onClose}
          className="absolute right-4 top-4 text-gray-500 hover:text-gray-700"
          aria-label={t("close")}
        >
          <X size={20} />
        </button>

        {/* Modal content */}
        <div className="p-6">
          <h2 className="text-2xl font-bold mb-1 text-gray-900">{t("uploadYourResume")}</h2>
          <p className="text-sm text-gray-600 mb-6">{t("helpRecruiterKnowAboutYou")}</p>

          {/* Upload area */}
          <div
            className={`relative border-2 border-dashed rounded-lg p-8 flex flex-col items-center justify-center cursor-pointer mb-6 ${isDragging ? "border-blue-500 bg-blue-50" : "border-gray-300"
              }`}
            onDragOver={handleDragOver}
            onDragLeave={handleDragLeave}
            onDrop={handleDrop}
            onClick={() => fileInputRef.current?.click()}
          >
            <input
              type="file"
              ref={fileInputRef}
              className="hidden"
              accept="application/pdf"
              onChange={handleFileSelect}
            />
            <div className="w-12 h-12 rounded-full bg-gray-100 flex items-center justify-center mb-4">
              <Upload className="text-gray-500" size={24} />
            </div>
            <p className="text-sm text-gray-600 mb-4">{t("dragAndDropOrClickToUpload")}</p>

            {/* Loading overlay */}
            {isLoading && (
              <div className="absolute inset-0 bg-white/80 flex flex-col items-center justify-center rounded-lg z-10">
                <div className="w-12 h-12 border-4 border-blue-200 border-t-blue-500 rounded-full animate-spin mb-4"></div>
                <p className="text-sm text-gray-700">{t("uploadingYourResume")}</p>
              </div>
            )}

            {/* Success message */}
            {uploadStatus === "success" && (
              <div className="absolute inset-0 bg-green-50 flex flex-col items-center justify-center rounded-lg z-10">
                <div className="w-12 h-12 rounded-full bg-green-100 flex items-center justify-center mb-4">
                  <svg
                    className="w-6 h-6 text-green-500"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                  </svg>
                </div>
                <p className="text-sm text-green-700">{t("resumeUploadedSuccessfully")}</p>
              </div>
            )}

            {/* Error message */}
            {uploadStatus === "error" && (
              <div className="absolute inset-0 bg-red-50 flex flex-col items-center justify-center rounded-lg z-10">
                <div className="w-12 h-12 rounded-full bg-red-100 flex items-center justify-center mb-4">
                  <svg
                    className="w-6 h-6 text-red-500"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                  </svg>
                </div>
                <p className="text-sm text-red-700">{errorMessage}</p>
              </div>
            )}
          </div>

          {/* Divider */}
          <div className="flex items-center mb-6">
            <div className="flex-grow h-px bg-gray-200"></div>
            <span className="px-4 text-sm text-gray-500">{t("or")}</span>
            <div className="flex-grow h-px bg-gray-200"></div>
          </div>

          {/* AI button */}
          <button
            onClick={handleCreateWithAI}
            className="w-full py-3 bg-gradient-to-r from-[#042052] to-[#0D57E1] text-white rounded-md font-medium flex items-center justify-center gap-2 hover:opacity-90"
          >
            <Sparkles size={16} className="text-yellow-300" />
            {t("createNewUsingAI")}
          </button>

          <button
            onClick={onAiEnhance}
            className="bg-gradient-to-r from-purple-600 to-pink-600 text-white px-4 rounded-md flex items-center gap-2 hover:opacity-90 w-full mt-3 text-center justify-center py-3 font-medium"
          >
            <Sparkles size={20} />
            <span>{t("uploadAndEnhance")}</span>
          </button>
        </div>
      </div>
    </div>
  )
}
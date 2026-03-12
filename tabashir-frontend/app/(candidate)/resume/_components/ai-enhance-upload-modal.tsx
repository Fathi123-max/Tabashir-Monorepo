"use client"

import type React from "react"
import { useState, useRef } from "react"
import { X, Upload, Sparkles, Loader2 } from "lucide-react"
import { useRouter } from "next/navigation"
import { useSession } from "next-auth/react"
import { toast } from "sonner"
import { uploadCVFile } from "@/actions/ai-resume"

interface AiEnhanceUploadModalProps {
  isOpen: boolean
  onClose: () => void
}

export function AiEnhanceUploadModal({ isOpen, onClose }: AiEnhanceUploadModalProps) {
  const router = useRouter()
  const { data: session } = useSession()
  const [isDragging, setIsDragging] = useState(false)
  const [isLoading, setIsLoading] = useState(false)
  const [uploadStatus, setUploadStatus] = useState<"idle" | "success" | "error">("idle")
  const [errorMessage, setErrorMessage] = useState("")
  const fileInputRef = useRef<HTMLInputElement>(null)
  const token = process.env.NEXT_PUBLIC_API_TOKEN;


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

      if (!session?.user?.id) {
        throw new Error("User session not found")
      }

      // First, create an AI resume record
      const createResumeResponse = await fetch('/api/ai-resume/create', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          userId: session.user.id,
        }),
      });

      if (!createResumeResponse.ok) {
        throw new Error("Failed to create AI resume record")
      }

      const { resumeId } = await createResumeResponse.json();

      // Create FormData for the API call
      const formData = new FormData()
      formData.append("file", file)
      formData.append("output_language", "regular")
      formData.append("user_id", session.user.id)
      formData.append("resume_id", resumeId)

      // Call the backend API
      const response = await fetch(`${process.env.NEXT_PUBLIC_BACKEND_URL}/api/v1/resume/format`, {
        method: "POST",
        body: formData,
        headers: {
          "X-API-TOKEN": `${token}`,
        },
      })

      if (!response.ok) {
        throw new Error("Failed to enhance resume")
      }

      // Get the file as arrayBuffer since API returns file directly
      const fileArrayBuffer = await response.arrayBuffer()

      if (!fileArrayBuffer) {
        throw new Error("Failed to generate enhanced resume")
      }

      // Convert arrayBuffer to Blob
      const blob = new Blob([fileArrayBuffer], { type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' })

      // Create a File object from the blob
      const enhancedFile = new File([blob], file.name.replace(/\.[^/.]+$/, "") + "_enhanced.docx", {
        type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
      })

      // Upload the enhanced file to the database
      const uploadResult = await uploadCVFile(enhancedFile, resumeId)
      if (uploadResult.error || !uploadResult.data) {
        throw new Error(uploadResult.message || "Failed to upload enhanced resume")
      }

      setUploadStatus("success")

      // Navigate to display page with the enhanced resume ID
      setTimeout(() => {
        onClose()
        setUploadStatus("idle")

        // Navigate to a page to display the enhanced resume using the ID
        router.push(`/resume/enhanced?id=${resumeId}`)
      }, 1500)

    } catch (error) {
      setUploadStatus("error")
      setErrorMessage(error instanceof Error ? error.message : "Failed to enhance resume")
      toast.error(error instanceof Error ? error.message : "Failed to enhance resume")
    } finally {
      setIsLoading(false)
    }
  }

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
      <div className="bg-white rounded-lg w-full max-w-md relative">
        {/* Close button */}
        <button
          onClick={onClose}
          className="absolute right-4 top-4 text-gray-500 hover:text-gray-700"
          aria-label="Close"
        >
          <X size={20} />
        </button>

        {/* Modal content */}
        <div className="p-6">
          <div className="flex items-center mb-2">
            <Sparkles className="text-yellow-400 mr-2" size={20} />
            <h2 className="text-2xl font-bold text-gray-900">Upload & Enhance with AI</h2>
          </div>
          <p className="text-sm text-gray-600 mb-6">Upload your existing resume and let AI enhance it for you</p>

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
              accept="application/pdf,.doc,.docx"
              onChange={handleFileSelect}
            />
            <div className="w-12 h-12 rounded-full bg-gradient-to-r from-blue-100 to-purple-100 flex items-center justify-center mb-4">
              <Upload className="text-blue-600" size={24} />
            </div>
            <p className="text-sm text-gray-600 mb-2">Drag and drop or click to upload</p>
            <p className="text-xs text-gray-500">Supports PDF, DOC, and DOCX files</p>

            {/* Loading overlay */}
            {isLoading && (
              <div className="absolute inset-0 bg-white/90 flex flex-col items-center justify-center rounded-lg z-10">
                <div className="flex items-center justify-center mb-4">
                  <Loader2 className="w-8 h-8 text-blue-500 animate-spin mr-2" />
                  <Sparkles className="w-6 h-6 text-yellow-400 animate-pulse" />
                </div>
                <p className="text-sm text-gray-700 font-medium">Enhancing your resume with AI...</p>
                <p className="text-xs text-gray-500 mt-1">This may take a few moments</p>
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
                <p className="text-sm text-green-700 font-medium">Resume enhanced successfully!</p>
                <p className="text-xs text-green-600 mt-1">Redirecting to view your enhanced resume...</p>
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
                <p className="text-sm text-red-700 text-center">{errorMessage}</p>
                <button
                  onClick={() => setUploadStatus("idle")}
                  className="text-xs text-red-600 underline mt-2"
                >
                  Try again
                </button>
              </div>
            )}
          </div>

          {/* Info box */}
          <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
            <div className="flex items-start">
              <Sparkles className="text-blue-500 mr-2 mt-0.5" size={16} />
              <div>
                <h4 className="text-sm font-medium text-blue-800 mb-1">AI Enhancement Features</h4>
                <ul className="text-xs text-blue-700 space-y-1">
                  <li>• Professional formatting and layout</li>
                  <li>• Grammar and language optimization</li>
                  <li>• ATS-friendly structure</li>
                  <li>• Enhanced readability</li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
} 
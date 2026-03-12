"use client"

import { useState, useEffect } from "react"
import { Plus, Download, Trash2, FileText, Loader2, Sparkles, Upload } from "lucide-react"
import { ResumeUploadModal } from "./resume-upload-modal"
import { AiEnhanceUploadModal } from "./ai-enhance-upload-modal"
import { DeleteConfirmationModal } from "./delete-confirmation-modal"
import { toast } from "sonner"
import { deleteResume, downloadResume } from "@/actions/resume"
import { uploadCVFile } from "@/actions/ai-resume"
import { UserProfileHeader } from "../../dashboard/_components/user-profile-header"
import { useTranslation } from "@/lib/use-translation"

interface Resume {
  id: string
  filename: string
  createdAt: Date
  formatedUrl: string | null
  originalUrl: string
  formatedContent: string | null
}

interface AiResume {
  id: string
  formatedUrl: string | null
  createdAt: Date
}

interface ResumeListClientProps {
  initialResumes: Resume[]
}

export function ResumeListClient({
  initialResumes,
}: ResumeListClientProps) {
  const [isModalOpen, setIsModalOpen] = useState(false)
  const [isAiEnhanceModalOpen, setIsAiEnhanceModalOpen] = useState(false)
  const [isDeleteModalOpen, setIsDeleteModalOpen] = useState(false)
  const [selectedResume, setSelectedResume] = useState<Resume | null>(null)
  const [resumes, setResumes] = useState<Resume[]>(initialResumes)
  const [isLoading, setIsLoading] = useState(false)
  const [downloadingResumeId, setDownloadingResumeId] = useState<string | null>(null)
  const { t, isRTL } = useTranslation()

  const handleAiEnhance = () => {
    setIsAiEnhanceModalOpen(true)
  }

  // Note: Initial data is fetched on the server, no need for useEffect fetch here
  // If you need real-time updates, you might consider alternative approaches like polling or websockets.

  const handleUploadSuccess = (newResume: Resume) => {
    setResumes(prev => [...prev, newResume])
    setIsModalOpen(false)
    toast.success(t('success'), {
      description: t('resumeUploadedSuccessfully')
    })
  }

  const handleDeleteClick = (resume: Resume) => {
    setSelectedResume(resume)
    setIsDeleteModalOpen(true)
  }

  const handleDeleteConfirm = async () => {
    if (!selectedResume) return

    try {
      const result = await deleteResume(selectedResume.id)

      if (!result.error) {
        setResumes(prev => prev.filter(r => r.id !== selectedResume.id))
        toast.success(t('success'), {
          description: t('resumeDeletedSuccessfully')
        })
      } else {
        toast.error(t('error'), {
          description: result.message || t('failedToDeleteResume')
        })
      }
    } catch (error) {
      console.error('Error deleting resume:', error)
      toast.error(t('error'), {
        description: t('somethingWentWrong')
      })
    }

    setIsDeleteModalOpen(false)
    setSelectedResume(null)
  }

  const handleDownload = async (resumeId: string, filename: string) => {
    setDownloadingResumeId(resumeId)

    try {
      const result = await downloadResume(resumeId)

      if (result.data) {
        // Create blob and download
        const url = result.data.url
        window.open(url, '_blank')

        toast.success(t('success'), {
          description: t('resumeDownloadedSuccessfully')
        })
      } else {
        toast.error(t('error'), {
          description: result.message || t('failedToDownloadResume')
        })
      }
    } catch (error) {
      console.error('Error downloading resume:', error)
      toast.error(t('error'), {
        description: t('somethingWentWrong')
      })
    } finally {
      setDownloadingResumeId(null)
    }
  }

  const handleAiEnhanceUpload = async (file: File) => {
    setIsLoading(true)
    try {
      const result = await uploadCVFile(file, "ai-enhance")

      if (result.data) {
        toast.success(t('success'), {
          description: t('cvUploadedSuccessfully')
        })
        setIsAiEnhanceModalOpen(false)
        // Optionally refresh the page or update state
        window.location.reload()
      } else {
        toast.error(t('error'), {
          description: result.message || t('failedToUploadCV')
        })
      }
    } catch (error) {
      console.error('Error uploading CV:', error)
      toast.error(t('error'), {
        description: t('somethingWentWrong')
      })
    } finally {
      setIsLoading(false)
    }
  }

  return (
    <div className={`bg-white rounded-lg p-6 min-h-[calc(100vh-35px)] ${isRTL ? 'text-right' : ''}`}>

      <div className="mt-6">
        <div className={`flex justify-between items-center mb-6 ${isRTL ? 'flex-row-reverse' : ''}`}>
          <h1 className="text-2xl font-bold text-gray-900">{t('myResumes')}</h1>
          <div className={`flex gap-3 ${isRTL ? 'flex-row-reverse' : ''}`}>
            <button
              onClick={handleAiEnhance}
              className={`flex items-center gap-2 px-4 py-2 bg-gradient-to-r from-purple-600 to-pink-600 text-white rounded-lg hover:from-purple-700 hover:to-pink-700 transition-colors ${isRTL ? 'flex-row-reverse' : ''}`}
            >
              <Sparkles className="h-4 w-4" />
              {t('aiEnhance')}
            </button>
            <button
              onClick={() => setIsModalOpen(true)}
              className={`flex items-center gap-2 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors ${isRTL ? 'flex-row-reverse' : ''}`}
            >
              <Plus className="h-4 w-4" />
              {t('uploadResume')}
            </button>
          </div>
        </div>

        {resumes.length === 0 ? (
          <div className="text-center py-12">
            <FileText className="h-16 w-16 text-gray-300 mx-auto mb-4" />
            <h3 className="text-xl font-semibold text-gray-900 mb-2">{t('noResumesFound')}</h3>
            <p className="text-gray-600 mb-6">{t('uploadFirstResume')}</p>
            <button
              onClick={() => setIsModalOpen(true)}
              className={`flex items-center gap-2 px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors mx-auto ${isRTL ? 'flex-row-reverse' : ''}`}
            >
              <Upload className="h-5 w-5" />
              {t('uploadResume')}
            </button>
          </div>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {resumes.map((resume) => (
              <div key={resume.id} className="border border-gray-200 rounded-lg p-6 hover:shadow-md transition-shadow overflow-hidden">
                <div className={`flex items-start justify-between mb-4 ${isRTL ? 'flex-row-reverse' : ''}`}>
                  <div className={`flex items-center gap-3 flex-1 ${isRTL ? 'flex-row-reverse' : ''}`}>
                    <div className="p-2 bg-blue-100 rounded-lg">
                      <FileText className="h-6 w-6 text-blue-600" />
                    </div>
                    <div className={`min-w-0 flex-1 ${isRTL ? 'text-right' : ''}`}>
                      <h3 className="font-semibold text-gray-900 truncate text-sm">
                        {resume.filename.split(".")[0].slice(0, 15) + (resume.filename.split(".")[0].length > 15 ? "..." : "") + resume.filename.split(".")[1]}
                      </h3>
                      <p className="text-sm text-gray-500">
                        {new Date(resume.createdAt).toLocaleDateString()}
                      </p>
                    </div>
                  </div>
                </div>

                <div className={`flex gap-2 ${isRTL ? 'flex-row-reverse' : ''}`}>
                  <button
                    onClick={() => handleDownload(resume.id, resume.filename)}
                    disabled={downloadingResumeId === resume.id}
                    className={`flex items-center gap-2 px-3 py-2 text-sm bg-gray-100 text-gray-700 rounded hover:bg-gray-200 transition-colors flex-1 justify-center disabled:opacity-50 ${isRTL ? 'flex-row-reverse' : ''}`}
                  >
                    {downloadingResumeId === resume.id ? (
                      <Loader2 className="h-4 w-4 animate-spin" />
                    ) : (
                      <Download className="h-4 w-4" />
                    )}
                    {downloadingResumeId === resume.id ? t('downloading') : t('download')}
                  </button>
                  <button
                    onClick={() => handleDeleteClick(resume)}
                    className="flex items-center gap-2 px-3 py-2 text-sm bg-red-100 text-red-700 rounded hover:bg-red-200 transition-colors"
                  >
                    <Trash2 className="h-4 w-4" />
                    {t('delete')}
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      <ResumeUploadModal
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        onUploadSuccess={handleUploadSuccess}
        onAiEnhance={handleAiEnhance}
      />

      <AiEnhanceUploadModal
        isOpen={isAiEnhanceModalOpen}
        onClose={() => setIsAiEnhanceModalOpen(false)}
      />

      <DeleteConfirmationModal
        isOpen={isDeleteModalOpen}
        onClose={() => setIsDeleteModalOpen(false)}
        onConfirm={handleDeleteConfirm}
        title={t('deleteResume')}
        description={t('confirmDeleteResume')}
      />
    </div>
  )
}
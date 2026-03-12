"use client"

import { useState, useEffect } from "react"
import { X, Globe, Building2, Briefcase, DollarSign, Calendar, Loader2, User, Mail, Contact } from "lucide-react"
import type { Job } from "./types"
import Image from "next/image"
import { ApplicationModal } from "./application-modal"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { getUserResumes } from "@/actions/resume"
import { Resume } from "@prisma/client"
import { toast } from "sonner"
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog"
import { Button } from "@/components/ui/button"
import { useSession } from "next-auth/react"
import { submitEasyApply } from "@/actions/job/easy-apply"
import { useRouter } from "next/navigation"
import { useTranslation } from "@/lib/use-translation"
import { submitAiJobApply, submitJobApply } from "@/actions/ai-resume"
import Link from "next/link"

interface JobDetailsProps {
  job: Job
  onClose: () => void
  isPreview?: boolean
  jobApplyCount?: number
  onJobApplied?: () => void
  userId: string
}

export function JobDetails({ job, onClose, isPreview = false, jobApplyCount = 0, onJobApplied, userId }: JobDetailsProps) {
  const { t, isRTL, loading } = useTranslation()
  const [isModalOpen, setIsModalOpen] = useState(false)
  const [showResumeModal, setShowResumeModal] = useState(false)
  const [resumeList, setResumeList] = useState<Resume[]>([])
  const [selectedResume, setSelectedResume] = useState<Resume | null>(null)
  const [isApplying, setIsApplying] = useState(false)
  const [showSuccessModal, setShowSuccessModal] = useState(false)
  const [resumeLoading, setResumeLoading] = useState(false)
  const session = useSession()
  const token = process.env.NEXT_PUBLIC_API_TOKEN;
  const router = useRouter();
  // Fetch user resumes when component mounts
  useEffect(() => {
    async function fetchResumes() {
      setResumeLoading(true)
      const response = await getUserResumes()
      if (response.data) {
        setResumeList(response.data)
      }
      setResumeLoading(false)
    }
    if (!isPreview) {
      fetchResumes()
    }
  }, [isPreview])

  const handleEasyApply = async () => {
    if (jobApplyCount <= 1) {
      toast.error("You need more than one job apply count to use Easy Apply")
      return
    }

    setIsApplying(true)
    try {
      // Use the latest resume if available
      const selectedResumeId = resumeList.length > 0 ? resumeList[0].id : undefined
      const result = await submitEasyApply(job.id, selectedResumeId)

      if (result.success) {
        toast.success(result.message || "Successfully applied for the job!")
        setShowSuccessModal(true)

        // Call the callback to refresh the page
        if (onJobApplied) {
          onJobApplied()
          router.refresh()
        }
      } else {
        toast.error(result.error || "Failed to apply for job")
      }
    } catch (error: any) {
      toast.error(error.message || "Failed to apply for job")
    } finally {
      setIsApplying(false)
    }
  }

  const handleApplyWithResume = async () => {
    if (!selectedResume) {
      toast.error("Please select a resume")
      return
    }

    setIsApplying(true)
    try {
      // Fetch the file as a Blob
      const fileResponse = await fetch(selectedResume.originalUrl)
      if (!fileResponse.ok) {
        throw new Error("Failed to fetch resume file")
      }
      const fileBlob = await fileResponse.blob()
      const file = new File([fileBlob], selectedResume.filename, { type: fileBlob.type })

      // Prepare form data
      const formData = new FormData()
      formData.append("email", session.data?.user?.email || "")
      formData.append("user_id", userId || "")
      formData.append("file", file)
      formData.append("job_id", job.id)

      // Make API call
      const response = await fetch(`${process.env.NEXT_PUBLIC_BACKEND_URL}/api/v1/resume/${job.id}/apply`, {
        method: "POST",
        body: formData,
        headers: {
          "X-API-TOKEN": `${token}`,
        },
      })

      if (!response.ok) {
        const errorData = await response.json()
        throw new Error(errorData.error || "Failed to apply for job")
      }

      // Update job apply count
      await submitJobApply(userId)

      handleEasyApply()

      // Success
      setShowResumeModal(false)
      setShowSuccessModal(true)
      toast.success("Successfully applied for the job!")

      // Call the callback to refresh the page
      if (onJobApplied) {
        onJobApplied()
      }
    } catch (error: any) {
      toast.error(error.message || "Failed to apply for job")
    } finally {
      setIsApplying(false)
    }
  }

  return (
    <div className="p-6 max-w-[90vw]">
      {/* Application Modal - Only show if not in preview mode */}
      {!isPreview && (
        <ApplicationModal
          isOpen={isModalOpen}
          onClose={() => setIsModalOpen(false)}
          jobTitle={job.title}
          companyName={job.company}
        />
      )}

      {/* Resume Selection Modal */}
      <Dialog open={showResumeModal} onOpenChange={setShowResumeModal}>
        <DialogContent className="max-w-3xl max-h-[80vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle>{t('selectResumeToApply')}</DialogTitle>
            <DialogDescription>
              {t('chooseResumeForJob')} {job.title} {t('at')} {job.company}
            </DialogDescription>
          </DialogHeader>

          {resumeLoading ? <div className="flex justify-center items-center h-full mt-5 text-lg">
            <Loader2 className="w-6 h-6 animate-spin" /> {t('loading')}
          </div> : <>
            {resumeList.length === 0 && (
              <div className="text-center py-8 text-gray-500">
                {t('noResumesFound')}
              </div>
            )}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4 py-4">
              {resumeList.map((resume) => (
                <div
                  key={resume.id}
                  onClick={() => setSelectedResume(resume)}
                  className={`cursor-pointer rounded-lg border-2 p-4 transition-all ${selectedResume?.id === resume.id
                    ? "border-blue-500 bg-blue-50"
                    : "border-gray-200 hover:border-gray-300"
                    }`}
                >
                  <div className="flex items-center justify-between mb-2">
                    <h3 className="font-medium text-sm truncate text-black">{resume.filename.split(".")[0].slice(0, 15) + (resume.filename.split(".")[0].length > 15 ? "..." : "") + resume.filename.split(".")[1]}</h3>
                    {selectedResume?.id === resume.id && (
                      <div className="w-5 h-5 bg-blue-500 rounded-full flex items-center justify-center">
                        <svg className="w-3 h-3 text-white" fill="currentColor" viewBox="0 0 20 20">
                          <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                        </svg>
                      </div>
                    )}
                  </div>
                  <p className="text-xs text-gray-500 mb-2">
                    {t('uploaded')}: {new Date(resume.createdAt).toLocaleDateString()}
                  </p>
                </div>
              ))}
            </div>
          </>}

          <DialogFooter>
            <Button variant="outline" onClick={() => setShowResumeModal(false)}>
              {t('cancel')}
            </Button>
            <Button
              onClick={handleApplyWithResume}
              disabled={!selectedResume || isApplying}
            >
              {isApplying ? (
                <>
                  <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                  {t('applying')}
                </>
              ) : (
                t('applyNow')
              )}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Success Modal */}
      <Dialog open={showSuccessModal} onOpenChange={setShowSuccessModal}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle className="text-green-600">{t('applicationSubmittedSuccessfully')}</DialogTitle>
            <DialogDescription>
              {t('applicationSubmittedMessage').replace('{jobTitle}', job.title).replace('{company}', job.company)}
            </DialogDescription>
          </DialogHeader>
          <DialogFooter>
            <Button onClick={() => setShowSuccessModal(false)}>
              {t('close')}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      <div className="flex justify-between items-start mb-6">
        <div className="flex items-center gap-3">
          <div className="w-12 h-12 rounded-md overflow-hidden bg-gray-100">
            <Image
              src={getJobEntity(job.entity, t) === (t ? t('government') : 'Government') ? (isRTL ? "/Gov_ar.png" : "/Gov_en.png") : (isRTL ? "/private_ar.png" : "/private_en.png")}
              alt={job.company ? job.company + ' logo' : 'Company logo'}
              width={48}
              height={48}
              className="w-full h-full object-contain p-1"
            />
          </div>
          <div>
            <h2 className="font-semibold text-lg text-gray-900">{job.title}</h2>
            <p className="text-sm text-gray-600">
              {job.company === "Nan" ? t('private') : job.company}
              {job.location === "Nan" ? ` • ${t('notSpecified')}` : ` • ${job.location}`}
            </p>
          </div>
        </div>

        {!isPreview && (
          <button onClick={onClose} className="text-gray-500 hover:text-gray-700">
            <X size={20} />
          </button>
        )}
      </div>

      <div className="space-y-4">
        {!isPreview && (
          <div className="flex flex-col gap-2">
            {jobApplyCount >= 1 ? (
              <button
                onClick={() => {
                  setShowResumeModal(true)
                }}
                disabled={isApplying}
                className="w-full py-2 bg-gradient-to-r from-[#042052] to-[#0D57E1] text-white rounded-md font-medium flex items-center justify-center gap-2 disabled:opacity-50"
              >
                {isApplying ? (
                  <>
                    <Loader2 className="w-4 h-4 animate-spin" />
                    {t('applying')}
                  </>
                ) : (
                  <>
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <path
                        d="M13 10V3L4 14H11V21L20 10H13Z"
                        stroke="currentColor"
                        strokeWidth="2"
                        strokeLinecap="round"
                        strokeLinejoin="round"
                      />
                    </svg>
                    {t('easyApplyViaTabashir')}
                  </>
                )}
              </button>
            ) : <Link
              href={`/service-details`}
              className="w-full py-2 bg-gradient-to-r from-[#042052] to-[#0D57E1] text-white rounded-md font-medium flex items-center justify-center gap-2 disabled:opacity-50"
            >
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path
                  d="M13 10V3L4 14H11V21L20 10H13Z"
                  stroke="currentColor"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                />
              </svg>
              {t('easyApplyViaTabashir')}
            </Link>}

            {job.applyUrl && (
              <button onClick={() => window.open(job.applyUrl, '_blank')} className="w-full py-2 border border-gray-300 rounded-md font-medium flex items-center justify-center gap-2 text-gray-700">
                <Globe size={16} />
                {t('applyThroughCompanyWebsite')}
              </button>
            )}
            {job.email && (
              <div className="w-full py-2 border border-gray-300 rounded-md font-medium flex items-center justify-center gap-2 text-gray-700">
                <Mail size={16} />
                {job.email}
              </div>
            )}
          </div>
        )}

        <div className="grid grid-cols-2 gap-4 mb-6">
          <div className="flex items-center gap-2 p-3 bg-gray-50 rounded-lg">
            <Building2 size={20} className="text-gray-500" />
            <div>
              <p className="text-sm text-gray-500">{t('company')}</p>
              <p className="font-medium text-gray-900">{job.company === "Nan" ? t('private') : job.company}</p>
            </div>
          </div>
          <div className="flex items-center gap-2 p-3 bg-gray-50 rounded-lg">
            <Briefcase size={20} className="text-gray-500" />
            <div>
              <p className="text-sm text-gray-500">{t('jobType')}</p>
              <p className="font-medium text-gray-900">{job.jobType || "-"}</p>
            </div>
          </div>
          <div className="flex items-center gap-2 p-3 bg-gray-50 rounded-lg">
            <DollarSign size={20} className="text-gray-500" />
            <div>
              <p className="text-sm text-gray-500">{t('salary')}</p>
              <p className="font-medium text-gray-900">
                {job.salary.amount ? job.salary.amount : t('tbd')}
              </p>
            </div>
          </div>
          <div className="flex items-center gap-2 p-3 bg-gray-50 rounded-lg">
            <Calendar size={20} className="text-gray-500" />
            <div>
              <p className="text-sm text-gray-500">{t('postedTime')}</p>
              <p className="font-medium text-gray-900">{job.postedTime || "-"}</p>
            </div>
          </div>
          <div className="flex items-center gap-2 p-3 bg-gray-50 rounded-lg">
            <User size={20} className="text-gray-500" />
            <div>
              <p className="text-sm text-gray-500">{t('gender')}</p>
              <p className="font-medium text-gray-900">
                {job.gender === "Male" ? t('forMale') : job.gender === "Female" ? t('forFemale') : t('forAll')}
              </p>
            </div>
          </div>
          <div className="flex items-center gap-2 p-3 bg-gray-50 rounded-lg">
            <Contact size={20} className="text-gray-500" />
            <div>
              <p className="text-sm text-gray-500">{t('entity')}</p>
              <p className="font-medium text-gray-900">
                {getJobEntity(job.entity || "", t)}
              </p>
            </div>
          </div>
        </div>

        <Tabs defaultValue="description" className="w-full">
          <TabsList className="grid w-full grid-cols-2">
            <TabsTrigger value="description">{t('description')}</TabsTrigger>
            <TabsTrigger value="company">{t('company')}</TabsTrigger>
          </TabsList>

          <TabsContent value="description" className="space-y-6 mt-6">
            <div>
              <h3 className="font-medium mb-3 text-gray-900">{t('jobDescription')}</h3>
              <div className="prose prose-sm max-w-none text-gray-700">
                {/* Removing all the links https or http from description */}
                {job.description ? job.description.replace(/https?:\/\/[^\s]+/g, '') : <span className="text-gray-400">{t('noDescriptionProvided')}</span>}
              </div>
            </div>

            <div>
              <h3 className="font-medium mb-3 text-gray-900">{t('nationality')}</h3>
              <div className="prose prose-sm max-w-none text-gray-700">
                {job.nationality || t('noNationalityRequired')}
              </div>
            </div>

            <div>
              <h3 className="font-medium mb-3 text-gray-900">{t('experience')}</h3>
              <div className="prose prose-sm max-w-none text-gray-700">
                {job.experience || t('noExperienceRequired')}
              </div>
            </div>

            <div>
              <h3 className="font-medium mb-3 text-gray-900">{t('requirements')}</h3>
              <div className="prose prose-sm max-w-none text-gray-700">
                {job.requirements ? job.requirements : <span className="text-gray-400">{t('noRequirementsProvided')}</span>}
              </div>
            </div>

            <div>
              <h3 className="font-medium mb-3 text-gray-900">{t('department')}</h3>
              <div className="text-sm text-gray-700">{job.department || "-"}</div>
            </div>

            <div>
              <h3 className="font-medium mb-3 text-gray-900">{t('team')}</h3>
              <div className="text-sm text-gray-700">{job.team || "-"}</div>
            </div>
          </TabsContent>

          <TabsContent value="company" className="mt-6">
            <div className="space-y-6">
              <div className="flex items-center gap-4">
                <div className="w-16 h-16 rounded-lg overflow-hidden bg-gray-100">
                  <Image
                    src={job.logo || "/placeholder.svg"}
                    alt={job.company ? job.company + ' logo' : 'Company logo'}
                    width={64}
                    height={64}
                    className="w-full h-full object-contain p-2"
                  />
                </div>
                <div>
                  <h3 className="font-medium text-gray-900">{job.company}</h3>
                  <p className="text-sm text-gray-600">{job.location}</p>
                </div>
              </div>

              <div>
                <h3 className="font-medium mb-3 text-gray-900">{t('aboutTheCompany')}</h3>
                <p className="text-sm text-gray-700">
                  {/* Removing all the links https or http from companyDescription */}
                  {job.companyDescription ? job.companyDescription.replace(/https?:\/\/[^\s]+/g, '') : <span className="text-gray-400">{t('noCompanyDescriptionProvided')}</span>}
                </p>
              </div>
            </div>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  )
}


export function getJobEntity(entity: string | null, t: (key: string) => string) {
  // Safety check to ensure t is a function
  if (!t || typeof t !== 'function') {
    console.warn('Translation function is not available');
    if (!entity) return 'Private'
    if (entity.toLowerCase().includes("government") || entity.toLowerCase().includes("govt") || entity.toLowerCase().includes("gov") || entity.toLowerCase().includes("governmental")) {
      return 'Government'
    } else if (entity.toLowerCase().includes("semi-government") || entity.toLowerCase().includes("semi-govt") || entity.toLowerCase().includes("semi-gov") || entity.toLowerCase().includes("semi governmental")) {
      return 'Semi-Government'
    } else {
      return 'Private'
    }
  }

  if (!entity) return t('private')
  if (entity.toLowerCase().includes("government") || entity.toLowerCase().includes("govt") || entity.toLowerCase().includes("gov") || entity.toLowerCase().includes("governmental")) {
    return t('government')
  } else if (entity.toLowerCase().includes("semi-government") || entity.toLowerCase().includes("semi-govt") || entity.toLowerCase().includes("semi-gov") || entity.toLowerCase().includes("semi governmental")) {
    return t('semiGovernment')
  } else {
    return t('private')
  }
}
"use client"

import { useState } from "react"
import { X, FileText, Check, CheckCircle } from "lucide-react"

interface Resume {
  id: string
  name: string
  position: string
}

interface ApplicationModalProps {
  isOpen: boolean
  onClose: () => void
  jobTitle?: string
  companyName?: string
}

export function ApplicationModal({ isOpen, onClose, jobTitle, companyName }: ApplicationModalProps) {
  const [progress, setProgress] = useState(25) // Progress percentage (first step)
  const [showResumeList, setShowResumeList] = useState(false)
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [isSubmitted, setIsSubmitted] = useState(false)

  // Sample resumes
  const resumes: Resume[] = [
    { id: "1", name: "Sami Haider", position: "UI UX Designer" },
    { id: "2", name: "Sami Haider", position: "Product Designer" },
    { id: "3", name: "Sami Haider", position: "Frontend Developer" },
    { id: "4", name: "Sami Haider", position: "UX Researcher" },
  ]

  const [selectedResume, setSelectedResume] = useState<Resume>(resumes[0])

  const handleResumeSelect = (resume: Resume) => {
    setSelectedResume(resume)
    setShowResumeList(false)
  }

  const handleSubmit = () => {
    setIsSubmitting(true)

    // Simulate API call with timeout
    setTimeout(() => {
      setProgress(100)

      // Short delay before showing success message
      setTimeout(() => {
        setIsSubmitting(false)
        setIsSubmitted(true)
      }, 500)
    }, 1000)
  }

  if (!isOpen) return null

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
      <div className="bg-white rounded-lg w-full max-w-md relative">
        {/* Close button */}
        <button onClick={onClose} className="absolute right-4 top-4 text-gray-500 hover:text-gray-700">
          <X size={20} />
        </button>

        {/* Modal content */}
        <div className="p-6 text-gray-900">
          {!isSubmitted ? (
            <>
              <h2 className="text-xl font-bold mb-1 text-gray-900">Application Form</h2>
              <p className="text-sm text-gray-600 mb-4">Help recruiter know about you</p>

              {/* Progress bar */}
              <div className="h-2 bg-gray-200 rounded-full mb-6">
                <div
                  className={`h-full rounded-full transition-all duration-1000 ease-out ${
                    progress === 100 ? "bg-green-500" : "bg-gradient-to-r from-[#042052] to-[#0D57E1]"
                  }`}
                  style={{ width: `${progress}%` }}
                ></div>
              </div>

              {/* CV Section */}
              <div className="mb-6 relative">
                <div className="flex justify-between items-center mb-2">
                  <h3 className="font-medium">CV</h3>
                  <button
                    className="text-blue-600 text-sm font-medium"
                    onClick={() => setShowResumeList(!showResumeList)}
                  >
                    Edit
                  </button>
                </div>
                <div className="border border-gray-200 rounded-lg p-4 flex items-center gap-3">
                  <div className="text-gray-800">
                    <FileText size={24} />
                  </div>
                  <span className="font-medium">
                    {selectedResume.name} - {selectedResume.position} CV
                  </span>
                </div>

                {/* Resume selection dropdown */}
                {showResumeList && (
                  <div className="absolute z-10 mt-2 w-full bg-white border border-gray-200 rounded-lg shadow-lg transition-all duration-300 ease-in-out animate-in slide-in-from-top-5 fade-in-20">
                    <div className="p-2 max-h-60 overflow-y-auto">
                      {resumes.map((resume) => (
                        <div
                          key={resume.id}
                          className="flex items-center justify-between p-3 hover:bg-gray-50 rounded-md cursor-pointer"
                          onClick={() => handleResumeSelect(resume)}
                        >
                          <div className="flex items-center gap-3">
                            <FileText size={20} className="text-gray-600" />
                            <span>
                              {resume.name} - {resume.position} CV
                            </span>
                          </div>
                          {selectedResume.id === resume.id && <Check size={18} className="text-green-500" />}
                        </div>
                      ))}
                    </div>
                  </div>
                )}
              </div>

              {/* Supporting documents */}
              <div className="mb-6">
                <div className="flex justify-between items-center mb-2">
                  <h3 className="font-medium">Supporting documents</h3>
                  <button className="text-blue-600 text-sm font-medium">Add</button>
                </div>
                <div className="border border-gray-200 rounded-lg p-4 text-gray-500 text-sm">
                  No cover letter or additional documents included (optional)
                </div>
              </div>

              {/* Submit button */}
              <button
                className="w-full py-3 bg-gradient-to-r from-[#042052] to-[#0D57E1] text-white rounded-md font-medium disabled:opacity-70"
                onClick={handleSubmit}
                disabled={isSubmitting}
              >
                {isSubmitting ? "Submitting..." : "Submit your application"}
              </button>
            </>
          ) : (
            <div className="py-8 flex flex-col items-center text-center animate-in fade-in duration-500">
              <div className="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mb-4">
                <CheckCircle size={32} className="text-green-500" />
              </div>
              <h2 className="text-2xl font-bold mb-2 text-gray-900">Application Submitted!</h2>
              <p className="text-gray-600 mb-6">
                Your application for {jobTitle || "the position"} at {companyName || "the company"} has been
                successfully submitted.
              </p>
              <button
                className="px-6 py-3 bg-gradient-to-r from-[#042052] to-[#0D57E1] text-white rounded-md font-medium"
                onClick={onClose}
              >
                View My Applications
              </button>
            </div>
          )}
        </div>
      </div>
    </div>
  )
}

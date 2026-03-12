"use client"

import type { ReactNode } from "react"
import { useRouter } from "next/navigation"
import { Button } from "@/components/ui/button"
import { useToast } from "@/components/ui/use-toast"
import { useResumeStore, type ResumeSection } from "../store/resume-store"

interface FormWrapperProps {
  children: ReactNode
  section: ResumeSection
  resumeId: string
  isLastStep?: boolean
  onSubmit: () => Promise<boolean>
}

export function FormWrapper({ children, section, resumeId, isLastStep = false, onSubmit }: FormWrapperProps) {
  const router = useRouter()
  const { toast } = useToast()
  const { setFormCompleted } = useResumeStore()

  const handleSubmit = async () => {
    try {
      const success = await onSubmit()

      if (success) {
        // setFormCompleted(section)

        toast({
          title: "Success",
          description: "Your information has been saved successfully.",
          variant: "default",
        })

        if (isLastStep) {
          router.push(`/resume/new/${resumeId}/generating`)
        } else {
          // Get the next section based on the current section
          const sections: ResumeSection[] = [
            "personal-details",
            "professional-summary",
            "employment-history",
            "education",
            "skills",
            // "languages",
          ]

          const currentIndex = sections.indexOf(section)
          if (currentIndex < sections.length - 1) {
            const nextSection = sections[currentIndex + 1]
            router.push(`/resume/new/${resumeId}/${nextSection}`)
          }
        }
      }
    } catch (error) {
      toast({
        title: "Error",
        description: "There was a problem saving your information.",
        variant: "destructive",
      })
    }
  }

  return (
    <div className="space-y-6">
      {children}

      <div className="flex justify-end mt-8">
        <Button
          className="bg-gradient-to-r from-[#042052] to-[#0D57E1] hover:opacity-90 text-white"
          onClick={handleSubmit}
        >
          {isLastStep ? "Create Resume" : "Save & Continue"}
        </Button>
      </div>
    </div>
  )
}

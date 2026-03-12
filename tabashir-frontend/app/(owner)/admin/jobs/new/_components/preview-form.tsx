"use client"

import { useState } from "react"
import type { UseFormReturn } from "react-hook-form"
import { Button } from "@/components/ui/button"
import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs"
import JobCard from "@/components/job-card"
import { JobDetails } from "@/app/(candidate)/jobs/_components/job-details"
import { createJob } from "@/app/actions/admin"
import { useToast } from "@/components/ui/use-toast"
import { useRouter } from "next/navigation"
import { useSession } from "next-auth/react"

interface PreviewFormProps {
  form: UseFormReturn<any>
  onPrev: () => void
}

export default function PreviewForm({ form, onPrev }: PreviewFormProps) {
  const [activeView, setActiveView] = useState("social")
  const [isLiked, setIsLiked] = useState(false)
  const [isLoading, setIsLoading] = useState(false)
  const { toast } = useToast()
  const router = useRouter()
  const session = useSession()

  const formValues = form.getValues()

  const handleLike = () => {
    setIsLiked(!isLiked)
  }

  const handleUpload = async () => {
    try {
      setIsLoading(true)
      const result = await createJob(formValues)

      if (result.success) {
        toast({
          title: "Success",
          description: "Job posted successfully!",
        })
        router.push("/admin/jobs")
      } else {
        toast({
          title: "Error",
          description: result.error || "Failed to post job",
          variant: "destructive",
        })
      }

    } catch (error) {
      toast({
        title: "Error",
        description: "An unexpected error occurred",
        variant: "destructive",
      })
    } finally {
      setIsLoading(false)
    }
  }

  // Transform form values to match Job type
  const previewJob = {
    id: "preview",
    title: formValues.jobTitle || "Job Title",
    company: formValues.company || "Company Name",
    logo: formValues.companyLogo || "/placeholder.svg",
    nationality: formValues.nationality || "Nationality",
    entity: formValues.company || "Company Name",
    location: formValues.location || "Location",
    email: formValues.application_email || "Email",
    country: "Country",
    jobType: formValues.jobType || "Full-time",
    gender: formValues.gender || "For all",
    experience: formValues.experience || "No experience required",
    salary: {
      amount: parseInt(formValues.salaryMin?.replace(/,/g, '') || "0"),
      currency: "AED",
      period: "year"
    },
    views: 0,
    postedTime: "Just now",
    applicationsCount: 0,
    department: "Department",
    isLikded: isLiked,
    match: undefined,
    requiredSkills: formValues.requiredSkills || [],
    benefits: formValues.benefits || [],
    description: formValues.description || "",
    requirements: formValues.requirements || "",
    qualifications: [],
    locationDetails: {
      type: "onsite",
      place: formValues.location || "Location"
    },
    jobTypes: [formValues.jobType || "Full-time"],
    skills: (formValues.requiredSkills || []).map((skill: string) => ({
      name: skill,
      color: "#3B82F6"
    })),
    perks: formValues.benefits || [],
    companyDescription: formValues.companyDescription || "TABASHIR HR Consulting is a leading recruitment and HR consulting firm dedicated to connecting top talent with exceptional opportunities."
  }

  return (
    <div className="text-gray-900">
      <h2 className="text-xl font-semibold mb-6">Preview</h2>

      <div className="border rounded-lg p-6">
        <Tabs defaultValue="social" value={activeView} onValueChange={setActiveView} className="mb-6">
          <TabsList className="grid w-full grid-cols-2 bg-gray-100">
            <TabsTrigger value="social">User Social View</TabsTrigger>
            <TabsTrigger value="detail">User Detail View</TabsTrigger>
          </TabsList>
        </Tabs>

        {activeView === "social" ? (
          <div className="max-w-2xl mx-auto">
            <JobCard
              job={previewJob}
              onClick={() => { }}
              isSelected={false}
            />
          </div>
        ) : (
          <div className="max-w-4xl mx-auto">
            <JobDetails
              job={previewJob}
              onClose={() => { }}
              isPreview={true}
              userId={session.data?.user?.id || ""}
            />
          </div>
        )}
      </div>

      <div className="flex justify-between mt-6">
        <Button type="button" variant="outline" onClick={onPrev}>
          Previous
        </Button>
        <Button
          type="button"
          onClick={handleUpload}
          className="bg-blue-950 hover:bg-blue-900 text-white"
          disabled={isLoading}
        >
          {isLoading ? "Uploading..." : "Upload"}
        </Button>
      </div>
    </div>
  )
}

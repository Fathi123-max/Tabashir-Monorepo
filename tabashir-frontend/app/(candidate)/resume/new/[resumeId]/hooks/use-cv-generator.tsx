"use client"

import { useState } from "react"
import { useRouter } from "next/navigation"
import { useToast } from "@/components/ui/use-toast"
import { AiResumeStatus } from "@prisma/client"
import { getCV, getAiResumeFormatedContent } from "@/actions/ai-resume"
import { changeAiResumeStatus, updateAiResumeRawData, uploadAIResume } from "@/actions/resume"
import { useResumeStore } from "../../store/resume-store"

export const cleanupFormattedData = (data: any): any => {
  if (!data || typeof data !== 'object') return data

  // Handle arrays
  if (Array.isArray(data)) {
    return data.map((item: any) => cleanupFormattedData(item))
  }

  const cleaned = { ...data }

  // If this object has _gpa field, replace it with gpa
  if ('_gpa' in cleaned) {
    cleaned.gpa = cleaned._gpa
    delete cleaned._gpa
  }

  // Recursively clean nested objects
  for (const key in cleaned) {
    if (cleaned[key] && typeof cleaned[key] === 'object') {
      cleaned[key] = cleanupFormattedData(cleaned[key])
    }
  }

  return cleaned
}

// Helper function to update formatted content with database data
export const updateFormattedContent = async (resumeId: string, existingFormattedContent: string) => {
  try {
    // Parse existing formatted content
    const formattedData = JSON.parse(existingFormattedContent)

    // Get updated raw data from database
    const updatedData = await getCV(resumeId)
    if (updatedData.error) {
      throw new Error(updatedData.message)
    }

    const rawData = updatedData.data

    if (!rawData) {
      throw new Error('No data received from database')
    }

    // Update header section (personal details)
    if (rawData.cvPersonalDetails) {
      formattedData.header = {
        ...formattedData.header,
        name: rawData.cvPersonalDetails.fullName || formattedData.header?.name || '',
        email: rawData.cvPersonalDetails.email || formattedData.header?.email || '',
        phone: rawData.cvPersonalDetails.phone || formattedData.header?.phone || '',
        location: rawData.cvPersonalDetails.city && rawData.cvPersonalDetails.country
          ? `${rawData.cvPersonalDetails.city}, ${rawData.cvPersonalDetails.country}`
          : formattedData.header?.location || '',
        github: formattedData.header?.github || '',
        linkedin: formattedData.header?.linkedin || '',
        nationality: formattedData.header?.nationality || '',
      }
    }

    // Update objective section (professional summary)
    if (rawData.cvProfessionalSummary?.summary) {
      formattedData.objective = rawData.cvProfessionalSummary.summary
    }

    // Update work section (employment history)
    if (rawData.cvEmploymentHistory && rawData.cvEmploymentHistory.length > 0) {
      formattedData.work = rawData.cvEmploymentHistory.map((job: any) => ({
        company: job.company || '',
        date: job.startDate && job.endDate
          ? `${new Date(job.startDate).toLocaleDateString('en-US', { month: 'long', year: 'numeric' })} – ${job.current ? 'Present' : new Date(job.endDate).toLocaleDateString('en-US', { month: 'long', year: 'numeric' })}`
          : '',
        details: job.description ? job.description.split('\n').filter((line: string) => line.trim()) : [],
        location: job.city || '',
        position: job.position || ''
      }))
    }

    // Update education section
    if (rawData.cvEducation && rawData.cvEducation.length > 0) {
      formattedData.education = rawData.cvEducation.map((edu: any) => ({
        gpa: edu.gpa || '',
        coursework: edu.achievements || [],
        date: edu.startDate && edu.endDate
          ? `${new Date(edu.startDate).toLocaleDateString('en-US', { month: 'long', year: 'numeric' })} – ${new Date(edu.endDate).toLocaleDateString('en-US', { month: 'long', year: 'numeric' })}`
          : '',
        degree: edu.degree || '',
        details: edu.achievements || [],
        gpa_hidden: edu.gpa ? edu.gpa : 'N/A',
        location: edu.city || '',
        major: edu.field || '',
        university: edu.institution || ''
      }))
    }

    // Update skills section
    if (rawData.cvSkills && rawData.cvSkills.length > 0) {
      const technicalSkills = rawData.cvSkills.filter((skill: any) => skill.category === 'Technical').map((skill: any) => skill.name)
      const softSkills = rawData.cvSkills.filter((skill: any) => skill.category === 'Soft Skills').map((skill: any) => skill.name)

      formattedData.skills = {
        skillset: technicalSkills.length > 0 ? technicalSkills : formattedData.skills?.skillset || [],
        softskills: softSkills.length > 0 ? softSkills : formattedData.skills?.softskills || [],
        training: formattedData.skills?.training || []
      }
    }

    // Update languages section - keeping existing languages as cvLanguages doesn't exist in current schema
    // Languages will be kept as-is from existing formatted content

    // Update keywords (combine all skills)
    const allSkills = [
      ...(formattedData.skills?.skillset || []),
      ...(formattedData.skills?.softskills || []),
      ...(rawData.cvSkills?.map((skill: any) => skill.name) || [])
    ]
    formattedData.keywords = [...new Set(allSkills)] // Remove duplicates

    return formattedData
  } catch (error) {
    console.error('Error updating formatted content:', error)
    throw error
  }
}

export const useCVGenerator = (resumeId: string, userId: string) => {
  const [generatingCV, setGeneratingCV] = useState(false)
  const { toast } = useToast()
  const router = useRouter()
  const { setResumeGenerated } = useResumeStore()
  const token = process.env.NEXT_PUBLIC_API_TOKEN

  const handleGenerateCV = async () => {
    console.log("🚀 handleGenerateCV called - Starting CV generation process...")
    setGeneratingCV(true)

    try {
      // Check if resume has existing formatted content or generated file
      console.log("📡 Checking existing resume content...")
      const existingContentResult = await getAiResumeFormatedContent(resumeId)

      console.log("📊 getAiResumeFormatedContent result:", existingContentResult)

      if (existingContentResult.error) {
        console.error("❌ Error getting formatted content:", existingContentResult.message)
        toast({
          title: "Error",
          description: existingContentResult.message,
          variant: "destructive",
        })
        return
      }

      const { hasExistingContent, hasGeneratedResume, formatedContent, formatedUrl, status } = existingContentResult.data || {}

      console.log("🔍 Resume status check detailed:", {
        hasExistingContent,
        hasGeneratedResume,
        status,
        hasFormatedContent: !!formatedContent,
        hasFormatedUrl: !!formatedUrl,
        formatedContentLength: formatedContent ? formatedContent.length : 0,
        formatedUrl: formatedUrl ? formatedUrl.substring(0, 50) + "..." : null,
        resumeId
      })

      // If resume is already generated and has a downloadable file, just go to download page
      // if (hasGeneratedResume && formatedUrl) {
      //   console.log("🎯 CONDITION 1: Resume already generated, redirecting to download page...")
      //   console.log("✅ hasGeneratedResume:", hasGeneratedResume)
      //   console.log("✅ formatedUrl:", formatedUrl)
      //   console.log("🚨 NO API CALLS WILL BE MADE - REDIRECTING TO DOWNLOAD PAGE")
      //   console.log("🚨 API CALLS WILL BE MADE", hasExistingContent)
      //   console.log("🚨 API CALLS WILL BE MADE", formatedContent)
      //   setResumeGenerated(true)
      //   router.push(`/resume/new/${resumeId}/download`)
      //   return
      // }

      // If we have existing formatted content, update it with new form data first
      if (hasExistingContent && formatedContent) {
        console.log("Updating existing formatted content with new form data...")

        try {
          // Update the formatted content with database data
          const updatedFormattedContent = await updateFormattedContent(resumeId, formatedContent)
          console.log("Updated formatted content:", updatedFormattedContent)

          // Update the formatted content in the database
          await updateAiResumeRawData(resumeId, JSON.stringify(updatedFormattedContent))

          // Now call generate-docx-from-json API with the updated formatted content
          console.log("Calling generate-docx-from-json API with updated content...")
          const response = await fetch(`${process.env.NEXT_PUBLIC_BACKEND_URL}/api/v1/resume/generate-docx-from-json`, {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
              "X-API-TOKEN": `${token}`,
            },
            body: JSON.stringify({
              cv_data: updatedFormattedContent,
              output_language: "regular"
            }),
          })

          if (!response.ok) {
            console.error("Failed to generate CV from updated content:", response.status, response.statusText)
            toast({
              title: "Error",
              description: "Failed to generate CV from updated content",
              variant: "destructive",
            })
            return
          }

          const file = await response.arrayBuffer()

          if (!file) {
            console.log("Failed to generate CV", file)
            toast({
              title: "Error",
              description: "Failed to generate CV",
              variant: "destructive",
            })
            return
          }

          // Convert ArrayBuffer to Blob
          console.log("Converting ArrayBuffer to Blob......")
          const blob = new Blob([file], { type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' })

          // Create a File object from the Blob
          const namedFile = new File([blob], `resume_${resumeId}.docx`, { type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' })

          // Upload to UploadThing
          const uploadResult = await uploadAIResume(namedFile, resumeId)

          if (uploadResult.error) {
            toast({
              title: "Error",
              description: uploadResult.message,
              variant: "destructive",
            })
            return
          }

          await changeAiResumeStatus(resumeId, AiResumeStatus.COMPLETED)

          toast({
            title: "Success",
            description: "CV generated and saved successfully",
          })

          setResumeGenerated(true)
          router.push(`/resume/new/${resumeId}/download`)
        } catch (error) {
          console.error("Error updating formatted content:", error)
          toast({
            title: "Error",
            description: "Failed to update formatted content",
            variant: "destructive",
          })
          return
        }

      } else {
        // First time generation - use the original APIs
        console.log("First time generation, using original APIs (format-from-raw & format-cv-object)...")

        const data = await getCV(resumeId)
        console.log("CV data:", data)

        if (data.error) {
          toast({
            title: "Error",
            description: data.message,
            variant: "destructive",
          })
          return
        }

        console.log("Generating CV WITH AI using original APIs...")
        console.log("API calls:", {
          formatFromRaw: `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/v1/resume/format-from-raw`,
          formatCvObject: `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/v1/resume/format-cv-object`
        })

        // Run both requests in parallel
        const [response, responseRawJson] = await Promise.all([
          fetch(`${process.env.NEXT_PUBLIC_BACKEND_URL}/api/v1/resume/format-from-raw`, {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
              "X-API-TOKEN": `${token}`,
            },
            body: JSON.stringify({
              user_id: userId,
              raw_data: JSON.stringify(data.data),
              output_language: "regular"
            }),
          }),
          fetch(`${process.env.NEXT_PUBLIC_BACKEND_URL}/api/v1/resume/format-cv-object`, {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
              "X-API-TOKEN": `${token}`,
            },
            body: JSON.stringify({
              user_id: userId,
              raw_data: JSON.stringify(data.data),
              output_language: "regular"
            }),
          })
        ])

        // Check if both requests were successful
        if (!response.ok) {
          console.error("Failed to generate CV:", response.status, response.statusText)
          toast({
            title: "Error",
            description: "Failed to generate CV from server",
            variant: "destructive",
          })
          return
        }

        if (!responseRawJson.ok) {
          console.error("Failed to get CV object:", responseRawJson.status, responseRawJson.statusText)
          toast({
            title: "Error",
            description: "Failed to get CV object from server",
            variant: "destructive",
          })
          return
        }

        const file = await response.arrayBuffer()
        const jsonData = await responseRawJson.json()

        // Clean up the formatted data (remove _gpa, add gpa)
        const cleanedFormattedResume = cleanupFormattedData(jsonData.formatted_resume)

        // Update the formatted content in the database
        await updateAiResumeRawData(resumeId, JSON.stringify(cleanedFormattedResume))
        await changeAiResumeStatus(resumeId, AiResumeStatus.COMPLETED)

        console.log("CV object data:", jsonData)

        if (!file) {
          console.log("Failed to generate CV", file)
          toast({
            title: "Error",
            description: "Failed to generate CV",
            variant: "destructive",
          })
          return
        }

        // Convert ArrayBuffer to Blob
        console.log("Converting ArrayBuffer to Blob......")
        const blob = new Blob([file], { type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' })

        // Create a File object from the Blob
        const namedFile = new File([blob], `resume_${resumeId}.docx`, { type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' })

        // Upload to UploadThing
        const uploadResult = await uploadAIResume(namedFile, resumeId)

        if (uploadResult.error) {
          toast({
            title: "Error",
            description: uploadResult.message,
            variant: "destructive",
          })
          return
        }

        toast({
          title: "Success",
          description: "CV generated and saved successfully",
        })

        setResumeGenerated(true)
        router.push(`/resume/new/${resumeId}/download`)
      }

    } catch (error) {
      console.error("Error generating CV:", error)
      toast({
        title: "Error",
        description: "Failed to generate CV",
        variant: "destructive",
      })
    } finally {
      setGeneratingCV(false)
    }
  }

  return {
    generatingCV,
    handleGenerateCV,
  }
} 
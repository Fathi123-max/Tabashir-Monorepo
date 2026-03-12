"use server"

import { auth } from "@/app/utils/auth";
import { prisma } from "@/lib/prisma"
import { createJobAPI, updateJobAPI, getJobByApiId } from "@/lib/api"
import { revalidatePath } from "next/cache"

export const onLikeJob = async (jobId: string) => {
  const session = await auth()
  if (!session?.user) {
    return { error: "Unauthorized" }
  }

  try {
    const jobLike = await prisma.jobLike.create({
      data: {
        jobId,
        userId: session.user.id,
      },
    })

    return { success: "Job liked" }
  } catch (error) {
    return { error: "Failed to like job" }
  }
}

export const onUnlikeJob = async (jobId: string) => {
  const session = await auth()
  if (!session?.user) {
    return { error: "Unauthorized" }
  }

  try {
    const jobLike = await prisma.jobLike.deleteMany({
      where: {
        jobId: jobId,
        userId: session.user.id,
      },
    })

    return { success: "Job unliked" }
  } catch (error) {
    return { error: "Failed to unlike job" }
  }
}

export const getLikedJobs = async () => {
  const session = await auth()
  if (!session?.user) {
    return { error: "Unauthorized" }
  }

  try {
    const jobLikes = await prisma.jobLike.findMany({
      where: {
        userId: session.user.id,
      },
    })

    return { success: jobLikes }
  } catch (error) {
    return { error: "Failed to get liked jobs" }
  }
}

export const getIsLiked = async (jobId: string) => {
  const session = await auth()
  if (!session?.user) {
    return false
  }

  const jobLike = await prisma.jobLike.findFirst({
    where: {
      jobId: jobId,
      userId: session.user.id,
    },
  })

  return jobLike ? true : false
}

export async function createRecruiterJob(formData: {
  title: string
  company: string
  companyDescription: string
  jobType: string
  salaryMin: number
  salaryMax: number
  location: string
  description: string
  requirements: string
  benefits: string[]
  applicationDeadline?: string
  contactEmail: string
  contactPhone?: string
  companyLogo?: string
  requiredSkills: string[]
  // Additional fields for API
  nationality?: string
  gender?: string
  academicQualification?: string
  experience?: string
  languages?: string
  workingHours?: string
  workingDays?: string
  jobDate?: string
  link?: string
}) {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      return { success: false, error: "Unauthorized" }
    }

    // Check if user is a recruiter
    const recruiter = await prisma.recruiter.findUnique({
      where: { userId: session.user.id }
    })

    if (!recruiter) {
      return { success: false, error: "Recruiter not found" }
    }

    // Transform form data to API payload format
    const apiPayload = {
      entity: formData.company,
      nationality: formData.nationality || "Open to all",
      gender: formData.gender || "Open to all",
      job_title: formData.title,
      academic_qualification: formData.academicQualification || "As per job requirements",
      experience: formData.experience || "As specified in job description",
      languages: formData.languages || "As per job requirements",
      salary: `${formData.salaryMin} - ${formData.salaryMax} AED`,
      vacancy_city: formData.location,
      working_hours: formData.workingHours || "Full time",
      working_days: formData.workingDays || "Monday to Friday",
      application_email: formData.contactEmail,
      job_description: formData.description,
      job_date: formData.jobDate || new Date().toISOString().split('T')[0],
      link: formData.link || "",
      phone: formData.contactPhone || "",
    }

    // Send to external API
    const apiResult = await createJobAPI(apiPayload)
    
    if (!apiResult.success) {
      console.error("API Error:", apiResult.error)
      return { success: false, error: "Failed to create job via API" }
    }

    // Save to local database for recruiter management
    const job = await prisma.job.create({
      data: {
        title: formData.title,
        company: formData.company,
        companyDescription: formData.companyDescription,
        companyLogo: formData.companyLogo || "",
        jobType: formData.jobType,
        salaryMin: formData.salaryMin,
        salaryMax: formData.salaryMax,
        location: formData.location,
        description: formData.description,
        requirements: formData.requirements,
        benefits: formData.benefits,
        applicationDeadline: formData.applicationDeadline ? new Date(formData.applicationDeadline) : null,
        contactEmail: formData.contactEmail,
        contactPhone: formData.contactPhone,
        requiredSkills: formData.requiredSkills,
        recruiterId: recruiter.id,
        externalApiJobId: apiResult.data?.job?.id || null // Store the external API job ID
      }
    })

    revalidatePath("/recruiter/jobs")
    revalidatePath("/recruiter/dashboard")
    return { success: true, jobId: job.id, apiData: apiResult.data }
  } catch (error) {
    console.error("Error creating job:", error)
    return { success: false, error: "Failed to create job" }
  }
}

export async function getRecruiterJobs() {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      return { success: false, error: "Unauthorized" }
    }

    // Check if user is a recruiter
    const recruiter = await prisma.recruiter.findUnique({
      where: { userId: session.user.id }
    })

    if (!recruiter) {
      return { success: false, error: "Recruiter not found" }
    }

    // Get recruiter's jobs
    const jobs = await prisma.job.findMany({
      where: { recruiterId: recruiter.id },
      include: {
        applicants: {
          select: { id: true }
        }
      },
      orderBy: {
        createdAt: 'desc'
      }
    })

    return { success: true, jobs }
  } catch (error) {
    console.error("Error fetching recruiter jobs:", error)
    return { success: false, error: "Failed to fetch jobs" }
  }
}

export async function getRecruiterJobById(jobId: string) {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      return { success: false, error: "Unauthorized" }
    }

    // Check if user is a recruiter
    const recruiter = await prisma.recruiter.findUnique({
      where: { userId: session.user.id }
    })

    if (!recruiter) {
      return { success: false, error: "Recruiter not found" }
    }

    // Get the job
    const job = await prisma.job.findFirst({
      where: { 
        id: jobId,
        recruiterId: recruiter.id 
      },
      include: {
        applicants: {
          select: { id: true }
        }
      }
    })

    if (!job) {
      return { success: false, error: "Job not found" }
    }

    return { success: true, job }
  } catch (error) {
    console.error("Error fetching job:", error)
    return { success: false, error: "Failed to fetch job" }
  }
}

export async function updateRecruiterJob(jobId: string, formData: {
  title: string
  company: string
  companyDescription: string
  jobType: string
  salaryMin: number
  salaryMax: number
  location: string
  description: string
  requirements: string
  benefits: string[]
  applicationDeadline?: string
  contactEmail: string
  contactPhone?: string
  companyLogo?: string
  requiredSkills: string[]
  // Additional fields for API
  nationality?: string
  gender?: string
  academicQualification?: string
  experience?: string
  languages?: string
  workingHours?: string
  workingDays?: string
  jobDate?: string
  link?: string
}) {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      return { success: false, error: "Unauthorized" }
    }

    // Check if user is a recruiter
    const recruiter = await prisma.recruiter.findUnique({
      where: { userId: session.user.id }
    })

    if (!recruiter) {
      return { success: false, error: "Recruiter not found" }
    }

    // Get the existing job
    const existingJob = await prisma.job.findFirst({
      where: { 
        id: jobId,
        recruiterId: recruiter.id 
      }
    })

    if (!existingJob) {
      return { success: false, error: "Job not found" }
    }

    // If there's an external API job ID, update it via API
    if (existingJob.externalApiJobId) {
      // Transform form data to API payload format
      const apiPayload = {
        entity: formData.company,
        nationality: formData.nationality || "Open to all",
        gender: formData.gender || "Open to all",
        job_title: formData.title,
        academic_qualification: formData.academicQualification || "As per job requirements",
        experience: formData.experience || "As specified in job description",
        languages: formData.languages || "As per job requirements",
        salary: `${formData.salaryMin} - ${formData.salaryMax} AED`,
        vacancy_city: formData.location,
        working_hours: formData.workingHours || "Full time",
        working_days: formData.workingDays || "Monday to Friday",
        application_email: formData.contactEmail,
        job_description: formData.description,
        job_date: formData.jobDate || new Date().toISOString().split('T')[0],
        apply_url: formData.link || "",
        phone: formData.contactPhone || "",
        source: "recruiter_portal",
        company_name: formData.company,
        website_url: formData.link || "",
        job_type: formData.jobType
      }

      // Update via external API
      const apiResult = await updateJobAPI(existingJob.externalApiJobId, apiPayload)
      
      if (!apiResult.success) {
        console.error("API Update Error:", apiResult.error)
        return { success: false, error: "Failed to update job via API" }
      }
    }

    // Update in local database
    const updatedJob = await prisma.job.update({
      where: { id: jobId },
      data: {
        title: formData.title,
        company: formData.company,
        companyDescription: formData.companyDescription,
        companyLogo: formData.companyLogo || "",
        jobType: formData.jobType,
        salaryMin: formData.salaryMin,
        salaryMax: formData.salaryMax,
        location: formData.location,
        description: formData.description,
        requirements: formData.requirements,
        benefits: formData.benefits,
        applicationDeadline: formData.applicationDeadline ? new Date(formData.applicationDeadline) : null,
        contactEmail: formData.contactEmail,
        contactPhone: formData.contactPhone,
        requiredSkills: formData.requiredSkills,
        updatedAt: new Date()
      }
    })

    revalidatePath("/recruiter/jobs")
    revalidatePath("/recruiter/dashboard")
    return { success: true, job: updatedJob }
  } catch (error) {
    console.error("Error updating job:", error)
    return { success: false, error: "Failed to update job" }
  }
}

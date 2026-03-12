"use server"

import { prisma } from "@/lib/prisma"
import { auth } from "@/app/utils/auth"
import { updateJobAPI, deleteJobAPI } from "@/lib/api"
import { revalidatePath } from "next/cache"

export async function getJobs(page: number = 1, limit: number = 10) {
  try {
    const skip = (page - 1) * limit;
    
    const [jobs, total] = await Promise.all([
      prisma.job.findMany({
        orderBy: {
          createdAt: 'desc'
        },
        skip,
        take: limit,
      }),
      prisma.job.count()
    ]);
    
    return {
      jobs,
      total,
      totalPages: Math.ceil(total / limit),
      currentPage: page
    }
  } catch (error) {
    console.error('Error fetching jobs:', error)
    throw new Error('Failed to fetch jobs')
  }
}

export async function getAdminJobById(jobId: string) {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      return { success: false, error: "Unauthorized" }
    }

    // Check if user is an admin/owner
    // const owner = await prisma.owner.findFirst({
    //   where: { userId: session.user.id }
    // })

    // if (!owner) {
    //   return { success: false, error: "Unauthorized - Admin access required" }
    // }

    // Get the job (admin can access any job)
    const job = await prisma.job.findUnique({
      where: { id: jobId },
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

export async function updateAdminJob(jobId: string, formData: {
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

    // Check if user is an admin/owner
    // const owner = await prisma.owner.findFirst({
    //   where: { userId: session.user.id }
    // })

    // if (!owner) {
    //   return { success: false, error: "Unauthorized - Admin access required" }
    // }

    // Get the existing job
    const existingJob = await prisma.job.findUnique({
      where: { id: jobId }
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
        source: "admin_portal",
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

    revalidatePath("/admin/jobs")
    revalidatePath("/admin/dashboard")
    return { success: true, job: updatedJob }
  } catch (error) {
    console.error("Error updating job:", error)
    return { success: false, error: "Failed to update job" }
  }
}

export async function deleteAdminJob(jobId: string) {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      return { success: false, error: "Unauthorized" }
    }

    // Check if user is an admin/owner
    // const owner = await prisma.owner.findFirst({
    //   where: { userId: session.user.id }
    // })

    // if (!owner) {
    //   return { success: false, error: "Unauthorized - Admin access required" }
    // }

    // Get the existing job to check if it has external API ID
    const existingJob = await prisma.job.findUnique({
      where: { id: jobId },
      include: {
        applicants: {
          select: { id: true }
        }
      }
    })

    if (!existingJob) {
      return { success: false, error: "Job not found" }
    }

    // If there are applicants, we might want to prevent deletion or handle it differently
    if (existingJob.applicants.length > 0) {
      // For now, we'll allow deletion but you might want to change this behavior
      console.log(`Deleting job with ${existingJob.applicants.length} applicants`)
    }

    // If there's an external API job ID, delete it via API
    if (existingJob.externalApiJobId) {
      try {
        const apiResult = await deleteJobAPI(existingJob.externalApiJobId)
        if (!apiResult.success) {
          console.error("API Delete Error:", apiResult.error)
          // Continue with local deletion even if API deletion fails
        }
      } catch (apiError) {
        console.error("Error deleting job via API:", apiError)
        // Continue with local deletion even if API deletion fails
      }
    }

    // Delete from local database (this will cascade delete related records)
    await prisma.job.delete({
      where: { id: jobId }
    })

    revalidatePath("/admin/jobs")
    revalidatePath("/admin/dashboard")
    return { success: true, message: "Job deleted successfully" }
  } catch (error) {
    console.error("Error deleting job:", error)
    return { success: false, error: "Failed to delete job" }
  }
} 
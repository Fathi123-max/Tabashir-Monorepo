"use server"

import { auth } from "@/app/utils/auth"
import { prisma } from "@/app/utils/db"
import { revalidatePath } from "next/cache"
import { createJobAPI } from "@/lib/api"

export async function createJob(formData: {
  jobTitle: string
  company: string
  companyDescription: string
  companyLogo: string
  jobType: string
  salaryMin: string
  salaryMax: string
  location?: string
  description: string
  requirements: string
  benefits: string[]
  applicationDeadline?: string
  contactEmail?: string
  contactPhone?: string
  requiredSkills: string[]
  // New API required fields
  nationality: string
  gender: string
  academicQualification: string
  experience: string
  languages: string
  workingHours: string
  workingDays: string
  jobDate: string
  link?: string
}) {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      throw new Error("Unauthorized")
    }

    // Transform form data to API payload format
    const apiPayload = {
      entity: formData.company,
      nationality: formData.nationality,
      gender: formData.gender,
      job_title: formData.jobTitle,
      academic_qualification: formData.academicQualification,
      experience: formData.experience,
      languages: formData.languages,
      salary: `${formData.salaryMin} - ${formData.salaryMax} AED`,
      vacancy_city: formData.location || "",
      working_hours: formData.workingHours,
      working_days: formData.workingDays,
      application_email: formData.contactEmail || "",
      job_description: formData.description,
      job_date: formData.jobDate,
      link: formData.link || "",
      phone: formData.contactPhone || "",
    }

    // Also save to local database for admin management
    let owner = await prisma.owner.findUnique({
      where: { userId: session.user.id }
    })

    if (!owner) {
      owner = await prisma.owner.create({
        data: {
          userId: session.user.id,
          phone: formData.contactPhone || "",
        }
      })
    }

    console.log("owner", owner)

    // Send to external API
    const apiResult = await createJobAPI(apiPayload)

    const job = await prisma.job.create({
      data: {
        title: formData.jobTitle,
        company: formData.company,
        companyDescription: formData.companyDescription,
        companyLogo: formData.companyLogo,
        jobType: formData.jobType,
        salaryMin: parseInt(formData.salaryMin.replace(/,/g, '')),
        salaryMax: parseInt(formData.salaryMax.replace(/,/g, '')),
        location: formData.location,
        description: formData.description,
        requirements: formData.requirements,
        benefits: formData.benefits,
        applicationDeadline: formData.applicationDeadline ? new Date(formData.applicationDeadline) : null,
        contactEmail: formData.contactEmail,
        contactPhone: formData.contactPhone,
        requiredSkills: formData.requiredSkills,
        ownerId: owner.id,
        externalApiJobId: apiResult.data?.job_id.toString() || null
      }
    })

    console.log("job", job);

    revalidatePath("/admin/jobs")
    return { success: true, jobId: job.id, apiData: apiResult.data }
  } catch (error) {
    console.error("Error creating job:", error)
    return { success: false, error: "Failed to create job" }
  }
} 
"use server"

import { prisma } from "@/lib/prisma"
import { auth } from "@/app/utils/auth"
import { revalidatePath } from "next/cache"

export async function getApplications(page: number = 1, limit: number = 10) {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      return { success: false, error: "Unauthorized" }
    }

    const skip = (page - 1) * limit

    const [applications, totalCount] = await Promise.all([
      prisma.jobApplication.findMany({
        where: {
          applicationType: "easy_apply",
          isDismissed: false
        },
        include: {
          user: {
            select: {
              id: true,
              name: true,
              email: true,
              image: true
            }
          },
          
        },
        orderBy: {
          appliedAt: 'desc'
        },
        skip,
        take: limit
      }),
      prisma.jobApplication.count({
        where: {
          applicationType: "easy_apply",
          isDismissed: false
        }
      })
    ])

    const totalPages = Math.ceil(totalCount / limit)

    return {
      success: true,
      applications,
      totalCount,
      totalPages,
      currentPage: page
    }
  } catch (error) {
    console.error("Error fetching applications:", error)
    return { success: false, error: "Failed to fetch applications" }
  }
}

export async function dismissApplication(applicationId: string) {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      return { success: false, error: "Unauthorized" }
    }

    await prisma.jobApplication.update({
      where: { id: applicationId },
      data: { isDismissed: true }
    })

    revalidatePath("/admin/applications")
    return { success: true, message: "Application dismissed successfully" }
  } catch (error) {
    console.error("Error dismissing application:", error)
    return { success: false, error: "Failed to dismiss application" }
  }
}

export async function fetchJobDetailsFromAPI(jobId: string) {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      return { success: false, error: "Unauthorized" }
    }

    const response = await fetch(`${process.env.NEXT_PUBLIC_BACKEND_URL}/api/v1/resume/jobs/${jobId}`, {
      method: 'GET',
      headers: {
        "X-API-TOKEN": `${process.env.NEXT_PUBLIC_API_TOKEN}`
      }
    })

    if (!response.ok) {
      throw new Error(`API responded with status: ${response.status}`)
    }

    const data = await response.json()
    return { success: true, jobData: data }
  } catch (error) {
    console.error("Error fetching job details from API:", error)
    return { success: false, error: "Failed to fetch job details from external API" }
  }
}

export async function updateApplicationStatus(applicationId: string, status: string) {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      return { success: false, error: "Unauthorized" }
    }

    // Validate status
    const validStatuses = ['pending', 'approved', 'rejected']
    if (!validStatuses.includes(status.toLowerCase())) {
      return { success: false, error: "Invalid status" }
    }

    await prisma.jobApplication.update({
      where: { id: applicationId },
      data: { status: status.toLowerCase() }
    })

    revalidatePath("/admin/applications")
    return { success: true, message: "Application status updated successfully" }
  } catch (error) {
    console.error("Error updating application status:", error)
    return { success: false, error: "Failed to update application status" }
  }
} 
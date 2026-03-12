"use server"

import { prisma } from "@/app/utils/db"
import { auth } from "@/app/utils/auth"
import { JobStatus } from "@prisma/client"

export async function getJobDetails(jobId: string) {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      throw new Error("Unauthorized")
    }

    // const owner = await prisma.owner.findFirst({
    //     where:{
    //         userId:session.user.id
    //     }
    // })

    // if(!owner) throw new Error("Unauthorized")

    const job = await prisma.job.findUnique({
      where: { id: jobId },
      include: {
        owner: true,
        applicants: {
          include: {
            candidate: {
              include: {
                user: true,
                profile: true
              }
            }
          }
        }
      }
    })

    if (!job) {
      throw new Error("Job not found")
    }

    return {
      job,
      applications: job.applicants
    }
  } catch (error) {
    console.error("Error fetching job details:", error)
    throw new Error("Failed to fetch job details")
  }
}

export async function updateJobStatus(jobId: string, status: JobStatus) {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      throw new Error("Unauthorized")
    }

    // const owner = await prisma.owner.findFirst({
    //   where: {
    //     userId: session.user.id
    //   }
    // })

    // if (!owner) throw new Error("Unauthorized")

    const job = await prisma.job.update({
      where: { 
        id: jobId,
        // ownerId: owner.id 
      },
      data: {
        status: status
      }
    })

    return { success: true, message: `Job ${status}ed successfully` }
  } catch (error) {
    console.error("Error updating job status:", error)
    return { success: false, message: "Failed to update job status" }
  }
} 
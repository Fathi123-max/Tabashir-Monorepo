"use server"

import { auth } from "@/app/utils/auth"
import { prisma } from "@/lib/prisma"

export async function getCurrentRecruiterUser() {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      return { success: false, error: "Unauthorized" }
    }

    // Get user data with recruiter information
    const user = await prisma.user.findUnique({
      where: { id: session.user.id },
      include: {
        Recruiter: true
      }
    })

    if (!user) {
      return { success: false, error: "User not found" }
    }

    return {
      success: true,
      user: {
        id: user.id,
        name: user.name || "Recruiter",
        email: user.email || "",
        image: user.image,
        userType: user.userType,
        recruiter: user.Recruiter ? {
          companyName: user.Recruiter.companyName,
          contactPersonName: user.Recruiter.contactPersonName,
          phone: user.Recruiter.phone
        } : null
      }
    }
  } catch (error) {
    console.error("Error fetching current recruiter user:", error)
    return { success: false, error: "Failed to fetch user data" }
  }
} 
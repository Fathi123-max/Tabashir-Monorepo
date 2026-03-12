"use server"

import { auth } from "@/app/utils/auth"
import { prisma } from "@/lib/prisma"

export async function getCurrentOwnerUser() {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      return { success: false, error: "Unauthorized" }
    }

    // Get user data with owner information
    const user = await prisma.user.findUnique({
      where: { id: session.user.id },
      include: {
        Owner: true
      }
    })

    if (!user) {
      return { success: false, error: "User not found" }
    }

    return {
      success: true,
      user: {
        id: user.id,
        name: user.name || "Admin User",
        email: user.email || "",
        image: user.image,
        userType: user.userType,
        isOwner: !!user.Owner
      }
    }
  } catch (error) {
    console.error("Error fetching current owner user:", error)
    return { success: false, error: "Failed to fetch user data" }
  }
} 
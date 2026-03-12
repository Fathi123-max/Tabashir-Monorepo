"use server"

import { prisma } from "@/lib/prisma"
import { auth } from "@/app/utils/auth"
import { AdminPermission, AdminRole } from "@prisma/client"

export async function getUserPermissions() {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      return { success: false, error: "Unauthorized" }
    }

    const user = await prisma.user.findUnique({
      where: { id: session.user.id },
      select: {
        userType: true,
        adminRole: true,
        adminPermissions: {
          select: {
            permission: true
          }
        }
      }
    })

    if (!user || user.userType !== "ADMIN") {
      return { success: false, error: "Not an admin user" }
    }

    return {
      success: true,
      permissions: user.adminPermissions.map(p => p.permission),
      adminRole: user.adminRole,
      isAdmin: true
    }
  } catch (error) {
    console.error("Error fetching user permissions:", error)
    return { success: false, error: "Failed to fetch permissions" }
  }
} 
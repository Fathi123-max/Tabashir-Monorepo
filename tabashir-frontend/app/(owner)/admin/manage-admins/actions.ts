"use server"

import { prisma } from "@/lib/prisma"
import { auth } from "@/app/utils/auth"
import { revalidatePath } from "next/cache"
import { AdminRole, AdminPermission } from "@prisma/client"

// Temporary types until Prisma generates the new schema
interface AdminUser {
  id: string
  name: string | null
  email: string | null
  userType: string | null
  createdAt: Date
  adminRole?: AdminRole | null
  permissions?: AdminPermission[]
}

export async function getAdminUsers() {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      return { success: false, error: "Unauthorized" }
    }

    // Check if current user is Admin
    const currentUser = await prisma.user.findUnique({
      where: { id: session.user.id },
      select: { userType: true }
    })

    if (!currentUser || currentUser.userType !== "ADMIN") {
      return { success: false, error: "Access denied. Admin privileges required." }
    }

    // Get all admin users with their permissions
    const adminUsers = await prisma.user.findMany({
      where: {
        userType: "ADMIN"
      },
      select: {
        id: true,
        name: true,
        email: true,
        userType: true,
        createdAt: true,
        adminRole: true,
        adminPermissions: {
          select: {
            permission: true
          }
        }
      },
      orderBy: {
        createdAt: "desc"
      }
    })

    // Transform the data to include permissions array
    const transformedUsers = adminUsers.map(user => ({
      ...user,
      permissions: user.adminPermissions.map(ap => ap.permission)
    }))

    return {
      success: true,
      adminUsers: transformedUsers
    }
  } catch (error) {
    console.error("Error fetching admin users:", error)
    return { success: false, error: "Failed to fetch admin users" }
  }
}

export async function getUserPermissions(userId: string) {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      return { success: false, error: "Unauthorized" }
    }

    // Check if current user is Admin
    const currentUser = await prisma.user.findUnique({
      where: { id: session.user.id },
      select: { userType: true }
    })

    if (!currentUser || currentUser.userType !== "ADMIN") {
      return { success: false, error: "Access denied. Admin privileges required." }
    }

    // Get user with their permissions
    const user = await prisma.user.findUnique({
      where: { id: userId },
      select: {
        id: true,
        name: true,
        email: true,
        adminRole: true,
        adminPermissions: {
          select: {
            permission: true
          }
        }
      }
    })

    if (!user) {
      return { success: false, error: "User not found" }
    }

    return {
      success: true,
      user: {
        ...user,
        permissions: user.adminPermissions.map(ap => ap.permission)
      }
    }
  } catch (error) {
    console.error("Error fetching user permissions:", error)
    return { success: false, error: "Failed to fetch user permissions" }
  }
}

export async function updateUserPermissions(userId: string, permissions: AdminPermission[]) {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      return { success: false, error: "Unauthorized" }
    }

    // Check if current user is Admin
    const currentUser = await prisma.user.findUnique({
      where: { id: session.user.id },
      select: { userType: true }
    })

    if (!currentUser || currentUser.userType !== "ADMIN") {
      return { success: false, error: "Access denied. Admin privileges required." }
    }

    // Prevent modifying own permissions
    if (userId === session.user.id) {
      return { success: false, error: "Cannot modify your own permissions" }
    }

    // Get the target user
    const targetUser = await prisma.user.findUnique({
      where: { id: userId },
      select: { id: true, userType: true }
    })

    if (!targetUser || targetUser.userType !== "ADMIN") {
      return { success: false, error: "Target user is not an admin" }
    }

    // Update permissions using a transaction
    await prisma.$transaction(async (tx) => {
      // Delete existing permissions
      await tx.adminPermissionAssignment.deleteMany({
        where: { userId }
      })

      // Add new permissions
      if (permissions.length > 0) {
        await tx.adminPermissionAssignment.createMany({
          data: permissions.map(permission => ({
            userId,
            permission
          }))
        })
      }
    })

    revalidatePath("/admin/manage-admins")
    return { success: true, message: "Permissions updated successfully" }
  } catch (error) {
    console.error("Error updating user permissions:", error)
    return { success: false, error: "Failed to update permissions" }
  }
}

export async function updateUserRole(userId: string, role: AdminRole) {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      return { success: false, error: "Unauthorized" }
    }

    // Check if current user is Admin
    const currentUser = await prisma.user.findUnique({
      where: { id: session.user.id },
      select: { userType: true }
    })

    if (!currentUser || currentUser.userType !== "ADMIN") {
      return { success: false, error: "Access denied. Admin privileges required." }
    }

    // Prevent modifying own role
    if (userId === session.user.id) {
      return { success: false, error: "Cannot modify your own role" }
    }

    // Update user role
    await prisma.user.update({
      where: { id: userId },
      data: { adminRole: role }
    })

    revalidatePath("/admin/manage-admins")
    return { success: true, message: "Role updated successfully" }
  } catch (error) {
    console.error("Error updating user role:", error)
    return { success: false, error: "Failed to update role" }
  }
}

export async function createAdmin(email: string, name: string) {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      return { success: false, error: "Unauthorized" }
    }

    // Check if current user is Admin
    const currentUser = await prisma.user.findUnique({
      where: { id: session.user.id },
      select: { userType: true }
    })

    if (!currentUser || currentUser.userType !== "ADMIN") {
      return { success: false, error: "Access denied. Admin privileges required." }
    }

    // Check if user already exists
    const existingUser = await prisma.user.findUnique({
      where: { email }
    })

    if (existingUser) {
      if (existingUser.userType === "ADMIN") {
        return { success: false, error: "User is already an admin" }
      }
      
      // Update existing user to admin
      await prisma.user.update({
        where: { id: existingUser.id },
        data: {
          userType: "ADMIN",
          name: name || existingUser.name
        }
      })

      revalidatePath("/admin/manage-admins")
      return { success: true, message: "User promoted to admin successfully" }
    } else {
      return { success: false, error: "User not found. User must register first before being made an admin." }
    }
  } catch (error) {
    console.error("Error creating admin:", error)
    return { success: false, error: "Failed to create admin" }
  }
}

export async function removeAdmin(userId: string) {
  try {
    const session = await auth()
    if (!session?.user?.id) {
      return { success: false, error: "Unauthorized" }
    }

    // Check if current user is Admin
    const currentUser = await prisma.user.findUnique({
      where: { id: session.user.id },
      select: { userType: true }
    })

    if (!currentUser || currentUser.userType !== "ADMIN") {
      return { success: false, error: "Access denied. Admin privileges required." }
    }

    // Prevent removing own admin status
    if (userId === session.user.id) {
      return { success: false, error: "Cannot remove your own admin status" }
    }

    // Update user to remove admin status
    await prisma.user.update({
      where: { id: userId },
      data: {
        userType: "CANDIDATE"
      }
    })

    revalidatePath("/admin/manage-admins")
    return { success: true, message: "Admin status removed successfully" }
  } catch (error) {
    console.error("Error removing admin:", error)
    return { success: false, error: "Failed to remove admin status" }
  }
} 
"use client"

import { useState, useEffect } from "react"
import { useSession } from "next-auth/react"
import { AdminPermission, AdminRole } from "@prisma/client"
import { getDefaultPermissionsForRole } from "@/lib/permissions"
import { getUserPermissions } from "@/actions/admin/permissions"

interface AdminPermissionState {
  permissions: AdminPermission[]
  adminRole: AdminRole | null
  isLoading: boolean
  isSuperAdmin: boolean
  canAccess: (permission: AdminPermission) => boolean
  canAccessPage: (path: string) => boolean
}

// Temporary permission mapping until schema is migrated
const TEMP_ADMIN_PERMISSIONS = [
  AdminPermission.MANAGE_DASHBOARD,
  AdminPermission.MANAGE_USERS,
  AdminPermission.MANAGE_JOBS,
  AdminPermission.MANAGE_APPLICATIONS,
  AdminPermission.MANAGE_PAYMENTS,
  AdminPermission.MANAGE_INTERVIEWS,
  AdminPermission.MANAGE_AI_CV,
  AdminPermission.MANAGE_HELP,
  AdminPermission.MANAGE_ACCOUNT,
  AdminPermission.MANAGE_ADMIN_PERMISSIONS, // Temporary - all admins have this until we implement roles
]

export function useAdminPermissions(): AdminPermissionState {
  const { data: session, status } = useSession()
  const [permissions, setPermissions] = useState<AdminPermission[]>([])
  const [adminRole, setAdminRole] = useState<AdminRole | null>(null)
  const [isLoading, setIsLoading] = useState(true)

  useEffect(() => {
    if (status === "loading") return

    const fetchPermissions = async () => {
      if (session?.user?.userType === "ADMIN") {
        try {
          const result = await getUserPermissions()
          if (result.success) {
            setPermissions(result.permissions || [])
            setAdminRole(result.adminRole || null)
          } else {
            // Fallback to temporary permissions if database fetch fails
            setPermissions(TEMP_ADMIN_PERMISSIONS)
            setAdminRole(AdminRole.SUPER_ADMIN)
          }
        } catch (error) {
          console.error("Error fetching permissions:", error)
          // Fallback to temporary permissions
          setPermissions(TEMP_ADMIN_PERMISSIONS)
          setAdminRole(AdminRole.SUPER_ADMIN)
        }
      } else {
        setPermissions([])
        setAdminRole(null)
      }

      setIsLoading(false)
    }

    fetchPermissions()
  }, [session, status])

  const canAccess = (permission: AdminPermission): boolean => {
    return permissions.includes(permission)
  }

  const canAccessPage = (path: string): boolean => {
    // Basic page access logic - can be expanded later
    const pagePermissionMap: Record<string, AdminPermission> = {
      "/admin/dashboard": AdminPermission.MANAGE_DASHBOARD,
      "/admin/users": AdminPermission.MANAGE_USERS,
      "/admin/jobs": AdminPermission.MANAGE_JOBS,
      "/admin/applications": AdminPermission.MANAGE_APPLICATIONS,
      "/admin/payments": AdminPermission.MANAGE_PAYMENTS,
      "/admin/scheduled-interview": AdminPermission.MANAGE_INTERVIEWS,
      "/admin/aicv": AdminPermission.MANAGE_AI_CV,
      "/admin/help": AdminPermission.MANAGE_HELP,
      "/admin/account": AdminPermission.MANAGE_ACCOUNT,
      "/admin/manage-admins": AdminPermission.MANAGE_ADMIN_PERMISSIONS,
    }

    const requiredPermission = pagePermissionMap[path]
    return requiredPermission ? canAccess(requiredPermission) : false
  }

  return {
    permissions,
    adminRole,
    isLoading,
    isSuperAdmin: adminRole === AdminRole.SUPER_ADMIN,
    canAccess,
    canAccessPage,
  }
} 
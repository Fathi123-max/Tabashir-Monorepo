"use client"

import { useEffect } from "react"
import { useRouter } from "next/navigation"
import { Loader2, AlertCircle } from "lucide-react"
import { useAdminPermissions } from "@/hooks/use-admin-permissions"
import { AdminPermission } from "@prisma/client"

interface PermissionGuardProps {
  children: React.ReactNode
  requiredPermission: AdminPermission
  fallbackPath?: string
}

export function PermissionGuard({
  children,
  requiredPermission,
  fallbackPath = "/admin/dashboard"
}: PermissionGuardProps) {
  const { canAccess, isLoading } = useAdminPermissions()
  const router = useRouter()

  useEffect(() => {
    if (!isLoading && !canAccess(requiredPermission)) {
      router.replace(fallbackPath)
    }
  }, [isLoading, canAccess, requiredPermission, fallbackPath, router])

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <Loader2 className="w-8 h-8 animate-spin text-blue-600" />
      </div>
    )
  }

  if (!canAccess(requiredPermission)) {
    return (
      <div className="flex flex-col items-center justify-center min-h-[400px] p-6">
        <AlertCircle className="w-16 h-16 text-red-500 mb-4" />
        <h2 className="text-xl font-semibold text-gray-900 mb-2">Access Denied</h2>
        <p className="text-gray-600 text-center max-w-md">
          You don't have permission to access this page. Please contact your administrator if you believe this is an error.
        </p>
      </div>
    )
  }

  return <>{children}</>
}

// Higher-order component version for easier use
export function withPermissionGuard<P extends object>(
  Component: React.ComponentType<P>,
  requiredPermission: AdminPermission,
  fallbackPath?: string
) {
  return function ProtectedComponent(props: P) {
    return (
      <PermissionGuard
        requiredPermission={requiredPermission}
        fallbackPath={fallbackPath}
      >
        <Component {...props} />
      </PermissionGuard>
    )
  }
} 
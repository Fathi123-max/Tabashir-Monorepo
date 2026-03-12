import { AdminRole, AdminPermission } from "@prisma/client"

// Permission constants mapped to admin pages
export const ADMIN_PAGE_PERMISSIONS = {
  "/admin/dashboard": [AdminPermission.MANAGE_DASHBOARD],
  "/admin/users": [AdminPermission.MANAGE_USERS],
  "/admin/jobs": [AdminPermission.MANAGE_JOBS],
  "/admin/applications": [AdminPermission.MANAGE_APPLICATIONS],
  "/admin/payments": [AdminPermission.MANAGE_PAYMENTS],
  "/admin/scheduled-interview": [AdminPermission.MANAGE_INTERVIEWS],
  "/admin/aicv": [AdminPermission.MANAGE_AI_CV],
  "/admin/help": [AdminPermission.MANAGE_HELP],
  "/admin/account": [AdminPermission.MANAGE_ACCOUNT],
  "/admin/manage-admins": [AdminPermission.MANAGE_ADMIN_PERMISSIONS], // Only Super Admin
} as const

// Default permissions for each admin role
export const DEFAULT_ROLE_PERMISSIONS = {
  [AdminRole.SUPER_ADMIN]: [
    AdminPermission.MANAGE_DASHBOARD,
    AdminPermission.MANAGE_USERS,
    AdminPermission.MANAGE_JOBS,
    AdminPermission.MANAGE_APPLICATIONS,
    AdminPermission.MANAGE_PAYMENTS,
    AdminPermission.MANAGE_INTERVIEWS,
    AdminPermission.MANAGE_AI_CV,
    AdminPermission.MANAGE_HELP,
    AdminPermission.MANAGE_ACCOUNT,
    AdminPermission.MANAGE_ADMIN_PERMISSIONS,
  ],
  [AdminRole.REGULAR_ADMIN]: [
    AdminPermission.MANAGE_DASHBOARD,
    AdminPermission.MANAGE_APPLICATIONS,
    AdminPermission.MANAGE_ACCOUNT,
  ],
} as const

// Permission labels for UI
export const PERMISSION_LABELS = {
  [AdminPermission.MANAGE_USERS]: "Manage Users",
  [AdminPermission.MANAGE_JOBS]: "Manage Jobs",
  [AdminPermission.MANAGE_APPLICATIONS]: "Manage Applications",
  [AdminPermission.MANAGE_PAYMENTS]: "Manage Payments",
  [AdminPermission.MANAGE_DASHBOARD]: "View Dashboard",
  [AdminPermission.MANAGE_INTERVIEWS]: "Manage Interviews",
  [AdminPermission.MANAGE_AI_CV]: "Manage AI CV",
  [AdminPermission.MANAGE_HELP]: "Manage Help",
  [AdminPermission.MANAGE_ACCOUNT]: "Manage Account",
  [AdminPermission.MANAGE_ADMIN_PERMISSIONS]: "Manage Admin Permissions",
} as const

// Admin role labels
export const ADMIN_ROLE_LABELS = {
  [AdminRole.SUPER_ADMIN]: "Super Admin",
  [AdminRole.REGULAR_ADMIN]: "Regular Admin",
} as const

// Page information for navigation
export const ADMIN_PAGES = [
  {
    path: "/admin/dashboard",
    label: "Dashboard",
    icon: "LayoutDashboard",
    permission: AdminPermission.MANAGE_DASHBOARD,
  },
  {
    path: "/admin/users",
    label: "Users",
    icon: "Users",
    permission: AdminPermission.MANAGE_USERS,
  },
  {
    path: "/admin/jobs",
    label: "Jobs",
    icon: "Briefcase",
    permission: AdminPermission.MANAGE_JOBS,
  },
  {
    path: "/admin/applications",
    label: "Applications",
    icon: "FileText",
    permission: AdminPermission.MANAGE_APPLICATIONS,
  },
  {
    path: "/admin/payments",
    label: "Payments",
    icon: "CreditCard",
    permission: AdminPermission.MANAGE_PAYMENTS,
  },
  {
    path: "/admin/scheduled-interview",
    label: "Interviews",
    icon: "Calendar",
    permission: AdminPermission.MANAGE_INTERVIEWS,
  },
  {
    path: "/admin/aicv",
    label: "AI CV",
    icon: "Bot",
    permission: AdminPermission.MANAGE_AI_CV,
  },
  {
    path: "/admin/help",
    label: "Help",
    icon: "HelpCircle",
    permission: AdminPermission.MANAGE_HELP,
  },
  {
    path: "/admin/account",
    label: "Account",
    icon: "Settings",
    permission: AdminPermission.MANAGE_ACCOUNT,
  },
  {
    path: "/admin/manage-admins",
    label: "Manage Admins",
    icon: "UserCog",
    permission: AdminPermission.MANAGE_ADMIN_PERMISSIONS,
  },
] as const

// Utility functions
export function hasPermission(
  userPermissions: AdminPermission[],
  requiredPermission: AdminPermission
): boolean {
  return userPermissions.includes(requiredPermission)
}

export function hasAnyPermission(
  userPermissions: AdminPermission[],
  requiredPermissions: AdminPermission[]
): boolean {
  return requiredPermissions.some(permission => 
    userPermissions.includes(permission)
  )
}

export function hasAllPermissions(
  userPermissions: AdminPermission[],
  requiredPermissions: AdminPermission[]
): boolean {
  return requiredPermissions.every(permission => 
    userPermissions.includes(permission)
  )
}

export function canAccessPage(
  userPermissions: AdminPermission[],
  pagePath: string
): boolean {
  const requiredPermissions = ADMIN_PAGE_PERMISSIONS[pagePath as keyof typeof ADMIN_PAGE_PERMISSIONS]
  if (!requiredPermissions) return false
  
  return hasAnyPermission(userPermissions, [...requiredPermissions])
}

export function isSuperAdmin(adminRole: AdminRole | null): boolean {
  return adminRole === AdminRole.SUPER_ADMIN
}

export function getAccessiblePages(userPermissions: AdminPermission[]) {
  return ADMIN_PAGES.filter(page => 
    hasPermission(userPermissions, page.permission)
  )
}

export function getDefaultPermissionsForRole(role: AdminRole): AdminPermission[] {
  const permissions = DEFAULT_ROLE_PERMISSIONS[role]
  return permissions ? [...permissions] : []
} 
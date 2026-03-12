"use client"

import { useState, useEffect } from "react"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table"
import { Badge } from "@/components/ui/badge"
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog"
import { Label } from "@/components/ui/label"
import { Checkbox } from "@/components/ui/checkbox"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { AlertCircle, Plus, Trash2, UserPlus, Loader2, Settings, Eye } from "lucide-react"
import { toast } from "sonner"
import { getAdminUsers, createAdmin, removeAdmin, getUserPermissions, updateUserPermissions, updateUserRole } from "./actions"
import { PermissionGuard } from "@/components/admin/permission-guard"
import { AdminPermission, AdminRole } from "@prisma/client"
import { PERMISSION_LABELS } from "@/lib/permissions"

interface AdminUser {
  id: string
  name: string | null
  email: string | null
  userType: string | null
  createdAt: Date
  adminRole?: AdminRole | null
  permissions?: AdminPermission[]
}

interface UserPermissions {
  id: string
  name: string | null
  email: string | null
  adminRole: AdminRole | null
  permissions: AdminPermission[]
}

export default function ManageAdminsPage() {
  const [adminUsers, setAdminUsers] = useState<AdminUser[]>([])
  const [loading, setLoading] = useState(true)
  const [isCreateDialogOpen, setIsCreateDialogOpen] = useState(false)
  const [isCreating, setIsCreating] = useState(false)
  const [createForm, setCreateForm] = useState({
    email: "",
    name: ""
  })

  // Permission management state
  const [isPermissionDialogOpen, setIsPermissionDialogOpen] = useState(false)
  const [isViewPermissionDialogOpen, setIsViewPermissionDialogOpen] = useState(false)
  const [currentEditingUser, setCurrentEditingUser] = useState<UserPermissions | null>(null)
  const [currentViewingUser, setCurrentViewingUser] = useState<UserPermissions | null>(null)
  const [selectedPermissions, setSelectedPermissions] = useState<AdminPermission[]>([])
  const [selectedRole, setSelectedRole] = useState<AdminRole | null>(null)
  const [isUpdatingPermissions, setIsUpdatingPermissions] = useState(false)

  useEffect(() => {
    fetchAdminUsers()
  }, [])

  const fetchAdminUsers = async () => {
    try {
      setLoading(true)
      const result = await getAdminUsers()

      if (result.success) {
        setAdminUsers(result.adminUsers || [])
      } else {
        toast.error(result.error || "Failed to fetch admin users")
      }
    } catch (error) {
      toast.error("Failed to fetch admin users")
    } finally {
      setLoading(false)
    }
  }

  const handleCreateAdmin = async () => {
    if (!createForm.email.trim()) {
      toast.error("Email is required")
      return
    }

    try {
      setIsCreating(true)
      const result = await createAdmin(createForm.email.trim(), createForm.name.trim())

      if (result.success) {
        toast.success(result.message || "Admin created successfully")
        setIsCreateDialogOpen(false)
        setCreateForm({ email: "", name: "" })
        fetchAdminUsers()
      } else {
        toast.error(result.error || "Failed to create admin")
      }
    } catch (error) {
      toast.error("Failed to create admin")
    } finally {
      setIsCreating(false)
    }
  }

  const handleRemoveAdmin = async (userId: string, userEmail: string) => {
    if (!confirm(`Are you sure you want to remove admin access for ${userEmail}?`)) {
      return
    }

    try {
      const result = await removeAdmin(userId)

      if (result.success) {
        toast.success(result.message || "Admin removed successfully")
        fetchAdminUsers()
      } else {
        toast.error(result.error || "Failed to remove admin")
      }
    } catch (error) {
      toast.error("Failed to remove admin")
    }
  }

  const handleManagePermissions = async (userId: string) => {
    try {
      const result = await getUserPermissions(userId)

      if (result.success && result.user) {
        setCurrentEditingUser(result.user)
        setSelectedPermissions(result.user.permissions || [])
        setSelectedRole(result.user.adminRole || AdminRole.REGULAR_ADMIN)
        setIsPermissionDialogOpen(true)
      } else {
        toast.error(result.error || "Failed to fetch user permissions")
      }
    } catch (error) {
      toast.error("Failed to fetch user permissions")
    }
  }

  const handleViewPermissions = async (userId: string) => {
    try {
      const result = await getUserPermissions(userId)

      if (result.success && result.user) {
        setCurrentViewingUser(result.user)
        setIsViewPermissionDialogOpen(true)
      } else {
        toast.error(result.error || "Failed to fetch user permissions")
      }
    } catch (error) {
      toast.error("Failed to fetch user permissions")
    }
  }

  const handleUpdatePermissions = async () => {
    if (!currentEditingUser) return

    try {
      setIsUpdatingPermissions(true)

      // Update role first
      if (selectedRole && selectedRole !== currentEditingUser.adminRole) {
        const roleResult = await updateUserRole(currentEditingUser.id, selectedRole)
        if (!roleResult.success) {
          toast.error(roleResult.error || "Failed to update role")
          return
        }
      }

      // Update permissions
      const permissionsResult = await updateUserPermissions(currentEditingUser.id, selectedPermissions)

      if (permissionsResult.success) {
        toast.success("Permissions updated successfully")
        setIsPermissionDialogOpen(false)
        setCurrentEditingUser(null)
        setSelectedPermissions([])
        setSelectedRole(null)
        fetchAdminUsers()
      } else {
        toast.error(permissionsResult.error || "Failed to update permissions")
      }
    } catch (error) {
      toast.error("Failed to update permissions")
    } finally {
      setIsUpdatingPermissions(false)
    }
  }

  const handlePermissionToggle = (permission: AdminPermission) => {
    setSelectedPermissions(prev =>
      prev.includes(permission)
        ? prev.filter(p => p !== permission)
        : [...prev, permission]
    )
  }

  const getRoleBadgeColor = (role: AdminRole | null) => {
    switch (role) {
      case AdminRole.SUPER_ADMIN:
        return "bg-red-100 text-red-800"
      case AdminRole.REGULAR_ADMIN:
        return "bg-blue-100 text-blue-800"
      default:
        return "bg-gray-100 text-gray-800"
    }
  }

  const formatPermissionCount = (permissions: AdminPermission[] | undefined) => {
    if (!permissions) return "0 permissions"
    return `${permissions.length} permission${permissions.length === 1 ? '' : 's'}`
  }

  if (loading) {
    return (
      <div className="p-6 text-gray-900">
        <div className="flex items-center justify-center min-h-[400px]">
          <Loader2 className="w-8 h-8 animate-spin" />
        </div>
      </div>
    )
  }

  return (
    <PermissionGuard requiredPermission={AdminPermission.MANAGE_ADMIN_PERMISSIONS}>
      <div className="p-6 text-gray-900">
        <div className="flex justify-between items-center mb-6">
          <div>
            <h1 className="text-2xl font-bold">Manage Admins</h1>
            <p className="text-gray-600 mt-1">Manage admin users and their permissions</p>
          </div>

          <Dialog open={isCreateDialogOpen} onOpenChange={setIsCreateDialogOpen}>
            <DialogTrigger asChild>
              <Button className="bg-gradient-to-r from-[#042052] to-[#0D57E1]">
                <UserPlus className="w-4 h-4 mr-2" />
                Add Admin
              </Button>
            </DialogTrigger>
            <DialogContent>
              <DialogHeader>
                <DialogTitle>Add New Admin</DialogTitle>
                <DialogDescription>
                  Promote an existing user to admin. The user must already have an account.
                </DialogDescription>
              </DialogHeader>

              <div className="space-y-4 py-4">
                <div className="space-y-2">
                  <Label htmlFor="email">Email Address *</Label>
                  <Input
                    id="email"
                    type="email"
                    placeholder="user@example.com"
                    value={createForm.email}
                    onChange={(e) => setCreateForm(prev => ({ ...prev, email: e.target.value }))}
                  />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="name">Name (Optional)</Label>
                  <Input
                    id="name"
                    type="text"
                    placeholder="Full Name"
                    value={createForm.name}
                    onChange={(e) => setCreateForm(prev => ({ ...prev, name: e.target.value }))}
                  />
                </div>

                <div className="flex items-start gap-2 p-3 bg-blue-50 rounded-lg">
                  <AlertCircle className="w-4 h-4 text-blue-600 mt-0.5 flex-shrink-0" />
                  <div className="text-sm text-blue-800">
                    <p className="font-medium">Note:</p>
                    <p>The user must already have an account in the system. New admins will be granted basic permissions that can be customized later.</p>
                  </div>
                </div>
              </div>

              <div className="flex justify-end gap-2">
                <Button
                  variant="outline"
                  onClick={() => setIsCreateDialogOpen(false)}
                  disabled={isCreating}
                >
                  Cancel
                </Button>
                <Button
                  onClick={handleCreateAdmin}
                  disabled={isCreating}
                >
                  {isCreating ? (
                    <>
                      <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                      Creating...
                    </>
                  ) : (
                    "Create Admin"
                  )}
                </Button>
              </div>
            </DialogContent>
          </Dialog>
        </div>

        <div className="bg-white rounded-lg shadow-sm">
          <div className="p-6">
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>User</TableHead>
                  <TableHead>Email</TableHead>
                  <TableHead>Role</TableHead>
                  <TableHead>Permissions</TableHead>
                  <TableHead>Created</TableHead>
                  <TableHead className="text-right">Actions</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {adminUsers.length === 0 ? (
                  <TableRow>
                    <TableCell colSpan={6} className="text-center py-8 text-gray-500">
                      No admin users found
                    </TableCell>
                  </TableRow>
                ) : (
                  adminUsers.map((user) => (
                    <TableRow key={user.id}>
                      <TableCell>
                        <div>
                          <div className="font-medium">{user.name || 'Unknown'}</div>
                          <div className="text-sm text-gray-500">ID: {user.id}</div>
                        </div>
                      </TableCell>
                      <TableCell>{user.email}</TableCell>
                      <TableCell>
                        <Badge className={getRoleBadgeColor(user.adminRole || null)}>
                          {user.adminRole === AdminRole.SUPER_ADMIN ? 'Super Admin' :
                            user.adminRole === AdminRole.REGULAR_ADMIN ? 'Regular Admin' : 'Admin'}
                        </Badge>
                      </TableCell>
                      <TableCell>
                        <div className="flex items-center gap-2">
                          <span className="text-sm text-gray-600">
                            {formatPermissionCount(user.permissions)}
                          </span>
                          <Button
                            variant="ghost"
                            size="sm"
                            onClick={() => handleViewPermissions(user.id)}
                            className="h-6 w-6 p-0"
                          >
                            <Eye className="w-4 h-4" />
                          </Button>
                        </div>
                      </TableCell>
                      <TableCell>
                        {new Date(user.createdAt).toLocaleDateString()}
                      </TableCell>
                      <TableCell className="text-right">
                        <div className="flex items-center gap-2 justify-end">
                          <Button
                            variant="outline"
                            size="sm"
                            onClick={() => handleManagePermissions(user.id)}
                            className="text-blue-600 hover:text-blue-700 hover:bg-blue-50"
                          >
                            <Settings className="w-4 h-4 mr-1" />
                            Manage
                          </Button>
                          <Button
                            variant="outline"
                            size="sm"
                            onClick={() => handleRemoveAdmin(user.id, user.email || 'Unknown')}
                            className="text-red-600 hover:text-red-700 hover:bg-red-50"
                          >
                            <Trash2 className="w-4 h-4 mr-1" />
                            Remove
                          </Button>
                        </div>
                      </TableCell>
                    </TableRow>
                  ))
                )}
              </TableBody>
            </Table>
          </div>
        </div>

        {/* Permission Management Dialog */}
        <Dialog open={isPermissionDialogOpen} onOpenChange={setIsPermissionDialogOpen}>
          <DialogContent className="max-w-2xl">
            <DialogHeader>
              <DialogTitle>Manage Permissions</DialogTitle>
              <DialogDescription>
                Update permissions and role for {currentEditingUser?.name || currentEditingUser?.email}
              </DialogDescription>
            </DialogHeader>

            <div className="space-y-6 py-4">
              <div className="space-y-2">
                <Label>Admin Role</Label>
                <Select value={selectedRole || ""} onValueChange={(value) => setSelectedRole(value as AdminRole)}>
                  <SelectTrigger>
                    <SelectValue placeholder="Select admin role" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value={AdminRole.REGULAR_ADMIN}>Regular Admin</SelectItem>
                    <SelectItem value={AdminRole.SUPER_ADMIN}>Super Admin</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="space-y-4">
                <Label>Permissions</Label>
                <div className="grid grid-cols-2 gap-3">
                  {Object.entries(PERMISSION_LABELS).map(([permission, label]) => (
                    <div key={permission} className="flex items-center space-x-2">
                      <Checkbox
                        id={permission}
                        checked={selectedPermissions.includes(permission as AdminPermission)}
                        onCheckedChange={() => handlePermissionToggle(permission as AdminPermission)}
                      />
                      <Label htmlFor={permission} className="text-sm font-normal">
                        {label}
                      </Label>
                    </div>
                  ))}
                </div>
              </div>

              <div className="flex items-start gap-2 p-3 bg-amber-50 rounded-lg">
                <AlertCircle className="w-4 h-4 text-amber-600 mt-0.5 flex-shrink-0" />
                <div className="text-sm text-amber-800">
                  <p className="font-medium">Note:</p>
                  <p>Super Admins typically have all permissions. Regular Admins should have limited permissions based on their responsibilities.</p>
                </div>
              </div>
            </div>

            <div className="flex justify-end gap-2">
              <Button
                variant="outline"
                onClick={() => setIsPermissionDialogOpen(false)}
                disabled={isUpdatingPermissions}
              >
                Cancel
              </Button>
              <Button
                onClick={handleUpdatePermissions}
                disabled={isUpdatingPermissions}
              >
                {isUpdatingPermissions ? (
                  <>
                    <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                    Updating...
                  </>
                ) : (
                  "Update Permissions"
                )}
              </Button>
            </div>
          </DialogContent>
        </Dialog>

        {/* View Permissions Dialog */}
        <Dialog open={isViewPermissionDialogOpen} onOpenChange={setIsViewPermissionDialogOpen}>
          <DialogContent className="max-w-xl">
            <DialogHeader>
              <DialogTitle>View Permissions</DialogTitle>
              <DialogDescription>
                Current permissions for {currentViewingUser?.name || currentViewingUser?.email}
              </DialogDescription>
            </DialogHeader>

            <div className="space-y-4 py-4">
              <div>
                <Label className="text-sm font-medium text-gray-700">Role</Label>
                <div className="mt-1">
                  <Badge className={getRoleBadgeColor(currentViewingUser?.adminRole || null)}>
                    {currentViewingUser?.adminRole === AdminRole.SUPER_ADMIN ? 'Super Admin' :
                      currentViewingUser?.adminRole === AdminRole.REGULAR_ADMIN ? 'Regular Admin' : 'Admin'}
                  </Badge>
                </div>
              </div>

              <div>
                <Label className="text-sm font-medium text-gray-700">Permissions</Label>
                <div className="mt-2 space-y-2">
                  {currentViewingUser?.permissions && currentViewingUser.permissions.length > 0 ? (
                    currentViewingUser.permissions.map((permission) => (
                      <div key={permission} className="flex items-center space-x-2">
                        <div className="w-2 h-2 bg-green-500 rounded-full"></div>
                        <span className="text-sm">{PERMISSION_LABELS[permission]}</span>
                      </div>
                    ))
                  ) : (
                    <p className="text-sm text-gray-500">No permissions assigned</p>
                  )}
                </div>
              </div>
            </div>

            <div className="flex justify-end">
              <Button
                variant="outline"
                onClick={() => setIsViewPermissionDialogOpen(false)}
              >
                Close
              </Button>
            </div>
          </DialogContent>
        </Dialog>
      </div>
    </PermissionGuard>
  )
} 
"use client"

import { Menu } from "lucide-react"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { useEffect, useState } from "react"
import { getCurrentOwnerUser } from "./header-actions"

interface HeaderProps {
  sidebarOpen: boolean
  setSidebarOpen: (open: boolean) => void
}

interface UserData {
  id: string
  name: string
  email: string
  image?: string | null
  userType: string | null
  isOwner: boolean
}

export default function Header({ sidebarOpen, setSidebarOpen }: HeaderProps) {
  const [userData, setUserData] = useState<UserData | null>(null)
  const [loading, setLoading] = useState(true)

  // Fetch user data
  useEffect(() => {
    const fetchUserData = async () => {
      try {
        const result = await getCurrentOwnerUser()
        if (result.success && result.user) {
          setUserData(result.user)
        }
      } catch (error) {
        console.error("Error fetching user data:", error)
      } finally {
        setLoading(false)
      }
    }

    fetchUserData()
  }, [])

  // Generate initials for avatar fallback
  const getInitials = (name: string) => {
    return name
      .split(' ')
      .map(word => word.charAt(0))
      .join('')
      .toUpperCase()
      .slice(0, 2)
  }

  // Get role display text
  const getRoleText = (userType: string | null, isOwner: boolean) => {
    if (isOwner) return "Admin"
    if (userType === "ADMIN") return "Admin"
    return "User"
  }

  return (
    <header className="bg-white border-b border-gray-200 py-5 px-6 flex items-center justify-between">
      <button className="md:hidden" onClick={() => setSidebarOpen(!sidebarOpen)}>
        <Menu className="h-6 w-6" />
      </button>

      <div className="flex items-center ml-auto">
        {loading ? (
          <div className="flex items-center">
            <div className="text-right mr-4">
              <div className="h-4 bg-gray-200 rounded w-20 mb-1 animate-pulse"></div>
              <div className="h-3 bg-gray-200 rounded w-12 animate-pulse"></div>
            </div>
            <div className="w-10 h-10 bg-gray-200 rounded-full animate-pulse"></div>
          </div>
        ) : userData ? (
          <>
            <div className="text-right mr-4">
              <p className="text-sm font-medium text-gray-900">{userData.name}</p>
              <p className="text-xs text-gray-500">{getRoleText(userData.userType, userData.isOwner)}</p>
            </div>
            <Avatar>
              <AvatarImage
                src={userData.image || undefined}
                alt={userData.name}
                className="object-cover h-full w-full rounded-full"
              />
              <AvatarFallback className="bg-blue-100 text-blue-600 font-medium">
                {getInitials(userData.name)}
              </AvatarFallback>
            </Avatar>
          </>
        ) : (
          <>
            <div className="text-right mr-4">
              <p className="text-sm font-medium text-gray-900">Admin User</p>
              <p className="text-xs text-gray-500">Admin</p>
            </div>
            <Avatar>
              <AvatarFallback className="bg-blue-100 text-blue-600 font-medium">
                AU
              </AvatarFallback>
            </Avatar>
          </>
        )}
      </div>
    </header>
  )
}

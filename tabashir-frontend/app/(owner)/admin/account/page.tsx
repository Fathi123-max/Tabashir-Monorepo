"use client"

import { useState, useEffect } from "react"
import { Pencil, Loader2 } from "lucide-react"
import { Badge } from "@/components/ui/badge"
import { useSession } from "next-auth/react"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Skeleton } from "@/components/ui/skeleton"

interface UserProfile {
  id: string
  name: string | null
  email: string
  image: string | null
  userType: string
  phone?: string | null
  gender?: string | null
  skills?: string[]
}

export default function AccountPage() {
  const { data: session, status } = useSession()
  const [userProfile, setUserProfile] = useState<UserProfile | null>(null)
  const [skills, setSkills] = useState<string[]>([])
  const [newSkill, setNewSkill] = useState("")
  const [loading, setLoading] = useState(false)

  useEffect(() => {
    if (session?.user) {
      // Set the basic user profile from session
      const basicProfile: UserProfile = {
        id: session.user.id,
        name: session.user.name || null,
        email: session.user.email || "",
        image: session.user.image || null,
        userType: session.user.userType || "USER"
      }
      setUserProfile(basicProfile)

      // Set default skills for now
      setSkills(["Figma", "Adobe Cloud", "Team Work", "Time Management"])
    }
  }, [session])

  const addSkill = () => {
    if (newSkill.trim() !== "" && !skills.includes(newSkill.trim())) {
      setSkills([...skills, newSkill.trim()])
      setNewSkill("")
    }
  }

  const removeSkill = (skillToRemove: string) => {
    setSkills(skills.filter((skill) => skill !== skillToRemove))
  }

  const getInitials = (name: string) => {
    return name
      .split(' ')
      .map(n => n[0])
      .join('')
      .toUpperCase()
      .slice(0, 2)
  }

  if (status === "loading") {
    return (
      <div className="flex-1 p-6 h-full text-gray-900">
        <div className="mx-auto space-y-6">
          {/* Loading Personal Information */}
          <div className="bg-white rounded-lg shadow-sm p-6">
            <Skeleton className="h-6 w-48 mb-6" />
            <div className="space-y-4">
              {[1, 2, 3].map((i) => (
                <div key={i} className="grid grid-cols-4 gap-4 items-center">
                  <Skeleton className="h-4 w-20" />
                  <div className="col-span-3">
                    <Skeleton className="h-10 w-full" />
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* Loading Account Information */}
          <div className="bg-white rounded-lg shadow-sm p-6">
            <Skeleton className="h-6 w-48 mb-6" />
            <div className="space-y-4">
              {[1, 2, 3].map((i) => (
                <div key={i} className="grid grid-cols-4 gap-4 items-center">
                  <Skeleton className="h-4 w-20" />
                  <div className="col-span-3">
                    <Skeleton className="h-10 w-full" />
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    )
  }

  if (status === "unauthenticated") {
    return (
      <div className="flex-1 p-6 h-full text-gray-900 flex items-center justify-center">
        <div className="text-center">
          <h2 className="text-2xl font-bold text-gray-900 mb-2">Authentication Required</h2>
          <p className="text-gray-600">Please sign in to view your account information.</p>
        </div>
      </div>
    )
  }

  return (
    <div className="flex-1 p-6 h-full text-gray-900">
      <div className="mx-auto space-y-6">
        {/* Personal Information */}
        <div className="bg-white rounded-lg shadow-sm p-6">
          <h2 className="text-xl font-bold mb-6">Personal Information</h2>

          <div className="space-y-4">
            <div className="grid grid-cols-4 gap-4 items-center">
              <label className="text-gray-700">Full Name</label>
              <div className="col-span-3">
                <div className="flex items-center border rounded-md p-2">
                  <span className="flex-1 text-gray-900">
                    {userProfile?.name || "Not provided"}
                  </span>
                  <button className="text-gray-500 hover:text-gray-700">
                    <Pencil size={16} />
                  </button>
                </div>
              </div>
            </div>

            <div className="grid grid-cols-4 gap-4 items-center">
              <label className="text-gray-700">User ID</label>
              <div className="col-span-3">
                <div className="flex items-center border rounded-md p-2">
                  <span className="flex-1 text-gray-900 font-mono text-sm">
                    {userProfile?.id || "Not available"}
                  </span>
                  <Badge variant="outline" className="ml-2">
                    ID
                  </Badge>
                </div>
              </div>
            </div>

            <div className="grid grid-cols-4 gap-4 items-center">
              <label className="text-gray-700">Profile Picture</label>
              <div className="col-span-3">
                <div className="flex items-center border rounded-md p-2">
                  <span className="flex-1 text-gray-900">Profile Picture</span>
                  <Avatar className="h-6 w-6">
                    <AvatarImage src={userProfile?.image || undefined} alt={userProfile?.name || "User"} />
                    <AvatarFallback className="text-xs">
                      {userProfile?.name ? getInitials(userProfile.name) : "U"}
                    </AvatarFallback>
                  </Avatar>
                  <button className="ml-2 text-gray-500 hover:text-gray-700">
                    <Pencil size={16} />
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Account Information */}
        <div className="bg-white rounded-lg shadow-sm p-6">
          <h2 className="text-xl font-bold mb-6">Account Information</h2>

          <div className="space-y-4">
            <div className="grid grid-cols-4 gap-4 items-center">
              <label className="text-gray-700">Email</label>
              <div className="col-span-3">
                <div className="flex items-center border rounded-md p-2">
                  <span className="flex-1 text-gray-900">
                    {userProfile?.email || "Not provided"}
                  </span>
                  <button className="text-gray-500 hover:text-gray-700">
                    <Pencil size={16} />
                  </button>
                </div>
              </div>
            </div>

            <div className="grid grid-cols-4 gap-4 items-center">
              <label className="text-gray-700">Password</label>
              <div className="col-span-3">
                <div className="flex items-center border rounded-md p-2">
                  <span className="flex-1 text-gray-900">••••••••••••••</span>
                  <button className="text-gray-500 hover:text-gray-700">
                    <Pencil size={16} />
                  </button>
                </div>
              </div>
            </div>

            <div className="grid grid-cols-4 gap-4 items-center">
              <label className="text-gray-700">User Type</label>
              <div className="col-span-3">
                <div className="flex items-center border rounded-md p-2">
                  <span className="flex-1 text-gray-900 capitalize">
                    {userProfile?.userType || "Not specified"}
                  </span>
                  <Badge variant="secondary" className="ml-2">
                    {userProfile?.userType || "N/A"}
                  </Badge>
                </div>
              </div>
            </div>

            <div className="grid grid-cols-4 gap-4 items-center">
              <label className="text-gray-700">Account Status</label>
              <div className="col-span-3">
                <div className="flex items-center border rounded-md p-2">
                  <span className="flex-1 text-gray-900">
                    Active
                  </span>
                  <Badge variant="default" className="ml-2 bg-green-500">
                    Active
                  </Badge>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* User Skills */}
        {skills.length > 0 && (
          <div className="bg-white rounded-lg shadow-sm p-6">
            <h2 className="text-xl font-bold mb-6">Skills & Expertise</h2>
            <div className="flex flex-wrap gap-2">
              {skills.map((skill, index) => (
                <Badge key={index} variant="secondary" className="px-3 py-1">
                  {skill}
                </Badge>
              ))}
            </div>
          </div>
        )}

        {/* Session Information (for debugging) */}
        {process.env.NODE_ENV === "development" && (
          <div className="bg-white rounded-lg shadow-sm p-6">
            <h2 className="text-xl font-bold mb-6">Session Debug Info</h2>
            <div className="bg-gray-100 rounded-md p-4">
              <pre className="text-xs text-gray-700 overflow-auto">
                {JSON.stringify(session, null, 2)}
              </pre>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}

"use client"
import Image from "next/image"
import { X, Download, FileText, Star } from "lucide-react"
import { Dialog, DialogContent } from "@/components/ui/dialog"
import { Button } from "@/components/ui/button"

interface ApplicantViewDialogProps {
  open: boolean
  onOpenChange: (open: boolean) => void
  applicant?: {
    refNo: string
    name: string
    status: string
    location: string
    time: string
    matchScore?: number
  }
}

export function ApplicantViewDialog({ open, onOpenChange, applicant }: ApplicantViewDialogProps) {
  if (!applicant) return null

  // Mock data for the dialog
  const userData = {
    name: "Alexis Wolen",
    title: "UX Designer",
    avatar: "/diverse-group.png",
    matchScore: 88,
    status: "None",
    appliedFor: {
      title: "UX Designer, Google Pay",
      type: "Full time",
      postedDate: "12 March 2025",
    },
    resume: {
      filename: "Alexis Wolen-Wordpress-Developer-Resume",
    },
    info: {
      email: "baiamia@gmail.com",
      phone: "+01-322-212121",
      location: "New York City, USA",
      language: "English, Arabic",
      gender: "Male",
    },
  }

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px] p-0 gap-0 text-gray-900">
        <div className="flex justify-between items-center p-4 border-b">
          <div className="flex items-center gap-2">
            <h2 className="text-xl font-semibold">User Information</h2>
            <span className="text-sm text-gray-500">Ref no {applicant.refNo}</span>
          </div>
          <button
            onClick={() => onOpenChange(false)}
            className="rounded-full h-6 w-6 flex items-center justify-center text-gray-500 hover:bg-gray-100"
          >
            <X className="h-4 w-4" />
          </button>
        </div>

        <div className="p-6">
          {/* User Profile */}
          <div className="flex justify-between mb-6">
            <div className="flex items-center gap-3">
              <div className="relative h-16 w-16 rounded-full overflow-hidden">
                <Image src={userData.avatar || "/placeholder.svg"} alt={userData.name} fill className="object-cover" />
              </div>
              <div>
                <h3 className="font-semibold text-lg text-gray-900">{userData.name}</h3>
                <p className="text-gray-600">{userData.title}</p>
              </div>
            </div>
            <div className="bg-blue-50 rounded-lg p-3 flex flex-col items-center justify-center">
              <div className="flex items-center gap-1 mb-1">
                <span className="text-xl font-bold text-gray-900">{userData.matchScore}%</span>
                <Star className="h-5 w-5 fill-yellow-400 text-yellow-400" />
              </div>
              <span className="text-xs text-blue-800">AI Match Score</span>
            </div>
          </div>

          {/* Status */}
          <div className="grid grid-cols-[120px_1fr] items-center mb-4">
            <span className="text-gray-600">Status:</span>
            <span className="text-gray-900">{userData.status}</span>
          </div>

          {/* Applied For */}
          <div className="grid grid-cols-[120px_1fr] items-start mb-4">
            <span className="text-gray-600">Applied For:</span>
            <div>
              <div className="flex items-center gap-2 mb-1">
                <div className="w-6 h-6 bg-blue-100 rounded-md overflow-hidden flex-shrink-0">
                  <Image
                    src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/2048px-Google_%22G%22_Logo.svg.png"
                    alt="Google Logo"
                    width={24}
                    height={24}
                    className="p-1"
                  />
                </div>
                <span className="font-medium text-gray-900">{userData.appliedFor.title}</span>
              </div>
              <div className="flex justify-between text-sm">
                <span className="text-gray-600">{userData.appliedFor.type}</span>
                <span className="text-gray-600">Posted on {userData.appliedFor.postedDate}</span>
              </div>
            </div>
          </div>

          {/* Resume */}
          <div className="grid grid-cols-[120px_1fr] items-center mb-6">
            <span className="text-gray-600">Resume:</span>
            <div className="flex items-center gap-2">
              <div className="flex items-center gap-2 bg-red-50 text-red-700 rounded-md px-3 py-2 flex-1">
                <FileText className="h-5 w-5" />
                <span className="text-sm truncate">{userData.resume.filename}</span>
              </div>
              <Button size="icon" variant="outline" className="h-9 w-9">
                <Download className="h-4 w-4" />
              </Button>
            </div>
          </div>

          {/* User Info */}
          <div className="mb-6">
            <h3 className="font-medium mb-3">User Info</h3>
            <div className="space-y-3">
              <div className="grid grid-cols-[120px_1fr] items-center">
                <span className="text-gray-600">Email</span>
                <input
                  type="text"
                  value={userData.info.email}
                  readOnly
                  className="border rounded-md px-3 py-1.5 w-full bg-white text-gray-900"
                />
              </div>
              <div className="grid grid-cols-[120px_1fr] items-center">
                <span className="text-gray-600">Phone</span>
                <input
                  type="text"
                  value={userData.info.phone}
                  readOnly
                  className="border rounded-md px-3 py-1.5 w-full bg-white text-gray-900"
                />
              </div>
              <div className="grid grid-cols-[120px_1fr] items-center">
                <span className="text-gray-600">Location</span>
                <input
                  type="text"
                  value={userData.info.location}
                  readOnly
                  className="border rounded-md px-3 py-1.5 w-full bg-white text-gray-900"
                />
              </div>
              <div className="grid grid-cols-[120px_1fr] items-center">
                <span className="text-gray-600">Language</span>
                <input
                  type="text"
                  value={userData.info.language}
                  readOnly
                  className="border rounded-md px-3 py-1.5 w-full bg-white text-gray-900"
                />
              </div>
              <div className="grid grid-cols-[120px_1fr] items-center">
                <span className="text-gray-600">Gender</span>
                <input
                  type="text"
                  value={userData.info.gender}
                  readOnly
                  className="border rounded-md px-3 py-1.5 w-full bg-white text-gray-900"
                />
              </div>
            </div>
          </div>

          {/* Action Buttons */}
          <div className="flex justify-end gap-2">
            <Button variant="outline" className="text-red-600 border-red-200 hover:bg-red-50 hover:text-red-700">
              Reject
            </Button>
            <Button variant="outline">Set as pending</Button>
            <Button className="bg-blue-950 hover:bg-blue-900">Call for interview</Button>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  )
}

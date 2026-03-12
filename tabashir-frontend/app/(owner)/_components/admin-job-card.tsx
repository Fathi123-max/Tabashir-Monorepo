import { Button } from "@/components/ui/button"
import Link from "next/link"
import { Edit, Eye, MapPin, Calendar, Users, Trash2 } from "lucide-react"
import { getApplicationsByJobId } from "@/lib/api"
import { useEffect, useState } from "react"
import { deleteAdminJob } from "@/app/(owner)/admin/jobs/actions"
import { useRouter } from "next/navigation"
interface AdminJobCardProps {
  id: string
  title: string
  company: string
  type: string
  location?: string
  applicationsCount: number
  views: number
  postedDate: string
  status: "ACTIVE" | "PAUSED" | "CLOSED"
  externalApiJobId?: string
  description?: string
}

export default function AdminJobCard({
  id,
  title,
  company,
  type,
  location,
  applicationsCount,
  views,
  postedDate,
  status,
  externalApiJobId,
  description
}: AdminJobCardProps) {
  const router = useRouter()
  const [isDeleting, setIsDeleting] = useState(false)
  const getStatusColor = (status: string) => {
    switch (status) {
      case "ACTIVE":
        return "bg-green-100 text-green-800"
      case "PAUSED":
        return "bg-yellow-100 text-yellow-800"
      case "CLOSED":
        return "bg-red-100 text-red-800"
      default:
        return "bg-gray-100 text-gray-800"
    }
  }

  const getStatusText = (status: string) => {
    return status?.charAt(0).toUpperCase() + status?.slice(1).toLowerCase()
  }

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('en-GB', {
      day: '2-digit',
      month: 'short',
      year: 'numeric'
    })
  }

  // Helper function to extract text from JSON structure (for rich text editor content)
  const extractTextFromJSON = (json: any): string => {
    if (typeof json === 'string') return json
    if (typeof json !== 'object') return String(json)

    let text = ''

    const extractText = (obj: any) => {
      if (typeof obj === 'string') {
        text += obj + ' '
      } else if (Array.isArray(obj)) {
        obj.forEach(extractText)
      } else if (obj && typeof obj === 'object') {
        Object.values(obj).forEach(extractText)
      }
    }

    extractText(json)
    return text.trim()
  }

  // Function to get displayable description text
  const getDescriptionText = (desc?: string): string => {
    if (!desc) return 'No description provided'

    // Check if it's JSON (starts with { and ends with })
    if (desc.trim().startsWith('{') && desc.trim().endsWith('}')) {
      try {
        const parsedDesc = JSON.parse(desc)
        const extractedText = extractTextFromJSON(parsedDesc)
        return extractedText || 'No description provided'
      } catch (e) {
        // If parsing fails, return the original string
        return desc.slice(0, 100) + (desc.length > 100 ? '...' : '')
      }
    }

    // If it's plain text, truncate it
    return desc.slice(0, 100) + (desc.length > 100 ? '...' : '')
  }

  const handleGetApplications = async () => {
    if (externalApiJobId) {
      const result = await getApplicationsByJobId(externalApiJobId)

    }
  }

  const handleDeleteJob = async () => {
    if (!confirm('Are you sure you want to delete this job? This action cannot be undone.')) {
      return
    }

    setIsDeleting(true)
    try {
      const result = await deleteAdminJob(id)
      if (result.success) {
        window.location.reload()
      } else {
        alert('Failed to delete job: ' + result.error)
      }
    } catch (error) {
      console.error('Error deleting job:', error)
      alert('Failed to delete job. Please try again.')
    } finally {
      setIsDeleting(false)
    }
  }

  useEffect(() => {
    handleGetApplications()
  }, [])

  return (
    <div className="bg-white border border-gray-200 rounded-lg p-6 hover:shadow-md transition-shadow h-full">
      {/* Header */}
      <div className="flex justify-between items-start mb-4">
        <div className="flex-1">
          <h3 className="text-lg font-semibold text-gray-900 mb-1">{title}</h3>
          <p className="text-sm text-gray-600">{company}</p>
          <p className="text-xs text-gray-500 mt-1 line-clamp-2">{getDescriptionText(description)}</p>
        </div>
        <div className="flex flex-col items-end gap-2">
          <span className={`text-xs px-2 py-1 rounded-full font-medium ${getStatusColor(status)}`}>
            {getStatusText(status)}
          </span>
          <span className="text-xs bg-blue-50 text-blue-700 px-2 py-1 rounded-full">
            {type}
          </span>
        </div>
      </div>

      {/* Location */}
      {location && (
        <div className="flex items-center text-sm text-gray-600 mb-4">
          <MapPin className="h-4 w-4 mr-1" />
          <span>{location}</span>
        </div>
      )}

      {/* Stats */}
      <div className="grid grid-cols-2 gap-4 mb-6">
        <div className="text-center p-3 bg-gray-50 rounded-lg">
          <div className="flex items-center justify-center mb-1">
            <Users className="h-4 w-4 text-blue-600 mr-1" />
          </div>
          <div className="text-lg font-semibold text-gray-900">{applicationsCount}</div>
          <div className="text-xs text-gray-600">Applications</div>
        </div>

        <div className="text-center p-3 bg-gray-50 rounded-lg">
          <div className="flex items-center justify-center mb-1">
            <Eye className="h-4 w-4 text-green-600 mr-1" />
          </div>
          <div className="text-lg font-semibold text-gray-900">{views}</div>
          <div className="text-xs text-gray-600">Views</div>
        </div>
      </div>

      {/* Posted Date */}
      <div className="flex items-center text-sm text-gray-600 mb-4">
        <Calendar className="h-4 w-4 mr-1" />
        <span>Posted {formatDate(postedDate)}</span>
      </div>

      {/* Actions */}
      <div className="flex gap-2 pt-2 border-t border-gray-100">
        <Link href={`/admin/jobs/${id}/edit`} className="flex-1">
          <Button variant="outline" size="sm" className="w-full">
            <Edit className="h-3 w-3 mr-1" />
            Edit
          </Button>
        </Link>
        <Link href={`/admin/jobs/${id}`} className="flex-1">
          <Button size="sm" className="w-full bg-blue-600 hover:bg-blue-700">
            <Eye className="h-3 w-3 mr-1" />
            View
          </Button>
        </Link>
        <Button
          variant="outline"
          size="sm"
          className="flex-1 text-red-600 border-red-200 hover:bg-red-50 hover:border-red-300"
          onClick={handleDeleteJob}
          disabled={isDeleting}
        >
          <Trash2 className="h-3 w-3 mr-1" />
          {isDeleting ? 'Deleting...' : 'Delete'}
        </Button>
      </div>
    </div>
  )
} 
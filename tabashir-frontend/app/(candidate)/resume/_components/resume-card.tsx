import { Download, Trash2 } from "lucide-react"

interface ResumeCardProps {
  resume: {
    id: number
    name: string
    createdOn: string
  }
}

export function ResumeCard({ resume }: ResumeCardProps) {
  return (
    <div className="border border-gray-200 rounded-lg p-4 bg-white hover:shadow-md transition-shadow">
      <div className="flex gap-4">
        <div className="w-16 h-16 bg-red-500 rounded-md flex items-center justify-center text-white font-bold">PDF</div>
        <div className="flex-1">
          <h3 className="text-sm font-medium text-gray-900 mb-1">{resume.name}</h3>
          <p className="text-xs text-gray-500">Created on: {resume.createdOn}</p>
        </div>
      </div>
      <div className="flex justify-end gap-2 mt-4">
        <button className="p-1 text-gray-500 hover:text-gray-700">
          <Download size={18} />
        </button>
        <button className="p-1 text-gray-500 hover:text-red-500">
          <Trash2 size={18} />
        </button>
      </div>
    </div>
  )
}

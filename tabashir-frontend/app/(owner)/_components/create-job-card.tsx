import Link from "next/link"
import { Plus } from "lucide-react"

export default function CreateJobCard() {
  return (
    <Link href="/admin/jobs/new" className="block h-full">
      <div className="flex flex-col items-center justify-center h-full min-h-[300px] border-2 border-dashed border-gray-300 rounded-lg p-6 bg-white hover:border-blue-500 hover:bg-blue-50 transition-colors text-gray-900">
        <div className="w-16 h-16 bg-gray-200 rounded-full flex items-center justify-center mb-4">
          <Plus className="h-8 w-8 text-gray-500" />
        </div>
        <h3 className="text-xl font-semibold mb-2">Create a New Job</h3>
      </div>
    </Link>
  )
}

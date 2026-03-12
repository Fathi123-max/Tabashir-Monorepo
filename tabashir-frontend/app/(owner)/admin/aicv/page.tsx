"use client"

import { useState, useEffect } from "react"
import { ChevronLeft, ChevronRight } from "lucide-react"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { getAICVs } from "./actions"

export default function AICVPage() {
  const [currentPage, setCurrentPage] = useState(1)
  const [itemsPerPage, setItemsPerPage] = useState(10)
  const [aiCvs, setAiCvs] = useState<any[]>([])
  const [totalCvs, setTotalCvs] = useState(0)
  const [totalPages, setTotalPages] = useState(0)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    const fetchAICVs = async () => {
      try {
        const result = await getAICVs(currentPage, itemsPerPage)
        setAiCvs(result.aiCvs)
        setTotalCvs(result.total)
        setTotalPages(result.totalPages)
      } catch (error) {
        console.error('Error fetching AI CVs:', error)
      } finally {
        setLoading(false)
      }
    }

    fetchAICVs()
  }, [currentPage, itemsPerPage])

  if (loading) {
    return <div className="p-6">Loading...</div>
  }

  return (
    <div className="p-6 text-gray-900">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold">AI CV Management</h1>
      </div>

      <div className="bg-white rounded-lg shadow-sm p-6">
        <table className="w-full">
          <thead>
            <tr className="border-b border-gray-200">
              <th className="text-left py-3 px-4 font-semibold text-gray-700 w-1/4">User</th>
              <th className="text-left py-3 px-4 font-semibold text-gray-700 w-1/4">Created At</th>
              <th className="text-left py-3 px-4 font-semibold text-gray-700 w-1/4">Status</th>
              <th className="text-left py-3 px-4 font-semibold text-gray-700">Payment Status</th>
            </tr>
          </thead>
          <tbody>
            {aiCvs.map((cv) => (
              <tr key={cv.id} className="border-b border-gray-100 hover:bg-gray-50">
                <td className="py-3 px-4">{cv.candidate.user.name} ({cv.candidate.user.email})</td>
                <td className="py-3 px-4">{new Date(cv.createdAt).toLocaleDateString()}</td>
                <td className="py-3 px-4">
                  <span className={`px-2 py-1 rounded-full text-sm ${cv.status === 'COMPLETED' ? 'bg-green-100 text-green-800' :
                    cv.status === 'PROCESSING' ? 'bg-yellow-100 text-yellow-800' :
                      'bg-red-100 text-red-800'
                    }`}>
                    {cv.status}
                  </span>
                </td>
                <td className="py-3 px-4">
                  <span className={`px-2 py-1 rounded-full text-sm ${cv.paymentStatus ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'
                    }`}>
                    {cv.paymentStatus ? 'Paid' : 'Unpaid'}
                  </span>
                </td>
              </tr>
            ))}
          </tbody>
        </table>

        {/* Pagination */}
        <div className="flex justify-between items-center mt-6 text-sm text-gray-600">
          <div className="flex items-center">
            <span>Showing</span>
            <Select
              defaultValue="10"
              onValueChange={(value) => {
                setItemsPerPage(Number(value))
                setCurrentPage(1) // Reset to first page when changing items per page
              }}
            >
              <SelectTrigger className="w-[60px] mx-2 h-8">
                <SelectValue placeholder="10" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="5">5</SelectItem>
                <SelectItem value="10">10</SelectItem>
                <SelectItem value="20">20</SelectItem>
              </SelectContent>
            </Select>
            <span>of {totalCvs}</span>
          </div>

          <div className="flex items-center space-x-1">
            <button
              className="p-1 rounded-md hover:bg-gray-100 disabled:opacity-50"
              disabled={currentPage === 1}
              onClick={() => setCurrentPage((prev) => Math.max(prev - 1, 1))}
            >
              <ChevronLeft className="h-5 w-5" />
            </button>

            {Array.from({ length: totalPages }).map((_, index) => (
              <button
                key={index}
                className={`w-8 h-8 rounded-md ${currentPage === index + 1 ? "bg-blue-950 text-white" : "hover:bg-gray-100 text-gray-700"
                  }`}
                onClick={() => setCurrentPage(index + 1)}
              >
                {index + 1}
              </button>
            ))}

            <button
              className="p-1 rounded-md hover:bg-gray-100 disabled:opacity-50"
              disabled={currentPage === totalPages}
              onClick={() => setCurrentPage((prev) => Math.min(prev + 1, totalPages))}
            >
              <ChevronRight className="h-5 w-5" />
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

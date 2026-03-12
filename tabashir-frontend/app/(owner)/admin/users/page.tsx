"use client"

import { useState, useEffect, useMemo } from "react"
import { ChevronLeft, ChevronRight } from "lucide-react"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { getUsers } from "./actions"
import { Input } from "@/components/ui/input"

export default function UsersPage() {
  const [currentPage, setCurrentPage] = useState(1)
  const [itemsPerPage, setItemsPerPage] = useState(10)
  const [users, setUsers] = useState<any[]>([])
  const [totalUsers, setTotalUsers] = useState(0)
  const [totalPages, setTotalPages] = useState(0)
  const [loading, setLoading] = useState(true)
  const [query, setQuery] = useState("")

  const debouncedQuery = useDebounce(query, 300)

  useEffect(() => {
    const fetchUsers = async () => {
      try {
        const result = await getUsers(currentPage, itemsPerPage, debouncedQuery)
        setUsers(result.users)
        setTotalUsers(result.total)
        setTotalPages(result.totalPages)
      } catch (error) {
        console.error('Error fetching users:', error)
      } finally {
        setLoading(false)
      }
    }

    fetchUsers()
  }, [currentPage, itemsPerPage, debouncedQuery])

  if (loading) {
    return <div className="p-6">Loading...</div>
  }

  return (
    <div className="p-6 text-gray-900">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold">User Management</h1>
        <div className="w-72">
          <Input
            placeholder="Search by name or email"
            value={query}
            onChange={(e) => {
              setQuery(e.target.value)
              setCurrentPage(1)
            }}
          />
        </div>
      </div>

      <div className="bg-white rounded-lg shadow-sm p-6">
        <table className="w-full">
          <thead>
            <tr className="border-b border-gray-200">
              <th className="text-left py-3 px-4 font-semibold text-gray-700">Name</th>
              <th className="text-left py-3 px-4 font-semibold text-gray-700">Email</th>
              <th className="text-left py-3 px-4 font-semibold text-gray-700">User Type</th>
              <th className="text-left py-3 px-4 font-semibold text-gray-700">Phone</th>
              <th className="text-left py-3 px-4 font-semibold text-gray-700">Nationality</th>
              <th className="text-left py-3 px-4 font-semibold text-gray-700">Gender</th>
              <th className="text-left py-3 px-4 font-semibold text-gray-700">Age</th>
              <th className="text-left py-3 px-4 font-semibold text-gray-700">Joined Date</th>
            </tr>
          </thead>
          <tbody>
            {users.map((user) => (
              <tr key={user.id} className="border-b border-gray-100 hover:bg-gray-50">
                <td className="py-3 px-4">{user.name || 'N/A'}</td>
                <td className="py-3 px-4">{user.email}</td>
                <td className="py-3 px-4">
                  <span className={`px-2 py-1 rounded-full text-sm ${user.userType === 'ADMIN' ? 'bg-purple-100 text-purple-800' :
                    user.userType === 'RECURITER' ? 'bg-blue-100 text-blue-800' :
                      'bg-green-100 text-green-800'
                    }`}>
                    {user.userType || 'CANDIDATE'}
                  </span>
                </td>
                <td className="py-3 px-4">{user.candidate?.profile?.phone || 'N/A'}</td>
                <td className="py-3 px-4">{user.candidate?.profile?.nationality || 'N/A'}</td>
                <td className="py-3 px-4">{user.candidate?.profile?.gender || 'N/A'}</td>
                <td className="py-3 px-4">{user.candidate?.profile?.age || 'N/A'}</td>
                <td className="py-3 px-4">{new Date(user.createdAt).toLocaleDateString()}</td>
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
            <span>of {totalUsers}</span>
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

function useDebounce<T>(value: T, delay: number) {
  const [debouncedValue, setDebouncedValue] = useState(value)

  useEffect(() => {
    const handler = setTimeout(() => {
      setDebouncedValue(value)
    }, delay)

    return () => {
      clearTimeout(handler)
    }
  }, [value, delay])

  return debouncedValue
}
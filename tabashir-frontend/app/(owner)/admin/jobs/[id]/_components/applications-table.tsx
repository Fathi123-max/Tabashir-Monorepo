"use client"

import { useState } from "react"
import { Eye, Download, Sparkles } from "lucide-react"
import { Button } from "@/components/ui/button"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table"
import {
  Pagination,
  PaginationContent,
  PaginationItem,
  PaginationLink,
  PaginationNext,
  PaginationPrevious,
} from "@/components/ui/pagination"
import { ApplicantViewDialog } from "../../_components/applicant-view-dialog"
import { JobApplication } from "@prisma/client"

interface Application {
  id: string
  status: string
  matchedScore: number
  candidate: {
    user: {
      name: string | null
      id: string
      email: string
      emailVerified: Date | null
      image: string | null
      password: string | null
      userType: string
      createdAt: Date
      updatedAt: Date
    }
    profile: {
      nationality: string | null
    } | null
  }[]
}

interface ApplicationsTableProps {
  applications: Application[]
}

export function ApplicationsTable({ applications }: ApplicationsTableProps) {
  const [currentPage, setCurrentPage] = useState(1)
  const [selectedApplicant, setSelectedApplicant] = useState<Application | null>(null)
  const [isViewDialogOpen, setIsViewDialogOpen] = useState(false)
  const itemsPerPage = 5

  const totalPages = Math.ceil(applications.length / itemsPerPage)

  const getStatusBadge = (status: string) => {
    switch (status) {
      case "Pending":
        return <span className="px-2 py-1 bg-yellow-100 text-yellow-800 rounded text-xs">Pending</span>
      case "Rejected":
        return <span className="px-2 py-1 bg-red-100 text-red-800 rounded text-xs">Rejected</span>
      case "Viewed":
        return <span className="px-2 py-1 bg-blue-100 text-blue-800 rounded text-xs">Viewed</span>
      case "Interview":
        return <span className="px-2 py-1 bg-green-100 text-green-800 rounded text-xs">Interview</span>
      default:
        return <span className="px-2 py-1 bg-gray-100 text-gray-800 rounded text-xs">{status}</span>
    }
  }

  const handleViewApplicant = (applicant: Application) => {
    setSelectedApplicant(applicant)
    setIsViewDialogOpen(true)
  }

  if (applications.length === 0) {
    return (
      <div className="bg-white rounded-lg shadow-sm p-8 text-center">
        <div className="flex flex-col items-center justify-center space-y-4">
          <div className="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center">
            <Sparkles className="h-8 w-8 text-gray-400" />
          </div>
          <h3 className="text-lg font-medium text-gray-900">No Applications Yet</h3>
          <p className="text-sm text-gray-500 max-w-sm">
            When candidates apply for this job, their applications will appear here.
          </p>
        </div>
      </div>
    )
  }

  return (
    <div className="bg-white rounded-lg shadow-sm">
      <div className="p-4 border-b flex justify-between items-center">
        <h2 className="text-xl font-semibold">Applications</h2>
        <div className="flex items-center gap-4">
          <div className="flex items-center gap-2">
            <span className="text-sm text-gray-700">Sort</span>
            <Select defaultValue="latest">
              <SelectTrigger className="w-[120px] h-8 text-sm border-gray-200">
                <SelectValue placeholder="Latest" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="latest">Latest</SelectItem>
                <SelectItem value="oldest">Oldest</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <Button className="bg-blue-950 hover:bg-blue-900 text-white flex items-center gap-1">
            <Sparkles className="h-4 w-4 text-yellow-300" />
            <span>AI Candidate Recommendation</span>
          </Button>
        </div>
      </div>

      <div className="overflow-x-auto">
        <Table>
          <TableHeader className="bg-gray-50">
            <TableRow>
              <TableHead className="text-xs font-medium text-gray-500 uppercase">#</TableHead>
              <TableHead className="text-xs font-medium text-gray-500 uppercase">NAME</TableHead>
              <TableHead className="text-xs font-medium text-gray-500 uppercase">STATUS</TableHead>
              <TableHead className="text-xs font-medium text-gray-500 uppercase">LOCATION</TableHead>
              <TableHead className="text-xs font-medium text-gray-500 uppercase">TIME</TableHead>
              <TableHead className="text-xs font-medium text-gray-500 uppercase">MATCH</TableHead>
              <TableHead className="text-xs font-medium text-gray-500 uppercase">ACTION</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {applications.slice((currentPage - 1) * itemsPerPage, currentPage * itemsPerPage).map((app, index) => (
              <TableRow key={app.id} className="hover:bg-gray-50 border-b">
                <TableCell className="py-4 text-sm text-gray-700">{(currentPage - 1) * itemsPerPage + index + 1}</TableCell>
                <TableCell className="py-4 text-sm text-gray-700">{app.candidate[0]?.user.name || "Unknown"}</TableCell>
                <TableCell className="py-4">{getStatusBadge(app.status)}</TableCell>
                <TableCell className="py-4 text-sm text-gray-700">{app.candidate[0]?.profile?.nationality || "Not specified"}</TableCell>
                <TableCell className="py-4 text-sm text-gray-700">Just now</TableCell>
                <TableCell className="py-4 text-sm text-gray-700">{app.matchedScore}% Match</TableCell>
                <TableCell className="py-4">
                  <div className="flex space-x-2">
                    <button className="p-2 bg-blue-950 text-white rounded" onClick={() => handleViewApplicant(app)}>
                      <Eye className="h-4 w-4" />
                    </button>
                    <button className="p-2 bg-blue-950 text-white rounded">
                      <Download className="h-4 w-4" />
                    </button>
                  </div>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </div>

      <div className="py-4">
        <Pagination>
          <PaginationContent>
            <PaginationItem>
              <PaginationPrevious
                onClick={() => setCurrentPage((prev) => Math.max(prev - 1, 1))}
                className={currentPage === 1 ? "pointer-events-none opacity-50" : "cursor-pointer"}
              />
            </PaginationItem>

            {Array.from({ length: totalPages }, (_, i) => i + 1).map((page) => (
              <PaginationItem key={page}>
                <PaginationLink
                  onClick={() => setCurrentPage(page)}
                  isActive={currentPage === page}
                  className="cursor-pointer"
                >
                  {page}
                </PaginationLink>
              </PaginationItem>
            ))}

            <PaginationItem>
              <PaginationNext
                onClick={() => setCurrentPage((prev) => Math.min(prev + 1, totalPages))}
                className={currentPage === totalPages ? "pointer-events-none opacity-50" : "cursor-pointer"}
              />
            </PaginationItem>
          </PaginationContent>
        </Pagination>
      </div>

      {selectedApplicant && (
        <ApplicantViewDialog 
          open={isViewDialogOpen} 
          onOpenChange={setIsViewDialogOpen} 
          applicant={{
            refNo: selectedApplicant.id,
            name: selectedApplicant.candidate[0]?.user.name || "Unknown",
            status: selectedApplicant.status,
            location: selectedApplicant.candidate[0]?.profile?.nationality || "Not specified",
            time: "Just now",
            matchScore: selectedApplicant.matchedScore
          }} 
        />
      )}
    </div>
  )
} 
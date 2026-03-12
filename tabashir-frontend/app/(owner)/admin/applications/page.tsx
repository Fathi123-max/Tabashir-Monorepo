"use client"

import { useState, useEffect } from "react"
import { ChevronLeft, ChevronRight, Eye, X, ExternalLink, Loader2 } from "lucide-react"
import { Button } from "@/components/ui/button"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table"
import { Badge } from "@/components/ui/badge"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog"
import { toast } from "sonner"
import { getApplications, dismissApplication, fetchJobDetailsFromAPI, updateApplicationStatus } from "./actions"

interface Application {
  id: string
  status: string
  appliedAt: Date
  user: {
    id: string
    name: string | null
    email: string | null
    image: string | null
  } | null
  Job: {
    id: string
    title: string
    company: string
    jobType: string
    location: string | null
    externalApiJobId: string | null
  } | null
}

export default function ApplicationsPage() {
  const [applications, setApplications] = useState<Application[]>([])
  const [loading, setLoading] = useState(true)
  const [currentPage, setCurrentPage] = useState(1)
  const [totalPages, setTotalPages] = useState(0)
  const [totalCount, setTotalCount] = useState(0)
  const [itemsPerPage, setItemsPerPage] = useState(10)
  const [selectedJobData, setSelectedJobData] = useState<any>(null)
  const [jobDetailsLoading, setJobDetailsLoading] = useState(false)
  const [jobDetailsOpen, setJobDetailsOpen] = useState(false)
  const [updatingStatus, setUpdatingStatus] = useState<string | null>(null)

  useEffect(() => {
    fetchApplications()
  }, [currentPage, itemsPerPage])

  const fetchApplications = async () => {
    try {
      setLoading(true)
      const result = await getApplications(currentPage, itemsPerPage)

      if (result.success) {
        setApplications(result.applications as any[])
        setTotalPages(result.totalPages || 0)
        setTotalCount(result.totalCount || 0)
      } else {
        toast.error(result.error || "Failed to fetch applications")
      }
    } catch (error) {
      toast.error("Failed to fetch applications")
    } finally {
      setLoading(false)
    }
  }

  const handleDismiss = async (applicationId: string) => {
    try {
      const result = await dismissApplication(applicationId)

      if (result.success) {
        toast.success(result.message || "Application dismissed successfully")
        fetchApplications() // Refresh the list
      } else {
        toast.error(result.error || "Failed to dismiss application")
      }
    } catch (error) {
      toast.error("Failed to dismiss application")
    }
  }

  const handleStatusChange = async (applicationId: string, newStatus: string) => {
    try {
      setUpdatingStatus(applicationId)
      const result = await updateApplicationStatus(applicationId, newStatus)

      if (result.success) {
        toast.success(result.message || "Application status updated successfully")
        fetchApplications() // Refresh the list
      } else {
        toast.error(result.error || "Failed to update application status")
      }
    } catch (error) {
      toast.error("Failed to update application status")
    } finally {
      setUpdatingStatus(null)
    }
  }

  const handleViewJobDetails = async (externalJobId: string) => {
    if (!externalJobId) {
      toast.error("No external job ID available")
      return
    }

    try {
      setJobDetailsLoading(true)
      setJobDetailsOpen(true)

      const result = await fetchJobDetailsFromAPI(externalJobId)

      if (result.success) {
        setSelectedJobData(result.jobData)
      } else {
        toast.error(result.error || "Failed to fetch job details")
        setJobDetailsOpen(false)
      }
    } catch (error) {
      toast.error("Failed to fetch job details")
      setJobDetailsOpen(false)
    } finally {
      setJobDetailsLoading(false)
    }
  }

  const getStatusColor = (status: string) => {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'bg-yellow-100 text-yellow-800'
      case 'approved':
        return 'bg-green-100 text-green-800'
      case 'rejected':
        return 'bg-red-100 text-red-800'
      default:
        return 'bg-gray-100 text-gray-800'
    }
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
    <div className="p-6 text-gray-900">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold">Easy Apply Applications</h1>
        <div className="text-sm text-gray-600">
          Total: {totalCount} applications
        </div>
      </div>

      <div className="bg-white rounded-lg shadow-sm">
        <div className="p-6">
          <div className="flex justify-between items-center mb-4">
            <div className="flex items-center gap-4">
              <span className="text-sm text-gray-600">Show</span>
              <Select
                value={itemsPerPage.toString()}
                onValueChange={(value) => {
                  setItemsPerPage(Number(value))
                  setCurrentPage(1)
                }}
              >
                <SelectTrigger className="w-[70px]">
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="5">5</SelectItem>
                  <SelectItem value="10">10</SelectItem>
                  <SelectItem value="20">20</SelectItem>
                  <SelectItem value="50">50</SelectItem>
                </SelectContent>
              </Select>
              <span className="text-sm text-gray-600">entries</span>
            </div>
          </div>

          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Applicant</TableHead>
                <TableHead>Job</TableHead>
                <TableHead>Company</TableHead>
                <TableHead>Applied Date</TableHead>
                <TableHead>Status</TableHead>
                <TableHead className="text-right">Actions</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {applications.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={6} className="text-center py-8 text-gray-500">
                    No Easy Apply applications found
                  </TableCell>
                </TableRow>
              ) : (
                applications.map((application) => (
                  <TableRow key={application.id}>
                    <TableCell>
                      <div className="flex items-center gap-3">
                        <Avatar className="w-8 h-8">
                          <AvatarImage src={application.user?.image || undefined} />
                          <AvatarFallback>
                            {application.user?.name?.charAt(0) || application.user?.email?.charAt(0) || 'U'}
                          </AvatarFallback>
                        </Avatar>
                        <div>
                          <div className="font-medium">{application.user?.name || 'Unknown'}</div>
                          <div className="text-sm text-gray-500">{application.user?.email || 'No email'}</div>
                        </div>
                      </div>
                    </TableCell>
                    <TableCell>
                      {application.Job ? (
                        <>
                          <div className="font-medium">{application.Job.title}</div>
                          <div className="text-sm text-gray-500">{application.Job.jobType}</div>
                        </>
                      ) : (
                        <div className="text-sm text-gray-500">Job not available</div>
                      )}
                    </TableCell>
                    <TableCell>
                      {application.Job ? (
                        <>
                          <div>{application.Job.company}</div>
                          {application.Job.location && (
                            <div className="text-sm text-gray-500">{application.Job.location}</div>
                          )}
                        </>
                      ) : (
                        <div className="text-sm text-gray-500">Company not available</div>
                      )}
                    </TableCell>
                    <TableCell>
                      {new Date(application.appliedAt).toLocaleDateString()}
                    </TableCell>
                    <TableCell>
                      <Select
                        value={application.status}
                        onValueChange={(value) => handleStatusChange(application.id, value)}
                        disabled={updatingStatus === application.id}
                      >
                        <SelectTrigger className="w-[120px]">
                          <SelectValue>
                            {updatingStatus === application.id ? (
                              <div className="flex items-center gap-2">
                                <Loader2 className="w-3 h-3 animate-spin" />
                                <span className="text-xs">Updating...</span>
                              </div>
                            ) : (
                              <Badge className={getStatusColor(application.status)}>
                                {application.status}
                              </Badge>
                            )}
                          </SelectValue>
                        </SelectTrigger>
                        <SelectContent>
                          <SelectItem value="pending">
                            <Badge className="bg-yellow-100 text-yellow-800">Pending</Badge>
                          </SelectItem>
                          <SelectItem value="approved">
                            <Badge className="bg-green-100 text-green-800">Approved</Badge>
                          </SelectItem>
                          <SelectItem value="rejected">
                            <Badge className="bg-red-100 text-red-800">Rejected</Badge>
                          </SelectItem>
                        </SelectContent>
                      </Select>
                    </TableCell>
                    <TableCell className="text-right">
                      <div className="flex items-center gap-2 justify-end">
                        {application.Job?.externalApiJobId && (
                          <Button
                            variant="outline"
                            size="sm"
                            onClick={() => handleViewJobDetails(application.Job!.externalApiJobId!)}
                          >
                            <Eye className="w-4 h-4 mr-1" />
                            View Job
                          </Button>
                        )}
                        <Button
                          variant="outline"
                          size="sm"
                          onClick={() => handleDismiss(application.id)}
                        >
                          <X className="w-4 h-4 mr-1" />
                          Dismiss
                        </Button>
                      </div>
                    </TableCell>
                  </TableRow>
                ))
              )}
            </TableBody>
          </Table>

          {/* Pagination */}
          {totalPages > 1 && (
            <div className="flex justify-between items-center mt-6">
              <div className="text-sm text-gray-600">
                Showing {((currentPage - 1) * itemsPerPage) + 1} to {Math.min(currentPage * itemsPerPage, totalCount)} of {totalCount} entries
              </div>
              <div className="flex items-center gap-2">
                <Button
                  variant="outline"
                  size="sm"
                  onClick={() => setCurrentPage(prev => Math.max(prev - 1, 1))}
                  disabled={currentPage === 1}
                >
                  <ChevronLeft className="w-4 h-4" />
                </Button>

                {Array.from({ length: totalPages }).map((_, index) => (
                  <Button
                    key={index}
                    variant={currentPage === index + 1 ? "default" : "outline"}
                    size="sm"
                    onClick={() => setCurrentPage(index + 1)}
                  >
                    {index + 1}
                  </Button>
                ))}

                <Button
                  variant="outline"
                  size="sm"
                  onClick={() => setCurrentPage(prev => Math.min(prev + 1, totalPages))}
                  disabled={currentPage === totalPages}
                >
                  <ChevronRight className="w-4 h-4" />
                </Button>
              </div>
            </div>
          )}
        </div>
      </div>

      {/* Job Details Modal */}
      <Dialog open={jobDetailsOpen} onOpenChange={setJobDetailsOpen}>
        <DialogContent className="max-w-4xl max-h-[80vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle>Job Details</DialogTitle>
            <DialogDescription>
              Details fetched from external API
            </DialogDescription>
          </DialogHeader>

          {jobDetailsLoading ? (
            <div className="flex items-center justify-center py-8">
              <Loader2 className="w-8 h-8 animate-spin" />
            </div>
          ) : selectedJobData ? (
            <div className="space-y-4">
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <h3 className="font-semibold mb-2">Job Information</h3>
                  <div className="space-y-2 text-sm">
                    <div><span className="font-medium">Title:</span> {selectedJobData.job_title || 'N/A'}</div>
                    <div><span className="font-medium">Company:</span> {selectedJobData.entity || 'N/A'}</div>
                    <div><span className="font-medium">Location:</span> {selectedJobData.vacancy_city || 'N/A'}</div>
                    <div><span className="font-medium">Salary:</span> {selectedJobData.salary || 'N/A'}</div>
                  </div>
                </div>
                <div>
                  <h3 className="font-semibold mb-2">Requirements</h3>
                  <div className="space-y-2 text-sm">
                    <div><span className="font-medium">Experience:</span> {selectedJobData.experience || 'N/A'}</div>
                    <div><span className="font-medium">Nationality:</span> {selectedJobData.nationality || 'N/A'}</div>
                    <div><span className="font-medium">Gender:</span> {selectedJobData.gender || 'N/A'}</div>
                    <div><span className="font-medium">Languages:</span> {selectedJobData.languages || 'N/A'}</div>
                  </div>
                </div>
              </div>

              {selectedJobData.job_description && (
                <div>
                  <h3 className="font-semibold mb-2">Job Description</h3>
                  <div className="text-sm text-gray-700 whitespace-pre-wrap">
                    {selectedJobData.job_description}
                  </div>
                </div>
              )}

              {selectedJobData.link && (
                <div>
                  <h3 className="font-semibold mb-2">External Link</h3>
                  <a
                    href={selectedJobData.link}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-blue-600 hover:underline flex items-center gap-1"
                  >
                    <ExternalLink className="w-4 h-4" />
                    View Original Job Posting
                  </a>
                </div>
              )}
            </div>
          ) : (
            <div className="text-center py-8 text-gray-500">
              No job details available
            </div>
          )}
        </DialogContent>
      </Dialog>
    </div>
  )
}

"use client"

import { useState, useEffect } from "react"
import { ChevronLeft, ChevronRight, Search, Eye } from "lucide-react"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { Input } from "@/components/ui/input"
import { Button } from "@/components/ui/button"
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog"
import { auth } from "@/app/utils/auth";
import { redirect } from "next/navigation";
import { getPayments, getSubscriptionById } from "./actions";

export default function PaymentsPage() {
  const [currentPage, setCurrentPage] = useState(1)
  const [itemsPerPage, setItemsPerPage] = useState(10)
  const [payments, setPayments] = useState<any[]>([])
  const [totalPayments, setTotalPayments] = useState(0)
  const [totalPages, setTotalPages] = useState(0)
  const [loading, setLoading] = useState(true)
  const [searchTerm, setSearchTerm] = useState("")
  const [selectedSubscription, setSelectedSubscription] = useState<any>(null)
  const [subscriptionDialogOpen, setSubscriptionDialogOpen] = useState(false)
  const [searching, setSearching] = useState(false)

  useEffect(() => {
    const fetchPayments = async () => {
      try {
        const result = await getPayments(currentPage, itemsPerPage, searchTerm)
        setPayments(result.payments)
        setTotalPayments(result.total)
        setTotalPages(result.totalPages)
      } catch (error) {
        console.error('Error fetching payments:', error)
      } finally {
        setLoading(false)
        setSearching(false)
      }
    }

    fetchPayments()
  }, [currentPage, itemsPerPage, searchTerm])

  const handleSearch = () => {
    setCurrentPage(1) // Reset to first page when searching
    setSearching(true)
  }

  const handleSubscriptionView = async (subscriptionId: string) => {
    try {
      const result = await getSubscriptionById(subscriptionId)
      if (result.subscription) {
        setSelectedSubscription(result.subscription)
        setSubscriptionDialogOpen(true)
      }
    } catch (error) {
      console.error('Error fetching subscription details:', error)
    }
  }

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    })
  }

  if (loading) {
    return <div className="p-6">Loading...</div>
  }

  return (
    <div className="p-6 text-gray-900">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold">Payments Management</h1>
      </div>

      {/* Search Section */}
      <div className="bg-white rounded-lg shadow-sm p-6 mb-6">
        <div className="flex gap-4 items-end">
          <div className="flex-1">
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Search by Subscription ID, User Name, or Email
            </label>
            <div className="relative">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 h-4 w-4" />
              <Input
                type="text"
                placeholder="Enter subscription ID, name, or email..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                className="pl-10"
                onKeyPress={(e) => e.key === 'Enter' && handleSearch()}
              />
            </div>
          </div>
          <Button onClick={handleSearch} className={`bg-blue-950 hover:bg-blue-900 ${searching ? 'opacity-50 cursor-not-allowed' : ''}`} disabled={loading}>
            Search
          </Button>
        </div>
      </div>

      <div className="bg-white rounded-lg shadow-sm p-6">
        <table className="w-full">
          <thead>
            <tr className="border-b border-gray-200">
              <th className="text-left py-3 px-4 font-semibold text-gray-700">User</th>
              <th className="text-left py-3 px-4 font-semibold text-gray-700">Amount</th>
              <th className="text-left py-3 px-4 font-semibold text-gray-700">Status</th>
              <th className="text-left py-3 px-4 font-semibold text-gray-700">Payment Method</th>
              <th className="text-left py-3 px-4 font-semibold text-gray-700">Payment Date</th>
              <th className="text-left py-3 px-4 font-semibold text-gray-700">Subscription</th>
              <th className="text-left py-3 px-4 font-semibold text-gray-700">Actions</th>
            </tr>
          </thead>
          <tbody>
            {payments.map((payment) => (
              <tr key={payment.id} className="border-b border-gray-100 hover:bg-gray-50">
                <td className="py-3 px-4">{payment.user.name} ({payment.user.email})</td>
                <td className="py-3 px-4">{(payment.amount / 100).toFixed(2)} {payment.currency}</td>
                <td className="py-3 px-4">
                  <span className={`px-2 py-1 rounded-full text-sm ${payment.status === 'COMPLETED' ? 'bg-green-100 text-green-800' :
                    payment.status === 'PENDING' ? 'bg-yellow-100 text-yellow-800' :
                      'bg-red-100 text-red-800'
                    }`}>
                    {payment.status}
                  </span>
                </td>
                <td className="py-3 px-4">{payment.paymentMethod}</td>
                <td className="py-3 px-4">{payment.createdAt ? payment.createdAt.toLocaleDateString() : "N/A"}</td>
                <td className="py-3 px-4">
                  {payment.subscription ? (
                    <div className="text-sm">
                      <div className="font-mono text-xs text-gray-600">{payment.subscription.id}</div>
                      <div className="text-xs text-gray-500 capitalize">{payment.subscription.plan.toLowerCase().replace('_', ' ')}</div>
                    </div>
                  ) : (
                    <span className="text-gray-400 text-sm">No subscription</span>
                  )}
                </td>
                <td className="py-3 px-4">
                  {payment.subscription && (
                    <Button
                      variant="outline"
                      size="sm"
                      onClick={() => handleSubscriptionView(payment.subscription.id)}
                      className="h-8 px-2"
                    >
                      <Eye className="h-3 w-3 mr-1" />
                      View
                    </Button>
                  )}
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
            <span>of {totalPayments}</span>
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

      {/* Subscription Details Dialog */}
      <Dialog open={subscriptionDialogOpen} onOpenChange={setSubscriptionDialogOpen}>
        <DialogContent className="max-w-2xl">
          <DialogHeader>
            <DialogTitle>Subscription Details</DialogTitle>
          </DialogHeader>
          {selectedSubscription && (
            <div className="space-y-4">
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="text-sm font-medium text-gray-700">Subscription ID</label>
                  <p className="text-sm text-gray-900 font-mono">{selectedSubscription.id}</p>
                </div>
                <div>
                  <label className="text-sm font-medium text-gray-700">Plan</label>
                  <p className="text-sm text-gray-900 capitalize">{selectedSubscription.plan.toLowerCase().replace('_', ' ')}</p>
                </div>
                <div>
                  <label className="text-sm font-medium text-gray-700">Status</label>
                  <span className={`px-2 py-1 rounded-full text-xs ${selectedSubscription.status === 'ACTIVE' ? 'bg-green-100 text-green-800' :
                    selectedSubscription.status === 'CANCELLED' ? 'bg-red-100 text-red-800' :
                      selectedSubscription.status === 'EXPIRED' ? 'bg-gray-100 text-gray-800' :
                        'bg-yellow-100 text-yellow-800'
                    }`}>
                    {selectedSubscription.status}
                  </span>
                </div>
                <div>
                  <label className="text-sm font-medium text-gray-700">User</label>
                  <p className="text-sm text-gray-900">{selectedSubscription.user.name} ({selectedSubscription.user.email})</p>
                </div>
                <div>
                  <label className="text-sm font-medium text-gray-700">Start Date</label>
                  <p className="text-sm text-gray-900">{formatDate(selectedSubscription.startDate)}</p>
                </div>
                <div>
                  <label className="text-sm font-medium text-gray-700">End Date</label>
                  <p className="text-sm text-gray-900">{formatDate(selectedSubscription.endDate)}</p>
                </div>
              </div>

              {selectedSubscription.payments && selectedSubscription.payments.length > 0 && (
                <div>
                  <label className="text-sm font-medium text-gray-700">Payment History</label>
                  <div className="mt-2 space-y-2">
                    {selectedSubscription.payments.map((payment: any) => (
                      <div key={payment.id} className="flex justify-between items-center p-2 bg-gray-50 rounded">
                        <div>
                          <p className="text-sm font-medium">{(payment.amount / 100).toFixed(2)} {payment.currency}</p>
                          <p className="text-xs text-gray-500">{formatDate(payment.createdAt)}</p>
                        </div>
                        <span className={`px-2 py-1 rounded-full text-xs ${payment.status === 'COMPLETED' ? 'bg-green-100 text-green-800' :
                          payment.status === 'PENDING' ? 'bg-yellow-100 text-yellow-800' :
                            'bg-red-100 text-red-800'
                          }`}>
                          {payment.status}
                        </span>
                      </div>
                    ))}
                  </div>
                </div>
              )}
            </div>
          )}
        </DialogContent>
      </Dialog>
    </div>
  );
}

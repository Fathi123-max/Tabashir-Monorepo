"use client"

import { useState, useRef, useEffect } from "react"
import { ZoomIn, ZoomOut, ChevronRight, FileText, Info, CreditCard, Check } from "lucide-react"
import { Card } from "@/components/ui/card"
import { Progress } from "@/components/ui/progress"
import { Button } from "@/components/ui/button"
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover"
import { Switch } from "@/components/ui/switch"
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
} from "@/components/ui/dialog"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"

interface ResumePreviewProps {
  isOpen: boolean
  onClose: () => void
  resumeName: string
  resumeScore: number
  resumeData: ResumeData
}

// Define the resume data structure
export interface ResumeData {
  personalInfo: {
    fullName: string
    location: string
    phone: string
    email: string
    linkedin?: string
  }
  objective: string
  experience: Array<{
    title: string
    company?: string
    period?: string
    description: string
  }>
}

// A4 dimensions in pixels at 96 DPI
const A4_WIDTH_PX = 794 // 210mm at 96 DPI
const A4_HEIGHT_PX = 1123 // 297mm at 96 DPI

export function ResumePreview({ isOpen, onClose, resumeName, resumeScore, resumeData }: ResumePreviewProps) {
  const [currentPage, setCurrentPage] = useState(1)
  const [totalPages, setTotalPages] = useState(1) // Default to 1 page
  const [zoomLevel, setZoomLevel] = useState(0.8) // Start with a slightly zoomed out view
  const [editorMode, setEditorMode] = useState(true) // Start with editor mode ON
  const [activeTab, setActiveTab] = useState("personal")
  const [showPaymentModal, setShowPaymentModal] = useState(false)
  const [paymentProcessing, setPaymentProcessing] = useState(false)
  const [paymentSuccess, setPaymentSuccess] = useState(false)

  const resumeContainerRef = useRef<HTMLDivElement>(null)
  const pageRefs = useRef<(HTMLDivElement | null)[]>([])

  // Set up page refs
  useEffect(() => {
    pageRefs.current = pageRefs.current.slice(0, totalPages)
  }, [totalPages])

  if (!isOpen) return null

  const handleZoomIn = () => {
    setZoomLevel((prev) => Math.min(prev + 0.1, 1.5))
  }

  const handleZoomOut = () => {
    setZoomLevel((prev) => Math.max(prev - 0.1, 0.5))
  }

  const handleExport = (format: "pdf" | "docx") => {
    // In a real implementation, this would trigger the resume download in the specified format
    console.log(`Exporting resume as ${format}...`)
  }

  const handleEditorModeToggle = (checked: boolean) => {
    if (checked) {
      setEditorMode(true)
    } else {
      // Show payment modal when trying to turn off editor mode
      setShowPaymentModal(true)
    }
  }

  const handlePayment = async () => {
    setPaymentProcessing(true)
    try {
      // Get the CV transformer service link from payment data
      const { paymentData } = await import('@/lib/payment-data')
      const cvService = paymentData.cvTransformer

      if (cvService?.link) {
        // Add user email to the checkout link if available
        let checkoutLink = cvService.link
        // Note: You'll need to get user email from session here
        // For now, we'll use the link as is
        // const userEmail = session.data?.user?.email
        // if (userEmail) {
        //   const url = new URL(checkoutLink)
        //   url.searchParams.set('prefilled_email', userEmail)
        //   checkoutLink = url.toString()
        // }

        // Redirect directly to Stripe checkout link
        window.location.href = checkoutLink
      } else {
        throw new Error('No checkout link available for CV service')
      }
    } catch (error) {
      console.error('Payment error:', error)
      setPaymentProcessing(false)
      // You can add toast notification here
    }
  }

  return (
    <div className="w-full bg-[#F5F5F5] min-h-screen">
      <div className="max-w-6xl mx-auto px-4 py-6">
        {/* Header */}
        <div className="flex items-center mb-6">
          <h1 className="text-2xl font-bold text-black">TABASHIR</h1>
        </div>

        {/* Resume score card */}
        <Card className="mb-6 p-4 shadow-sm bg-white">
          <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center">
            <div>
              <h2 className="text-sm font-medium text-gray-700 mb-1">{resumeName}</h2>
              <div className="flex items-center gap-2">
                <div className="bg-green-500 text-white text-xs px-2 py-0.5 rounded">100%</div>
                <span className="text-sm font-medium text-gray-700">Resume Score</span>
              </div>
              <Progress value={100} className="h-2 w-40 mt-1 bg-gray-200" />
            </div>
            <Button variant="outline" size="sm" className="h-8 gap-1 text-gray-700">
              <Info size={16} />
              <span>Tips</span>
            </Button>
          </div>
        </Card>

        {/* Controls */}
        <div className="flex justify-end items-center mb-4">
          <div className="flex items-center gap-4">
            <div className="flex items-center gap-2">
              <span className="text-sm text-gray-700">Editor Mode</span>
              <Switch checked={editorMode} onCheckedChange={handleEditorModeToggle} />
            </div>
            <Button onClick={() => handleExport("docx")} className="bg-[#002B6B] hover:bg-[#042052] text-white gap-2">
              Export Resume
            </Button>
          </div>
        </div>

        {/* Resume Preview with editor sidebar */}
        <div className="flex overflow-hidden mx-auto max-w-5xl">
          {/* Editor Sidebar - Always visible when in editor mode */}
          {editorMode && (
            <div className="w-64 mr-6">
              <h3 className="text-sm font-medium text-gray-700 mb-3">Resume Sections</h3>
              <div className="space-y-2">
                <SidebarNavItem
                  title="Personal Details"
                  isActive={activeTab === "personal"}
                  onClick={() => setActiveTab("personal")}
                />
                <SidebarNavItem
                  title="Professional Summary"
                  isActive={activeTab === "summary"}
                  onClick={() => setActiveTab("summary")}
                />
                <SidebarNavItem
                  title="Employment History"
                  isActive={activeTab === "employment"}
                  onClick={() => setActiveTab("employment")}
                />
                <SidebarNavItem
                  title="Education"
                  isActive={activeTab === "education"}
                  onClick={() => setActiveTab("education")}
                />
                <SidebarNavItem
                  title="Skills"
                  isActive={activeTab === "skills"}
                  onClick={() => setActiveTab("skills")}
                />
                <SidebarNavItem
                  title="Languages"
                  isActive={activeTab === "languages"}
                  onClick={() => setActiveTab("languages")}
                />
              </div>
            </div>
          )}

          {/* Resume Preview */}
          <div className="flex-1 bg-gray-100 rounded-lg shadow-md p-8 max-h-[800px] overflow-x-auto overflow-y-auto relative">
            {/* Zoom controls */}
            <div className="absolute right-4 top-4 flex flex-col gap-2 z-10">
              <Button
                variant="outline"
                size="icon"
                onClick={handleZoomIn}
                disabled={zoomLevel >= 1.5}
                className="h-8 w-8 rounded-full bg-white"
              >
                <ZoomIn size={16} className="text-gray-700" />
              </Button>
              <Button
                variant="outline"
                size="icon"
                onClick={handleZoomOut}
                disabled={zoomLevel <= 0.5}
                className="h-8 w-8 rounded-full bg-white"
              >
                <ZoomOut size={16} className="text-gray-700" />
              </Button>
            </div>

            <div
              ref={resumeContainerRef}
              className="max-h-[calc(100vh-300px)] overflow-auto flex flex-col items-center"
              style={{
                transform: `scale(${zoomLevel})`,
                transformOrigin: "top center",
                minHeight: "500px",
                width: "100%",
                minWidth: `${A4_WIDTH_PX * zoomLevel}px`,
                margin: "0 auto",
              }}
            >
              {/* Resume Page */}
              <div
                ref={(el) => {
                  if (el) {
                    pageRefs.current[0] = el;
                  }
                }}
                className="bg-white shadow-md text-black"
                style={{
                  width: `${A4_WIDTH_PX}px`,
                  height: `${A4_HEIGHT_PX}px`,
                  padding: "48px",
                  position: "relative",
                }}
              >
                {/* Resume Content */}
                <ResumeContent data={resumeData} editorMode={editorMode} activeTab={activeTab} isBlurred={editorMode} />
              </div>
            </div>

            {/* Page navigation */}
            <div className="flex justify-center items-center mt-4">
              <Button
                variant="outline"
                size="icon"
                disabled={currentPage <= 1}
                className="h-8 w-8 rounded-full bg-white"
              >
                <ChevronRight className="rotate-180 h-4 w-4 text-gray-700" />
              </Button>
              <span className="mx-2 text-sm text-gray-700">
                {currentPage}/{totalPages}
              </span>
              <Button
                variant="outline"
                size="icon"
                disabled={currentPage >= totalPages}
                className="h-8 w-8 rounded-full bg-white"
              >
                <ChevronRight className="h-4 w-4 text-gray-700" />
              </Button>
            </div>
          </div>
        </div>
      </div>

      {/* Payment Modal */}
      <Dialog open={showPaymentModal} onOpenChange={setShowPaymentModal}>
        <DialogContent className="sm:max-w-[425px]">
          <DialogHeader>
            <DialogTitle className="text-gray-900">Unlock Full Resume View</DialogTitle>
            <DialogDescription className="text-gray-600">
              To view and download your resume without blur, please complete the payment.
            </DialogDescription>
          </DialogHeader>

          {paymentSuccess ? (
            <div className="flex flex-col items-center justify-center py-6">
              <div className="w-12 h-12 rounded-full bg-green-100 flex items-center justify-center mb-4">
                <Check className="h-6 w-6 text-green-600" />
              </div>
              <h3 className="text-lg font-medium text-gray-900 mb-1">Payment Successful!</h3>
              <p className="text-gray-600 text-center">Your resume is now unlocked.</p>
            </div>
          ) : (
            <>
              <div className="grid gap-4 py-4">
                <div className="flex items-center justify-between">
                  <span className="font-medium text-gray-700">Resume Unlock Fee:</span>
                  <span className="font-bold text-gray-900">40 AED</span>
                </div>

                <div className="space-y-2">
                  <Label htmlFor="cardNumber" className="text-gray-700">
                    Card Number
                  </Label>
                  <Input id="cardNumber" placeholder="1234 5678 9012 3456" className="text-gray-900" />
                </div>

                <div className="grid grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label htmlFor="expiry" className="text-gray-700">
                      Expiry Date
                    </Label>
                    <Input id="expiry" placeholder="MM/YY" className="text-gray-900" />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="cvc" className="text-gray-700">
                      CVC
                    </Label>
                    <Input id="cvc" placeholder="123" className="text-gray-900" />
                  </div>
                </div>

                <div className="space-y-2">
                  <Label htmlFor="name" className="text-gray-700">
                    Cardholder Name
                  </Label>
                  <Input id="name" placeholder="John Doe" className="text-gray-900" />
                </div>
              </div>

              <DialogFooter>
                <Button variant="outline" onClick={() => setShowPaymentModal(false)} className="text-gray-700">
                  Cancel
                </Button>
                <Button
                  onClick={handlePayment}
                  className="bg-[#002B6B] hover:bg-[#042052] text-white"
                  disabled={paymentProcessing}
                >
                  {paymentProcessing ? (
                    <span className="flex items-center gap-2">
                      <svg
                        className="animate-spin -ml-1 mr-2 h-4 w-4 text-white"
                        xmlns="http://www.w3.org/2000/svg"
                        fill="none"
                        viewBox="0 0 24 24"
                      >
                        <circle
                          className="opacity-25"
                          cx="12"
                          cy="12"
                          r="10"
                          stroke="currentColor"
                          strokeWidth="4"
                        ></circle>
                        <path
                          className="opacity-75"
                          fill="currentColor"
                          d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
                        ></path>
                      </svg>
                      Processing...
                    </span>
                  ) : (
                    <span className="flex items-center gap-2">
                      <CreditCard className="h-4 w-4" />
                      Pay 40 AED
                    </span>
                  )}
                </Button>
              </DialogFooter>
            </>
          )}
        </DialogContent>
      </Dialog>
    </div>
  )
}

// Component for the resume content
function ResumeContent({
  data,
  editorMode,
  activeTab,
  isBlurred,
}: {
  data: ResumeData
  editorMode: boolean
  activeTab: string
  isBlurred: boolean
}) {
  // Add editable styling when in editor mode
  const editableClass = editorMode
    ? "hover:bg-blue-50 hover:outline hover:outline-1 hover:outline-blue-200 cursor-text"
    : ""

  // Add blur when in editor mode
  const blurClass = isBlurred ? "blur-[3px]" : ""

  return (
    <div className={`font-serif text-sm text-black ${blurClass}`}>
      {/* Header with name and contact info */}
      <div className="text-center mb-6">
        <h1 className={`text-3xl font-bold mb-4 ${editableClass}`}>{data.personalInfo.fullName}</h1>
        <div className="flex justify-center items-center gap-3 text-sm flex-wrap">
          <span>{data.personalInfo.location}</span>
          <span className="inline-block w-1 h-1 bg-black rounded-full"></span>
          <span>{data.personalInfo.email}</span>
          <span className="inline-block w-1 h-1 bg-black rounded-full"></span>
          <span>{data.personalInfo.phone}</span>
          {data.personalInfo.linkedin && (
            <>
              <span className="inline-block w-1 h-1 bg-black rounded-full"></span>
              <span>{data.personalInfo.linkedin}</span>
            </>
          )}
        </div>
      </div>

      {/* Career Objective */}
      <div className="mb-6">
        <h2 className="text-lg font-bold border-b border-gray-400 pb-1 mb-2">Career objective</h2>
        <p className={`text-sm ${editableClass}`}>{data.objective}</p>
      </div>

      {/* Professional Experience */}
      <div>
        <h2 className="text-lg font-bold border-b border-gray-400 pb-1 mb-4">Professional Experience</h2>
        {data.experience.map((exp, index) => (
          <div key={index} className="mb-4">
            <h3 className={`font-bold ${editableClass}`}>{exp.title}</h3>
            {exp.company && exp.period && (
              <p className={`text-sm mb-1 ${editableClass}`}>
                {exp.company} • {exp.period}
              </p>
            )}
            <p className={`text-sm ${editableClass}`}>{exp.description}</p>
          </div>
        ))}
      </div>
    </div>
  )
}

// Sidebar navigation item component
function SidebarNavItem({
  title,
  isActive,
  onClick,
}: {
  title: string
  isActive: boolean
  onClick: () => void
}) {
  return (
    <div
      className={`p-3 rounded-md cursor-pointer transition-colors ${isActive
        ? "bg-gradient-to-r from-[#042052] to-[#0D57E1] text-white"
        : "bg-white text-gray-700 hover:bg-gray-50 border border-gray-200 shadow-sm"
        }`}
      onClick={onClick}
    >
      <h3 className="font-medium text-sm">{title}</h3>
    </div>
  )
}

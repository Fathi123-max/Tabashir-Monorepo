"use client"

import { useState, useRef, useEffect } from "react"
import { ZoomIn, ZoomOut, ChevronLeft, ChevronRight, Download } from "lucide-react"
import { Button } from "@/components/ui/button"
import { getCV, getResumePaymentStatus as getResumePaymentStatusAction } from "@/actions/ai-resume"
import { renderAsync } from "docx-preview"
import ResumePayment from "../_components/resume-payment"
import { Loader2 } from "lucide-react"
import { useSearchParams } from "next/navigation"

// A4 dimensions in pixels at 96 DPI
const A4_WIDTH_PX = 850 // 210mm at 96 DPI

interface EnhancedResumeDisplayProps {
  resumeId: string
}

export default function EnhancedResumeDisplay({ resumeId }: EnhancedResumeDisplayProps) {
  const [isLoading, setIsLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [cvData, setCvData] = useState<any>(null)
  const [currentPage, setCurrentPage] = useState(1)
  const [totalPages] = useState(1)
  const [zoomLevel, setZoomLevel] = useState(1)
  const [isPaymentOpened, setIsPaymentOpened] = useState(false)
  const [isCheckingPayment, setIsCheckingPayment] = useState(false)
  const [isPaid, setIsPaid] = useState(false)
  const resumeContainerRef = useRef<HTMLDivElement>(null)
  const docxContainerRef = useRef<HTMLDivElement>(null)
  const searchParams = useSearchParams()

  // Effect to fetch CV data
  useEffect(() => {
    const fetchCV = async () => {
      try {
        setIsLoading(true)
        const result = await getCV(resumeId)
        if (result.error) {
          setError(result.message)
          return
        }
        if (!result.data) {
          setError("No data received from the server")
          return
        }
        console.log('CV Data received:', result.data)
        setCvData(result.data)
      } catch (error) {
        console.error('Error fetching CV:', error)
        setError(error instanceof Error ? error.message : "Failed to fetch CV data")
      } finally {
        setIsLoading(false)
      }
    }

    fetchCV()
  }, [resumeId])

  // Load and render DOCX file
  useEffect(() => {
    const loadDocx = async () => {
      if (!cvData?.resume?.formatedUrl || !docxContainerRef.current) return;

      try {
        const response = await fetch(cvData.resume.formatedUrl);
        if (!response.ok) {
          throw new Error(`Failed to fetch DOCX: ${response.status} ${response.statusText}`)
        }

        const blob = await response.blob();
        if (blob.size === 0) {
          throw new Error('Received empty DOCX file')
        }

        // Clear previous content
        if (docxContainerRef.current) {
          docxContainerRef.current.innerHTML = '';
        }

        // Render the DOCX file
        await renderAsync(blob, docxContainerRef.current);

        // Remove unwanted borders after rendering
        setTimeout(() => {
          if (docxContainerRef.current) {
            const container = docxContainerRef.current;

            // Remove borders from all paragraphs and divs
            const paragraphs = container.querySelectorAll('p');
            paragraphs.forEach(p => {
              p.style.border = 'none';
              p.style.borderBottom = 'none';
              p.style.borderTop = 'none';
            });

            const divs = container.querySelectorAll('div');
            divs.forEach(div => {
              div.style.border = 'none';
              div.style.borderBottom = 'none';
              div.style.borderTop = 'none';
            });

            // Preserve legitimate HR elements
            const hrs = container.querySelectorAll('hr');
            hrs.forEach(hr => {
              hr.style.borderTop = '1px solid #000';
              hr.style.borderBottom = 'none';
              hr.style.borderLeft = 'none';
              hr.style.borderRight = 'none';
            });
          }
        }, 100);

      } catch (error) {
        console.error('Error loading DOCX:', error);
        setError(error instanceof Error ? error.message : 'Failed to render DOCX')
      }
    };

    loadDocx();
  }, [cvData]);

  const handleZoomIn = () => {
    setZoomLevel((prev) => Math.min(prev + 0.1, 1.5))
  }

  const handleZoomOut = () => {
    setZoomLevel((prev) => Math.max(prev - 0.1, 0.5))
  }

  const handlePrevPage = () => {
    setCurrentPage((prev) => Math.max(prev - 1, 1))
  }

  const handleNextPage = () => {
    setCurrentPage((prev) => Math.min(prev + 1, totalPages))
  }

  const handleDownload = async () => {
    if (!isPaid) {
      setIsPaymentOpened(true);
      return;
    }

    if (!cvData?.resume?.formatedUrl) {
      setError("No resume URL found");
      return;
    }

    try {
      const response = await fetch(cvData.resume.formatedUrl);
      if (!response.ok) {
        throw new Error(`Failed to fetch DOCX: ${response.status} ${response.statusText}`);
      }

      const blob = await response.blob();
      const url = window.URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = `resume_${resumeId}.docx`;
      document.body.appendChild(a);
      a.click();
      window.URL.revokeObjectURL(url);
      document.body.removeChild(a);
    } catch (error) {
      console.error('Error downloading resume:', error);
      setError(error instanceof Error ? error.message : 'Failed to download resume');
    }
  }

  // Effect to check payment status when returning from payment
  useEffect(() => {
    const paymentCompleted = searchParams.get('payment_completed')
    if (paymentCompleted === 'true') {
      setIsCheckingPayment(true)
      // Wait for 3 seconds to ensure webhook has processed
      setTimeout(async () => {
        try {
          const result = await getResumePaymentStatusAction(resumeId)
          if (result.data?.paymentStatus) {
            setIsPaid(true)
            setIsPaymentOpened(false)
          }
        } catch (error) {
          console.error('Error checking payment status:', error)
        } finally {
          setIsCheckingPayment(false)
        }
      }, 3000)
    }
  }, [searchParams, resumeId])

  // Effect to check initial payment status
  useEffect(() => {
    const checkPaymentStatus = async () => {
      setIsCheckingPayment(true)
      try {
        const result = await getResumePaymentStatusAction(resumeId)
        if (result.data?.paymentStatus) {
          setIsPaid(true)
          setIsPaymentOpened(false)
        }
      } catch (error) {
        console.error('Error checking payment status:', error)
      } finally {
        setIsCheckingPayment(false)
      }
    }

    checkPaymentStatus()
  }, [resumeId])

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="text-center">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-gray-900 mx-auto mb-4" />
          <p className="text-gray-600">Loading your enhanced resume...</p>
        </div>
      </div>
    )
  }

  if (error) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="text-center">
          <h1 className="text-2xl font-bold text-gray-900 mb-4">Error Loading Resume</h1>
          <p className="text-gray-600">{error}</p>
        </div>
      </div>
    )
  }

  if (!cvData) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="text-center">
          <h1 className="text-2xl font-bold text-gray-900 mb-4">No Resume Data Found</h1>
          <p className="text-gray-600">The requested resume could not be found.</p>
        </div>
      </div>
    )
  }

  return (
    <div className="w-full max-w-[calc(100vw-50px)] overflow-hidden min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-white border-b border-gray-200 px-6 py-4">
        <div className="max-w-7xl mx-auto flex items-center justify-between">
          <h1 className="text-xl font-semibold text-gray-900 max-md:ml-6 max-md:text-lg">Enhanced Resume</h1>
          <Button
            onClick={handleDownload}
            className="bg-gradient-to-r from-[#042052] to-[#0D57E1] hover:opacity-90 text-white max-md:py-2 max-md:px-4 max-md:text-sm"
          >
            <Download className="mr-2 h-4 w-4" />
            Download Resume
          </Button>
        </div>
      </div>

      {/* Resume Display */}
      <div className="max-w-6xl mx-auto px-4 py-6">
        <div className="w-full">
          <div className="overflow-hidden relative bg-white rounded-lg shadow-sm border border-gray-200">
            {/* Zoom controls */}
            <div className="absolute right-8 top-4 flex gap-2 z-10">
              <Button
                variant="outline"
                size="icon"
                onClick={handleZoomOut}
                className="h-8 w-8 rounded-full bg-white border-gray-200"
              >
                <ZoomOut size={16} className="text-gray-700" />
              </Button>
              <Button
                variant="outline"
                size="icon"
                onClick={handleZoomIn}
                className="h-8 w-8 rounded-full bg-white border-gray-200"
              >
                <ZoomIn size={16} className="text-gray-700" />
              </Button>
            </div>

            {/* Page navigation */}
            <div className="absolute left-4 top-4 flex items-center gap-2 z-10">
              <Button
                variant="outline"
                size="icon"
                onClick={handlePrevPage}
                disabled={currentPage <= 1}
                className="h-8 w-8 rounded-full bg-white border-gray-200"
              >
                <ChevronLeft size={16} className="text-gray-700" />
              </Button>
              <span className="text-sm text-gray-600 bg-white px-2 py-1 rounded border border-gray-200">
                {currentPage} / {totalPages}
              </span>
              <Button
                variant="outline"
                size="icon"
                onClick={handleNextPage}
                disabled={currentPage >= totalPages}
                className="h-8 w-8 rounded-full bg-white border-gray-200"
              >
                <ChevronRight size={16} className="text-gray-700" />
              </Button>
            </div>

            {/* Resume content */}
            <div className="p-3">
              <div
                ref={resumeContainerRef}
                className="max-h-[calc(100vh-150px)] overflow-auto"
                style={{
                  paddingTop: "3rem",
                  paddingBottom: "2rem",
                }}
              >
                {/* DOCX Content */}
                <div
                  ref={docxContainerRef}
                  className="docx-container mx-auto overflow-x-auto relative"
                  style={{
                    width: "100%",
                    maxWidth: `${A4_WIDTH_PX}px`,
                    minHeight: "100px",
                    height: "100%",
                    border: "1px solid #eee",
                    backgroundColor: "#fff",
                    transform: `scale(${zoomLevel})`,
                    transformOrigin: "top center",
                    filter: !isPaid ? "blur(8px)" : "none",
                    userSelect: !isPaid ? "none" : "auto",
                    pointerEvents: !isPaid ? "none" : "auto",
                  }}
                />

                {/* Overlay for unpaid users */}
                {!isPaid && (
                  <div
                    className="absolute inset-0 flex items-center justify-center bg-black/20 z-10"
                    style={{
                      top: "3rem",
                      bottom: "2rem",
                      left: "50%",
                      transform: "translateX(-50%)",
                      width: `${A4_WIDTH_PX}px`,
                      maxWidth: "100%",
                    }}
                  >
                    <div className="bg-white/90 backdrop-blur-sm rounded-lg p-6 text-center shadow-lg">
                      <h3 className="text-lg font-semibold text-gray-900 mb-2">
                        Payment Required
                      </h3>
                      <p className="text-gray-600 mb-4">
                        Please complete payment to view and download your enhanced resume
                      </p>
                      <Button
                        onClick={() => setIsPaymentOpened(true)}
                        className="bg-gradient-to-r from-[#042052] to-[#0D57E1] hover:opacity-90 text-white"
                      >
                        Pay Now
                      </Button>
                    </div>
                  </div>
                )}

                {/* Global styles to prevent unwanted borders */}
                <style dangerouslySetInnerHTML={{
                  __html: `
                    .docx-container p {
                      border: none !important;
                      border-bottom: none !important;
                      border-top: none !important;
                    }
                    
                    .docx-container div {
                      border: none !important;
                      border-bottom: none !important;
                      border-top: none !important;
                    }
                    
                    .docx-container .docx-wrapper {
                      border: none !important;
                    }
                    
                    .docx-container .docx-wrapper > div {
                      border: none !important;
                    }
                    
                    /* Preserve legitimate HR/divider elements */
                    .docx-container hr {
                      border-top: 1px solid #000 !important;
                      border-bottom: none !important;
                      border-left: none !important;
                      border-right: none !important;
                    }
                    
                    /* Preserve table borders if they exist */
                    .docx-container table {
                      border-collapse: collapse !important;
                    }
                    
                    .docx-container td,
                    .docx-container th {
                      border: 1px solid #000 !important;
                    }
                    
                    /* Prevent copying and selection when not paid */
                    ${!isPaid ? `
                      .docx-container * {
                        -webkit-user-select: none !important;
                        -moz-user-select: none !important;
                        -ms-user-select: none !important;
                        user-select: none !important;
                        -webkit-touch-callout: none !important;
                        -webkit-tap-highlight-color: transparent !important;
                      }
                      
                      .docx-container {
                        -webkit-user-select: none !important;
                        -moz-user-select: none !important;
                        -ms-user-select: none !important;
                        user-select: none !important;
                        pointer-events: none !important;
                      }
                    ` : ''}
                  `
                }} />


              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Payment Modal */}
      <ResumePayment
        resumeId={resumeId}
        isOpened={isPaymentOpened}
        successUrl={`${window.location.origin}/resume/enhanced?id=${resumeId}&payment_completed=true`}
      />

      {/* Payment Status Check Overlay */}
      {isCheckingPayment && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
          <div className="bg-white p-6 rounded-lg shadow-lg flex items-center gap-3">
            <Loader2 className="w-6 h-6 animate-spin" />
            <p className="text-gray-700">Checking payment status...</p>
          </div>
        </div>
      )}
    </div>
  )
} 
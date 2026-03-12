"use client"

import { useState, useRef, useEffect } from "react"
import { ZoomIn, ZoomOut, ChevronLeft, ChevronRight, Download, CreditCard, Check } from "lucide-react"
import { Button } from "@/components/ui/button"
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
import { useResumeStore } from "../../store/resume-store"
import { renderAsync } from "docx-preview"
import { useTranslation } from "@/lib/use-translation"

// A4 dimensions in pixels at 96 DPI
const A4_WIDTH_PX = 794 // 210mm at 96 DPI
const A4_HEIGHT_PX = 1123 // 297mm at 96 DPI

export default function ResumeDownload({ resumeUrl }: { resumeUrl: string }) {
  const [currentPage, setCurrentPage] = useState(1)
  const [totalPages] = useState(1)
  const [zoomLevel, setZoomLevel] = useState(1)
  const [showPaymentModal, setShowPaymentModal] = useState(false)
  const [paymentProcessing, setPaymentProcessing] = useState(false)
  const [paymentSuccess, setPaymentSuccess] = useState(false)
  const [isPaid, setIsPaid] = useState(false)
  const resumeContainerRef = useRef<HTMLDivElement>(null)
  const docxContainerRef = useRef<HTMLDivElement>(null)

  const { setPaymentCompleted, isPaymentCompleted, setSidebarVisibility, getResumeScore, editorMode, setEditorMode } = useResumeStore()
  const { t, isRTL } = useTranslation()

  // Initialize isPaid from store
  useEffect(() => {
    setIsPaid(isPaymentCompleted)
    setEditorMode(!isPaymentCompleted)
  }, [isPaymentCompleted, setEditorMode])

  // Control sidebar visibility based on editor mode
  useEffect(() => {
    setSidebarVisibility(editorMode)

    // Cleanup function to restore sidebar when leaving the page
    return () => {
      setSidebarVisibility(true)
    }
  }, [editorMode, setSidebarVisibility])

  // Load and render DOCX file
  useEffect(() => {
    const loadDocx = async () => {
      if (!resumeUrl || !docxContainerRef.current) return;

      try {
        const response = await fetch(resumeUrl);
        const blob = await response.blob();

        // Clear previous content
        if (docxContainerRef.current) {
          docxContainerRef.current.innerHTML = '';
        }

        // Render the DOCX file
        await renderAsync(blob, docxContainerRef.current, undefined, {
          className: 'docx-wrapper',
          inWrapper: true,
          ignoreWidth: false,
          ignoreHeight: false,
          ignoreFonts: false,
          breakPages: true,
          useBase64URL: true,
          renderEndnotes: true,
          renderFootnotes: true,
          renderFooters: true,
          renderHeaders: true,
        });

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
      }
    };

    loadDocx();
  }, [resumeUrl]);

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

  const handleEditorModeToggle = (checked: boolean) => {
    if (!checked && !isPaid) {
      // Show payment modal when trying to turn off editor mode
      setShowPaymentModal(true)
    } else {
      setEditorMode(checked)
    }
  }

  const handleExport = (format: "pdf" | "docx") => {
    // In a real implementation, this would trigger the resume download
    console.log(`Exporting resume as ${format}...`);

    // Downloading the resume using the resumeUrl
    const a = document.createElement('a');
    a.href = resumeUrl;
    a.download = `resume.docx`;
    a.click();
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
    <div className="w-full min-h-screen">
      <div className="flex justify-end items-center mb-6 gap-4">
        <div className={`flex items-center gap-2 ${isRTL ? 'flex-row-reverse' : ''}`}>
          <span className="text-sm text-gray-700">{t('editorMode')}</span>
          <Switch checked={editorMode} onCheckedChange={handleEditorModeToggle} />
        </div>

        <Button onClick={() => handleExport("docx")} className="bg-[#002B6B] hover:bg-[#042052] text-gray-50 gap-2">
          {t('exportAs')}
        </Button>
      </div>
      <div className="max-w-6xl mx-auto px-4 py-6 rounded-[6px]">
        {/* Header with Controls */}

        {/* Resume Preview */}
        <div className="w-full">
          {/* Resume Preview */}
          <div className={` overflow-hidden relative`}>
            {/* Zoom controls */}
            <div className="absolute right-4 top-4 flex gap-2 z-10">
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

            <div
              ref={resumeContainerRef}
              className="max-h-[calc(100vh-150px)] overflow-auto"
              style={{
                transform: `scale(${zoomLevel})`,
                transformOrigin: "top center",
                padding: "2rem",
              }}
            >
              {/* DOCX Content */}
              <div
                ref={docxContainerRef}
                className={`max-w-[${A4_WIDTH_PX}px] docx-wrapper mx-auto`}
                style={{
                  width: `${A4_WIDTH_PX}px`,
                  margin: "0 auto",
                }}
              />
            </div>

            {/* Pagination */}
            <div className="flex justify-center items-center gap-4 py-4 bg-white border-t border-gray-200">
              <Button
                variant="outline"
                size="icon"
                onClick={handlePrevPage}
                disabled={currentPage === 1}
                className="h-8 w-8 rounded-full"
              >
                <ChevronLeft size={16} className="text-gray-700" />
              </Button>

              <div className="text-sm text-gray-700">
                {currentPage}/{totalPages}
              </div>

              <Button
                variant="outline"
                size="icon"
                onClick={handleNextPage}
                disabled={currentPage === totalPages}
                className="h-8 w-8 rounded-full"
              >
                <ChevronRight size={16} className="text-gray-700" />
              </Button>
            </div>
          </div>
        </div>

        {/* Download Button */}
      </div>

      {/* Payment Modal */}
      <Dialog open={showPaymentModal} onOpenChange={setShowPaymentModal}>
        <DialogContent className="sm:max-w-[425px]">
          <DialogHeader className={isRTL ? 'text-right' : ''}>
            <DialogTitle className="text-gray-900">{t('unlockFullResumeView')}</DialogTitle>
            <DialogDescription className="text-gray-600">
              {t('completePaymentToUnlock')}
            </DialogDescription>
          </DialogHeader>

          {paymentSuccess ? (
            <div className="flex flex-col items-center justify-center py-6">
              <div className="w-12 h-12 rounded-full bg-green-100 flex items-center justify-center mb-4">
                <Check className="h-6 w-6 text-green-600" />
              </div>
              <h3 className="text-lg font-medium text-gray-900 mb-1">{t('paymentSuccessful')}</h3>
              <p className="text-gray-600 text-center">{t('resumeNowUnlocked')}</p>
            </div>
          ) : (
            <>
              <div className="grid gap-4 py-4">
                <div className={`flex items-center justify-between ${isRTL ? 'flex-row-reverse' : ''}`}>
                  <span className="font-medium text-gray-700">{t('resumeUnlockFee')}:</span>
                  <span className="font-bold text-gray-900">40 {t('aed')}</span>
                </div>

                <div className="space-y-2">
                  <Label htmlFor="cardNumber" className={`text-gray-700 ${isRTL ? 'text-right' : ''}`}>
                    {t('cardNumber')}
                  </Label>
                  <Input id="cardNumber" placeholder="1234 5678 9012 3456" className={`text-gray-900 ${isRTL ? 'text-right' : ''}`} />
                </div>

                <div className="grid grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label htmlFor="expiry" className={`text-gray-700 ${isRTL ? 'text-right' : ''}`}>
                      {t('expiryDate')}
                    </Label>
                    <Input id="expiry" placeholder="MM/YY" className={`text-gray-900 ${isRTL ? 'text-right' : ''}`} />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="cvc" className={`text-gray-700 ${isRTL ? 'text-right' : ''}`}>
                      CVC
                    </Label>
                    <Input id="cvc" placeholder="123" className={`text-gray-900 ${isRTL ? 'text-right' : ''}`} />
                  </div>
                </div>

                <div className="space-y-2">
                  <Label htmlFor="name" className={`text-gray-700 ${isRTL ? 'text-right' : ''}`}>
                    {t('cardholderName')}
                  </Label>
                  <Input id="name" placeholder="John Doe" className={`text-gray-900 ${isRTL ? 'text-right' : ''}`} />
                </div>
              </div>

              <DialogFooter className={isRTL ? 'flex-row-reverse' : ''}>
                <Button variant="outline" onClick={() => setShowPaymentModal(false)} className="text-gray-700">
                  {t('cancel')}
                </Button>
                <Button
                  onClick={handlePayment}
                  className="bg-[#002B6B] hover:bg-[#042052] text-gray-50"
                  disabled={paymentProcessing}
                >
                  {paymentProcessing ? (
                    <span className={`flex items-center gap-2 ${isRTL ? 'flex-row-reverse' : ''}`}>
                      <svg
                        className={`animate-spin h-4 w-4 text-gray-50 ${isRTL ? '-mr-1 ml-2' : '-ml-1 mr-2'}`}
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
                      {t('processing')}
                    </span>
                  ) : (
                    <span className={`flex items-center gap-2 ${isRTL ? 'flex-row-reverse' : ''}`}>
                      <CreditCard className="h-4 w-4" />
                      {t('pay')} 40 {t('aed')}
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

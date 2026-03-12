"use client"

import { useState, useEffect } from "react"
import { Check, CoinsIcon as Coin } from "lucide-react"
import { TermsModal } from "./_components/terms-modal"
import { ServiceModal } from "./_components/service-modal"
import { PaymentSuccessModal } from "./_components/payment-success-modal"
import { UserProfileHeader } from "../dashboard/_components/user-profile-header"
import { useSearchParams } from "next/navigation"
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import Link from "next/link"
import { useSession } from "next-auth/react"
import { paymentData } from "@/lib/payment-data"
import { useTranslation } from "@/lib/use-translation"

export default function ServiceDetailsPage() {
  const session = useSession();
  const { t, isRTL } = useTranslation()
  const [showTermsModal, setShowTermsModal] = useState(false)
  const [selectedService, setSelectedService] = useState<{
    id: string
    title: string
    price: number
    description: string
    features?: string[]
    link?: string
  } | null>(null)
  const [showSuccessModal, setShowSuccessModal] = useState(false)
  const [successServiceId, setSuccessServiceId] = useState<string | null>(null)
  const [latestPayment, setLatestPayment] = useState<{
    amount: number
    currency: string
    formattedDate: string
  } | null>(null)
  const searchParams = useSearchParams()

  useEffect(() => {
    // Check if user has already accepted terms
    const hasAcceptedTerms = localStorage.getItem("tabashir-terms-accepted")

    if (!hasAcceptedTerms) {
      setShowTermsModal(true)
    }

    // Check for success parameter
    const success = searchParams.get("success")
    const serviceId = searchParams.get("service_id")

    if (success === "true" && serviceId) {
      setSuccessServiceId(serviceId)
      setShowSuccessModal(true)
    }

    // Fetch latest payment
    const fetchLatestPayment = async () => {
      try {
        const response = await fetch("/api/payments/latest")
        if (response.ok) {
          const payment = await response.json()
          setLatestPayment(payment)
        }
      } catch (error) {
        console.error("Error fetching latest payment:", error)
      }
    }

    fetchLatestPayment()
  }, [searchParams])

  const handleServiceSelect = (service: {
    id: string
    title: string
    price: number
    description: string
    features?: string[]
    link?: string
  }) => {
    setSelectedService(service)
  }

  const services = [
    {
      id: "ai-job-apply",
      title: t('aiJobApply'),
      price: 200,
      description: t('aiJobApplyDesc'),
      features: [
        t('aiJobSearch'),
        t('aiJobApplication'),
        t('aiJobLinkedin'),
        t('aiJobTracking'),
        t('aiJobInterview'),
        t('aiJobOffer')
      ],
      popular: true,
    },
    {
      id: "ai-resume-optimization",
      title: t('aiResumeOptimization'),
      price: 40,
      description: t('aiResumeOptimizationDesc'),
      features: [
        t('aiAnalysisMatching'),
        t('professionalFormatting'),
        t('keywordOptimization'),
        t('atsCompatibility'),
        t('instantDownload')
      ],
      popular: true,
    },
    // {
    //   id: "cover-letter-generation",
    //   title: t('coverLetterGeneration'),
    //   price: 25,
    //   description: t('coverLetterGenerationDesc'),
    //   features: [
    //     t('personalizedCoverLetter'),
    //     t('jobSpecificContent'),
    //     t('professionalTone'),
    //     t('multipleFormats'),
    //     t('editableTemplate')
    //   ],
    // },
    {
      id: "linkedin-optimization",
      title: t('linkedinEnhancement'),
      price: 60,
      description: t('linkedinEnhancementDesc'),
      features: [
        t('profileCompletion'),
        t('contentOptimization'),
        t('engagementBoost'),
        t('visibilityEnhancement'),
        t('instantDownload')
      ],
    },
    {
      id: "interview-preparation",
      title: t('interviewPreparation'),
      price: 60,
      description: t('interviewPreparationDesc'),
      features: [
        t('commonQuestions'),
        t('industrySpecificQuestions'),
        t('answerTemplates'),
        t('confidenceBuilding'),
        t('practiceSimulations')
      ],
      comingSoon: true,
    },
  ]

  return (
    <div className={`bg-white rounded-lg p-6 min-h-[calc(100vh-35px)] ${isRTL ? 'text-right' : ''}`}>
      {latestPayment && (
        <div className="mt-6 p-4 bg-green-50 border border-green-200 rounded-lg">
          <div className={`flex items-center gap-3 ${isRTL ? 'flex-row-reverse' : ''}`}>
            <div className="w-8 h-8 bg-green-500 rounded-full flex items-center justify-center">
              <Check className="w-5 h-5 text-white" />
            </div>
            <div className={isRTL ? 'text-right' : ''}>
              <p className="text-green-800 font-medium">
                {t('recentPayment')}
              </p>
              <p className="text-green-600 text-sm">
                {latestPayment.amount} {latestPayment.currency} - {latestPayment.formattedDate}
              </p>
            </div>
          </div>
        </div>
      )}

      <div className="mt-6">
        <div className="text-center mb-8">
          <h1 className="text-3xl font-bold text-gray-900 mb-2">
            {t('tabashirServices')}
          </h1>
          <p className="text-gray-600 max-w-2xl mx-auto">
            {t('tabashirServicesDesc')}
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          {services.map((service) => (
            <Card
              key={service.id}
              className={`relative transition-all duration-200 hover:shadow-lg ${service.popular ? "border-blue-500 shadow-md" : ""
                } ${service.comingSoon ? "opacity-75" : ""}`}
            >
              {service.popular && (
                <div className="absolute -top-3 left-1/2 transform -translate-x-1/2">
                  <span className="bg-blue-500 text-white px-3 py-1 rounded-full text-xs font-medium">
                    {t('mostPopular')}
                  </span>
                </div>
              )}
              {service.comingSoon && (
                <div className="absolute -top-3 right-4">
                  <span className="bg-orange-500 text-white px-3 py-1 rounded-full text-xs font-medium">
                    {t('comingSoon')}
                  </span>
                </div>
              )}
              <CardHeader className={isRTL ? 'text-right' : ''}>
                <CardTitle className="text-xl font-bold text-gray-900">
                  {service.title}
                </CardTitle>
                <CardDescription className="text-gray-600">
                  {service.description}
                </CardDescription>
                <div className={`flex items-baseline gap-1 mt-2 ${isRTL ? 'flex-row-reverse' : ''}`}>
                  <span className="text-3xl font-bold text-blue-600">
                    {service.price}
                  </span>
                  <span className="text-gray-500">{t('aed')}</span>
                </div>
              </CardHeader>
              <CardContent className={isRTL ? 'text-right' : ''}>
                <ul className="space-y-2">
                  {service.features?.map((feature, index) => (
                    <li key={index} className={`flex items-start gap-2 ${isRTL ? 'flex-row-reverse' : ''}`}>
                      <Check className="w-5 h-5 text-green-500 mt-0.5 flex-shrink-0" />
                      <span className="text-gray-700 text-sm">{feature}</span>
                    </li>
                  ))}
                </ul>
              </CardContent>
              <CardFooter>
                <Button
                  onClick={() => handleServiceSelect(service)}
                  disabled={service.comingSoon}
                  className="w-full bg-gradient-to-r from-[#042052] to-[#0D57E1] hover:from-[#0D57E1] hover:to-[#042052] text-white disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  {service.comingSoon ? t('comingSoon') : t('selectService')}
                </Button>
              </CardFooter>
            </Card>
          ))}
        </div>

        <div className="mt-12 text-center">
          <h2 className="text-2xl font-bold text-gray-900 mb-4">
            {t('needCustomSolution')}
          </h2>
          <p className="text-gray-600 mb-6">
            {t('needCustomSolutionDesc')}
          </p>
          <Link href="/contact">
            <Button variant="outline" className="px-8 py-2">
              {t('contactUs')}
            </Button>
          </Link>
        </div>
      </div>

      <TermsModal
        isOpen={showTermsModal}
        onClose={() => {
          setShowTermsModal(false)
          localStorage.setItem("tabashir-terms-accepted", "true")
        }}
      />

      {selectedService && <ServiceModal
        isOpen={!!selectedService}
        onClose={() => setSelectedService(null)}
        service={selectedService}
      />}

      {successServiceId && <PaymentSuccessModal
        isOpen={showSuccessModal}
        onClose={() => setShowSuccessModal(false)}
        serviceId={successServiceId}
      />}
    </div>
  )
}
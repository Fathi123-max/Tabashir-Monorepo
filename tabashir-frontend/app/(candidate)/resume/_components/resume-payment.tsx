'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import { useSession } from 'next-auth/react'

export default function ResumePayment({
  resumeId,
  isOpened,
  successUrl
}: {
  resumeId: string,
  isOpened: boolean,
  successUrl?: string
}) {
  const [loading, setLoading] = useState(false)
  const router = useRouter()
  const session = useSession()

  async function handlePay() {
    setLoading(true)
    try {
      const userId = session.data?.user?.id
      if (!userId) throw new Error('You must be logged in to make a payment')

      const baseUrl = window.location.origin
      const success = successUrl || `${baseUrl}/resume/new/${resumeId}/skills?payment_completed=true`
      const cancel = `${baseUrl}/resume/new/${resumeId}/skills`

      const response = await fetch('/api/stripe/create-checkout-session', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          serviceId: 'ai-resume-optimization',
          userId,
          enhancedResumeId: resumeId,
          successUrl: success,
          cancelUrl: cancel,
        }),
      })

      if (!response.ok) {
        const errorData = await response.json().catch(() => ({}))
        throw new Error(errorData?.error || 'Failed to start checkout')
      }

      const data = await response.json()
      if (!data?.url) throw new Error('No checkout URL returned')

      window.location.href = data.url
    } catch (error) {
      console.error('Payment error:', error)
      setLoading(false)
      // You can add toast notification here
    }
  }

  if (!isOpened) return null

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
      <div className="bg-white p-6 rounded-lg shadow-xl max-w-md w-full mx-4">
        <h2 className="text-xl font-semibold mb-4 text-black">Payment Required</h2>
        <p className="text-gray-600 mb-6">
          You have to pay 40 AED in order to create your ATS CV.
        </p>
        <div className="flex justify-end gap-4">
          <button
            onClick={() => router.push('/resume')}
            disabled={loading}
            className="bg-gray-200 text-black px-4 py-2 rounded hover:bg-gray-300 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            Go Back to Dashboard
          </button>
          <button
            onClick={handlePay}
            disabled={loading}
            className="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            {loading ? 'Processing...' : 'Pay with Stripe'}
          </button>
        </div>
      </div>
    </div>
  )
}

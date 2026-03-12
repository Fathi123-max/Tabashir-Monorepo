import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog"
import { Button } from "@/components/ui/button"
import { useState } from "react"
import { useSession } from "next-auth/react"

interface ServiceModalProps {
  isOpen: boolean
  onClose: () => void
  service: {
    id: string
    title: string
    price: number
    description: string
    features?: string[]
    link?: string
  }
}

export function ServiceModal({ isOpen, onClose, service }: ServiceModalProps) {
  const [loading, setLoading] = useState(false)
  const session = useSession()

  async function handlePay() {
    setLoading(true)
    try {
      // Use the link from the service prop if available, otherwise get from paymentData
      let checkoutLink = service.link

      if (!checkoutLink) {
        // Fallback to paymentData
        const { paymentData } = await import('@/lib/payment-data')
        const serviceData = Object.values(paymentData).find(s => s.id === service.id)
        checkoutLink = serviceData?.link
      }

      if (checkoutLink) {
        // Add user email to the checkout link if available
        const response = await fetch('/api/stripe/create-checkout-session', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            serviceId: service.id,
            userId: session.data?.user?.id,
          }),
        })

        if (!response.ok) {
          const errorData = await response.json().catch(() => ({}))
          throw new Error(errorData?.error || 'Failed to start checkout')
        }

        const data = await response.json()
        if (!data?.url) throw new Error('No checkout URL returned')

        // window.location.href = data.url

        // Redirect directly to Stripe checkout link
        window.location.href = data.url
      } else {
        throw new Error('No checkout link available for this service')
      }
    } catch (error) {
      console.error('Payment error:', error)
      setLoading(false)
      // You can add toast notification here
    }
  }
  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="sm:max-w-[425px]">
        <DialogHeader>
          <div className="flex items-center justify-between">
            <DialogTitle className="text-2xl font-bold">{service.title}</DialogTitle>
          </div>
        </DialogHeader>

        <div className="mt-4 space-y-6">
          <div className="bg-gray-50 p-4 rounded-lg">
            <div className="text-3xl font-bold text-primary mb-2">{service.price} AED</div>
            <p className="text-gray-600">{service.description}</p>
          </div>

          {service.features && (
            <div className="space-y-3">
              <h3 className="font-semibold text-lg">What's included:</h3>
              <ul className="space-y-2 !text-gray-600">
                {service.features.map((feature, index) => (
                  <li key={index} className="flex items-start">
                    <div className="h-5 w-5 rounded-full bg-green-100 flex items-center justify-center mr-2 mt-0.5 flex-shrink-0">
                      <div className="h-2 w-2 rounded-full bg-green-500" />
                    </div>
                    <span>{feature}</span>
                  </li>
                ))}
              </ul>
            </div>
          )}

          <div className="pt-4">
            <Button
              className="w-full text-lg py-6"
              style={{ background: "linear-gradient(91.97deg, #042052 25.05%, #0D57E1 176.12%)" }}
              onClick={handlePay}
              disabled={loading}
            >
              {loading ? 'Processing...' : 'Pay Now'}
            </Button>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  )
} 
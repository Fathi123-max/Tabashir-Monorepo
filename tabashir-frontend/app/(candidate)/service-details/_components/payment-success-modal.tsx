import { CheckCircle2 } from "lucide-react"
import { motion } from "framer-motion"
import {
  Dialog,
  DialogContent,
} from "@/components/ui/dialog"
import { subscriptionPlans } from "@/app/utils/subscriptions"

interface PaymentSuccessModalProps {
  isOpen: boolean
  onClose: () => void
  serviceId: string
}

export function PaymentSuccessModal({ isOpen, onClose, serviceId }: PaymentSuccessModalProps) {
  const service = Object.values(subscriptionPlans).find(plan => plan.id === serviceId)

  if (!service) {
    return null
  }

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="sm:max-w-[425px]">
        <div className="flex flex-col items-center justify-center py-8">
          <motion.div
            initial={{ scale: 0 }}
            animate={{ scale: 1 }}
            transition={{
              type: "spring",
              stiffness: 260,
              damping: 20
            }}
          >
            <CheckCircle2 className="h-24 w-24 text-green-500" />
          </motion.div>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.2 }}
            className="mt-6 text-center"
          >
            <h2 className="text-2xl font-bold text-gray-900">Payment Successful!</h2>
            <p className="mt-2 text-gray-600">
              Thank you for purchasing {service.name}. Your service has been activated.
            </p>
          </motion.div>

          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.4 }}
            className="mt-6 w-full"
          >
            <div className="bg-gray-50 rounded-lg p-4">
              <h3 className="font-semibold text-gray-900">What's Next?</h3>
              <ul className="mt-2 space-y-2 text-sm text-gray-600">
                {service.totalJobs > 0 && (
                  <li>• You can now apply to {service.totalJobs} jobs</li>
                )}
                {service.totalInterviewTraining > 0 && (
                  <li>• Schedule your {service.totalInterviewTraining} minutes interview training</li>
                )}
                {service.totalCoverLetters > 0 && (
                  <li>• Get your tailored cover letter</li>
                )}
                {service.totalAiJobApply > 0 && (
                  <li>• Our AI will start matching and applying to jobs for you</li>
                )}
              </ul>
            </div>
          </motion.div>
        </div>
      </DialogContent>
    </Dialog>
  )
} 
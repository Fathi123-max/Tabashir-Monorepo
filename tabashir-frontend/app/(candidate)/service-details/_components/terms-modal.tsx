"use client"

import { useState } from "react"
import { Button } from "@/components/ui/button"
import { Checkbox } from "@/components/ui/checkbox"
import { useTranslation } from "@/lib/use-translation"

interface TermsModalProps {
  isOpen: boolean
  onClose: () => void
}

export function TermsModal({ isOpen, onClose }: TermsModalProps) {
  const [agreed, setAgreed] = useState(false)

  const { t, isRTL } = useTranslation()

  if (!isOpen) return null

  return (
    <div className="fixed inset-0 bg-black/50 z-50 flex items-center justify-center p-4">
      <div className="bg-white rounded-lg max-w-4xl w-full max-h-[90vh] overflow-y-auto">
        <div className={`p-6 ${isRTL ? 'text-right' : 'text-left'}`}>
          <h2 className="text-2xl font-bold mb-6">TABASHIR</h2>

          <div className="prose prose-sm max-w-none mb-6">
            <p>
              {t('termsAndConditionsText')}
            </p>
          </div>

          <div className={`flex items-center mb-6 ${isRTL ? 'space-x-reverse space-x-2' : 'space-x-2'}`}>
            <Checkbox id="terms" checked={agreed} onCheckedChange={(checked) => setAgreed(checked as boolean)} />
            <label
              htmlFor="terms"
              className="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
            >
              {t('agreeToTermsAndConditions')}
            </label>
          </div>

          <div className={`flex ${isRTL ? 'justify-start' : 'justify-end'}`}>
            <Button onClick={onClose} disabled={!agreed} className="bg-blue-600 hover:bg-blue-700 text-white">
              {t('continue')}
            </Button>
          </div>
        </div>
      </div>
    </div>
  )
}

"use client"

import type React from "react"

import { useState } from "react"
import type { UseFormReturn } from "react-hook-form"
import { Button } from "@/components/ui/button"
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form"
import { Input } from "@/components/ui/input"
import * as z from "zod"
import { applicationFormSchema } from "./job-form-schema"

interface ApplicationFormProps {
  form: UseFormReturn<any>
  onNext: () => void
  onPrev: () => void
}

export default function ApplicationForm({ form, onNext, onPrev }: ApplicationFormProps) {
  const [applicationType, setApplicationType] = useState<"easy" | "screening">("easy")

  const validateCurrentStep = async () => {
    // Get current form values
    const formData = form.getValues()

    // Extract only the fields for this step
    const stepData = {
      applicationDeadline: formData.applicationDeadline,
      contactEmail: formData.contactEmail,
      contactPhone: formData.contactPhone,
      jobDate: formData.jobDate,
      link: formData.link,
    }

    try {
      // Validate only the current step's fields
      applicationFormSchema.parse(stepData)

      // Clear any existing errors for these fields
      const fieldNames = Object.keys(stepData) as Array<keyof typeof stepData>
      fieldNames.forEach(fieldName => {
        form.clearErrors(fieldName)
      })

      return true
    } catch (error) {
      if (error instanceof z.ZodError) {
        // Set errors for invalid fields
        error.errors.forEach((err) => {
          if (err.path[0]) {
            form.setError(err.path[0] as any, {
              type: "manual",
              message: err.message,
            })
          }
        })
      }
      return false
    }
  }

  const handleNext = async (e: React.FormEvent) => {
    e.preventDefault()

    // Validate current step
    const isValid = await validateCurrentStep()

    if (isValid) {
      onNext()
    }
  }

  return (
    <div className="text-gray-900">
      <h2 className="text-xl font-semibold mb-6">Application</h2>

      <Form {...form}>
        <form onSubmit={handleNext} className="space-y-6">
          <div className="border rounded-lg p-6 space-y-6">
            <h3 className="text-lg font-medium mb-4">User Application Process</h3>

            {/* Only Easy Apply option */}
            <div className="flex space-x-6 mb-6">
              <div className="flex items-center space-x-2">
                <div className="w-4 h-4 rounded-full border border-blue-600 flex items-center justify-center">
                  <div className="w-2 h-2 rounded-full bg-blue-600"></div>
                </div>
                <span className="text-blue-600">Easy Apply</span>
              </div>
            </div>

            <FormField
              control={form.control}
              name="contactEmail"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Contact Email</FormLabel>
                  <FormControl>
                    <Input placeholder="Type recruiter email" type="email" {...field} />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name="contactPhone"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Contact Phone</FormLabel>
                  <FormControl>
                    <Input placeholder="Type contact phone number" type="tel" {...field} />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name="jobDate"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Job Posting Date</FormLabel>
                  <FormControl>
                    <Input placeholder="Select date" type="date" {...field} />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name="link"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Additional Link (Optional)</FormLabel>
                  <FormControl>
                    <Input placeholder="https://example.com/job-details" type="url" {...field} />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name="applicationDeadline"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Application Deadline (Optional)</FormLabel>
                  <FormControl>
                    <Input placeholder="Select deadline" type="date" {...field} />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />
          </div>

          {/* Navigation buttons */}
          <div className="flex justify-between">
            <Button type="button" variant="outline" onClick={onPrev}>
              Previous
            </Button>
            <Button type="submit" className="bg-blue-950 hover:bg-blue-900 transition-all duration-200 text-white">
              Next
            </Button>
          </div>
        </form>
      </Form>
    </div>
  )
}

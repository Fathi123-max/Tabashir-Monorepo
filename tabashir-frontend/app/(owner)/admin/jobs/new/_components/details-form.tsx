"use client"

import { useState, type KeyboardEvent, useEffect } from "react"
import type { UseFormReturn } from "react-hook-form"
import { Button } from "@/components/ui/button"
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form"
import { Input } from "@/components/ui/input"
import { X } from "lucide-react"
import TiptapEditor from "@/components/tiptap-editor"
import * as z from "zod"
import { detailsFormSchema } from "./job-form-schema"
import { Textarea } from "@/components/ui/textarea"

interface DetailsFormProps {
  form: UseFormReturn<any>
  onNext: () => void
  onPrev: () => void
}

export default function DetailsForm({ form, onNext, onPrev }: DetailsFormProps) {
  const [skillInput, setSkillInput] = useState("")
  const [skills, setSkills] = useState<string[]>([])
  const [benefitInput, setBenefitInput] = useState("")
  const [benefits, setBenefits] = useState<string[]>([])

  // Initialize skills and benefits from form values
  useEffect(() => {
    const formSkills = form.getValues("requiredSkills") || []
    const formBenefits = form.getValues("benefits") || []
    setSkills(formSkills)
    setBenefits(formBenefits)
  }, [form])

  const handleSkillKeyDown = (e: KeyboardEvent<HTMLInputElement>) => {
    if (e.key === "Enter") {
      e.preventDefault()
      if (skillInput.trim() && !skills.includes(skillInput.trim())) {
        const newSkills = [...skills, skillInput.trim()]
        setSkills(newSkills)
        form.setValue("requiredSkills", newSkills)
        setSkillInput("")
      }
    }
  }

  const removeSkill = (skillToRemove: string) => {
    const newSkills = skills.filter((skill) => skill !== skillToRemove)
    setSkills(newSkills)
    form.setValue("requiredSkills", newSkills)
  }

  const handleBenefitKeyDown = (e: KeyboardEvent<HTMLInputElement>) => {
    if (e.key === "Enter") {
      e.preventDefault()
      if (benefitInput.trim() && !benefits.includes(benefitInput.trim())) {
        const newBenefits = [...benefits, benefitInput.trim()]
        setBenefits(newBenefits)
        form.setValue("benefits", newBenefits)
        setBenefitInput("")
      }
    }
  }

  const removeBenefit = (benefitToRemove: string) => {
    const newBenefits = benefits.filter((benefit) => benefit !== benefitToRemove)
    setBenefits(newBenefits)
    form.setValue("benefits", newBenefits)
  }

  const validateCurrentStep = async () => {
    // Get current form values
    const formData = form.getValues()

    // Extract only the fields for this step
    const stepData = {
      location: formData.location,
      requiredSkills: formData.requiredSkills,
      description: formData.description,
      requirements: formData.requirements,
      benefits: formData.benefits,
      academicQualification: formData.academicQualification,
      experience: formData.experience,
      languages: formData.languages,
      workingHours: formData.workingHours,
      workingDays: formData.workingDays,
    }

    try {
      // Validate only the current step's fields
      detailsFormSchema.parse(stepData)

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
      <h2 className="text-xl font-semibold mb-6">Details</h2>

      <Form {...form}>
        <form onSubmit={handleNext} className="space-y-6">
          <div className="border rounded-lg p-6 space-y-6">
            <FormField
              control={form.control}
              name="location"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Location</FormLabel>
                  <FormControl>
                    <Input placeholder="e.g. New York, NY" {...field} />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name="requiredSkills"
              render={() => (
                <FormItem>
                  <FormLabel>Skills Required for Job</FormLabel>
                  <FormControl>
                    <Input
                      placeholder="Type a skill and press Enter"
                      value={skillInput}
                      onChange={(e) => setSkillInput(e.target.value)}
                      onKeyDown={handleSkillKeyDown}
                    />
                  </FormControl>
                  <div className="flex flex-wrap gap-2 mt-2">
                    {skills.map((skill) => (
                      <div
                        key={skill}
                        className="bg-blue-100 text-blue-800 px-3 py-1 rounded-full flex items-center text-sm"
                      >
                        {skill}
                        <button
                          type="button"
                          onClick={() => removeSkill(skill)}
                          className="ml-2 text-blue-600 hover:text-blue-800"
                        >
                          <X size={14} />
                        </button>
                      </div>
                    ))}
                  </div>
                  <FormMessage />
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name="description"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Job Description</FormLabel>
                  <FormControl>
                    <Textarea {...field} />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name="requirements"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Requirements</FormLabel>
                  <FormControl>
                    <Textarea {...field} />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name="benefits"
              render={() => (
                <FormItem>
                  <FormLabel>Benefits</FormLabel>
                  <FormControl>
                    <Input
                      placeholder="Type a benefit and press Enter"
                      value={benefitInput}
                      onChange={(e) => setBenefitInput(e.target.value)}
                      onKeyDown={handleBenefitKeyDown}
                    />
                  </FormControl>
                  <div className="flex flex-wrap gap-2 mt-2">
                    {benefits.map((benefit) => (
                      <div
                        key={benefit}
                        className="bg-green-100 text-green-800 px-3 py-1 rounded-full flex items-center text-sm"
                      >
                        {benefit}
                        <button
                          type="button"
                          onClick={() => removeBenefit(benefit)}
                          className="ml-2 text-green-600 hover:text-green-800"
                        >
                          <X size={14} />
                        </button>
                      </div>
                    ))}
                  </div>
                  <FormMessage />
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name="academicQualification"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Academic Qualification</FormLabel>
                  <FormControl>
                    <Input placeholder="e.g. Bachelor's Degree, Master's Degree, etc." {...field} />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name="experience"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Experience Requirements</FormLabel>
                  <FormControl>
                    <Input placeholder="e.g. 2-5 years, Fresh Graduate, etc." {...field} />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name="languages"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Language Requirements</FormLabel>
                  <FormControl>
                    <Input placeholder="e.g. English, Arabic, Hindi, etc." {...field} />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name="workingHours"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Working Hours</FormLabel>
                  <FormControl>
                    <Input placeholder="e.g. 9 AM - 6 PM, 8 hours/day, etc." {...field} />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name="workingDays"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Working Days</FormLabel>
                  <FormControl>
                    <Input placeholder="e.g. Monday - Friday, 5 days/week, etc." {...field} />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />
          </div>

          <div className="flex justify-between">
            <Button type="button" variant="outline" onClick={onPrev}>
              Previous
            </Button>
            <Button type="submit" className="bg-blue-950 hover:blue-gradient text-white">
              Next
            </Button>
          </div>
        </form>
      </Form>
    </div>
  )
}

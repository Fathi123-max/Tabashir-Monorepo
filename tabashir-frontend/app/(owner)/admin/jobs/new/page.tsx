"use client"

import { useState } from "react"
import { useForm } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"
import { jobFormSchema } from "./_components/job-form-schema"
import StepNavigation from "./_components/step-navigation"
import AboutForm from "./_components/about-form"
import DetailsForm from "./_components/details-form"
import ApplicationForm from "./_components/application-form"
import PreviewForm from "./_components/preview-form"

export default function NewJobPage() {
  const [currentStep, setCurrentStep] = useState(1) // Start at application step for testing

  const form = useForm({
    resolver: zodResolver(jobFormSchema),
    defaultValues: {
      jobTitle: "",
      company: "",
      companyDescription: "",
      jobType: "Onsite",
      salaryMin: "45,000",
      salaryMax: "50,000",
      location: "",
      description: "",
      requirements: "",
      benefits: [""],
      applicationDeadline: "",
      contactEmail: "",
      contactPhone: "",
      companyLogo: "",
      requiredSkills: [],
      nationality: "",
      gender: "",
      academicQualification: "",
      experience: "",
      languages: "",
      workingHours: "",
      workingDays: "",
      jobDate: "",
      link: "",
    },
  })

  const nextStep = () => {
    console.log("nextStep", form.getValues());
    setCurrentStep((prev) => Math.min(prev + 1, 4))
  }

  const prevStep = () => {
    setCurrentStep((prev) => Math.max(prev - 1, 1))
  }

  const renderStepContent = () => {
    switch (currentStep) {
      case 1:
        return <AboutForm form={form} onNext={nextStep} />
      case 2:
        return <DetailsForm form={form} onNext={nextStep} onPrev={prevStep} />
      case 3:
        return <ApplicationForm form={form} onNext={nextStep} onPrev={prevStep} />
      case 4:
        return <PreviewForm form={form} onPrev={prevStep} />
      default:
        return <AboutForm form={form} onNext={nextStep} />
    }
  }

  return (
    <div className="p-6 text-gray-900">
      <div className="bg-white rounded-lg shadow-sm p-6">
        <h1 className="text-2xl font-bold mb-6">Uploading new job</h1>

        <div className="flex flex-col md:flex-row gap-6">
          <div className="md:w-48 sticky top-6 self-start h-fit">
            <StepNavigation currentStep={currentStep} />
          </div>

          <div className="flex-1 pr-4">{renderStepContent()}</div>
        </div>
      </div>
    </div>
  )
}

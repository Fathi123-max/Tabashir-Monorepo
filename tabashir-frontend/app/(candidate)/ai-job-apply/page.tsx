"use client"

import type React from "react"
import { useState, useEffect } from "react"
import { Sparkles, X, Check, ChevronsUpDown, Loader2, Plus } from "lucide-react"
import { Button } from "@/components/ui/button"
import { z } from "zod"
import { useForm } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"
import { Form, FormControl, FormField, FormItem, FormMessage } from "@/components/ui/form"
import { UserProfileHeader } from "../dashboard/_components/user-profile-header"
import { getUserResumes } from "@/actions/resume"
import { Resume as PrismaResume } from "@prisma/client"
import { Command, CommandEmpty, CommandGroup, CommandInput, CommandItem } from "@/components/ui/command"

// Local Resume interface to match what's expected by the upload modal
interface Resume {
  id: string
  filename: string
  createdAt: Date
  formatedUrl: string | null
  originalUrl: string
  formatedContent: string | null
}
import { toast } from "sonner"
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover"
import { cn } from "@/lib/utils"
import { getAiJobApplyStatus, submitAiJobApply } from "@/actions/ai-resume"
import { useRouter } from "next/navigation"
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog"
import { CITIES } from "@/data/cities"
import { useSession } from "next-auth/react"
import { ResumeUploadModal } from "../resume/_components/resume-upload-modal"
import { useTranslation } from "@/lib/use-translation"

// Define the form schema with Zod (using translated messages)
const createFormSchema = (t: (key: string) => string) => z.object({
  resume: z
    .string()
    .nullable()
    .refine((val) => val !== null, {
      message: t("pleaseSelectResume"),
    }),
  positions: z.array(z.string()).min(1, t("pleaseAddAtLeastOnePosition")),
  locations: z.array(z.string()).min(1, t("pleaseSelectAtLeastOneLocation")),
  nationality: z.array(z.string()).min(1, t("pleaseSelectAtLeastOneNationality")),
  gender: z.string().min(1, t("pleaseSelectGender")),
})

type FormValues = {
  resume: string | null;
  positions: string[];
  locations: string[];
  nationality: string[];
  gender: string;
}

const NATIONALITIES = [
  "Emirati",
  "Saudi Arabian",
  "Egyptian",
  "Lebanese",
  "Jordanian",
  "Syrian",
  "Palestinian",
  "Kuwaiti",
  "Qatari",
  "Bahraini",
  "Omani",
  "Yemeni",
  "Iraqi",
  "Moroccan",
  "Tunisian",
  "Algerian",
  "Sudanese",
  "Indian",
  "Pakistani",
  "Bangladeshi",
  "Sri Lankan",
  "Filipino",
  "Indonesian",
  "Malaysian",
  "Thai",
  "Vietnamese",
  "Chinese",
  "Japanese",
  "Korean",
  "American",
  "British",
  "Canadian",
  "Australian",
  "German",
  "French",
  "Italian",
  "Spanish",
  "Dutch",
  "Swedish",
  "Norwegian",
  "Russian",
  "Ukrainian",
  "Turkish",
  "Iranian",
  "Afghan",
  "Ethiopian",
  "Kenyan",
  "Nigerian",
  "South African",
  "Brazilian",
  "Argentinian",
  "Other"
]

const GENDERS = ["Male", "Female"]

const JOB_POSITIONS = [
  // Technology & IT
  "Web Designer",
  "Product Manager",
  "UX Designer",
  "Frontend Developer",
  "Backend Developer",
  "Full Stack Developer",
  "Data Scientist",
  "Data Analyst",
  "Software Engineer",
  "DevOps Engineer",
  "Mobile App Developer",
  "UI/UX Designer",
  "System Administrator",
  "Network Engineer",
  "Cybersecurity Specialist",
  "Cloud Architect",
  "Database Administrator",
  "QA Engineer",
  "Technical Writer",
  "IT Support Specialist",

  // Business & Management
  "Business Analyst",
  "Project Manager",
  "Operations Manager",
  "General Manager",
  "Executive Assistant",
  "Business Development Manager",
  "Strategy Consultant",
  "Management Consultant",
  "Team Lead",
  "Department Head",

  // Marketing & Sales
  "Digital Marketing Specialist",
  "Social Media Manager",
  "Content Creator",
  "Marketing Manager",
  "Sales Representative",
  "Account Manager",
  "Brand Manager",
  "SEO Specialist",
  "Email Marketing Specialist",
  "Growth Hacker",
  "Sales Manager",
  "Customer Success Manager",

  // Finance & Accounting
  "Accountant",
  "Financial Analyst",
  "Finance Manager",
  "Investment Analyst",
  "Auditor",
  "Tax Specialist",
  "Credit Analyst",
  "Risk Analyst",
  "Treasury Analyst",
  "Controller",

  // Human Resources
  "HR Specialist",
  "Recruiter",
  "HR Manager",
  "Training Specialist",
  "Compensation Analyst",
  "Employee Relations Specialist",
  "HR Business Partner",
  "Talent Acquisition Specialist",

  // Customer Service
  "Customer Service Representative",
  "Call Center Agent",
  "Customer Support Specialist",
  "Help Desk Technician",
  "Client Relations Manager",

  // Healthcare
  "Registered Nurse",
  "Medical Assistant",
  "Healthcare Administrator",
  "Physical Therapist",
  "Pharmacist",
  "Medical Technician",
  "Healthcare Consultant",

  // Education
  "Teacher",
  "Professor",
  "Training Coordinator",
  "Curriculum Developer",
  "Educational Consultant",
  "Academic Advisor",

  // Engineering
  "Mechanical Engineer",
  "Civil Engineer",
  "Electrical Engineer",
  "Chemical Engineer",
  "Industrial Engineer",
  "Environmental Engineer",
  "Quality Engineer",
  "Process Engineer",

  // Creative & Design
  "Graphic Designer",
  "Creative Director",
  "Video Editor",
  "Photographer",
  "Content Writer",
  "Copywriter",
  "Art Director",
  "Interior Designer",

  // Operations & Logistics
  "Supply Chain Manager",
  "Logistics Coordinator",
  "Warehouse Manager",
  "Procurement Specialist",
  "Operations Analyst",
  "Production Manager",

  // Legal
  "Legal Assistant",
  "Paralegal",
  "Compliance Officer",
  "Contract Specialist",
  "Legal Counsel",

  // Others
  "Administrative Assistant",
  "Office Manager",
  "Receptionist",
  "Research Assistant",
  "Translator",
  "Virtual Assistant",
  "Consultant",
  "Freelancer",
  "Intern",
  "Entry Level"
]

export default function AIJobApplyPage() {
  const [resumeList, setResumeList] = useState<Resume[] | null>(null)
  const [hasAiJobApply, setHasAiJobApply] = useState(false)
  const [loading, setLoading] = useState(false)
  const [showPurchaseModal, setShowPurchaseModal] = useState(false)
  const [isUploadModalOpen, setIsUploadModalOpen] = useState(false)
  const session = useSession()
  const router = useRouter()
  const { t, isRTL } = useTranslation()
  const token = process.env.NEXT_PUBLIC_API_TOKEN;

  useEffect(() => {
    async function fetchResumeList() {
      const response = await getUserResumes()
      if (response.data) {
        // Convert PrismaResume to local Resume interface
        const convertedResumes: Resume[] = response.data.map((resume: PrismaResume) => ({
          id: resume.id,
          filename: resume.filename,
          createdAt: resume.createdAt,
          formatedUrl: resume.formatedUrl,
          originalUrl: resume.originalUrl,
          formatedContent: resume.formatedContent
        }))
        setResumeList(convertedResumes)
      }
    }
    fetchResumeList()
  }, [])

  const handleUploadSuccess = (newResume: Resume) => {
    // Add the new resume to the list and sort by creation date (most recent first)
    setResumeList(prevResumes => {
      const updatedList = prevResumes ? [newResume, ...prevResumes] : [newResume]
      return updatedList.sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime())
    })
  }

  // Initialize the form
  const form = useForm<FormValues>({
    resolver: zodResolver(createFormSchema(t)),
    defaultValues: {
      resume: null,
      positions: [],
      locations: [],
      nationality: [],
      gender: "",
    },
  })

  const { setValue, watch, formState } = form
  const selectedResume = watch("resume")
  const selectedPositions = watch("positions")

  const handleRemovePosition = (position: string) => {
    const updatedPositions = selectedPositions.filter((p) => p !== position)
    setValue("positions", updatedPositions, { shouldValidate: true })
  }

  const onSubmit = async (data: FormValues) => {
    // Check if user has AI job apply access
    if (!hasAiJobApply) {
      setShowPurchaseModal(true)
      return
    }

    setLoading(true)
    try {
      // Find the selected resume object
      const selectedResumeObj = resumeList?.find(r => r.id === data.resume)
      if (!selectedResumeObj) {
        toast.error(t("pleaseSelectValidResume"))
        setLoading(false)
        return
      }

      console.log("selectedResumeObj", selectedResumeObj);

      // Fetch the file as a Blob (using originalUrl)
      let file
      try {
        const fileResponse = await fetch(selectedResumeObj.originalUrl)
        if (!fileResponse.ok) {
          throw new Error(t("failedToFetchResumeFile"))
        }
        const fileBlob = await fileResponse.blob()
        file = new File([fileBlob], selectedResumeObj.filename, { type: fileBlob.type })
      } catch (fetchErr: any) {
        toast.error(fetchErr.message || t("couldNotFetchResumeFile"))
        setLoading(false)
        return
      }

      console.log("file", file);

      const formData = new FormData()
      formData.append("email", session.data?.user?.email || "")
      formData.append("file", file)
      formData.append("gender", data.gender)
      data.nationality.forEach(nat => formData.append("nationality", nat))
      data.locations.forEach(loc => formData.append("locations", loc))
      data.positions.forEach(pos => formData.append("positions", pos))

      console.log("formData", formData);

      await submitAiJobApply(false, true)

      let res
      try {
        res = await fetch(`${process.env.NEXT_PUBLIC_BACKEND_URL}/api/v1/resume/apply`, {
          method: "POST",
          body: formData,
          headers: {
            "X-API-TOKEN": `${token}`,
          },
        })
        console.log("res", res);

        if (!res.ok) {
          const errorData = await res.json()
          console.log("errorData", errorData);
          toast.error(errorData.error || t("failedToApplyTryAgain"))
          setLoading(false)
          return
        }

      } catch (networkErr: any) {
        toast.error(networkErr.message || t("couldNotReachServer"))
        setLoading(false)
        return
      } finally {
        console.log("finally");
        setLoading(false)
        router.refresh()
      }

      if (!res.ok) {
        let errorMsg = t("failedToApplyTryAgain")
        try {
          const errorData = await res.json()
          if (errorData?.message) errorMsg = errorData.message
        } catch { }
        toast.error(errorMsg)
        setLoading(false)
        return
      }

      toast.success(t("aiJobApplicationSentSuccess"))

    } catch (error: any) {
      console.log("error", error);
      toast.error(error.message || t("somethingWentWrong"))
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    (async () => {
      const res = await getAiJobApplyStatus()
      console.log("res", res);
      if (res.data) {
        setHasAiJobApply(res.data.aiJobApplyCount > 0)
      }
    })()
  }, [])

  const handleGoToServiceDetails = () => {
    setShowPurchaseModal(false)
    router.push("/service-details")
  }

  return (
    <div className={`flex-1 text-gray-900 overflow-y-auto ${isRTL ? 'text-right' : 'text-left'}`}>
      <div className="bg-white rounded-lg shadow-sm px-10 max-lg:px-6 py-10 max-lg:py-8 max-lg:h-full">
        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)}>
            <div className={`flex items-center mb-10 max-lg:mb-8 ${isRTL ? 'flex-row-reverse' : ''}`}>
              <h1 className="text-2xl font-bold max-lg:text-xl">{t("aiJobApply")}</h1>
              <Sparkles className={`${isRTL ? 'mr-3' : 'ml-3'} text-yellow-400 h-6 w-6 max-lg:hidden`} />
            </div>

            {/* Step 1: Select Resume */}
            <div className="mb-10">
              <div className={`flex items-center justify-between mb-6 max-lg:flex-col max-lg:items-start max-lg:gap-4 max-lg:mb-4`}>
                <div className={`flex items-center ${isRTL ? 'flex-row-reverse' : ''}`}>
                  <div className={`flex items-center justify-center w-8 h-8 rounded-full bg-gradient-to-r from-blue-950 to-blue-700 text-white font-bold ${isRTL ? 'ml-3' : 'mr-3'} max-lg:w-6 max-lg:h-6 max-lg:text-sm`}>
                    1
                  </div>
                  <h2 className="text-xl font-semibold max-lg:text-lg">{t("selectResume")}</h2>
                </div>
                <button
                  type="button"
                  onClick={() => setIsUploadModalOpen(true)}
                  className="bg-gradient-to-r from-blue-950 to-blue-700 text-white py-2 px-4 rounded-md flex items-center gap-2 hover:from-blue-900 hover:to-blue-600 text-sm"
                >
                  <Plus size={16} />
                  <span>{t("resume")}</span>
                </button>
              </div>

              <FormField
                control={form.control}
                name="resume"
                render={({ field }) => (
                  <FormItem>
                    <FormControl>
                      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                        {resumeList && resumeList.length > 0 ? (
                          resumeList.map((item) => (
                            <div
                              key={item.id}
                              onClick={() =>
                                setValue("resume", field.value === item.id ? null : item.id, { shouldValidate: true })
                              }
                              className={`cursor-pointer rounded-md ${field.value === item.id
                                ? "p-0" // No padding when selected to accommodate the border
                                : "border p-4 hover:border-blue-200"
                                }`}
                            >
                              {field.value === item.id ? (
                                <div className="rounded-md p-[3px] bg-gradient-to-r from-blue-950 to-blue-700">
                                  <div className="bg-white p-4 rounded-[4px] flex">
                                    <div className="flex-shrink-0 mr-4">
                                      <div className="w-16 h-20 bg-red-500 rounded-md flex items-center justify-center text-white font-bold">
                                        PDF
                                      </div>
                                    </div>
                                    <div className="flex-1">
                                      <p className="font-medium text-sm">{item.filename.split(".")[0].slice(0, 15) + (item.filename.split(".")[0].length > 15 ? "..." : "") + item.filename.split(".")[1]}</p>
                                      <p className="text-xs text-gray-500 mt-1">
                                        {t("createdOn")}: {new Date(item.createdAt).toLocaleDateString()}
                                      </p>
                                    </div>
                                  </div>
                                </div>
                              ) : (
                                <div className="flex">
                                  <div className="flex-shrink-0 mr-4">
                                    <div className="w-16 h-20 bg-red-500 rounded-md flex items-center justify-center text-white font-bold">
                                      PDF
                                    </div>
                                  </div>
                                  <div className="flex-1">
                                    <p className="font-medium text-sm">{item.filename.split(".")[0].slice(0, 15) + (item.filename.split(".")[0].length > 15 ? "..." : "") + item.filename.split(".")[1]}</p>
                                    <p className="text-xs text-gray-500 mt-1">
                                      {t("createdOn")}: {new Date(item.createdAt).toLocaleDateString()}
                                    </p>
                                  </div>
                                </div>
                              )}
                            </div>
                          ))
                        ) : (
                          <div className="col-span-3 text-center py-8">
                            <div className="text-gray-500 mb-2">{t("noResumesFoundUpload")}</div>
                            <p className="text-sm text-gray-400">{t("pleaseUploadResumeToGetStarted")}</p>
                          </div>
                        )}
                      </div>
                    </FormControl>
                    <FormMessage className="text-red-500 mt-2" />
                  </FormItem>
                )}
              />
            </div>

            {/* Step 2: Job Position (Multi-select dropdown) */}
            <div className="mb-10">
              <div className={`flex items-center mb-6 max-lg:mb-4 w-full`}>
                <div className={`flex items-center justify-center w-8 h-8 rounded-full bg-gradient-to-r from-blue-950 to-blue-700 text-white font-bold ${isRTL ? 'ml-3' : 'mr-3'} max-lg:w-6 max-lg:h-6 max-lg:text-sm shrink-0`}>
                  2
                </div>
                <h2 className="text-xl font-semibold max-lg:text-lg">{t("citiesYouPrefer")}</h2>
              </div>

              <FormField
                control={form.control}
                name="positions"
                render={({ field }) => (
                  <FormItem>
                    <FormControl>
                      <Popover>
                        <PopoverTrigger asChild>
                          <Button
                            variant="outline"
                            role="combobox"
                            className="w-full justify-between"
                          >
                            {field.value.length > 0
                              ? `${field.value.length} ${t("positionsSelected")}`
                              : t("selectPositions")}
                            <ChevronsUpDown className="ml-2 h-4 w-4 shrink-0 opacity-50" />
                          </Button>
                        </PopoverTrigger>
                        <PopoverContent className="w-full p-0">
                          <Command>
                            <CommandInput placeholder={t("searchPositions")} />
                            <CommandEmpty>{t("noPositionsFound")}</CommandEmpty>
                            <CommandGroup className="max-h-64 overflow-auto">
                              {JOB_POSITIONS.map((position) => (
                                <CommandItem
                                  key={position}
                                  onSelect={() => {
                                    const updatedPositions = field.value.includes(position)
                                      ? field.value.filter((p) => p !== position)
                                      : [...field.value, position]
                                    field.onChange(updatedPositions)
                                  }}
                                >
                                  <Check
                                    className={cn(
                                      "mr-2 h-4 w-4",
                                      field.value.includes(position) ? "opacity-100" : "opacity-0"
                                    )}
                                  />
                                  {position}
                                </CommandItem>
                              ))}
                            </CommandGroup>
                          </Command>
                        </PopoverContent>
                      </Popover>
                    </FormControl>
                    <div className="flex flex-wrap gap-2 mt-2">
                      {field.value.map((position) => (
                        <div
                          key={position}
                          className="flex items-center bg-blue-100 text-blue-800 text-xs px-2 py-1 rounded"
                        >
                          {position}
                          <button
                            type="button"
                            onClick={() => handleRemovePosition(position)}
                            className="ml-1 text-blue-600 hover:text-blue-800"
                          >
                            <X size={14} />
                          </button>
                        </div>
                      ))}
                    </div>
                    <FormMessage className="text-red-500 mt-2" />
                  </FormItem>
                )}
              />
            </div>

            {/* Step 3: Location */}
            <div className="mb-16 max-lg:mb-10">
              <div className={`flex items-center mb-6 max-lg:mb-4 ${isRTL ? 'flex-row-reverse' : ''}`}>
                <div className={`flex items-center justify-center w-8 h-8 rounded-full bg-gradient-to-r from-blue-950 to-blue-700 text-white font-bold ${isRTL ? 'ml-3' : 'mr-3'} max-lg:w-6 max-lg:h-6 max-lg:text-sm shrink-0`}>
                  3
                </div>
                <h2 className="text-xl font-semibold max-lg:text-lg">{t("citiesYouPrefer")}</h2>
              </div>

              <FormField
                control={form.control}
                name="locations"
                render={({ field }) => (
                  <FormItem>
                    <FormControl>
                      <Popover>
                        <PopoverTrigger asChild>
                          <Button
                            variant="outline"
                            role="combobox"
                            className="w-full justify-between"
                          >
                            {field.value.length > 0
                              ? `${field.value.length} ${t("citiesSelected")}`
                              : t("selectCities")}
                            <ChevronsUpDown className="ml-2 h-4 w-4 shrink-0 opacity-50" />
                          </Button>
                        </PopoverTrigger>
                        <PopoverContent className="w-full p-0">
                          <Command>
                            <CommandInput placeholder={t("searchCities")} />
                            <CommandEmpty>{t("noCitiesFound")}</CommandEmpty>
                            <CommandGroup className="max-h-64 overflow-auto">
                              {CITIES.map((city) => (
                                <CommandItem
                                  key={city}
                                  onSelect={() => {
                                    const updatedLocations = field.value.includes(city)
                                      ? field.value.filter((l) => l !== city)
                                      : [...field.value, city]
                                    field.onChange(updatedLocations)
                                  }}
                                >
                                  <Check
                                    className={cn(
                                      "mr-2 h-4 w-4",
                                      field.value.includes(city) ? "opacity-100" : "opacity-0"
                                    )}
                                  />
                                  {city}
                                </CommandItem>
                              ))}
                            </CommandGroup>
                          </Command>
                        </PopoverContent>
                      </Popover>
                    </FormControl>
                    <div className="flex flex-wrap gap-2 mt-2">
                      {field.value.map((city) => (
                        <div
                          key={city}
                          className="flex items-center bg-blue-100 text-blue-800 text-xs px-2 py-1 rounded"
                        >
                          {city}
                          <button
                            type="button"
                            onClick={() => {
                              const updatedLocations = field.value.filter((l) => l !== city)
                              field.onChange(updatedLocations)
                            }}
                            className="ml-1 text-blue-600 hover:text-blue-800"
                          >
                            <X size={14} />
                          </button>
                        </div>
                      ))}
                    </div>
                    <FormMessage className="text-red-500 mt-2" />
                  </FormItem>
                )}
              />
            </div>

            {/* Step 4: Nationality (Multi-select dropdown) */}
            <div className="mb-10">
              <div className={`flex items-center mb-6 max-lg:mb-4 ${isRTL ? 'flex-row-reverse' : ''}`}>
                <div className={`flex items-center justify-center w-8 h-8 rounded-full bg-gradient-to-r from-blue-950 to-blue-700 text-white font-bold ${isRTL ? 'ml-3' : 'mr-3'} max-lg:w-6 max-lg:h-6 max-lg:text-sm shrink-0`}>
                  4
                </div>
                <h2 className="text-xl font-semibold max-lg:text-lg">{t("nationality")}</h2>
              </div>
              <FormField
                control={form.control}
                name="nationality"
                render={({ field }) => (
                  <FormItem>
                    <FormControl>
                      <Popover>
                        <PopoverTrigger asChild>
                          <Button
                            variant="outline"
                            role="combobox"
                            className="w-full justify-between"
                          >
                            {field.value.length > 0
                              ? `${field.value.length} ${t("nationalitiesSelected")}`
                              : t("selectNationalities")}
                            <ChevronsUpDown className="ml-2 h-4 w-4 shrink-0 opacity-50" />
                          </Button>
                        </PopoverTrigger>
                        <PopoverContent className="w-full p-0">
                          <Command>
                            <CommandInput placeholder={t("searchNationalities")} />
                            <CommandEmpty>{t("noNationalitiesFound")}</CommandEmpty>
                            <CommandGroup className="max-h-64 overflow-auto">
                              {NATIONALITIES.map((nat) => (
                                <CommandItem
                                  key={nat}
                                  onSelect={() => {
                                    const updatedNationalities = field.value.includes(nat)
                                      ? field.value.filter((n) => n !== nat)
                                      : [...field.value, nat]
                                    field.onChange(updatedNationalities)
                                  }}
                                >
                                  <Check
                                    className={cn(
                                      "mr-2 h-4 w-4",
                                      field.value.includes(nat) ? "opacity-100" : "opacity-0"
                                    )}
                                  />
                                  {nat}
                                </CommandItem>
                              ))}
                            </CommandGroup>
                          </Command>
                        </PopoverContent>
                      </Popover>
                    </FormControl>
                    <div className="flex flex-wrap gap-2 mt-2">
                      {field.value.map((nat) => (
                        <div
                          key={nat}
                          className="flex items-center bg-blue-100 text-blue-800 text-xs px-2 py-1 rounded"
                        >
                          {nat}
                          <button
                            type="button"
                            onClick={() => {
                              const updatedNationalities = field.value.filter((n) => n !== nat)
                              field.onChange(updatedNationalities)
                            }}
                            className="ml-1 text-blue-600 hover:text-blue-800"
                          >
                            <X size={14} />
                          </button>
                        </div>
                      ))}
                    </div>
                    <FormMessage className="text-red-500 mt-2" />
                  </FormItem>
                )}
              />
            </div>

            {/* Step 5: Gender (Single-select dropdown) */}
            <div className="mb-10">
              <div className={`flex items-center mb-6 max-lg:mb-4 ${isRTL ? 'flex-row-reverse' : ''}`}>
                <div className={`flex items-center justify-center w-8 h-8 rounded-full bg-gradient-to-r from-blue-950 to-blue-700 text-white font-bold ${isRTL ? 'ml-3' : 'mr-3'} max-lg:w-6 max-lg:h-6 max-lg:text-sm shrink-0`}>
                  5
                </div>
                <h2 className="text-xl font-semibold max-lg:text-lg">{t("gender")}</h2>
              </div>
              <FormField
                control={form.control}
                name="gender"
                render={({ field }) => (
                  <FormItem>
                    <FormControl>
                      <Popover>
                        <PopoverTrigger asChild>
                          <Button
                            variant="outline"
                            role="combobox"
                            className="w-full justify-between"
                          >
                            {field.value || t("selectGender")}
                            <ChevronsUpDown className="ml-2 h-4 w-4 shrink-0 opacity-50" />
                          </Button>
                        </PopoverTrigger>
                        <PopoverContent className="w-full p-0">
                          <Command>
                            <CommandInput placeholder={t("searchGender")} />
                            <CommandEmpty>{t("noGenderFound")}</CommandEmpty>
                            <CommandGroup className="max-h-32 overflow-auto">
                              {GENDERS.map((gender) => (
                                <CommandItem
                                  key={gender}
                                  onSelect={() => field.onChange(gender)}
                                >
                                  <Check
                                    className={cn(
                                      "mr-2 h-4 w-4",
                                      field.value === gender ? "opacity-100" : "opacity-0"
                                    )}
                                  />
                                  {gender}
                                </CommandItem>
                              ))}
                            </CommandGroup>
                          </Command>
                        </PopoverContent>
                      </Popover>
                    </FormControl>
                    <FormMessage className="text-red-500 mt-2" />
                  </FormItem>
                )}
              />
            </div>

            {/* Submit Button */}
            <Button
              type="submit"
              className="w-full bg-gradient-to-r from-blue-950 to-blue-700 hover:from-blue-900 hover:to-blue-600 text-white py-6 rounded-md text-lg font-medium border-0"
              disabled={loading}
            >
              {loading ? (
                <span className="flex items-center justify-center">
                  <Loader2 className="animate-spin mr-2 h-5 w-5" />
                  {t("submitting")}
                </span>
              ) : (
                t("startApplyingMyApplication")
              )}
            </Button>

            {/* Show overall form error if any */}
            {Object.keys(formState.errors).length > 0 && (
              <div className="mt-4 p-3 bg-red-50 border border-red-200 rounded-md">
                <p className="text-red-600 font-medium">{t("pleaseFixFollowingErrors")}</p>
                <ul className="list-disc pl-5 mt-1 text-red-500 text-sm">
                  {formState.errors.resume && <li>{formState.errors.resume.message}</li>}
                  {formState.errors.positions && <li>{formState.errors.positions.message}</li>}
                  {formState.errors.locations && <li>{formState.errors.locations.message}</li>}
                </ul>
              </div>
            )}
          </form>
        </Form>
      </div>

      {/* Resume Upload Modal */}
      <ResumeUploadModal
        isOpen={isUploadModalOpen}
        onClose={() => setIsUploadModalOpen(false)}
        onUploadSuccess={handleUploadSuccess}
        onAiEnhance={() => { }}
      />

      {/* Purchase Modal */}
      <Dialog open={showPurchaseModal} onOpenChange={setShowPurchaseModal}>
        <DialogContent className="sm:max-w-[425px]">
          <DialogHeader>
            <DialogTitle className="flex items-center gap-2">
              <Sparkles className="h-5 w-5 text-yellow-400" />
              {t("aiJobApplyRequired")}
            </DialogTitle>
            <DialogDescription className="text-base pt-2">
              {t("aiJobApplyRequiredDesc")}
            </DialogDescription>
          </DialogHeader>
          <DialogFooter className="flex gap-2 sm:gap-0">
            <Button
              variant="outline"
              onClick={() => setShowPurchaseModal(false)}
              className="flex-1 sm:flex-none"
            >
              {t("cancel")}
            </Button>
            <Button
              onClick={handleGoToServiceDetails}
              className="flex-1 sm:flex-none bg-gradient-to-r from-blue-950 to-blue-700 hover:from-blue-900 hover:to-blue-600"
            >
              {t("viewServiceDetails")}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  )
}
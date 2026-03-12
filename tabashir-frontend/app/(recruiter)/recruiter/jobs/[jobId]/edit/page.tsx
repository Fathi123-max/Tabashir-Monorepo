"use client"

import { useState, useEffect } from "react"
import { useForm } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"
import { z } from "zod"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import {
  Form,
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form"
import { Input } from "@/components/ui/input"
import { Textarea } from "@/components/ui/textarea"
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select"
import { toast } from "sonner"
import { useRouter, useParams } from "next/navigation"
import { ArrowLeft, Save, Plus, Loader2 } from "lucide-react"
import Link from "next/link"
import { getRecruiterJobById, updateRecruiterJob } from "@/actions/job"

const jobFormSchema = z.object({
  title: z.string().min(5, "Job title must be at least 5 characters"),
  company: z.string().min(2, "Company name must be at least 2 characters"),
  companyDescription: z.string().min(50, "Company description must be at least 50 characters"),
  jobType: z.enum(["Full Time", "Part Time", "Contract", "Internship"], {
    required_error: "Please select a job type",
  }),
  salaryMin: z.number().min(0, "Minimum salary must be positive"),
  salaryMax: z.number().min(0, "Maximum salary must be positive"),
  location: z.string().min(2, "Location is required"),
  description: z.string().min(100, "Job description must be at least 100 characters"),
  requirements: z.string().min(50, "Requirements must be at least 50 characters"),
  benefits: z.array(z.string()).min(1, "At least one benefit is required"),
  applicationDeadline: z.string().optional(),
  contactEmail: z.string().email("Please enter a valid email"),
  contactPhone: z.string().optional(),
  companyLogo: z.string().url("Please enter a valid URL").optional().or(z.literal("")),
  requiredSkills: z.array(z.string()).min(1, "At least one skill is required"),
  // Additional fields for API
  nationality: z.string().optional(),
  gender: z.enum(["Male", "Female", "Open to all"]).optional(),
  academicQualification: z.string().optional(),
  experience: z.string().optional(),
  languages: z.string().optional(),
  workingHours: z.string().optional(),
  workingDays: z.string().optional(),
  jobDate: z.string().optional(),
  link: z.string().url("Please enter a valid URL").optional().or(z.literal("")),
})

type JobFormData = z.infer<typeof jobFormSchema>

export default function EditJobPage() {
  const [isLoading, setIsLoading] = useState(false)
  const [isLoadingJob, setIsLoadingJob] = useState(true)
  const [skills, setSkills] = useState<string[]>([])
  const [benefits, setBenefits] = useState<string[]>([])
  const [skillInput, setSkillInput] = useState("")
  const [benefitInput, setBenefitInput] = useState("")
  const router = useRouter()
  const params = useParams()
  const jobId = params.jobId as string

  const form = useForm<JobFormData>({
    resolver: zodResolver(jobFormSchema),
    defaultValues: {
      title: "",
      company: "",
      companyDescription: "",
      jobType: "Full Time",
      salaryMin: 0,
      salaryMax: 0,
      location: "",
      description: "",
      requirements: "",
      benefits: [],
      applicationDeadline: "",
      contactEmail: "",
      contactPhone: "",
      companyLogo: "",
      requiredSkills: [],
      nationality: "",
      gender: "Open to all",
      academicQualification: "",
      experience: "",
      languages: "",
      workingHours: "",
      workingDays: "",
      jobDate: "",
      link: "",
    },
  })

  useEffect(() => {
    const loadJob = async () => {
      try {
        const result = await getRecruiterJobById(jobId)
        if (result.success && result.job) {
          const job = result.job

          // Set form values
          form.setValue("title", job.title)
          form.setValue("company", job.company)
          form.setValue("companyDescription", job.companyDescription)
          form.setValue("jobType", job.jobType as any)
          form.setValue("salaryMin", job.salaryMin)
          form.setValue("salaryMax", job.salaryMax)
          form.setValue("location", job.location || "")
          form.setValue("description", job.description)
          form.setValue("requirements", job.requirements)
          form.setValue("benefits", job.benefits)
          form.setValue("contactEmail", job.contactEmail || "")
          form.setValue("contactPhone", job.contactPhone || "")
          form.setValue("companyLogo", job.companyLogo || "")
          form.setValue("requiredSkills", job.requiredSkills)
          form.setValue("applicationDeadline", job.applicationDeadline ? new Date(job.applicationDeadline).toISOString().split('T')[0] : "")

          // Set skills and benefits state
          setSkills(job.requiredSkills)
          setBenefits(job.benefits)

        } else {
          toast.error("Error loading job", {
            description: result.error || "Failed to load job data",
            className: "bg-red-500 text-white",
          })
          router.push("/recruiter/jobs")
        }
      } catch (error) {
        console.error("Error loading job:", error)
        toast.error("Error loading job", {
          description: "Failed to load job data. Please try again.",
          className: "bg-red-500 text-white",
        })
        router.push("/recruiter/jobs")
      } finally {
        setIsLoadingJob(false)
      }
    }

    if (jobId) {
      loadJob()
    }
  }, [jobId, form, router])

  const addSkill = () => {
    if (skillInput.trim() && !skills.includes(skillInput.trim())) {
      const newSkills = [...skills, skillInput.trim()]
      setSkills(newSkills)
      form.setValue("requiredSkills", newSkills)
      setSkillInput("")
    }
  }

  const removeSkill = (skillToRemove: string) => {
    const newSkills = skills.filter(skill => skill !== skillToRemove)
    setSkills(newSkills)
    form.setValue("requiredSkills", newSkills)
  }

  const addBenefit = () => {
    if (benefitInput.trim() && !benefits.includes(benefitInput.trim())) {
      const newBenefits = [...benefits, benefitInput.trim()]
      setBenefits(newBenefits)
      form.setValue("benefits", newBenefits)
      setBenefitInput("")
    }
  }

  const removeBenefit = (benefitToRemove: string) => {
    const newBenefits = benefits.filter(benefit => benefit !== benefitToRemove)
    setBenefits(newBenefits)
    form.setValue("benefits", newBenefits)
  }

  const onSubmit = async (data: JobFormData) => {
    try {
      setIsLoading(true)

      const result = await updateRecruiterJob(jobId, data)

      if (result.success) {
        toast.success("Job updated successfully!", {
          description: "Your job posting has been updated.",
          className: "bg-green-500 text-white",
        })
        router.push("/recruiter/jobs")
      } else {
        toast.error("Error updating job", {
          description: result.error || "There was an error updating your job posting. Please try again.",
          className: "bg-red-500 text-white",
        })
      }
    } catch (error) {
      console.error("Error updating job:", error)
      toast.error("Error updating job", {
        description: "There was an error updating your job posting. Please try again.",
        className: "bg-red-500 text-white",
      })
    } finally {
      setIsLoading(false)
    }
  }

  if (isLoadingJob) {
    return (
      <div className="p-6 max-w-4xl mx-auto">
        <div className="flex items-center justify-center min-h-[400px]">
          <div className="text-center">
            <Loader2 className="h-8 w-8 animate-spin mx-auto mb-4" />
            <p className="text-gray-600">Loading job data...</p>
          </div>
        </div>
      </div>
    )
  }

  return (
    <div className="p-6 max-w-4xl mx-auto">
      <div className="mb-6">
        <Link href="/recruiter/jobs">
          <Button variant="ghost" className="mb-4">
            <ArrowLeft className="h-4 w-4 mr-2" />
            Back to Jobs
          </Button>
        </Link>
        <h1 className="text-2xl font-bold text-gray-900">Edit Job</h1>
        <p className="text-gray-600">Update your job posting details</p>
      </div>

      <Form {...form}>
        <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
          {/* Basic Information */}
          <Card>
            <CardHeader>
              <CardTitle>Basic Information</CardTitle>
              <CardDescription>
                Basic details about the job position
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <FormField
                  control={form.control}
                  name="title"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Job Title</FormLabel>
                      <FormControl>
                        <Input placeholder="e.g., Senior Frontend Developer" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name="company"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Company Name</FormLabel>
                      <FormControl>
                        <Input placeholder="e.g., Tech Corp" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
              </div>

              <FormField
                control={form.control}
                name="companyDescription"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Company Description</FormLabel>
                    <FormControl>
                      <Textarea
                        placeholder="Tell us about your company..."
                        className="min-h-[100px]"
                        {...field}
                      />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />

              <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                <FormField
                  control={form.control}
                  name="jobType"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Job Type</FormLabel>
                      <Select onValueChange={field.onChange} value={field.value}>
                        <FormControl>
                          <SelectTrigger>
                            <SelectValue placeholder="Select job type" />
                          </SelectTrigger>
                        </FormControl>
                        <SelectContent>
                          <SelectItem value="Full Time">Full Time</SelectItem>
                          <SelectItem value="Part Time">Part Time</SelectItem>
                          <SelectItem value="Contract">Contract</SelectItem>
                          <SelectItem value="Internship">Internship</SelectItem>
                        </SelectContent>
                      </Select>
                      <FormMessage />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name="salaryMin"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Minimum Salary</FormLabel>
                      <FormControl>
                        <Input
                          type="number"
                          placeholder="45000"
                          {...field}
                          onChange={(e) => field.onChange(Number(e.target.value))}
                        />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name="salaryMax"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Maximum Salary</FormLabel>
                      <FormControl>
                        <Input
                          type="number"
                          placeholder="65000"
                          {...field}
                          onChange={(e) => field.onChange(Number(e.target.value))}
                        />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
              </div>

              <FormField
                control={form.control}
                name="location"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Location</FormLabel>
                    <FormControl>
                      <Input placeholder="e.g., Remote, New York, London" {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
            </CardContent>
          </Card>

          {/* Job Details */}
          <Card>
            <CardHeader>
              <CardTitle>Job Details</CardTitle>
              <CardDescription>
                Detailed information about the position
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <FormField
                control={form.control}
                name="description"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Job Description</FormLabel>
                    <FormControl>
                      <Textarea
                        placeholder="Describe the job responsibilities and what you're looking for..."
                        className="min-h-[150px]"
                        {...field}
                      />
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
                      <Textarea
                        placeholder="List the requirements for this position..."
                        className="min-h-[100px]"
                        {...field}
                      />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />

              {/* Skills */}
              <div className="space-y-2">
                <label className="text-sm font-medium">Required Skills</label>
                <div className="flex gap-2">
                  <Input
                    placeholder="Add a skill..."
                    value={skillInput}
                    onChange={(e) => setSkillInput(e.target.value)}
                    onKeyPress={(e) => e.key === 'Enter' && (e.preventDefault(), addSkill())}
                  />
                  <Button type="button" onClick={addSkill} variant="outline">
                    <Plus className="h-4 w-4" />
                  </Button>
                </div>
                {skills.length > 0 && (
                  <div className="flex flex-wrap gap-2 mt-2">
                    {skills.map((skill, index) => (
                      <span
                        key={index}
                        className="bg-blue-100 text-blue-800 px-2 py-1 rounded-md text-sm cursor-pointer hover:bg-blue-200"
                        onClick={() => removeSkill(skill)}
                      >
                        {skill} ×
                      </span>
                    ))}
                  </div>
                )}
              </div>

              {/* Benefits */}
              <div className="space-y-2">
                <label className="text-sm font-medium">Benefits</label>
                <div className="flex gap-2">
                  <Input
                    placeholder="Add a benefit..."
                    value={benefitInput}
                    onChange={(e) => setBenefitInput(e.target.value)}
                    onKeyPress={(e) => e.key === 'Enter' && (e.preventDefault(), addBenefit())}
                  />
                  <Button type="button" onClick={addBenefit} variant="outline">
                    <Plus className="h-4 w-4" />
                  </Button>
                </div>
                {benefits.length > 0 && (
                  <div className="flex flex-wrap gap-2 mt-2">
                    {benefits.map((benefit, index) => (
                      <span
                        key={index}
                        className="bg-green-100 text-green-800 px-2 py-1 rounded-md text-sm cursor-pointer hover:bg-green-200"
                        onClick={() => removeBenefit(benefit)}
                      >
                        {benefit} ×
                      </span>
                    ))}
                  </div>
                )}
              </div>
            </CardContent>
          </Card>

          {/* Additional Requirements */}
          <Card>
            <CardHeader>
              <CardTitle>Additional Requirements</CardTitle>
              <CardDescription>
                Additional criteria and preferences for the position
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <FormField
                  control={form.control}
                  name="nationality"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Nationality Preference (Optional)</FormLabel>
                      <FormControl>
                        <Input placeholder="e.g., Open to all, UAE Nationals" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name="gender"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Gender Preference</FormLabel>
                      <Select onValueChange={field.onChange} value={field.value}>
                        <FormControl>
                          <SelectTrigger>
                            <SelectValue placeholder="Select gender preference" />
                          </SelectTrigger>
                        </FormControl>
                        <SelectContent>
                          <SelectItem value="Open to all">Open to all</SelectItem>
                          <SelectItem value="Male">Male</SelectItem>
                          <SelectItem value="Female">Female</SelectItem>
                        </SelectContent>
                      </Select>
                      <FormMessage />
                    </FormItem>
                  )}
                />
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <FormField
                  control={form.control}
                  name="academicQualification"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Academic Qualification (Optional)</FormLabel>
                      <FormControl>
                        <Input placeholder="e.g., Bachelor's Degree, Master's" {...field} />
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
                      <FormLabel>Experience Level (Optional)</FormLabel>
                      <FormControl>
                        <Input placeholder="e.g., 2-5 years, Entry level" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <FormField
                  control={form.control}
                  name="languages"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Languages (Optional)</FormLabel>
                      <FormControl>
                        <Input placeholder="e.g., English, Arabic, French" {...field} />
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
                      <FormLabel>Working Hours (Optional)</FormLabel>
                      <FormControl>
                        <Input placeholder="e.g., 9 AM - 6 PM, Flexible" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <FormField
                  control={form.control}
                  name="workingDays"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Working Days (Optional)</FormLabel>
                      <FormControl>
                        <Input placeholder="e.g., Monday to Friday, 6 days" {...field} />
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
                      <FormLabel>Job Posting Date (Optional)</FormLabel>
                      <FormControl>
                        <Input type="date" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
              </div>

              <FormField
                control={form.control}
                name="link"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>External Link (Optional)</FormLabel>
                    <FormControl>
                      <Input placeholder="https://company.com/careers" {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
            </CardContent>
          </Card>

          {/* Contact Information */}
          <Card>
            <CardHeader>
              <CardTitle>Contact Information</CardTitle>
              <CardDescription>
                How candidates can reach out
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <FormField
                  control={form.control}
                  name="contactEmail"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Contact Email</FormLabel>
                      <FormControl>
                        <Input type="email" placeholder="hr@company.com" {...field} />
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
                      <FormLabel>Contact Phone (Optional)</FormLabel>
                      <FormControl>
                        <Input placeholder="+1 (555) 123-4567" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <FormField
                  control={form.control}
                  name="applicationDeadline"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Application Deadline (Optional)</FormLabel>
                      <FormControl>
                        <Input type="date" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name="companyLogo"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Company Logo URL (Optional)</FormLabel>
                      <FormControl>
                        <Input placeholder="https://example.com/logo.png" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
              </div>
            </CardContent>
          </Card>

          {/* Submit Button */}
          <div className="flex justify-end gap-4">
            <Button
              type="button"
              variant="outline"
              onClick={() => router.push("/recruiter/jobs")}
            >
              Cancel
            </Button>
            <Button
              type="submit"
              disabled={isLoading}
              className="bg-gradient-to-r from-[#042052] to-[#0D57E1] hover:from-[#0D57E1] hover:to-[#042052] text-white"
            >
              {isLoading ? (
                <>
                  <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                  Updating...
                </>
              ) : (
                <>
                  <Save className="h-4 w-4 mr-2" />
                  Update Job
                </>
              )}
            </Button>
          </div>
        </form>
      </Form>
    </div>
  )
} 
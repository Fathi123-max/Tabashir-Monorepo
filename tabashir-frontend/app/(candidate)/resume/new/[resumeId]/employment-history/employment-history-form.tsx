"use client"

import { useState } from "react"
import { useRouter } from "next/navigation"
import { z } from "zod"
import { useForm, useFieldArray } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form"
import { Input } from "@/components/ui/input"
import { Textarea } from "@/components/ui/textarea"
import { Checkbox } from "@/components/ui/checkbox"
import { Button } from "@/components/ui/button"
import { toast } from "sonner"
import { Plus, Trash2, CalendarIcon, Loader2 } from "lucide-react"
import { useResumeStore } from "../../store/resume-store"
import { format } from "date-fns"
import { Calendar } from "@/components/ui/calendar"
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover"
import { cn } from "@/lib/utils"
import { AiEmploymentHistory } from "@prisma/client"
import { onSaveEmploymentHistory } from "@/actions/ai-resume"
import { useCVGenerator } from "../hooks/use-cv-generator"

const jobSchema = z.object({
  jobTitle: z.string().min(2, { message: "Job title is required" }),
  companyName: z.string().min(2, { message: "Company name is required" }),
  city: z.string().min(2, { message: "City is required" }),
  tasks: z.string().min(10, { message: "Please describe your key tasks and responsibilities (minimum 10 characters)" }),
  startDate: z.string().min(2, { message: "Start date is required" }),
  endDate: z.string().optional(),
  isPresent: z.boolean(),
}).refine((data) => {
  if (!data.isPresent && !data.endDate) {
    return false;
  }
  return true;
}, {
  message: "End date is required when not currently working",
  path: ["endDate"],
})

const employmentHistorySchema = z.object({
  jobs: z.array(jobSchema).min(1, { message: "At least one work experience is required" }),
})

type EmploymentHistoryFormValues = z.infer<typeof employmentHistorySchema>

export default function EmploymentHistoryPage({ resumeId, aiResumeEmploymentHistory, userId, hasExistingContent }: { resumeId: string, aiResumeEmploymentHistory: AiEmploymentHistory[], userId: string, hasExistingContent: boolean }) {
  const [isSubmitting, setIsSubmitting] = useState(false)
  const router = useRouter()
  const { setResumeScore, setFormCompleted } = useResumeStore()
  const { generatingCV, handleGenerateCV } = useCVGenerator(resumeId, userId)

  // Initialize form with default values
  const form = useForm<EmploymentHistoryFormValues>({
    resolver: zodResolver(employmentHistorySchema),
    defaultValues: {
      jobs: aiResumeEmploymentHistory.length > 0 ? aiResumeEmploymentHistory.map((job) => ({
        jobTitle: job.position,
        companyName: job.company,
        city: job.city,
        tasks: job.description || "",
        startDate: job.startDate.toISOString().split('T')[0],
        endDate: job.endDate ? job.endDate.toISOString().split('T')[0] : undefined,
        isPresent: job.current,
      })) : [{
        jobTitle: "",
        companyName: "",
        city: "",
        tasks: "",
        startDate: "",
        endDate: "",
        isPresent: false,
      }],
    },
  })

  const { fields, append, remove } = useFieldArray({
    control: form.control,
    name: "jobs",
  })

  const onSubmit = async (data: EmploymentHistoryFormValues) => {
    setIsSubmitting(true)

    try {
      // Format dates to ISO string and add default country for backend compatibility
      const formattedData = {
        jobs: data.jobs.map(job => ({
          ...job,
          country: "", // Default empty country for backend compatibility
          startDate: new Date(job.startDate).toISOString(),
          endDate: job.endDate ? new Date(job.endDate).toISOString() : undefined,
        }))
      };

      const result = await onSaveEmploymentHistory(resumeId, formattedData)

      console.log(result, "Result of employment history")

      if (result.error) {
        toast.error(result.message)
        setIsSubmitting(false)
        return
      }

      // Mark this form as completed
      setFormCompleted("employment-history")

      toast.success("Your work experience has been saved successfully.")

      // Navigate to the next section
      router.push(`/resume/new/${resumeId}/education`)
    } catch (error) {
      toast.error("There was a problem saving your information.")
    } finally {
      setIsSubmitting(false)
    }
  }

  return (
    <div className="space-y-6 rounded-[6px]">
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-xl font-semibold text-gray-800">Work Experience</h2>
        <Button
          type="button"
          size="sm"
          className="bg-gradient-to-r from-[#042052] to-[#0D57E1] hover:opacity-90 text-white h-8 px-3"
          onClick={() =>
            append({
              jobTitle: "",
              companyName: "",
              city: "",
              tasks: "",
              startDate: "",
              endDate: "",
              isPresent: false,
            })
          }
        >
          <Plus size={16} className="mr-1" />
          Add
        </Button>
      </div>

      <Form {...form}>
        <form className="space-y-8" onSubmit={form.handleSubmit(onSubmit)}>
          {fields.map((field, index) => (
            <div key={field.id} className="p-6 border border-gray-200 rounded-md bg-[#FCFCFC] max-w-[680px] mx-auto">
              {index > 0 && (
                <div className="flex justify-between items-center mb-4">
                  <h3 className="font-medium text-gray-700">Experience {index + 1}</h3>
                  <Button
                    type="button"
                    variant="ghost"
                    size="sm"
                    className="text-red-500 hover:text-red-700 hover:bg-red-50 p-1 h-8"
                    onClick={() => remove(index)}
                  >
                    <Trash2 size={16} />
                  </Button>
                </div>
              )}

              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                <FormField
                  control={form.control}
                  name={`jobs.${index}.jobTitle`}
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel className="text-gray-700">Position/Role Title</FormLabel>
                      <FormControl>
                        <Input
                          {...field}
                          className="text-gray-900 placeholder:text-gray-500 border-gray-300"
                          placeholder="e.g., Software Engineer, Marketing Intern, Training Participant"
                        />
                      </FormControl>
                      <FormMessage className="text-red-500" />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name={`jobs.${index}.companyName`}
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel className="text-gray-700">Organization Name</FormLabel>
                      <FormControl>
                        <Input
                          {...field}
                          className="text-gray-900 placeholder:text-gray-500 border-gray-300"
                          placeholder="e.g., ABC Company, XYZ University, Training Institute"
                        />
                      </FormControl>
                      <FormMessage className="text-red-500" />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name={`jobs.${index}.tasks`}
                  render={({ field }) => (
                    <FormItem className="md:col-span-2">
                      <FormLabel className="text-gray-700">Key Tasks & Responsibilities</FormLabel>
                      <FormControl>
                        <Textarea
                          {...field}
                          className="text-gray-900 placeholder:text-gray-500 border-gray-300 min-h-[100px]"
                          placeholder="Describe your main responsibilities, achievements, and tasks in this role..."
                        />
                      </FormControl>
                      <FormMessage className="text-red-500" />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name={`jobs.${index}.city`}
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel className="text-gray-700">City</FormLabel>
                      <FormControl>
                        <Input
                          {...field}
                          className="text-gray-900 placeholder:text-gray-500 border-gray-300"
                          placeholder="Enter city"
                        />
                      </FormControl>
                      <FormMessage className="text-red-500" />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name={`jobs.${index}.startDate`}
                  render={({ field }) => (
                    <FormItem className="flex flex-col">
                      <FormLabel className="text-gray-700">Start Date</FormLabel>
                      <Popover>
                        <PopoverTrigger asChild>
                          <FormControl>
                            <Button
                              variant={"outline"}
                              className={cn(
                                "w-full pl-3 text-left font-normal text-gray-900 border-gray-300",
                                !field.value && "text-gray-500",
                              )}
                            >
                              {field.value ? format(new Date(field.value), "PPP") : <span>Pick a date</span>}
                              <CalendarIcon className="ml-auto h-4 w-4 opacity-50" />
                            </Button>
                          </FormControl>
                        </PopoverTrigger>
                        <PopoverContent className="w-auto p-0" align="start">
                          <Calendar
                            mode="single"
                            selected={field.value ? new Date(field.value) : undefined}
                            onSelect={(date) => field.onChange(date ? format(date, "yyyy-MM-dd") : "")}
                            initialFocus
                          />
                        </PopoverContent>
                      </Popover>
                      <FormMessage className="text-red-500" />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name={`jobs.${index}.endDate`}
                  render={({ field }) => (
                    <FormItem className="space-y-2">
                      <div className="flex items-center justify-between">
                        <FormLabel className="text-gray-700">End Date</FormLabel>

                        <div className="inline-flex items-center space-x-2">
                          <Checkbox
                            id={`present-${index}`}
                            checked={form.watch(`jobs.${index}.isPresent`)}
                            onCheckedChange={(checked) => {
                              form.setValue(`jobs.${index}.isPresent`, !!checked)
                              if (checked) {
                                form.setValue(`jobs.${index}.endDate`, "")
                              }
                            }}
                            className="border-gray-400"
                          />
                          <label htmlFor={`present-${index}`} className="text-sm text-gray-700 cursor-pointer">
                            Present
                          </label>
                        </div>
                      </div>
                      <div className="space-y-2">

                        <Popover>
                          <PopoverTrigger asChild>
                            <FormControl>
                              <Button
                                variant={"outline"}
                                className={cn(
                                  "w-full pl-3 text-left font-normal text-gray-900 border-gray-300",
                                  !field.value && "text-gray-500",
                                  form.watch(`jobs.${index}.isPresent`) && "opacity-50",
                                )}
                                disabled={form.watch(`jobs.${index}.isPresent`)}
                              >
                                {field.value ? format(new Date(field.value), "PPP") : <span>Pick a date</span>}
                                <CalendarIcon className="ml-auto h-4 w-4 opacity-50" />
                              </Button>
                            </FormControl>
                          </PopoverTrigger>
                          <PopoverContent className="w-auto p-0" align="start">
                            <Calendar
                              mode="single"
                              selected={field.value ? new Date(field.value) : undefined}
                              onSelect={(date) => field.onChange(date ? format(date, "yyyy-MM-dd") : "")}
                              initialFocus
                              disabled={form.watch(`jobs.${index}.isPresent`)}
                            />
                          </PopoverContent>
                        </Popover>
                      </div>
                      <FormMessage className="text-red-500" />
                    </FormItem>
                  )}
                />
              </div>
            </div>
          ))}

          <div className="flex justify-end gap-4 mt-8">
            <Button
              type="submit"
              className="bg-gradient-to-r from-[#042052] to-[#0D57E1] hover:opacity-90 text-white"
              disabled={isSubmitting || generatingCV}
            >
              {isSubmitting ? "Saving..." : "Save & Continue"}
            </Button>

            {hasExistingContent && (
              <Button
                type="button"
                variant="outline"
                className="border-[#042052] text-[#042052] hover:bg-[#042052] hover:text-white"
                disabled={isSubmitting || generatingCV}
                onClick={async () => {
                  // Save current form data first
                  const formData = form.getValues();
                  const formattedData = {
                    jobs: formData.jobs.map(job => ({
                      ...job,
                      country: "", // Default empty country for backend compatibility
                      startDate: new Date(job.startDate).toISOString(),
                      endDate: job.endDate ? new Date(job.endDate).toISOString() : undefined,
                    }))
                  };

                  const saveResult = await onSaveEmploymentHistory(resumeId, formattedData);

                  if (saveResult.error) {
                    toast.error(saveResult.message);
                    return;
                  }

                  // Then generate CV with updated data
                  handleGenerateCV();
                }}
              >
                {generatingCV ? (
                  <>
                    <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                    Generating CV...
                  </>
                ) : (
                  "Generate CV"
                )}
              </Button>
            )}
          </div>
        </form>
      </Form>
    </div>
  )
}

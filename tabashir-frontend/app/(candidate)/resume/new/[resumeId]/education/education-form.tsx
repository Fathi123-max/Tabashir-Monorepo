"use client"

import { useState } from "react"
import { useRouter } from "next/navigation"
import { z } from "zod"
import { useForm, useFieldArray } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form"
import { Input } from "@/components/ui/input"
import { Textarea } from "@/components/ui/textarea"
import { Button } from "@/components/ui/button"
import { useToast } from "@/components/ui/use-toast"
import { Plus, Trash2, Sparkles, CalendarIcon, Loader2 } from "lucide-react"
import { useResumeStore } from "../../store/resume-store"
import { format } from "date-fns"
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover"
import { Calendar } from "@/components/ui/calendar"
import { cn } from "@/lib/utils"
import { AiEducation } from "@prisma/client"
import { onSaveEducation } from "@/actions/ai-resume"
import { useCVGenerator } from "../hooks/use-cv-generator"

const educationSchema = z.object({
  id: z.string().optional(),
  school: z.string().min(2, { message: "School name is required" }),
  degree: z.string().min(2, { message: "Degree is required" }),
  startDate: z.string().min(2, { message: "Start date is required" }),
  endDate: z.string().min(2, { message: "End date is required" }),
  city: z.string().min(2, { message: "City is required" }),
  description: z.string().optional(),
})

const educationFormSchema = z.object({
  education: z.array(educationSchema).min(1, { message: "At least one education entry is required" }),
})

type EducationFormValues = z.infer<typeof educationFormSchema>

export default function EducationForm({
  resumeId,
  aiResumeEducation,
  userId,
  hasExistingContent,
}: {
  resumeId: string,
  aiResumeEducation: AiEducation[],
  userId: string,
  hasExistingContent: boolean
}) {

  const [isSubmitting, setIsSubmitting] = useState(false)
  const router = useRouter()
  const { toast } = useToast()
  const { setResumeScore, setFormCompleted } = useResumeStore()
  const { generatingCV, handleGenerateCV } = useCVGenerator(resumeId, userId)

  // Initialize form with default values
  const form = useForm<EducationFormValues>({
    resolver: zodResolver(educationFormSchema),
    defaultValues: {
      education: aiResumeEducation.length > 0 ? aiResumeEducation.map((education) => ({
        school: education.institution,
        degree: education.degree,
        startDate: education.startDate.toISOString(),
        endDate: education.endDate?.toISOString(),
        city: education.city,
        description: education.achievements.join(", "),
      })) : [{
        school: "",
        degree: "",
        startDate: "",
        endDate: "",
        city: "",
        description: "",
      }],
    },
  })

  const { fields, append, remove } = useFieldArray({
    control: form.control,
    name: "education",
  })

  const onSubmit = async (data: EducationFormValues) => {
    setIsSubmitting(true)

    try {
      // Simulate API call to save data
      const response = await onSaveEducation(resumeId, data)

      if (response.error) {
        toast({
          title: "Error",
          description: response.message,
          variant: "destructive",
        })
        return
      }

      // Mark this form as completed
      setFormCompleted("education")

      toast({
        title: "Success",
        description: "Your education information has been saved successfully.",
      })

      // Navigate to the next section
      router.push(`/resume/new/${resumeId}/skills`)
    } catch (error) {
      toast({
        title: "Error",
        description: "There was a problem saving your information.",
        variant: "destructive",
      })
    } finally {
      setIsSubmitting(false)
    }
  }

  const generateDescription = (index: number) => {
    // Simulate AI generation
    setTimeout(() => {
      form.setValue(
        `education.${index}.description`,
        "Graduated with honors in Computer Science. Completed coursework in UI/UX design, front-end development, and user research methodologies. Participated in design thinking workshops and led a team project that won the department's annual innovation award.",
      )
    }, 1000)
  }

  return (
    <div className="space-y-6 rounded-[6px]">
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-xl font-semibold text-gray-800">Education</h2>
        <Button
          type="button"
          size="sm"
          className="bg-[#002B6B] hover:bg-[#042052] text-white h-8 px-3"
          onClick={() =>
            append({
              school: "",
              degree: "",
              startDate: "",
              endDate: "",
              city: "",
              description: "",
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
            <div key={field.id} className="p-6 border border-gray-200 rounded-md">
              {index > 0 && (
                <div className="flex justify-between items-center mb-4">
                  <h3 className="font-medium text-gray-700">Education {index + 1}</h3>
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
                  name={`education.${index}.school`}
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel className="text-gray-700">School</FormLabel>
                      <FormControl>
                        <Input
                          {...field}
                          className="text-gray-900 placeholder:text-gray-500 border-gray-300"
                          placeholder="Enter school or university name"
                        />
                      </FormControl>
                      <FormMessage className="text-red-500" />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name={`education.${index}.degree`}
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel className="text-gray-700">Degree</FormLabel>
                      <FormControl>
                        <Input
                          {...field}
                          className="text-gray-900 placeholder:text-gray-500 border-gray-300"
                          placeholder="Enter degree or certification"
                        />
                      </FormControl>
                      <FormMessage className="text-red-500" />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name={`education.${index}.startDate`}
                  render={({ field }) => (
                    <FormItem>
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
                              {field.value ? (
                                format(new Date(field.value), "PPP")
                              ) : (
                                <span>Pick a date</span>
                              )}
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
                  name={`education.${index}.endDate`}
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel className="text-gray-700">End Date</FormLabel>
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
                              {field.value ? (
                                format(new Date(field.value), "PPP")
                              ) : (
                                <span>Pick a date</span>
                              )}
                              <CalendarIcon className="ml-auto h-4 w-4 opacity-50" />
                            </Button>
                          </FormControl>
                        </PopoverTrigger>
                        <PopoverContent className="w-auto p-0" align="start">
                          <Calendar
                            mode="single"
                            selected={field.value ? new Date(field.value + "-01") : undefined}
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
                  name={`education.${index}.city`}
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
                  name={`education.${index}.description`}
                  render={({ field }) => (
                    <FormItem className="col-span-2">
                      <div className="flex justify-between items-center w-full">
                        <FormLabel className="text-gray-700">Description</FormLabel>
                        {/* <Button
                          type="button"
                          variant="ghost"
                          size="sm"
                          className="text-[#002B6B] hover:text-[#042052] p-1 h-8 flex items-center gap-1"
                          onClick={() => generateDescription(index)}
                        >
                          <Sparkles size={14} className="text-yellow-500" />
                          <span className="text-xs">Generate</span>
                        </Button> */}
                      </div>
                      <FormControl>
                        <Textarea
                          {...field}
                          className="min-h-[100px] text-gray-900 resize-none border-gray-300"
                          placeholder="Describe your education, achievements, and relevant coursework"
                        />
                      </FormControl>
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
                  const saveResult = await onSaveEducation(resumeId, formData);

                  if (saveResult.error) {
                    toast({
                      title: "Error",
                      description: saveResult.message,
                      variant: "destructive",
                    });
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

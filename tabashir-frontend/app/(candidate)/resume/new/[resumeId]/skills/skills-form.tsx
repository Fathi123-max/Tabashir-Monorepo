"use client"

import { useEffect, useState } from "react"
import { useRouter } from "next/navigation"
import { z } from "zod"
import { useForm, useFieldArray } from "react-hook-form"
import { zodResolver } from "@hookform/resolvers/zod"
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage, FormDescription } from "@/components/ui/form"
import { Input } from "@/components/ui/input"
import { Button } from "@/components/ui/button"
import { useToast } from "@/components/ui/use-toast"
import { X, Plus, Loader2 } from "lucide-react"
import { useResumeStore } from "../../store/resume-store"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { AiResumeStatus, AiSkill } from "@prisma/client"
import { changeResumeStatus, onSaveSkills } from "@/actions/ai-resume"
import { getCV } from "@/actions/ai-resume"
import { changeAiResumeStatus, updateAiResumeRawData, uploadAIResume } from "@/actions/resume"
import ResumePayment from "../../../_components/resume-payment"
import { getResumePaymentStatus as getResumePaymentStatusAction } from "@/actions/ai-resume"
import Image from "next/image"
import { cleanupFormattedData } from "../hooks/use-cv-generator"

const skillSchema = z.object({
  name: z.string().min(2, { message: "Skill name is required" }),
  level: z.enum(["BEGINNER", "INTERMEDIATE", "ADVANCED", "EXPERT"], {
    required_error: "Please select a skill level",
  }),
  category: z.string().min(2, { message: "Category is required" }),
})

const skillsFormSchema = z.object({
  skills: z.array(skillSchema).min(1, { message: "At least one skill is required" }),
})

type SkillsFormValues = z.infer<typeof skillsFormSchema>

const skillCategories = [
  "Technical",
  "Soft Skills",
  "Languages",
]

export default function SkillsForm({
  resumeId,
  aiResumeSkills,
  userId,
  paymentCompleted,
}: {
  resumeId: string,
  aiResumeSkills: AiSkill[],
  userId: string,
  paymentCompleted: string | undefined,
}) {
  console.log(resumeId)
  const [isSubmitting, setIsSubmitting] = useState(false)
  const router = useRouter()
  const { toast } = useToast()
  const [isPaymentOpened, setIsPaymentOpened] = useState(false)
  const { setFormCompleted, isPaymentCompleted, setResumeGenerated } = useResumeStore()
  const [generatingCV, setGeneratingCV] = useState(false)
  const [isCheckingPayment, setIsCheckingPayment] = useState(false)
  const token = process.env.NEXT_PUBLIC_API_TOKEN;
  // Initialize form with default values
  const form = useForm<SkillsFormValues>({
    resolver: zodResolver(skillsFormSchema),
    defaultValues: {
      skills: aiResumeSkills.length > 0 ? aiResumeSkills.map((skill) => ({
        name: skill.name,
        level: skill.level || "INTERMEDIATE",
        category: skill.category,
      })) : [{
        name: "",
        level: "INTERMEDIATE",
        category: "Technical",
      }],
    },
  })

  const { fields, append, remove } = useFieldArray({
    control: form.control,
    name: "skills",
  })

  const onSubmit = async (data: SkillsFormValues) => {
    setIsSubmitting(true)

    try {
      const response = await onSaveSkills(resumeId, data)

      if (response.error) {
        toast({
          title: "Error",
          description: response.message,
          variant: "destructive",
        })
        return
      }

      // Mark this form as completed
      setFormCompleted("skills")

      toast({
        title: "Success",
        description: "Your skills have been saved successfully.",
      })

      // Navigate to the next section
      console.log("Generating CV......");

      if (isPaymentCompleted) {
        await handleGenerateCV();
      } else {
        setIsPaymentOpened(true);
      }

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

  const handleGenerateCV = async () => {
    console.log("CV Data fetching......");
    setGeneratingCV(true);
    const data = await getCV(resumeId);

    console.log("CV data:", data);

    if (data.error) {
      toast({
        title: "Error",
        description: data.message,
        variant: "destructive",
      })
      return;
    }

    console.log("Generating CV WITH AI......");

    // Run both requests in parallel
    const [response, responseRawJson] = await Promise.all([
      fetch(`${process.env.NEXT_PUBLIC_BACKEND_URL}/api/v1/resume/format-from-raw`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-API-TOKEN": `${token}`,
        },
        body: JSON.stringify({
          user_id: userId,
          raw_data: JSON.stringify(data.data),
          output_language: "regular"
        }),
      }),
      fetch(`${process.env.NEXT_PUBLIC_BACKEND_URL}/api/v1/resume/format-cv-object`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-API-TOKEN": `${token}`,
        },
        body: JSON.stringify({
          user_id: userId,
          raw_data: JSON.stringify(data.data),
          output_language: "regular"
        }),
      })
    ]);

    // Check if both requests were successful
    if (!response.ok) {
      console.error("Failed to generate CV:", response.status, response.statusText);
      toast({
        title: "Error",
        description: "Failed to generate CV from server",
        variant: "destructive",
      });
      setGeneratingCV(false);
      setIsSubmitting(false);
      setIsPaymentOpened(false);
      return;
    }

    if (!responseRawJson.ok) {
      console.error("Failed to get CV object:", responseRawJson.status, responseRawJson.statusText);
      toast({
        title: "Error",
        description: "Failed to get CV object from server",
        variant: "destructive",
      });
      setGeneratingCV(false);
      setIsSubmitting(false);
      setIsPaymentOpened(false);
      return;
    }

    const file = await response.arrayBuffer();
    const jsonData = await responseRawJson.json();

    const cleanedFormattedResume = cleanupFormattedData(jsonData.formatted_resume)

    await updateAiResumeRawData(resumeId, JSON.stringify(cleanedFormattedResume));
    await changeAiResumeStatus(resumeId, AiResumeStatus.COMPLETED);

    console.log("CV object data:", jsonData);

    if (!file) {
      console.log("Failed to generate CV", file);
      toast({
        title: "Error",
        description: "Failed to generate CV",
        variant: "destructive",
      });
      setGeneratingCV(false);
      setIsSubmitting(false);
      setIsPaymentOpened(false);
      return;
    }

    try {
      // Convert base64 to Blob
      console.log("Converting base64 to Blob......");
      const blob = new Blob([file], { type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' });

      // Create a File object from the Blob
      const namedFile = new File([blob], `resume_${resumeId}.docx`, { type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' });

      // Upload to UploadThing
      const uploadResult = await uploadAIResume(namedFile, resumeId);

      if (uploadResult.error) {
        toast({
          title: "Error",
          description: uploadResult.message,
          variant: "destructive",
        });
        return;
      }

      toast({
        title: "Success",
        description: "CV generated and saved successfully",
      });

      setResumeGenerated(true);

      router.push(`/resume/new/${resumeId}/download`);

    } catch (error) {
      console.error("Error saving formatted resume:", error);
      toast({
        title: "Error",
        description: "Failed to save formatted resume",
        variant: "destructive",
      });
    }
  }

  useEffect(() => {
    if (paymentCompleted) {
      // Waiting for three seconds to make sure the payment is completed
      setIsCheckingPayment(true);
      setTimeout(async () => {
        const isPaymentCompleted = await getResumePaymentStatusAction(resumeId)

        setIsCheckingPayment(false);

        if (isPaymentCompleted.data?.paymentStatus) {
          setIsPaymentOpened(false);
          if (!generatingCV) {
            setIsSubmitting(true);
            await handleGenerateCV();
          }
        }
      }, 3000)
    }
  }, [paymentCompleted]);

  if (generatingCV) {
    return (
      <div className="flex flex-col gap-[28px] justify-center items-center py-[100px]">
        <p className="text-[25.69px] font-semibold">Generating Resume...</p>
        <Image src="/ai_generating.svg" alt="Loading" width={133} height={109} />
      </div>
    )
  }

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-xl font-semibold text-gray-800">Skills</h2>
        <Button
          type="button"
          size="sm"
          className="bg-gradient-to-r from-[#042052] to-[#0D57E1] hover:opacity-90 text-white h-8 px-3"
          onClick={() =>
            append({
              name: "",
              level: "INTERMEDIATE",
              category: "Technical",
            })
          }
        >
          <Plus size={16} className="mr-1" />
          Add Skill
        </Button>
      </div>

      <Form {...form}>
        <form className="space-y-6" onSubmit={form.handleSubmit(onSubmit)}>
          {fields.map((field, index) => (
            <div key={field.id} className="p-6 border border-gray-200 rounded-md bg-[#FCFCFC]">
              {index > 0 && (
                <div className="flex justify-between items-center mb-4">
                  <h3 className="font-medium text-gray-700">Skill {index + 1}</h3>
                  <Button
                    type="button"
                    variant="ghost"
                    size="sm"
                    className="text-red-500 hover:text-red-700 hover:bg-red-50 p-1 h-8"
                    onClick={() => remove(index)}
                  >
                    <X size={16} />
                  </Button>
                </div>
              )}

              <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                <FormField
                  control={form.control}
                  name={`skills.${index}.name`}
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel className="text-gray-700">Skill Name</FormLabel>
                      <FormControl>
                        <Input
                          {...field}
                          className="text-gray-900 placeholder:text-gray-500 border-gray-300"
                          placeholder="e.g., JavaScript, Project Management"
                        />
                      </FormControl>
                      <FormMessage className="text-red-500" />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name={`skills.${index}.category`}
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel className="text-gray-700">Category</FormLabel>
                      <Select onValueChange={field.onChange} defaultValue={field.value}>
                        <FormControl>
                          <SelectTrigger className="text-gray-900 border-gray-300">
                            <SelectValue placeholder="Select category" />
                          </SelectTrigger>
                        </FormControl>
                        <SelectContent>
                          {skillCategories.map((category) => (
                            <SelectItem key={category} value={category}>
                              {category}
                            </SelectItem>
                          ))}
                        </SelectContent>
                      </Select>
                      <FormMessage className="text-red-500" />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name={`skills.${index}.level`}
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel className="text-gray-700">Proficiency Level</FormLabel>
                      <Select onValueChange={field.onChange} defaultValue={field.value}>
                        <FormControl>
                          <SelectTrigger className="text-gray-900 border-gray-300">
                            <SelectValue placeholder="Select level" />
                          </SelectTrigger>
                        </FormControl>
                        <SelectContent>
                          <SelectItem value="BEGINNER">Beginner</SelectItem>
                          <SelectItem value="INTERMEDIATE">Intermediate</SelectItem>
                          <SelectItem value="ADVANCED">Advanced</SelectItem>
                          <SelectItem value="EXPERT">Expert</SelectItem>
                        </SelectContent>
                      </Select>
                      <FormMessage className="text-red-500" />
                    </FormItem>
                  )}
                />
              </div>
            </div>
          ))}

          <div className="flex justify-end mt-8">
            <Button
              type="submit"
              className="bg-gradient-to-r from-[#042052] to-[#0D57E1] hover:opacity-90 text-white"
              disabled={isSubmitting}
            >
              {isSubmitting ? "Saving..." : "Generate CV"}
            </Button>
          </div>
        </form>
      </Form>
      {isCheckingPayment && (
        <div className="flex justify-center items-center gap-3 absolute top-0 left-0 w-full h-full bg-black/80">
          <Loader2 className="w-6 h-6 animate-spin" />
          <p className="text-white text-lg">Checking payment status...</p>
        </div>
      )}
      <ResumePayment resumeId={resumeId} isOpened={isPaymentOpened} />
    </div>
  )
} 
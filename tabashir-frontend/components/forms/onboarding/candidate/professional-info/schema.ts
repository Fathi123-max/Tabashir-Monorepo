import { z } from "zod";

export const candidateProfessionalInfoFormSchema = z.object({
    jobType: z.string().min(1, {
      message: "Please enter the type of job you're looking for",
    }),
    skills: z.array(z.string()).min(1, {
      message: "Please select at least one skill",
    }),
    experience: z.string().min(1, {
      message: "Please select your experience level",
    }),
    education: z.string().min(1, {
      message: "Please select your education level",
    }),
    degree: z.string().min(1, {
      message: "Please select your degree",
    }),
  })
  
export type CandidateProfessionalInfoFormSchemaType = z.infer<typeof candidateProfessionalInfoFormSchema>
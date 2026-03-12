import * as z from "zod"

// Step 1: About form schema
export const aboutFormSchema = z.object({
  jobTitle: z.string().min(1, "Job title is required"),
  company: z.string().min(1, "Company name is required"),
  companyDescription: z.string().min(1, "Company description is required"),
  companyLogo: z.string().min(1, "Company logo is required"),
  jobType: z.string().min(1, "Job type is required"),
  salaryMin: z.string().min(1, "Minimum salary is required"),
  salaryMax: z.string().min(1, "Maximum salary is required"),
  nationality: z.string().min(1, "Nationality is required"),
  gender: z.string().min(1, "Gender is required"),
})

// Step 2: Details form schema
export const detailsFormSchema = z.object({
  location: z.string().optional(),
  requiredSkills: z.array(z.string()).optional(),
  description: z.string().min(1, "Job description is required"),
  requirements: z.string().min(1, "Requirements are required"),
  benefits: z.array(z.string()).min(1, "At least one benefit is required"),
  academicQualification: z.string().min(1, "Academic qualification is required"),
  experience: z.string().min(1, "Experience is required"),
  languages: z.string().min(1, "Languages are required"),
  workingHours: z.string().min(1, "Working hours are required"),
  workingDays: z.string().min(1, "Working days are required"),
})

// Step 3: Application form schema
export const applicationFormSchema = z.object({
  applicationDeadline: z.string().optional(),
  contactEmail: z.string().email("Please enter a valid email").optional().or(z.literal("")),
  contactPhone: z.string().optional(),
  jobDate: z.string().min(1, "Job date is required"),
  link: z.string().url("Please enter a valid URL").optional().or(z.literal("")),
})

// Complete form schema (for preview and submission)
export const jobFormSchema = z.object({
  ...aboutFormSchema.shape,
  ...detailsFormSchema.shape,
  ...applicationFormSchema.shape,
})

import { z } from "zod";

export const aiResumePersonalDetailsSchema = z.object({
    fullName: z.string().min(2, { message: "Full name must be at least 2 characters." }),
    email: z.string().email({ message: "Please enter a valid email address." }),
    phone: z.string().min(6, { message: "Please enter a valid phone number." }),
    country: z.string().min(2, { message: "Country must be at least 2 characters." }),
    city: z.string().min(2, { message: "City must be at least 2 characters." }),
    socialLinks: z.array(
      z.object({
        label: z.string().optional(),
        url: z.string().url({ message: "Please enter a valid URL." }).optional().or(z.literal(""))
      })
    ).max(2, { message: "You can add up to 2 social links" }).optional(),
  })
  

export type AiResumePersonalDetailsSchemaType = z.infer<typeof aiResumePersonalDetailsSchema>;


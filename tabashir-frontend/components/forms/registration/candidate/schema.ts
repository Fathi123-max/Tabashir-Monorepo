import { z } from "zod";

export const registrationFormSchema = z.object({
    email: z.string().email({
      message: "Please enter a valid email address.",
    }),
    username: z.string().min(2, {
      message: "Username must be at least 2 characters.",
    }),
    password: z.string().min(5, {
      message: "Password must be at least 5 characters.",
    }),
  })
  
export type RegistrationFormSchemaType = z.infer<typeof registrationFormSchema>
import { z } from "zod";

export const candidatePersonalInfoFormSchema = z.object({
    phone: z.string().regex(/^(\+9715\d{8}|05\d{8})$/, {
      message: "Please enter a valid UAE phone number (05XXXXXXXX or +9715XXXXXXXX)",
    }),
    nationality: z.string().min(1, {
      message: "Please select your nationality",
    }),
    gender: z.string().min(1, {
      message: "Please select your gender",
    }),
    languages: z.array(z.string()).min(1, {
      message: "Please select at least one language",
    }),
    age: z
      .string()
      .regex(/^\d+$/, {
        message: "Please enter a valid age",
      })
      .refine((val) => parseInt(val) >= 18 && parseInt(val) <= 100, {
        message: "Age must be between 18 and 100",
      }),
    profilePicture: z.string().optional(),
    referralCode: z.string().optional(),
  });


export type CandidatePersonalInfoFormSchemaType = z.infer<typeof candidatePersonalInfoFormSchema>
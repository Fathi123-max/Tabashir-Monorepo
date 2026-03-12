"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { z } from "zod";
import { useForm, useFieldArray } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { useToast } from "@/components/ui/use-toast";
import { useResumeStore } from "@/app/(candidate)/resume/new/store/resume-store";
import {
  aiResumePersonalDetailsSchema,
  AiResumePersonalDetailsSchemaType,
} from "./schema";
import { AiResumePersonalDetails, AiSocialLink } from "@prisma/client";
import { onSavePersonalDetails } from "@/actions/ai-resume";
import { toast } from "sonner";
import { Loader2 } from "lucide-react";
import { useCVGenerator } from "@/app/(candidate)/resume/new/[resumeId]/hooks/use-cv-generator";
const AiResumePersonalDetailsForm = ({
  aiResumePersonalDetails,
  aiResumeId,
  userId,
  hasExistingContent,
}: {
  aiResumePersonalDetails?: AiResumePersonalDetails & { socialLinks: AiSocialLink[] };
  aiResumeId: string;
  userId: string;
  hasExistingContent: boolean;
}) => {
  const [isSubmitting, setIsSubmitting] = useState(false);
  const router = useRouter();
  const { setResumeScore, setFormCompleted } = useResumeStore()
  const { generatingCV, handleGenerateCV } = useCVGenerator(aiResumeId, userId)

  // Initialize form with default values
  const form = useForm<AiResumePersonalDetailsSchemaType>({
    resolver: zodResolver(aiResumePersonalDetailsSchema),
    defaultValues: {
      fullName: aiResumePersonalDetails?.fullName || "",
      email: aiResumePersonalDetails?.email || "",
      phone: aiResumePersonalDetails?.phone || "",
      country: aiResumePersonalDetails?.country || "",
      city: aiResumePersonalDetails?.city || "",
      socialLinks: aiResumePersonalDetails?.socialLinks || [],
    },
  });

  const { fields, append, remove } = useFieldArray({
    control: form.control,
    name: "socialLinks",
  });

  const addSocialLink = () => {
    if (fields.length < 2) {
      append({ label: "", url: "" });
      form.clearErrors(`socialLinks.${fields.length}`);
    }
  };

  const removeSocialLink = (index: number) => {
    remove(index);
  };

  const onSubmit = async (data: AiResumePersonalDetailsSchemaType) => {
    setIsSubmitting(true);

    try {
      const response = await onSavePersonalDetails(aiResumeId, data);
      console.log("response", response);
      if (response.error) {
        toast.error(response.message, {
          className: "bg-red-500 text-white"
        });
        return;
      }
      if (response.data) {
        // Mark this form as completed - use setState to ensure updates
        setFormCompleted("personal-details")
        toast.success(response.message);

        // Navigate to the next section
        router.push(response.redirectTo);
      }
    } catch (error) {
      toast.error("There was a problem saving your information.");
    } finally {
      setIsSubmitting(false);
    }
  };
  return (
    <Form {...form}>
      <form className="space-y-" onSubmit={form.handleSubmit(onSubmit)}>
        <div className="flex flex-col gap-6 max-w-[500px] mx-auto">
          <FormField
            control={form.control}
            name="fullName"
            render={({ field }) => (
              <FormItem>
                <FormLabel className="text-gray-700">Full Name</FormLabel>
                <FormControl>
                  <Input
                    {...field}
                    className="text-gray-900 placeholder:text-gray-500 border-gray-300"
                    placeholder="Enter your full name"
                  />
                </FormControl>
                <FormMessage className="text-red-500" />
              </FormItem>
            )}
          />

          <FormField
            control={form.control}
            name="email"
            render={({ field }) => (
              <FormItem>
                <FormLabel className="text-gray-700">Email</FormLabel>
                <FormControl>
                  <Input
                    {...field}
                    type="email"
                    className="text-gray-900 placeholder:text-gray-500 border-gray-300"
                    placeholder="Enter your email address"
                  />
                </FormControl>
                <FormMessage className="text-red-500" />
              </FormItem>
            )}
          />

          <FormField
            control={form.control}
            name="phone"
            render={({ field }) => (
              <FormItem>
                <FormLabel className="text-gray-700">Phone Number</FormLabel>
                <FormControl>
                  <Input
                    {...field}
                    className="text-gray-900 placeholder:text-gray-500 border-gray-300"
                    placeholder="Enter your phone number"
                  />
                </FormControl>
                <FormMessage className="text-red-500" />
              </FormItem>
            )}
          />

          <div className="flex gap-[34px]">
            <FormField
              control={form.control}
              name="country"
              render={({ field }) => (
                <FormItem className="w-full">
                  <FormLabel className="text-gray-700">Country</FormLabel>
                  <FormControl>
                    <Input
                      {...field}
                      className="text-gray-900 placeholder:text-gray-500 border-gray-300"
                      placeholder="Enter your country"
                    />
                  </FormControl>
                  <FormMessage className="text-red-500" />
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name="city"
              render={({ field }) => (
                <FormItem className="w-full">
                  <FormLabel className="text-gray-700">City</FormLabel>
                  <FormControl>
                    <Input
                      {...field}
                      className="text-gray-900 placeholder:text-gray-500 border-gray-300"
                      placeholder="Enter your city"
                    />
                  </FormControl>
                  <FormMessage className="text-red-500" />
                </FormItem>
              )}
            />
          </div>

          <div className="col-span-2 space-y-4">
            <div className="flex justify-between items-center">
              <h3 className="text-lg font-medium text-gray-700">
                Social Links <span className="text-sm text-gray-500 font-normal">(Optional)</span>
              </h3>
              {fields.length < 2 && (
                <Button
                  type="button"
                  variant="outline"
                  onClick={addSocialLink}
                  className="text-sm text-black"
                >
                  Add Social Link
                </Button>
              )}
            </div>

            {fields.length === 0 && (
              <div className="text-center py-8 border-2 border-dashed border-gray-200 rounded-lg">
                <p className="text-gray-500 mb-4">No social links added yet</p>
                <Button
                  type="button"
                  variant="outline"
                  onClick={addSocialLink}
                  className="text-sm text-black"
                >
                  Add Your First Social Link
                </Button>
              </div>
            )}

            {fields.map((field, index) => (
              <div
                key={field.id}
                className="grid grid-cols-1 md:grid-cols-2 gap-6 p-4 border rounded-lg relative"
              >
                <FormField
                  control={form.control}
                  name={`socialLinks.${index}.label`}
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel className="text-gray-700">Label</FormLabel>
                      <FormControl>
                        <Input
                          {...field}
                          className="text-gray-900 placeholder:text-gray-500 border-gray-300"
                          placeholder="e.g., LinkedIn, Twitter"
                        />
                      </FormControl>
                      <FormMessage className="text-red-500" />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name={`socialLinks.${index}.url`}
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel className="text-gray-700">URL</FormLabel>
                      <FormControl>
                        <Input
                          {...field}
                          className="text-gray-900 placeholder:text-gray-500 border-gray-300"
                          placeholder="https://..."
                        />
                      </FormControl>
                      <FormMessage className="text-red-500" />
                    </FormItem>
                  )}
                />

                <Button
                  type="button"
                  variant="ghost"
                  size="sm"
                  onClick={() => removeSocialLink(index)}
                  className="absolute top-2 right-2 text-gray-500 hover:text-red-500"
                >
                  Remove
                </Button>
              </div>
            ))}
          </div>
        </div>

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
                const saveResult = await onSavePersonalDetails(aiResumeId, formData);

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
  );
};

export default AiResumePersonalDetailsForm;

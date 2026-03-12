"use client";
import React from "react";
import { useState } from "react";
import { ChevronDown, X } from "lucide-react";
import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import * as z from "zod";
import { Button } from "@/components/ui/button";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { UploadButton } from "@/lib/uploadthing";
import { useRouter } from "next/navigation";
import { countryList } from "@/app/utils/country-list";
import {
  candidatePersonalInfoFormSchema,
  CandidatePersonalInfoFormSchemaType,
} from "./schema";
import Image from "next/image";
import { onCandidatePersonalInfoOnboarding } from "@/actions/auth";
import { toast } from "sonner";
const CandidatePersonalInfoForm = ({
  profilePicture,
}: {
  profilePicture?: string;
}) => {
  const [isLoading, setIsloading] = useState(false);
  const [selectedLanguages, setSelectedLanguages] = useState<string[]>([]);
  const [profilePictureUrl, setProfilePictureUrl] = useState<string>(
    profilePicture || ""
  );
  const router = useRouter();

  const form = useForm<CandidatePersonalInfoFormSchemaType>({
    resolver: zodResolver(candidatePersonalInfoFormSchema),
    defaultValues: {
      phone: "",
      nationality: "",
      gender: "",
      languages: selectedLanguages,
      age: "",
      profilePicture: profilePicture || "",
      referralCode: "",
    },
  });

  const removeLanguage = (language: string) => {
    const newLanguages = selectedLanguages.filter((lang) => lang !== language);
    setSelectedLanguages(newLanguages);
    form.setValue("languages", newLanguages);
  };

  async function onSubmit(values: CandidatePersonalInfoFormSchemaType) {
    try {
      setIsloading(true);
      const response = await onCandidatePersonalInfoOnboarding(values);

      if (response.error) {
        toast.error(response.message, {
          className: "bg-red-500 text-white",
        });
      }
      toast.success(response.message, {
        className: "bg-green-500 text-white",
      });
      router.push(response.redirectTo as string);
    } catch (error) {
      console.error("Error saving personal information:", error);
    } finally {
      setIsloading(false);
    }
  }

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
        <FormField
          control={form.control}
          name="phone"
          render={({ field }) => (
            <FormItem>
              <FormLabel className="text-gray-900">Phone</FormLabel>
              <FormControl>
                <Input
                  placeholder="+971 - 5X XXX XXXX"
                  {...field}
                  className="text-gray-900"
                />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />

        <FormField
          control={form.control}
          name="nationality"
          render={({ field }) => (
            <FormItem>
              <FormLabel className="text-gray-900">Nationality</FormLabel>
              <Select onValueChange={field.onChange} defaultValue={field.value}>
                <FormControl>
                  <SelectTrigger className="text-gray-900">
                    <SelectValue placeholder="Select your nationality" />
                  </SelectTrigger>
                </FormControl>
                <SelectContent>
                  {countryList.map((country) => (
                    <>
                      <SelectItem value={country.name}>
                        {country.name}
                      </SelectItem>
                    </>
                  ))}
                </SelectContent>
              </Select>
              <FormMessage />
            </FormItem>
          )}
        />

        <FormField
          control={form.control}
          name="gender"
          render={({ field }) => (
            <FormItem>
              <FormLabel className="text-gray-900">Gender</FormLabel>
              <Select onValueChange={field.onChange} defaultValue={field.value}>
                <FormControl>
                  <SelectTrigger className="text-gray-900">
                    <SelectValue placeholder="Select Gender" />
                  </SelectTrigger>
                </FormControl>
                <SelectContent>
                  <SelectItem value="male">Male</SelectItem>
                  <SelectItem value="female">Female</SelectItem>
                  <SelectItem value="other">Other</SelectItem>
                </SelectContent>
              </Select>
              <FormMessage />
            </FormItem>
          )}
        />

        <FormField
          control={form.control}
          name="languages"
          render={({ field }) => (
            <FormItem>
              <FormLabel className="text-gray-900">Language</FormLabel>
              <Select
                onValueChange={(value) => {
                  if (!selectedLanguages.includes(value)) {
                    const newLanguages = [...selectedLanguages, value];
                    setSelectedLanguages(newLanguages);
                    field.onChange(newLanguages);
                  }
                }}
              >
                <FormControl>
                  <SelectTrigger className="text-gray-900">
                    <SelectValue placeholder="Choose your languages" />
                  </SelectTrigger>
                </FormControl>
                <SelectContent>
                  <SelectItem value="English">English</SelectItem>
                  <SelectItem value="Arabic">Arabic</SelectItem>
                  <SelectItem value="French">French</SelectItem>
                  <SelectItem value="Spanish">Spanish</SelectItem>
                  <SelectItem value="German">German</SelectItem>
                  <SelectItem value="Italian">Italian</SelectItem>
                  <SelectItem value="Portuguese">Portuguese</SelectItem>
                  <SelectItem value="Russian">Russian</SelectItem>
                  <SelectItem value="Chinese">Chinese</SelectItem>
                  <SelectItem value="Japanese">Japanese</SelectItem>
                  <SelectItem value="Korean">Korean</SelectItem>
                  <SelectItem value="Hindi">Hindi</SelectItem>
                  <SelectItem value="Turkish">Turkish</SelectItem>
                  <SelectItem value="Dutch">Dutch</SelectItem>
                  <SelectItem value="Swedish">Swedish</SelectItem>
                  <SelectItem value="Polish">Polish</SelectItem>
                  <SelectItem value="Greek">Greek</SelectItem>
                  <SelectItem value="Hebrew">Hebrew</SelectItem>
                  <SelectItem value="Thai">Thai</SelectItem>
                  <SelectItem value="Vietnamese">Vietnamese</SelectItem>
                </SelectContent>
              </Select>
              <div className="flex flex-wrap gap-2 mt-2">
                {selectedLanguages.map((language) => (
                  <div
                    key={language}
                    className="flex items-center bg-blue-100 text-blue-800 text-xs px-2 py-1 rounded"
                  >
                    {language}
                    <button
                      type="button"
                      onClick={() => removeLanguage(language)}
                      className="ml-1 text-blue-600 hover:text-blue-800"
                    >
                      <X size={14} />
                    </button>
                  </div>
                ))}
              </div>
              <FormMessage />
            </FormItem>
          )}
        />

        <FormField
          control={form.control}
          name="age"
          render={({ field }) => (
            <FormItem>
              <FormLabel className="text-gray-900">Age</FormLabel>
              <FormControl>
                <Input
                  placeholder="Enter your age in years"
                  {...field}
                  className="text-gray-900"
                />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />

        <FormField
          control={form.control}
          name="referralCode"
          render={({ field }) => (
            <FormItem>
              <FormLabel className="text-gray-900">Referral Code</FormLabel>
              <FormControl>
                <Input
                  placeholder="Enter your referral code (optional)"
                  {...field}
                  className="text-gray-900"
                />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />

        <FormField
          control={form.control}
          name="profilePicture"
          render={({ field }) => (
            <FormItem>
              <FormLabel className="text-gray-900">Profile Picture</FormLabel>
              <div className="flex items-center mt-2">
                <div className="w-16 h-16 bg-gray-200 rounded-full flex items-center justify-center overflow-hidden">
                  {profilePictureUrl ? (
                    <Image
                      src={profilePictureUrl}
                      alt="Profile picture"
                      width={64}
                      height={64}
                      className="w-full h-full object-cover shadow-md"
                    />
                  ) : (
                    <svg
                      className="w-8 h-8 text-gray-400"
                      fill="none"
                      stroke="currentColor"
                      viewBox="0 0 24 24"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        strokeWidth="2"
                        d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"
                      ></path>
                    </svg>
                  )}
                </div>

                {!profilePicture && (
                  <div className="ml-5">
                    <UploadButton
                      endpoint="profilePictureUploader"
                      onClientUploadComplete={(res) => {
                        if (res?.[0]) {
                          setProfilePictureUrl(res[0].url);
                          form.setValue("profilePicture", res[0].url);
                        }
                      }}
                      onUploadError={(error: Error) => {
                        console.error(
                          "Error uploading profile picture:",
                          error
                        );
                      }}
                      className="border-[3px] border-dashed border-blue-950 py-2 px-3 rounded-md [&]:*:text-black"
                    />
                  </div>
                )}
              </div>
              <FormMessage />
            </FormItem>
          )}
        />

        <Button
          type="submit"
          className="w-full bg-gradient-to-r from-[#042052] to-[#0D57E1] text-white hover:opacity-90"
          disabled={isLoading}
        >
          {isLoading ? "Please wait..." : " Next"}
        </Button>
      </form>
    </Form>
  );
};

export default CandidatePersonalInfoForm;

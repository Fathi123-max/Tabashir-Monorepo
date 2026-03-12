"use client";

import { useState } from "react";
import { Eye, EyeOff } from "lucide-react";
import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
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
import { toast } from "sonner";
import { useRouter } from "next/navigation";
import { recruiterRegistrationFormSchema, RecruiterRegistrationFormSchemaType } from "./schema";
import { onRecruiterRegistration } from "@/actions/auth";

export default function RecruiterRegistrationForm() {
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const router = useRouter();

  const form = useForm<RecruiterRegistrationFormSchemaType>({
    resolver: zodResolver(recruiterRegistrationFormSchema),
    defaultValues: {
      companyName: "",
      email: "",
      contactPersonName: "",
      phone: "",
      password: "",
      confirmPassword: "",
    },
  });

  async function onSubmit(values: RecruiterRegistrationFormSchemaType) {
    try {
      setIsLoading(true);

      const response = await onRecruiterRegistration(values);

      if (response?.error) {
        toast.error("Registration failed", {
          description: response.message,
          className: "bg-red-500 text-white",
        });
        return;
      }

      toast.success("Registration successful!", {
        description: response.message,
        className: "bg-green-500 text-white",
      });

      router.push(response.redirectTo as string);
    } catch (error) {
      console.error("Registration error:", error);
      toast.error("Registration failed", {
        description: "There was an error creating your account. Please try again.",
        className: "bg-red-500 text-white",
      });
    } finally {
      setIsLoading(false);
    }
  }

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
        <FormField
          control={form.control}
          name="companyName"
          render={({ field }) => (
            <FormItem>
              <FormLabel className="text-gray-900">Company Name</FormLabel>
              <FormControl>
                <Input
                  placeholder="Your Company Name"
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
          name="email"
          render={({ field }) => (
            <FormItem>
              <FormLabel className="text-gray-900">Email Address</FormLabel>
              <FormControl>
                <Input
                  type="email"
                  placeholder="company@example.com"
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
          name="contactPersonName"
          render={({ field }) => (
            <FormItem>
              <FormLabel className="text-gray-900">Contact Person Name</FormLabel>
              <FormControl>
                <Input
                  placeholder="Your Full Name"
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
          name="phone"
          render={({ field }) => (
            <FormItem>
              <FormLabel className="text-gray-900">Phone Number</FormLabel>
              <FormControl>
                <Input
                  type="tel"
                  placeholder="+1 (555) 123-4567"
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
          name="password"
          render={({ field }) => (
            <FormItem>
              <FormLabel className="text-gray-900">Password</FormLabel>
              <FormControl>
                <div className="relative">
                  <Input
                    type={showPassword ? "text" : "password"}
                    placeholder="Create a password"
                    {...field}
                    className="text-gray-900"
                  />
                  <Button
                    type="button"
                    variant="ghost"
                    size="sm"
                    className="absolute inset-y-0 right-0 flex items-center px-3"
                    onClick={() => setShowPassword(!showPassword)}
                  >
                    {showPassword ? (
                      <EyeOff className="w-5 h-5 text-gray-400" />
                    ) : (
                      <Eye className="w-5 h-5 text-gray-400" />
                    )}
                  </Button>
                </div>
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />

        <FormField
          control={form.control}
          name="confirmPassword"
          render={({ field }) => (
            <FormItem>
              <FormLabel className="text-gray-900">Confirm Password</FormLabel>
              <FormControl>
                <div className="relative">
                  <Input
                    type={showConfirmPassword ? "text" : "password"}
                    placeholder="Confirm your password"
                    {...field}
                    className="text-gray-900"
                  />
                  <Button
                    type="button"
                    variant="ghost"
                    size="sm"
                    className="absolute inset-y-0 right-0 flex items-center px-3"
                    onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                  >
                    {showConfirmPassword ? (
                      <EyeOff className="w-5 h-5 text-gray-400" />
                    ) : (
                      <Eye className="w-5 h-5 text-gray-400" />
                    )}
                  </Button>
                </div>
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />

        <Button
          type="submit"
          className="w-full bg-gradient-to-r from-[#042052] to-[#0D57E1] text-white hover:opacity-90"
          disabled={isLoading}
        >
          {isLoading ? "Creating Account..." : "Create Account"}
        </Button>
      </form>
    </Form>
  );
} 
"use client";

import Image from "next/image";
import Link from "next/link";
import { useState, useEffect } from "react";
import { Eye, EyeOff } from "lucide-react";
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
import { onLogin } from "@/actions/auth";
import { toast } from "sonner";
import { useRouter, useSearchParams } from "next/navigation";
import {
  candidateLoginFormSchema,
  CandidateLoginFormSchemaType,
} from "./schema";
import { resendVerificationEmail } from "@/actions/auth";

const CandidateLoginForm = () => {
  const [showPassword, setShowPassword] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [showResendVerification, setShowResendVerification] = useState(false);
  const [userEmail, setUserEmail] = useState("");
  const router = useRouter();
  const searchParams = useSearchParams();

  const form = useForm<CandidateLoginFormSchemaType>({
    resolver: zodResolver(candidateLoginFormSchema),
    defaultValues: {
      email: "",
      password: "",
    },
  });

  useEffect(() => {
    // Check for success/error messages from email verification
    const success = searchParams.get("success");
    const error = searchParams.get("error");

    if (success) {
      toast.success("Email Verified", {
        description: decodeURIComponent(success),
      });
    }

    if (error) {
      let errorMessage = "An error occurred";
      if (error === "missing-token") {
        errorMessage = "Invalid verification link";
      } else if (error === "verification-failed") {
        errorMessage = "Email verification failed";
      } else {
        errorMessage = decodeURIComponent(error);
      }

      toast.error("Verification Error", {
        description: errorMessage,
        className: "bg-red-500 text-white",
      });
    }
  }, [searchParams]);

  async function onSubmit(values: CandidateLoginFormSchemaType) {
    try {
      setIsLoading(true);
      setShowResendVerification(false);

      // Get redirect parameter BEFORE login (in case URL changes)
      const redirectParam = searchParams.get("redirect");
      console.log("Redirect parameter from URL:", redirectParam);
      console.log("Current URL:", window.location.href);

      const response = await onLogin({
        email: values.email.toLowerCase(),
        password: values.password,
      });

      console.log("Login response: ", response);

      if (response?.error) {
        if (response.needsVerification) {
          setShowResendVerification(true);
          setUserEmail(response.email);
        }

        return toast.error("Authentication Error", {
          description: response.message,
          className: "bg-red-500 text-white",
        });
      }

      toast.success(response.message);

      // Use redirect parameter if available and valid, otherwise use default redirectTo from response
      let redirectTo: string;
      if (redirectParam && redirectParam.trim() !== "") {
        try {
          redirectTo = decodeURIComponent(redirectParam);
          // Validate that it's a valid path
          if (!redirectTo.startsWith("/")) {
            redirectTo = `/${redirectTo}`;
          }
        } catch (e) {
          console.error("Error decoding redirect parameter:", e);
          redirectTo = response.redirectTo as string;
        }
      } else {
        redirectTo = response.redirectTo as string;
      }

      console.log("Final redirect destination:", redirectTo);
      router.push(redirectTo);
    } catch (error) {
      console.error("Login error:", error);
    } finally {
      setIsLoading(false);
    }
  }

  async function handleResendVerification() {
    try {
      setIsLoading(true);
      const response = await resendVerificationEmail(userEmail);

      if (response.error) {
        toast.error("Error", {
          description: response.message,
          className: "bg-red-500 text-white",
        });
      } else {
        toast.success("Email Sent", {
          description: response.message,
        });
        setShowResendVerification(false);
      }
    } catch (error) {
      console.error("Resend verification error:", error);
      toast.error("Error", {
        description: "Failed to resend verification email",
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
          name="email"
          render={({ field }) => (
            <FormItem>
              <FormLabel className="text-gray-900">Email</FormLabel>
              <FormControl>
                <Input
                  placeholder="User@gmail.com"
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
              <div className="flex justify-between">
                <FormLabel className="text-gray-900">Password</FormLabel>
                <Link
                  href="/forgot-password"
                  className="text-sm text-blue-600 hover:text-blue-800"
                >
                  Forgot?
                </Link>
              </div>
              <FormControl>
                <div className="relative">
                  <Input
                    type={showPassword ? "text" : "password"}
                    placeholder="Enter your password"
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

        {showResendVerification && (
          <div className="p-4 bg-yellow-50 border border-yellow-200 rounded-md">
            <p className="text-sm text-yellow-800 mb-3">
              Your email address is not verified. Please verify your email before logging in.
            </p>
            <div className="flex gap-2">
              <Button
                type="button"
                variant="outline"
                size="sm"
                onClick={handleResendVerification}
                disabled={isLoading}
              >
                {isLoading ? "Sending..." : "Resend Email"}
              </Button>
              <Button
                type="button"
                variant="outline"
                size="sm"
                asChild
              >
                <Link href="/candidate/verify-email">
                  Verification Page
                </Link>
              </Button>
            </div>
          </div>
        )}

        <div className="flex justify-between items-baseline space-y-4 gap-4">
          <Button
            type="submit"
            className="w-full bg-gradient-to-r from-[#042052] to-[#0D57E1] text-white hover:opacity-90"
            disabled={isLoading}
          >
            {isLoading ? "Logging in..." : "Login"}
          </Button>
          <Button variant={"outline"} className="w-full text-black" asChild>
            <Link href={"/candidate/registration"}>Create Account</Link>
          </Button>
        </div>
      </form>
    </Form>
  );
};

export default CandidateLoginForm;

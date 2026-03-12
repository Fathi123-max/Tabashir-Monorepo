"use client";

import Image from "next/image";
import Link from "next/link";
import { useState } from "react";
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
import { toast } from "sonner";
import { useRouter } from "next/navigation";
import { onLogin } from "@/actions/auth";

const formSchema = z.object({
  email: z.string().email({
    message: "Please enter a valid email address.",
  }),
  password: z.string().min(8, {
    message: "Password must be at least 8 characters.",
  }),
});

export default function RecruiterLogin() {
  const [showPassword, setShowPassword] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const router = useRouter();

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      email: "",
      password: "",
    },
  });

  async function onSubmit(values: z.infer<typeof formSchema>) {
    try {
      setIsLoading(true);

      const response = await onLogin({ email: values.email, password: values.password });

      if (response?.error) {
        toast.error("Authentication Error", {
          description: response.message,
          className: "bg-red-500 text-white",
        });
        return;
      }

      toast.success("Successfully logged in", {
        className: "bg-green-500 text-white",
      });

      router.push(response.redirectTo as string);
    } catch (error) {
      console.error("Login error:", error);
      toast.error("Authentication Error", {
        description: "Invalid credentials. Please try again.",
        className: "bg-red-500 text-white",
      });
    } finally {
      setIsLoading(false);
    }
  }

  return (
    <div className="grid lg:grid-cols-2 min-h-screen w-full">
      <div className="flex flex-col justify-center px-8 py-12 sm:px-3 mx-auto w-[500px] max-w-full max-sm:w-full">
        <div className="mb-8">
          <h1 className="text-2xl font-bold text-gray-900">Recruiter Login</h1>
          <p className="mt-2 text-sm text-gray-600">
            Sign in to your account to manage job postings and find candidates
          </p>
        </div>

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

            <Button
              type="submit"
              className="w-full bg-gradient-to-r from-[#042052] to-[#0D57E1] text-white hover:opacity-90"
              disabled={isLoading}
            >
              {isLoading ? "Logging in..." : "Login to Dashboard"}
            </Button>
          </form>
        </Form>

        <div className="mt-6 text-center text-sm">
          <span className="text-gray-500">Don't have an account? </span>
          <Link
            href="/recruiter/register"
            className="text-[#002B6B] font-medium hover:underline"
          >
            Sign up
          </Link>
        </div>
      </div>

      <div className="hidden lg:flex flex-col items-center justify-center w-full bg-[#E6F0FA]">
        <div className="max-w-lg px-8 text-center">
          <h2 className="text-3xl font-bold text-center mb-2 text-black">
            TABASHIR
          </h2>
          <h3 className="text-4xl font-bold text-[#002B6B] mb-4">
            Recruiter Portal
          </h3>
          <p className="text-lg mb-8 text-black">
            Access your dashboard to manage job postings and find the best talent
          </p>

          <Image
            src="https://hebbkx1anhila5yf.public.blob.vercel-storage.com/candidate_login_image-sPDvrtKbYeiNB32TJrUNmswgRxGoHN.svg"
            alt="Recruiter dashboard illustration"
            width={500}
            height={400}
            priority
            className="mx-auto"
          />
        </div>
      </div>
    </div>
  );
} 
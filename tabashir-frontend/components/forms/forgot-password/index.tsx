"use client";

import { useState } from "react";
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
import { onForgotPassword } from "@/actions/auth";

interface ForgotPasswordFormData {
  email: string;
}

const ForgotPasswordForm = () => {
  const [isLoading, setIsLoading] = useState(false);
  const router = useRouter();

  const form = useForm<ForgotPasswordFormData>({
    defaultValues: {
      email: "",
    },
  });

  async function onSubmit(values: ForgotPasswordFormData) {
    if (!values.email || !values.email.includes('@')) {
      form.setError('email', { message: 'Please enter a valid email address' });
      return;
    }

    try {
      setIsLoading(true);
      const response = await onForgotPassword(values.email);

      if (response?.error) {
        return toast.error("Error", {
          description: response.message,
          className: "bg-red-500 text-white",
        });
      }

      toast.success("Password reset link sent", {
        description: "Please check your email for the reset link",
      });
      // router.push("/candidate/login");
    } catch (error) {
      console.error("Forgot password error:", error);
      toast.error("Something went wrong", {
        description: "Please try again later",
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
                  placeholder="Enter your email"
                  {...field}
                  className="text-gray-900"
                />
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
          {isLoading ? "Sending..." : "Send Reset Link"}
        </Button>
      </form>
    </Form>
  );
};

export default ForgotPasswordForm; 
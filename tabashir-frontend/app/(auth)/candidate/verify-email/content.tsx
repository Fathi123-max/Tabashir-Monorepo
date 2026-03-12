"use client"

import { useState, useEffect } from "react";
import { useSearchParams } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { resendVerificationEmail } from "@/actions/auth";
import { toast } from "sonner";
import Link from "next/link";
import { Mail, ArrowLeft } from "lucide-react";

export default function VerifyEmailContent() {
  const searchParams = useSearchParams();
  const emailFromUrl = searchParams.get("email");

  const [email, setEmail] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const [emailSent, setEmailSent] = useState(false);
  const [showResendForm, setShowResendForm] = useState(false);

  useEffect(() => {
    if (emailFromUrl) {
      setEmail(emailFromUrl);
      setEmailSent(true); // Show success message immediately if email is provided
    }
  }, [emailFromUrl]);

  async function handleResendVerification() {
    if (!email) {
      toast.error("Please enter your email address");
      return;
    }

    try {
      setIsLoading(true);
      const response = await resendVerificationEmail(email);

      if (response.error) {
        toast.error("Error", {
          description: response.message,
          className: "bg-red-500 text-white",
        });
      } else {
        setEmailSent(true);
        toast.success("Email Sent", {
          description: response.message,
        });
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
    <div className="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-md w-full space-y-8">
        <div>
          <Link
            href="/candidate/login"
            className="inline-flex items-center text-sm text-blue-600 hover:text-blue-800 mb-4"
          >
            <ArrowLeft className="w-4 h-4 mr-1" />
            Back to Login
          </Link>
        </div>

        <Card>
          <CardHeader className="text-center">
            <div className="flex justify-center mb-4">
              <div className="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center">
                <Mail className="w-8 h-8 text-blue-600" />
              </div>
            </div>
            <CardTitle className="text-2xl">Email Verification</CardTitle>
            <CardDescription>
              {emailFromUrl && emailSent
                ? `We've sent a verification email to ${emailFromUrl}`
                : emailSent
                  ? "We've sent a new verification email to your address"
                  : "Enter your email address to resend the verification link"
              }
            </CardDescription>
          </CardHeader>

          <CardContent className="space-y-4">
            {emailSent && !showResendForm ? (
              <div className="text-center space-y-4">
                <div className="p-4 bg-green-50 border border-green-200 rounded-lg">
                  <p className="text-green-800 text-sm">
                    Check your inbox and click the verification link to complete your registration.
                  </p>
                </div>

                <div className="space-y-2">
                  {emailFromUrl ? (
                    <Button
                      onClick={() => {
                        setShowResendForm(true);
                        setEmailSent(false);
                      }}
                      variant="outline"
                      className="w-full"
                    >
                      Resend Verification Email
                    </Button>
                  ) : (
                    <Button
                      onClick={() => setEmailSent(false)}
                      variant="outline"
                      className="w-full"
                    >
                      Send to Different Email
                    </Button>
                  )}

                  <Button asChild className="w-full bg-gradient-to-r from-[#042052] to-[#0D57E1] text-white hover:opacity-90">
                    <Link href="/candidate/login">
                      Go to Login
                    </Link>
                  </Button>
                </div>
              </div>
            ) : (
              <div className="space-y-4">
                <div>
                  <label htmlFor="email" className="block text-sm font-medium text-gray-700 mb-1">
                    Email Address
                  </label>
                  <Input
                    id="email"
                    type="email"
                    placeholder="Enter your email address"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    className="w-full"
                  />
                </div>

                <Button
                  onClick={handleResendVerification}
                  disabled={isLoading}
                  className="w-full bg-gradient-to-r from-[#042052] to-[#0D57E1] text-white hover:opacity-90"
                >
                  {isLoading ? "Sending..." : "Resend Verification Email"}
                </Button>

                <div className="text-center">
                  <p className="text-sm text-gray-600">
                    Already verified?{" "}
                    <Link href="/candidate/login" className="text-blue-600 hover:text-blue-800">
                      Sign in here
                    </Link>
                  </p>
                </div>
              </div>
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  );
}

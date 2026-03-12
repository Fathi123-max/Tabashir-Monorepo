"use client"
import React from "react";
import { useState } from "react";
import { Eye, EyeOff } from "lucide-react";
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
import { registrationFormSchema, RegistrationFormSchemaType } from "./schema";
import { onCandidateRegistration } from "@/actions/auth";
import { toast } from "sonner";
import { useRouter } from "next/navigation";
import { useTranslation } from "@/lib/use-translation";

const RegistrationForm = () => {
  const [showPassword, setShowPassword] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [showSuccessMessage, setShowSuccessMessage] = useState(false);
  const router = useRouter()
  const { t, isRTL } = useTranslation();

  const form = useForm<RegistrationFormSchemaType>({
    defaultValues: {
      email: "",
      username: "",
      password: "",
    },
  });

  async function onSubmit(values: RegistrationFormSchemaType) {
    try {
      setIsLoading(true)
      setShowSuccessMessage(false)

      const response = await onCandidateRegistration(values)

      if (response?.error) {
        return toast.error(t('registrationError'), {
          description: response.message,
          className: "bg-red-500 text-white",
        })
      } else {
        setShowSuccessMessage(true)
        toast.success(t('registrationSuccessful'), {
          description: response.message,
        })
        setTimeout(() => {
          router.push(`/candidate/verify-email?email=${encodeURIComponent(values.email)}`)
        }, 2000)
      }
    } catch (error) {
      toast.error(t('error'), {
        description: t('somethingWentWrong'),
      })
    } finally {
      setIsLoading(false)
    }
  }

  return (
    <div className={`w-full max-w-md mx-auto space-y-6 ${isRTL ? 'text-right' : ''}`}>
      <div className="space-y-2 text-center">
        <h1 className="text-3xl font-bold">{t('createAccount')}</h1>
        <p className="text-gray-500 dark:text-gray-400">
          {t('enterDetailsToCreateAccount')}
        </p>
      </div>

      {showSuccessMessage && (
        <div className="bg-green-50 border border-green-200 rounded-lg p-4">
          <div className="flex">
            <div className="flex-shrink-0">
              <svg className="h-5 w-5 text-green-400" viewBox="0 0 20 20" fill="currentColor">
                <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
              </svg>
            </div>
            <div className={`${isRTL ? 'mr-3' : 'ml-3'}`}>
              <h3 className="text-sm font-medium text-green-800">
                {t('accountCreatedSuccessfully')}
              </h3>
              <div className="mt-2 text-sm text-green-700">
                <p>{t('checkEmailForVerification')}</p>
              </div>
            </div>
          </div>
        </div>
      )}

      <Form {...form}>
        <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-4">
          <FormField
            control={form.control}
            name="email"
            render={({ field }) => (
              <FormItem>
                <FormLabel className={isRTL ? 'block text-right' : ''}>{t('email')}</FormLabel>
                <FormControl>
                  <Input
                    placeholder={t('enterYourEmail')}
                    type="email"
                    {...field}
                    className={isRTL ? 'text-right' : ''}
                  />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />

          <FormField
            control={form.control}
            name="username"
            render={({ field }) => (
              <FormItem>
                <FormLabel className={isRTL ? 'block text-right' : ''}>{t('username')}</FormLabel>
                <FormControl>
                  <Input
                    placeholder={t('enterYourUsername')}
                    {...field}
                    className={isRTL ? 'text-right' : ''}
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
                <FormLabel className={isRTL ? 'block text-right' : ''}>{t('password')}</FormLabel>
                <FormControl>
                  <div className="relative">
                    <Input
                      placeholder={t('enterYourPassword')}
                      type={showPassword ? "text" : "password"}
                      {...field}
                      className={isRTL ? 'text-right pr-10' : 'pr-10'}
                    />
                    <Button
                      type="button"
                      variant="ghost"
                      size="sm"
                      className={`absolute ${isRTL ? 'left-0' : 'right-0'} top-0 h-full px-3 py-2 hover:bg-transparent`}
                      onClick={() => setShowPassword(!showPassword)}
                    >
                      {showPassword ? (
                        <EyeOff className="h-4 w-4" />
                      ) : (
                        <Eye className="h-4 w-4" />
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
            className="w-full bg-gradient-to-r from-[#042052] to-[#0D57E1] hover:from-[#0D57E1] hover:to-[#042052] text-white"
            disabled={isLoading}
          >
            {isLoading ? t('creatingAccount') : t('createAccount')}
          </Button>
        </form>
      </Form>

      <div className="text-center">
        <p className="text-sm text-gray-600">
          {t('alreadyHaveAccount')}{" "}
          <a href="/candidate/login" className="text-blue-600 hover:underline">
            {t('signIn')}
          </a>
        </p>
      </div>
    </div>
  );
};

export default RegistrationForm;

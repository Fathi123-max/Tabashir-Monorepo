"use client";

import { useEffect } from "react";
import { useRouter } from "next/navigation";
import { v4 as uuidv4 } from "uuid";
import { useResumeStore } from "./store/resume-store";
import { onSetupResume } from "@/actions/ai-resume";
import { toast } from "sonner";

export default function NewResumePage() {
  const router = useRouter();
  const { setResumeId, resetForms } = useResumeStore();

  useEffect(() => {
    const setupResume = async () => {
      try {
        const response = await onSetupResume();
        if (response.error) {
          toast.error(response.message);
        } else {
          if (response.redirectTo) {
            router.push(response.redirectTo);
          }
        }
      } catch (error) {
        toast.error("Something went wrong");
      }

    };
    setupResume();
  }, []);

  return (
    <div className="flex items-center justify-center h-[calc(100vh-35px)]">
      <div className="text-center space-y-6 p-8 rounded-2xl shadow-lg max-w-md w-full mx-4 bg-white">
        <div className="relative">
          <div className="w-16 h-16 border-4 border-blue-200 border-t-blue-600 rounded-full animate-spin mx-auto"></div>
          <div className="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2">
            <svg className="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
          </div>
        </div>
        <h1 className="text-3xl font-bold text-gray-900 mb-2 bg-gradient-to-r from-blue-600 to-blue-800 bg-clip-text text-transparent">
          Creating New Resume
        </h1>
        <p className="text-gray-600 text-lg">
          Please wait while we set up your resume...
        </p>
        <div className="flex justify-center space-x-2">
          <div className="w-2 h-2 bg-blue-600 rounded-full animate-bounce" style={{ animationDelay: '0ms' }}></div>
          <div className="w-2 h-2 bg-blue-600 rounded-full animate-bounce" style={{ animationDelay: '150ms' }}></div>
          <div className="w-2 h-2 bg-blue-600 rounded-full animate-bounce" style={{ animationDelay: '300ms' }}></div>
        </div>
      </div>
    </div>
  );
}

"use client";

import React from "react";
import { motion } from "framer-motion";
import { Lock, Upload } from "lucide-react";
import { Button } from "@/components/ui/button";
import { useTranslation } from "@/lib/use-translation";
import Link from "next/link";

interface CVRequiredBlurProps {
  children: React.ReactNode;
  hasResume: boolean | null;
  title?: string;
  description?: string;
  onUploadClick?: () => void;
}

export function CVRequiredBlur({
  children,
  hasResume,
  title,
  description,
  onUploadClick,
}: CVRequiredBlurProps) {
  const { t } = useTranslation();

  if (hasResume === true) {
    return <>{children}</>;
  }

  return (
    <div className="relative group">
      {/* Blurred Content */}
      <div className="filter blur-md pointer-events-none select-none opacity-50">
        {children}
      </div>

      {/* Overlay */}
      <motion.div 
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        className="absolute inset-0 z-10 flex flex-col items-center justify-center p-6 text-center bg-white/30 backdrop-blur-[2px] rounded-lg border border-white/50 shadow-sm"
      >
        <div className="bg-white p-8 rounded-2xl shadow-xl border border-gray-100 max-w-md w-full animate-in fade-in zoom-in duration-300">
          <div className="mx-auto w-16 h-16 bg-blue-50 rounded-full flex items-center justify-center mb-6">
            <Lock className="w-8 h-8 text-blue-600" />
          </div>
          
          <h3 className="text-xl font-bold text-gray-900 mb-2">
            {title || t('cvRequiredTitle') || "CV Upload Required"}
          </h3>
          
          <p className="text-gray-600 mb-8">
            {description || t('cvRequiredDesc') || "Please upload your CV to unlock this feature and get personalized job recommendations."}
          </p>

          {onUploadClick ? (
            <Button 
              onClick={onUploadClick}
              className="w-full bg-gradient-to-r from-[#042052] to-[#0D57E1] text-white hover:opacity-90 py-6 text-lg font-semibold rounded-xl"
            >
              <Upload className="mr-2 h-5 w-5" />
              {t('uploadCV') || "Upload CV"}
            </Button>
          ) : (
            <Link href="/resume" className="w-full">
              <Button 
                className="w-full bg-gradient-to-r from-[#042052] to-[#0D57E1] text-white hover:opacity-90 py-6 text-lg font-semibold rounded-xl"
              >
                <Upload className="mr-2 h-5 w-5" />
                {t('goToResume') || "Go to Resume Section"}
              </Button>
            </Link>
          )}
        </div>
      </motion.div>
    </div>
  );
}

"use client"

import AiResumePersonalDetailsForm from "@/components/forms/ai-resume/personal-details";
import { prisma } from "@/app/utils/db";
import { AiResumePersonalDetails, AiSocialLink } from "@prisma/client";
import { auth } from "@/app/utils/auth";
import { redirect } from "next/navigation";
import { getAiResumeFormatedContent } from "@/actions/ai-resume";
import { useTranslation } from "@/lib/use-translation";
import { useSession } from "next-auth/react";
import { useEffect, useState } from "react";

export default function PersonalDetailsPage({
  params,
}: {
  params: Promise<{ resumeId: string }>;
}) {
  const { t, isRTL } = useTranslation();
  const { data: session } = useSession();
  const [resumeId, setResumeId] = useState<string>("");
  const [personalDetails, setPersonalDetails] = useState<any>(null);
  const [hasExistingContent, setHasExistingContent] = useState(false);

  useEffect(() => {
    const fetchData = async () => {
      const { resumeId: id } = await params;
      setResumeId(id);

      if (!session?.user?.id) {
        redirect("/login");
        return;
      }

      // This would need to be converted to a client-side API call
      // For now, keeping the structure similar but making it client-side compatible

      setHasExistingContent(false); // This would come from an API call
    };

    fetchData();
  }, [params, session]);

  if (!session?.user?.id) {
    redirect("/login");
    return null;
  }

  return (
    <div className={`space-y-6 rounded-[6px] ${isRTL ? 'text-right' : ''}`}>
      <h2 className="text-2xl font-bold text-gray-800 mb-6">
        {t('personalDetails')}
      </h2>

      <AiResumePersonalDetailsForm
        aiResumeId={resumeId}
        aiResumePersonalDetails={personalDetails}
        userId={session.user.id}
        hasExistingContent={hasExistingContent}
      />
    </div>
  );
}

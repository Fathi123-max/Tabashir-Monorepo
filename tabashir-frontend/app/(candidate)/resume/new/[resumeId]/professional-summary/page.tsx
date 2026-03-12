import { prisma } from "@/app/utils/db";
import ProfessionalSummaryForm from "./professional-summary-form";
import { auth } from "@/app/utils/auth";
import { redirect } from "next/navigation";
import { getAiResumeFormatedContent } from "@/actions/ai-resume";

export default async function ProfessionalSummaryPage({ params }: { params: Promise<{ resumeId: string }> }) {
  const { resumeId } = await params;

  const session = await auth();
  if (!session?.user?.id) {
    return redirect("/login");
  }

  const aiResumeProfessionalSummary = await prisma?.aiProfessionalDetails.findFirst({
    where: {
      aiResumeId: resumeId,
    },
  });

  const formattedContentResult = await getAiResumeFormatedContent(resumeId);
  const hasExistingContent = formattedContentResult.data?.hasExistingContent || false;

  return (
    <ProfessionalSummaryForm
      resumeId={resumeId}
      aiResumeProfessionalSummary={aiResumeProfessionalSummary}
      userId={session.user.id}
      hasExistingContent={hasExistingContent}
    />
  )
}

import EmploymentHistoryForm from "./employment-history-form";
import { prisma } from "@/app/utils/db";
import { auth } from "@/app/utils/auth";
import { redirect } from "next/navigation";
import { getAiResumeFormatedContent } from "@/actions/ai-resume";

export default async function EmploymentHistoryPage({ params }: { params: Promise<{ resumeId: string }> }) {
  const { resumeId } = await params;

  const session = await auth();
  if (!session?.user?.id) {
    return redirect("/login");
  }

  const aiResumeEmploymentHistory = await prisma.aiEmploymentHistory.findMany({
    where: {
      aiResumeId: resumeId,
    },
  });

  const formattedContentResult = await getAiResumeFormatedContent(resumeId);
  const hasExistingContent = formattedContentResult.data?.hasExistingContent || false;

  return (
    <EmploymentHistoryForm
      resumeId={resumeId}
      aiResumeEmploymentHistory={aiResumeEmploymentHistory}
      userId={session.user.id}
      hasExistingContent={hasExistingContent}
    />
  )
}

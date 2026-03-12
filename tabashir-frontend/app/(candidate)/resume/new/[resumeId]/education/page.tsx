import { prisma } from "@/app/utils/db"
import EducationForm from "./education-form"
import { auth } from "@/app/utils/auth"
import { redirect } from "next/navigation"
import { getAiResumeFormatedContent } from "@/actions/ai-resume"

export default async function EducationPage({ params }: { params: Promise<{ resumeId: string }> }) {
  const { resumeId } = await params

  const session = await auth()
  if (!session?.user?.id) {
    return redirect("/login")
  }

  const aiResumeEducation = await prisma.aiEducation.findMany({
    where: {
      aiResumeId: resumeId,
    },
  })

  const formattedContentResult = await getAiResumeFormatedContent(resumeId);
  const hasExistingContent = formattedContentResult.data?.hasExistingContent || false;

  return <EducationForm
    resumeId={resumeId}
    aiResumeEducation={aiResumeEducation}
    userId={session.user.id}
    hasExistingContent={hasExistingContent}
  />
}
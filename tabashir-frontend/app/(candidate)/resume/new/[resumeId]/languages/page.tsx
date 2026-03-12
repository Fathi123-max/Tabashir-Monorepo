import { prisma } from "@/app/utils/db"
import LanguagesForm from "./languages-form"
import { auth } from "@/app/utils/auth"
import { redirect } from "next/navigation"
import { getAiResumeFormatedContent } from "@/actions/ai-resume"

export default async function LanguagesPage({ params }: { params: Promise<{ resumeId: string }> }) {
  const { resumeId } = await params

  const session = await auth()
  if (!session?.user?.id) {
    return redirect("/login")
  }

  const aiResumeLanguages = await prisma.aiLanguage.findMany({
    where: {
      aiResumeId: resumeId,
    },
  })

  const formattedContentResult = await getAiResumeFormatedContent(resumeId);
  const hasExistingContent = formattedContentResult.data?.hasExistingContent || false;

  return <LanguagesForm
    resumeId={resumeId}
    aiResumeLanguages={aiResumeLanguages}
    userId={session.user.id}
    hasExistingContent={hasExistingContent}
  />
}

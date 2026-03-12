import { prisma } from "@/app/utils/db"
import SkillsForm from "./skills-form"
import { auth } from "@/app/utils/auth";
import { redirect } from "next/navigation";

export default async function SkillsPage({ params, searchParams }: { params: Promise<{ resumeId: string }>, searchParams: Promise<{ payment_completed?: string }> }) {
  const { resumeId } = await params;
  const { payment_completed } = await searchParams;

  const skills = await prisma.aiSkill.findMany({
    where: {
      aiResumeId: resumeId,
    },
  });

  const session = await auth();
  if (!session?.user?.id) {
    return redirect("/login");
  }

  return <SkillsForm resumeId={resumeId} aiResumeSkills={skills} userId={session.user.id} paymentCompleted={payment_completed} />
}

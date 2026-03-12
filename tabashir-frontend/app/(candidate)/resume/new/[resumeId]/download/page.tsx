import ResumeDownload from "./resume-download";
import { prisma } from "@/app/utils/db";

export default async function DownloadPage({ params }: { params: Promise<{ resumeId: string }> }) {
  const { resumeId } = await params;

  const resume = await prisma.aiResume.findUnique({
    where: {
      id: resumeId,
    },
  });

  return <ResumeDownload resumeUrl={resume?.formatedUrl || ""} />
}
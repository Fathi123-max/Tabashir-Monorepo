import { getUserResumes } from "@/actions/resume"
import { ResumeListClient } from "./_components/resume-list-client"

export default async function ResumePage() {
  const result = await getUserResumes()

  // Basic error handling for server data fetch
  if (result.error) {
    // You might want a more sophisticated error UI here
    return (
      <div className="bg-white rounded-lg p-6 min-h-[calc(100vh-35px)] flex items-center justify-center">
        <p className="text-red-500">Error loading resumes: {result.message}</p>
      </div>
    )
  }

  const initialResumes = result.data || []

  return (
    <ResumeListClient
      initialResumes={initialResumes}
    />
  )
}

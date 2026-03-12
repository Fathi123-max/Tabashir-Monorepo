import { getJobDetails } from "./actions"
import { JobDetailsClient } from "./_components/job-details-client"

interface PageProps {
  params: {
    id: string
  }
}

export default async function JobDetailsPage({ params }: PageProps) {
  const { job, applications } = await getJobDetails(params.id)

  return <JobDetailsClient job={job} applications={applications} jobId={params.id} />
}

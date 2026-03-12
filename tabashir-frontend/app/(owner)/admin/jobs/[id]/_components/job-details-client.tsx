"use client"

import Image from "next/image"
import { Eye, Edit } from "lucide-react"
import { Button } from "@/components/ui/button"
import { JobStatusSelector } from "./job-status-selector"
import { JsonToHtml } from "@/components/tiptap-editor/json-to-html"
import { ApplicationsTable } from "./applications-table"
import Link from "next/link"

interface JobDetailsClientProps {
  job: any
  applications: any[]
  jobId: string
}

export function JobDetailsClient({ job, applications, jobId }: JobDetailsClientProps) {
  return (
    <div className="p-6 text-gray-900">
      <div className="flex items-start gap-4 mb-6">
        <div className="w-16 h-16 bg-blue-100 rounded-lg overflow-hidden flex-shrink-0">
          <Image
            src={job.companyLogo}
            alt={`${job.company} Logo`}
            width={64}
            height={64}
            className="p-2"
          />
        </div>
        <div className="flex-1">
          <h1 className="text-2xl font-bold mb-1">{job.title}</h1>
          <p className="text-gray-600">{job.jobType}</p>
        </div>
        <div className="text-right">
          <p className="text-sm mb-2">Posted on {new Date(job.createdAt).toLocaleDateString()}</p>
          <div className="flex gap-2 mb-2">
            <Link href={`/admin/jobs/${jobId}/edit`}>
              <Button variant="outline" size="sm">
                <Edit className="h-4 w-4 mr-1" />
                Edit Job
              </Button>
            </Link>
          </div>
          <JobStatusSelector jobId={jobId} currentStatus={job.status} />
        </div>
      </div>

      {/* Job Description Section */}
      <div className="bg-white rounded-lg shadow-sm mb-6">
        <div className="flex justify-between items-center p-4">
          <h2 className="text-xl font-semibold text-gray-700">Job Description</h2>
        </div>

        <div className="p-6 pt-0 flex">
          {/* Left column - Job Description */}
          <div className="flex-1 pr-6">
            <div className="mb-6">
              <div className="prose prose-sm max-w-none text-gray-700">
                {job.description}
              </div>
              <div className="prose prose-sm max-w-none text-gray-700">
                {job.requirements}
              </div>
            </div>

            <div>
              <h3 className="font-medium mb-2 text-gray-800">Job Type</h3>
              <p className="text-xs text-gray-500 mb-2">All of the given options are available for you to work</p>

              <div className="flex gap-2">
                <div className="flex items-center gap-2 border border-gray-200 rounded-md px-3 py-2">
                  <svg
                    width="20"
                    height="20"
                    viewBox="0 0 24 24"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                    className="text-gray-500"
                  >
                    <path
                      d="M21 9.5V8.25C21 7.00736 19.9926 6 18.75 6H5.25C4.00736 6 3 7.00736 3 8.25V9.5M21 9.5V17.75C21 18.9926 19.9926 20 18.75 20H5.25C4.00736 20 3 18.9926 3 17.75V9.5M21 9.5H3M9 12.5H15"
                      stroke="currentColor"
                      strokeWidth="1.5"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                    />
                  </svg>
                  <span className="text-sm">{job.jobType}</span>
                </div>
              </div>
            </div>
          </div>

          {/* Right column - Location and Skillset */}
          <div className="w-64 border-l pl-6">
            {/* Location Section */}
            <div className="mb-6">
              <h3 className="font-medium mb-2 text-gray-800">Location</h3>
              <div className="flex items-center gap-2">
                <svg
                  width="16"
                  height="16"
                  viewBox="0 0 24 24"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                  className="text-gray-400"
                >
                  <path
                    d="M12 13C13.6569 13 15 11.6569 15 10C15 8.34315 13.6569 7 12 7C10.3431 7 9 8.34315 9 10C9 11.6569 10.3431 13 12 13Z"
                    stroke="currentColor"
                    strokeWidth="1.5"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                  <path
                    d="M12 22C16 18 20 14.4183 20 10C20 5.58172 16.4183 2 12 2C7.58172 2 4 5.58172 4 10C4 14.4183 8 18 12 22Z"
                    stroke="currentColor"
                    strokeWidth="1.5"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                </svg>
                <span className="text-sm text-gray-700">{job.location}</span>
              </div>
            </div>

            {/* Skillset Section */}
            <div>
              <h3 className="font-medium mb-2 text-gray-800">Skillset</h3>
              <div className="flex flex-col gap-2">
                {job.requiredSkills.map((skill: string, index: number) => (
                  <div key={index} className="flex items-center gap-2">
                    <div className={`w-3 h-3 rounded-full bg-${['blue', 'orange', 'green', 'purple'][index % 4]}-500`}></div>
                    <span className="text-sm">{skill}</span>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Applications Section */}
      <ApplicationsTable applications={applications} />
    </div>
  )
} 
"use client"

import { Heart } from "lucide-react"
import Image from "next/image"
import { Button } from "@/components/ui/button"

interface JobDetailCardProps {
  title: string
  company: string
  location: string
  logo?: string
  isLiked?: boolean
  onLike?: () => void
  requirements?: string[]
  className?: string
}

export default function JobDetailCard({
  title,
  company,
  location,
  logo = "/letter-g-floral.png",
  isLiked = false,
  onLike,
  requirements = [],
  className = "",
}: JobDetailCardProps) {
  return (
    <div className={`bg-white rounded-lg p-4 overflow-y-scroll max-h-[500px] ${className}`}>
      <div className="flex items-start mb-6">
        <div className="flex-shrink-0 mr-4">
          <Image
            src={logo || "/placeholder.svg"}
            alt={`${company} logo`}
            width={60}
            height={60}
            className="rounded-md"
          />
        </div>
        <div className="flex-1">
          <div className="flex justify-between">
            <div>
              <h3 className="text-xl font-semibold text-gray-900">{title}</h3>
              <p className="text-sm text-gray-600">
                {company} Inc. - {location}
              </p>
            </div>
            <button
              onClick={onLike}
              className="text-gray-400 hover:text-red-500"
              aria-label={isLiked ? "Unlike job" : "Like job"}
            >
              <Heart className={isLiked ? "fill-red-500 text-red-500" : ""} size={20} />
            </button>
          </div>
        </div>
      </div>

      <div className="space-y-3 mb-6">
        <Button className="w-full bg-blue-950 hover:bg-blue-900 text-white">Easy Apply via Tabashir</Button>
        <Button variant="outline" className="w-full border-gray-300">
          Apply through company website
        </Button>
      </div>

      <div className="space-y-4">
        <div className="flex space-x-4 border-b pb-2">
          <button className="text-blue-600 font-medium border-b-2 border-blue-600 pb-2">Role</button>
          <button className="text-gray-500">Company</button>
        </div>

        <div>
          <h4 className="font-medium text-gray-900 mb-2">Minimum qualifications:</h4>
          <ul className="list-disc pl-5 space-y-1 text-gray-700">
            {requirements.length > 0 ? (
              requirements.map((req, index) => <li key={index}>{req}</li>)
            ) : (
              <>
                <li>Bachelor's degree in Design, Computer Science, HCI, or equivalent practical experience.</li>
                <li>7 years of experience as a UX or Interaction Designer.</li>
                <li>Experience in representing and advocating for UX.</li>
                <li>UI skills and others.</li>
              </>
            )}
          </ul>
        </div>

        <div>
          <h4 className="font-medium text-gray-900">Location</h4>
        </div>
      </div>
    </div>
  )
}

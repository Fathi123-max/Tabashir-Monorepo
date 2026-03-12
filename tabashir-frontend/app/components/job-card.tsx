"use client"

import { Heart } from "lucide-react"
import Image from "next/image"
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card"

interface JobCardProps {
  title: string
  company: string
  location: string
  jobType: string
  applicationsCount: number
  logo?: string
  team?: string
  salary?: string
  isLiked?: boolean
  onLike?: () => void
  className?: string
}

export default function JobCard({
  title,
  company,
  location,
  jobType,
  applicationsCount,
  logo = "/letter-g-floral.png",
  team,
  salary,
  isLiked = false,
  onLike,
  className = "",
}: JobCardProps) {
  return (
    <Card className={className}>
      <CardContent className="p-4">
        <div className="flex items-start">
          <div className="flex-shrink-0 mr-4">
            <Image
              src={logo || "/placeholder.svg"}
              alt={`${company} logo`}
              width={40}
              height={40}
              className="rounded-md"
            />
          </div>
          <div className="flex-1">
            <div className="flex justify-between">
              <div>
                <CardTitle className="text-lg font-medium">{title}</CardTitle>
                <CardDescription>{company} Inc.</CardDescription>
              </div>
              <button
                onClick={onLike}
                className="text-gray-400 hover:text-red-500"
                aria-label={isLiked ? "Unlike job" : "Like job"}
              >
                <Heart className={isLiked ? "fill-red-500 text-red-500" : ""} size={20} />
              </button>
            </div>

            <div className="mt-2 flex items-center text-sm text-muted-foreground">
              <span className="flex items-center">
                <span className="mr-1">•</span>
                <span>{location}</span>
              </span>
              <span className="mx-2">•</span>
              <span>{jobType}</span>
              <span className="mx-2">•</span>
              <span>{applicationsCount} applied</span>
            </div>

            {(team || salary) && (
              <div className="mt-3 flex justify-between">
                {team && (
                  <div className="text-sm">
                    <span className="text-muted-foreground">Team:</span>
                    <span className="ml-1">{team}</span>
                  </div>
                )}
                {salary && (
                  <div className="text-sm">
                    <span className="text-green-600 font-medium">${salary}k</span>
                    <span className="text-muted-foreground ml-1">/ year</span>
                  </div>
                )}
              </div>
            )}
          </div>
        </div>
      </CardContent>
    </Card>
  )
}

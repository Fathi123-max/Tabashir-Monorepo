import { ChevronRight } from "lucide-react"
import Link from "next/link"
import Image from "next/image"

interface Interview {
  company: string
  position: string
  time: string
}

const interviews: Interview[] = [
  {
    company: "Google",
    position: "UI/UX Designer",
    time: "Today at 2:00 PM",
  },
  {
    company: "Figma",
    position: "UI/UX Designer",
    time: "2 hours ago",
  },
]

export function InterviewScheduleCard() {
  return (
    <div className="relative">
      {/* Blurred Content */}
      <div className="filter blur-sm">
        <div className="flex justify-between items-center mb-4">
          <h2 className="text-lg font-medium text-gray-800">Interview Scheduled</h2>
          <Link href="/interviews" className="text-xs text-[#0D57E1] hover:text-[#042052]">
            View All
          </Link>
        </div>

        <div className="space-y-3">
          {interviews.map((interview, index) => (
            <div key={index} className="flex items-center gap-3">
              <div className="w-8 h-8 bg-gray-200 rounded-full overflow-hidden flex-shrink-0">
                <Image src="/generic-company-logo.png" alt={interview.company} width={32} height={32} />
              </div>
              <div className="flex-1 min-w-0">
                <p className="text-sm font-medium truncate">{interview.position}</p>
                <p className="text-xs text-gray-500 truncate">
                  {interview.company} • {interview.time}
                </p>
              </div>
              <ChevronRight size={16} className="text-gray-400" />
            </div>
          ))}
        </div>
      </div>
    </div>
  )
}

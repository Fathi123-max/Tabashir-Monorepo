import { ChevronRight } from "lucide-react"
import Link from "next/link"
import Image from "next/image"

interface JobOffer {
  company: string
  position: string
  time: string
}

const offers: JobOffer[] = [
  {
    company: "Google",
    position: "UI/UX Designer",
    time: "20 mins ago",
  },
]

export function JobOffersCard() {
  return (
    <div>
      <div className="flex justify-between items-center mb-4">
        <h2 className="text-lg font-medium text-gray-800">Job Offers</h2>
        <Link href="/offers" className="text-xs text-[#0D57E1] hover:text-[#042052]">
          View All
        </Link>
      </div>

      <div className="space-y-3">
        {offers.map((offer, index) => (
          <div key={index} className="flex items-center gap-3">
            <div className="w-8 h-8 bg-gray-200 rounded-full overflow-hidden flex-shrink-0">
              <Image src="/generic-company-logo.png" alt={offer.company} width={32} height={32} />
            </div>
            <div className="flex-1 min-w-0">
              <p className="text-sm font-medium truncate">{offer.position}</p>
              <p className="text-xs text-gray-500 truncate">
                {offer.company} • {offer.time}
              </p>
            </div>
            <ChevronRight size={16} className="text-gray-400" />
          </div>
        ))}
      </div>
    </div>
  )
}

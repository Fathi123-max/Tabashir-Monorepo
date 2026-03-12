import Link from "next/link"
import { Briefcase, Grid, CheckSquare, ArrowRight } from "lucide-react"

interface StatCardProps {
  title: string
  value: string
  icon: string
  color: string
  iconColor: string
}

export default function StatCard({ title, value, icon, color, iconColor }: StatCardProps) {
  const getIcon = () => {
    switch (icon) {
      case "briefcase":
        return <Briefcase className={`h-6 w-6 ${iconColor}`} />
      case "grid":
        return <Grid className={`h-6 w-6 ${iconColor}`} />
      case "check":
        return <CheckSquare className={`h-6 w-6 ${iconColor}`} />
      default:
        return <Briefcase className={`h-6 w-6 ${iconColor}`} />
    }
  }

  return (
    <div className="bg-white rounded-lg shadow-sm p-6">
      <div className="flex items-center justify-between mb-4">
        <div className={`p-3 rounded-lg ${color}`}>{getIcon()}</div>
        <h2 className="text-2xl font-bold">{value}</h2>
      </div>
      <div className="flex items-center justify-between">
        <p className="text-gray-600">{title}</p>
        <Link href="#" className="text-sm text-gray-500 flex items-center hover:text-gray-700">
          View Details
          <ArrowRight className="h-4 w-4 ml-1" />
        </Link>
      </div>
    </div>
  )
}

import { Skeleton } from "@/components/ui/skeleton"

export default function Loading() {
  return (
    <div className="p-6">
      <div className="flex items-start gap-4 mb-6">
        <Skeleton className="w-16 h-16 rounded-lg" />
        <div className="flex-1">
          <Skeleton className="h-8 w-64 mb-2" />
          <Skeleton className="h-4 w-20" />
        </div>
        <div className="text-right">
          <Skeleton className="h-4 w-40 mb-2 ml-auto" />
          <Skeleton className="h-6 w-32 ml-auto" />
        </div>
      </div>

      <Skeleton className="h-[200px] w-full mb-6 rounded-lg" />
      <Skeleton className="h-[120px] w-full mb-6 rounded-lg" />
      <Skeleton className="h-[120px] w-full mb-6 rounded-lg" />
      <Skeleton className="h-[400px] w-full rounded-lg" />
    </div>
  )
}

import { Skeleton } from "@/components/ui/skeleton"

export default function Loading() {
  return (
    <div className="w-full">
      {/* Search bar skeleton */}
      <div className="mb-8">
        <Skeleton className="h-10 w-[370px]" />
      </div>

      {/* Title skeletons */}
      <div className="mb-6">
        <Skeleton className="h-7 w-48 mb-2" />
        <Skeleton className="h-5 w-32" />
      </div>

      {/* Course grid skeletons */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {Array(6)
          .fill(0)
          .map((_, i) => (
            <div key={i} className="rounded-lg overflow-hidden shadow-sm">
              <Skeleton className="h-[180px] w-full" />
              <div className="p-4">
                <Skeleton className="h-5 w-3/4 mb-2" />
                <Skeleton className="h-4 w-1/2 mb-2" />
                <Skeleton className="h-4 w-full" />
                <Skeleton className="h-4 w-full mt-1" />
              </div>
            </div>
          ))}
      </div>
    </div>
  )
}

import { Skeleton } from "@/components/ui/skeleton"

export default function Loading() {
  return (
    <div className="p-6 text-gray-900">
      {/* Header skeleton */}
      <div className="flex justify-between items-center mb-6">
        <Skeleton className="h-8 w-48" /> {/* Title skeleton */}
        <Skeleton className="h-10 w-40" /> {/* Create New Job button skeleton */}
      </div>

      <div className="bg-white rounded-lg shadow-sm p-6">
        {/* Sort dropdown skeleton */}
        <div className="flex justify-between items-center mb-6">
          <div className="flex items-center">
            <Skeleton className="h-4 w-10 mr-2" /> {/* "Sort" text skeleton */}
            <Skeleton className="h-10 w-[180px]" /> {/* Dropdown skeleton */}
          </div>
        </div>

        {/* Job cards grid skeleton */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-6">
          {/* Create Job Card skeleton */}
          <div className="border-2 border-dashed border-gray-200 rounded-lg p-6 flex flex-col items-center justify-center h-[300px]">
            <Skeleton className="h-12 w-12 rounded-full mb-4" /> {/* Plus icon skeleton */}
            <Skeleton className="h-6 w-32 mb-2" /> {/* "Create New Job" text skeleton */}
            <Skeleton className="h-4 w-48" /> {/* Subtitle skeleton */}
          </div>

          {/* Job Cards skeletons */}
          {Array.from({ length: 5 }).map((_, index) => (
            <div key={index} className="border rounded-lg p-6 h-[300px]">
              <div className="flex justify-between items-start mb-4">
                <div className="space-y-2">
                  <Skeleton className="h-6 w-48" /> {/* Job title skeleton */}
                  <Skeleton className="h-4 w-24" /> {/* Job type skeleton */}
                </div>
                <Skeleton className="h-6 w-20" /> {/* Status badge skeleton */}
              </div>

              <div className="space-y-4">
                <div className="flex justify-between">
                  <Skeleton className="h-4 w-24" /> {/* Received applications skeleton */}
                  <Skeleton className="h-4 w-24" /> {/* Interviewed skeleton */}
                </div>
                <div className="flex justify-between">
                  <Skeleton className="h-4 w-24" /> {/* Views skeleton */}
                  <Skeleton className="h-4 w-32" /> {/* Active date skeleton */}
                </div>
              </div>

              <div className="mt-6 pt-6 border-t">
                <div className="flex justify-between items-center">
                  <Skeleton className="h-4 w-24" /> {/* Posted date skeleton */}
                  <Skeleton className="h-8 w-20" /> {/* View details button skeleton */}
                </div>
              </div>
            </div>
          ))}
        </div>

        {/* Pagination skeleton */}
        <div className="flex justify-between items-center text-sm text-gray-600">
          <div className="flex items-center">
            <Skeleton className="h-4 w-16 mr-2" /> {/* "Showing" text skeleton */}
            <Skeleton className="h-8 w-[60px] mx-2" /> {/* Items per page selector skeleton */}
            <Skeleton className="h-4 w-24" /> {/* "of X" text skeleton */}
          </div>

          <div className="flex items-center space-x-1">
            <Skeleton className="h-8 w-8" /> {/* Previous button skeleton */}
            {Array.from({ length: 3 }).map((_, index) => (
              <Skeleton key={index} className="h-8 w-8" /> /* Page number button skeletons */
            ))}
            <Skeleton className="h-8 w-8" /> {/* Next button skeleton */}
          </div>
        </div>
      </div>
    </div>
  )
}

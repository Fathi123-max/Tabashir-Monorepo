import { Skeleton } from "@/components/ui/skeleton"

export default function InterviewTrainingLoading() {
  return (
    <div className="container mx-auto px-4 py-8">
      <div className="flex flex-col items-center justify-center space-y-8 py-12">
        {/* Header Skeleton */}
        <div className="text-center space-y-4 max-w-3xl w-full">
          <Skeleton className="h-10 w-3/4 mx-auto" />
          <Skeleton className="h-6 w-2/3 mx-auto" />
        </div>

        {/* Coming Soon Banner Skeleton */}
        <Skeleton className="w-full max-w-4xl h-80 rounded-2xl" />

        {/* Feature Preview Skeleton */}
        <div className="w-full max-w-4xl mt-12">
          <Skeleton className="h-8 w-64 mx-auto mb-8" />

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {[...Array(3)].map((_, i) => (
              <div key={i} className="rounded-xl p-6 border border-gray-100">
                <Skeleton className="h-12 w-12 rounded-full mb-4" />
                <Skeleton className="h-6 w-3/4 mb-2" />
                <Skeleton className="h-4 w-full mb-1" />
                <Skeleton className="h-4 w-full mb-1" />
                <Skeleton className="h-4 w-2/3" />
              </div>
            ))}
          </div>
        </div>

        {/* Timeline Skeleton */}
        <div className="w-full max-w-2xl mt-8">
          <div className="flex items-center justify-center mb-8">
            <div className="h-px bg-gray-200 flex-grow"></div>
            <Skeleton className="h-6 w-40 mx-4" />
            <div className="h-px bg-gray-200 flex-grow"></div>
          </div>

          <div className="space-y-8">
            {[...Array(3)].map((_, i) => (
              <div key={i} className="flex">
                <div className="flex flex-col items-center mr-4">
                  <Skeleton className="rounded-full h-10 w-10" />
                  <div className="h-full w-0.5 bg-gray-200 mt-2"></div>
                </div>
                <div className="pb-8 w-full">
                  <Skeleton className="h-4 w-32 mb-2" />
                  <Skeleton className="h-6 w-3/4 mb-2" />
                  <Skeleton className="h-4 w-full" />
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* CTA Skeleton */}
        <div className="mt-12 text-center w-full">
          <Skeleton className="h-4 w-64 mx-auto mb-4" />
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Skeleton className="h-10 w-32" />
            <Skeleton className="h-10 w-32" />
          </div>
        </div>
      </div>
    </div>
  )
}

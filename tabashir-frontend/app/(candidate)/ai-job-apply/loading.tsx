import { Skeleton } from "@/components/ui/skeleton"

export default function Loading() {
  return (
    <div className="flex-1 p-6">
      <div className="bg-white rounded-lg shadow-sm p-8 max-w-4xl mx-auto">
        <div className="flex items-center mb-10">
          <Skeleton className="h-8 w-64" />
          <Skeleton className="h-6 w-6 ml-3 rounded-full" />
        </div>

        {/* Step 1 */}
        <div className="mb-10">
          <div className="flex items-center mb-6">
            <Skeleton className="h-8 w-8 rounded-full mr-3" />
            <Skeleton className="h-7 w-40" />
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            {[1, 2, 3].map((item) => (
              <Skeleton key={item} className="h-28 w-full rounded-md" />
            ))}
          </div>
        </div>

        {/* Step 2 */}
        <div className="mb-10">
          <div className="flex items-center mb-6">
            <Skeleton className="h-8 w-8 rounded-full mr-3" />
            <Skeleton className="h-7 w-56" />
          </div>

          <Skeleton className="h-10 w-full mb-4 rounded-full" />

          <div className="flex flex-wrap gap-2">
            {[1, 2, 3].map((item) => (
              <Skeleton key={item} className="h-8 w-24 rounded-full" />
            ))}
          </div>
        </div>

        {/* Step 3 */}
        <div className="mb-16">
          <div className="flex items-center mb-6">
            <Skeleton className="h-8 w-8 rounded-full mr-3" />
            <Skeleton className="h-7 w-40" />
          </div>

          <div className="flex gap-3">
            {[1, 2, 3].map((item) => (
              <Skeleton key={item} className="h-10 w-24 rounded-full" />
            ))}
          </div>
        </div>

        <Skeleton className="h-14 w-full rounded-md" />
      </div>
    </div>
  )
}

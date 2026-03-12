import { Skeleton } from "@/components/ui/skeleton"

export default function Loading() {
  return (
    <div className="flex-1 p-6">
      <div className="bg-white rounded-lg shadow-sm p-8 max-w-6xl mx-auto">
        <Skeleton className="h-8 w-64 mb-10" />

        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
          {[1, 2, 3].map((i) => (
            <div key={i} className="bg-white rounded-xl shadow-md p-6">
              <div className="flex items-center mb-4">
                <Skeleton className="h-8 w-8 rounded-full mr-3" />
                <div>
                  <Skeleton className="h-6 w-20 mb-1" />
                  <Skeleton className="h-5 w-32" />
                </div>
              </div>

              <div className="space-y-3 mb-8">
                {[1, 2, 3].map((j) => (
                  <div key={j} className="flex items-start">
                    <Skeleton className="h-5 w-5 mr-2 mt-0.5" />
                    <Skeleton className="h-5 w-full max-w-[180px]" />
                  </div>
                ))}
              </div>

              <Skeleton className="h-10 w-full rounded-md" />
              <Skeleton className="h-4 w-24 mx-auto mt-4" />
            </div>
          ))}
        </div>

        <div className="mt-12">
          <Skeleton className="h-7 w-40 mb-4" />
          <Skeleton className="h-20 w-full max-w-3xl mb-6" />

          <div className="space-y-4 max-w-xl">
            <div className="flex">
              <Skeleton className="h-5 w-36 mr-4" />
              <Skeleton className="h-5 w-32" />
            </div>
            <div className="flex">
              <Skeleton className="h-5 w-36 mr-4" />
              <Skeleton className="h-5 w-40" />
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

import { Skeleton } from "@/components/ui/skeleton"

export default function Loading() {
  return (
    <div className="flex-1 p-6 bg-gray-50">
      <div className="max-w-4xl mx-auto space-y-6">
        {/* Personal Information */}
        <div className="bg-white rounded-lg shadow-sm p-6">
          <Skeleton className="h-7 w-48 mb-6" />

          <div className="space-y-4">
            {[1, 2, 3].map((i) => (
              <div key={i} className="grid grid-cols-4 gap-4 items-center">
                <Skeleton className="h-5 w-24" />
                <div className="col-span-3">
                  <Skeleton className="h-10 w-full rounded-md" />
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Account Information */}
        <div className="bg-white rounded-lg shadow-sm p-6">
          <Skeleton className="h-7 w-48 mb-6" />

          <div className="space-y-4">
            {[1, 2, 3].map((i) => (
              <div key={i} className="grid grid-cols-4 gap-4 items-center">
                <Skeleton className="h-5 w-24" />
                <div className="col-span-3">
                  <Skeleton className="h-10 w-full rounded-md" />
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Professional Information */}
        <div className="bg-white rounded-lg shadow-sm p-6">
          <Skeleton className="h-7 w-48 mb-6" />

          <div className="space-y-4">
            {[1, 2, 3, 4].map((i) => (
              <div key={i} className="grid grid-cols-4 gap-4 items-center">
                <Skeleton className="h-5 w-24" />
                <div className="col-span-3">
                  <Skeleton className="h-10 w-full rounded-md" />
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  )
}

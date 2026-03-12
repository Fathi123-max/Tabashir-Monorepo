import { Skeleton } from "@/components/ui/skeleton"

export default function WhatsappCommunityLoading() {
  return (
    <div className="flex items-center justify-center min-h-[calc(100vh-140px)]">
      <div className="bg-white rounded-lg shadow-sm p-8 max-w-md w-full">
        <div className="text-center space-y-6">
          <Skeleton className="h-8 w-3/4 mx-auto" />
          <Skeleton className="h-6 w-1/2 mx-auto" />
          <Skeleton className="h-12 w-full mt-4" />
        </div>
      </div>
    </div>
  )
}

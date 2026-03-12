import { Skeleton } from "@/components/ui/skeleton"

export default function LikedJobsLoading() {
  return (
    <div className="px-6 py-2 bg-white rounded-md mx-auto max-h-[calc(100vh-35px)] overflow-y-scroll">
      <div className="flex justify-center items-center h-64">
        <div className="w-8 h-8 border-4 border-blue-200 border-t-blue-500 rounded-full animate-spin"></div>
        <span className="ml-3 text-gray-600">Loading your favorite jobs...</span>
      </div>
    </div>
  );
}

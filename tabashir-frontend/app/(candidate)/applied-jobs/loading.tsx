import { Skeleton } from "@/components/ui/skeleton"
import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table"

export default function Loading() {
  return (
    <div className="container mx-auto py-6 max-w-7xl">
      <div className="bg-white rounded-lg shadow-sm">
        <div className="p-4">
          {/* Tabs */}
          <Tabs defaultValue="all" className="w-full">
            <TabsList className="grid grid-cols-6 h-10 mb-6 bg-transparent border-b">
              <TabsTrigger value="all">All</TabsTrigger>
              <TabsTrigger value="viewed">Viewed</TabsTrigger>
              <TabsTrigger value="interview">Interview</TabsTrigger>
              <TabsTrigger value="offers">Offers</TabsTrigger>
              <TabsTrigger value="rejected">Rejected</TabsTrigger>
              <TabsTrigger value="bookmark">Bookmark</TabsTrigger>
            </TabsList>
          </Tabs>

          {/* Search */}
          <div className="relative mb-6">
            <Skeleton className="h-10 w-full" />
          </div>

          {/* Table */}
          <div className="rounded-lg border overflow-hidden">
            <Table>
              <TableHeader className="bg-gray-50">
                <TableRow>
                  <TableHead className="font-medium text-xs uppercase text-gray-500 py-3">Job Title</TableHead>
                  <TableHead className="font-medium text-xs uppercase text-gray-500 py-3">Position</TableHead>
                  <TableHead className="font-medium text-xs uppercase text-gray-500 py-3">Job ID</TableHead>
                  <TableHead className="font-medium text-xs uppercase text-gray-500 py-3">Applied</TableHead>
                  <TableHead className="font-medium text-xs uppercase text-gray-500 py-3">Company</TableHead>
                  <TableHead className="font-medium text-xs uppercase text-gray-500 py-3">Location</TableHead>
                  <TableHead className="font-medium text-xs uppercase text-gray-500 py-3">Status</TableHead>
                  <TableHead className="font-medium text-xs uppercase text-gray-500 py-3 w-10"></TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {Array(10)
                  .fill(0)
                  .map((_, index) => (
                    <TableRow key={index}>
                      <TableCell>
                        <Skeleton className="h-5 w-32" />
                      </TableCell>
                      <TableCell>
                        <Skeleton className="h-5 w-24" />
                      </TableCell>
                      <TableCell>
                        <Skeleton className="h-5 w-16" />
                      </TableCell>
                      <TableCell>
                        <Skeleton className="h-5 w-20" />
                      </TableCell>
                      <TableCell>
                        <Skeleton className="h-5 w-24" />
                      </TableCell>
                      <TableCell>
                        <Skeleton className="h-5 w-28" />
                      </TableCell>
                      <TableCell>
                        <Skeleton className="h-6 w-20 rounded-md" />
                      </TableCell>
                      <TableCell>
                        <Skeleton className="h-8 w-8 rounded-full" />
                      </TableCell>
                    </TableRow>
                  ))}
              </TableBody>
            </Table>
          </div>

          {/* Pagination */}
          <div className="flex items-center justify-between mt-4">
            <Skeleton className="h-8 w-40" />
            <Skeleton className="h-8 w-64" />
          </div>
        </div>
      </div>
    </div>
  )
}

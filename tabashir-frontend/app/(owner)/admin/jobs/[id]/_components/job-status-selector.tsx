"use client"

import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { JobStatus } from "@prisma/client"
import { updateJobStatus } from "../actions"
import { toast } from "sonner"

interface JobStatusSelectorProps {
  jobId: string
  currentStatus: JobStatus
}

export function JobStatusSelector({ jobId, currentStatus }: JobStatusSelectorProps) {
 

  const handleStatusChange = async (value: string) => {
    const result = await updateJobStatus(jobId, value as JobStatus)
    console.log(result)
     if(result.success){
        return toast.success(result.message, {
            className:"bg-green-500 text-white"
        })
     }else{
        return toast.error(result.message, {
            className:"bg-red-500 text-white"
        })
     }
  }

  const getStatusColor = (status: JobStatus) => {
    switch (status) {
      case "ACTIVE":
        return "bg-green-500"
      case "PAUSED":
        return "bg-amber-500"
      case "CLOSED":
        return "bg-red-500"
      default:
        return "bg-gray-500"
    }
  }

  return (
    <Select 
      defaultValue={currentStatus}
      onValueChange={handleStatusChange}
    >
      <SelectTrigger className="w-32 h-8 text-sm border-none focus:ring-0 focus:ring-offset-0 p-0 justify-end">
        <div className="flex items-center">
          
          <SelectValue placeholder="Status" className="capitalize" />
        </div>
      </SelectTrigger>
      <SelectContent>
        <SelectItem value="ACTIVE" className="flex items-center">
          <div className="flex items-center">
            <div className="w-3 h-3 bg-green-500 rounded-full mr-2"></div>
            <span>Active</span>
          </div>
        </SelectItem>
        <SelectItem value="PAUSED" className="flex items-center">
          <div className="flex items-center">
            <div className="w-3 h-3 bg-amber-500 rounded-full mr-2"></div>
            <span>Paused</span>
          </div>
        </SelectItem>
        <SelectItem value="CLOSED" className="flex items-center">
          <div className="flex items-center">
            <div className="w-3 h-3 bg-red-500 rounded-full mr-2"></div>
            <span>Closed</span>
          </div>
        </SelectItem>
      </SelectContent>
    </Select>
  )
} 
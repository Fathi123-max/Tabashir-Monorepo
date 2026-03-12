export interface JobApplication {
  id: number
  jobTitle: string
  position: string
  jobId: string
  applied: string
  company: string
  location: string
  status: "Pending" | "Rejected" | "Viewed" | "Interview" | "Offer"
}

export type TabType = "all" | "viewed" | "interview" | "offers" | "rejected" | "bookmark"

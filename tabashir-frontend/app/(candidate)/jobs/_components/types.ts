import { JSONContent } from "@tiptap/react"

export interface Job {
  id: string
  title: string
  website?: string
  applyUrl?: string
  company: string
  logo: string
  entity: string
  location: string
  nationality?: string
  email: string
  country?: string
  gender?: string
  views?: number
  postedTime: string
  jobType: string
  applicationsCount?: number
  salary: {
    amount: number | string
    currency: string
    period: string
  }
  match?: any
  team?: string
  department?: string
  qualifications?: string[]
  experience?: string[]
  locationDetails?: {
    type: string
    place: string
  }
  jobTypes?: string[]
  skills?: {
    name: string
    color: string
  }[]
  perks?: string[],
  isLikded?:boolean,
  description?: string
  requirements?: string
  companyDescription?:string
}

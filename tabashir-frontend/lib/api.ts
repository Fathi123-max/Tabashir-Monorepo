import { getSession, useSession } from "next-auth/react"

const token = process.env.NEXT_PUBLIC_API_TOKEN;

export const getJobs = async (
  email?: string,
  location?: string,
  jobType?: string,
  salaryMin?: string,
  salaryMax?: string,
  experience?: string,
  attendance?: string,
  query?: string,
  sort?: "job_date_desc" | "job_date_asc" | "salary_asc" | "salary_desc",
  page: number = 1,
  limit: number = 60,
  lang: string = "en"
) => {
  const session = await getSession()
  try {
    const params = new URLSearchParams()
    // Add filters only if they have values
    if (email) params.append("email", email)
    if (location) params.append("location", location)
    if (jobType) params.append("jobType", jobType)
    if (salaryMin) params.append("salaryMin", salaryMin)
    if (salaryMax) params.append("salaryMax", salaryMax)
    if (experience) params.append("experience", experience)
    if (attendance) params.append("attendance", attendance)
    if (query) params.append("search", query)
    if (sort) params.append("sort", sort)
    if (lang) params.append("lang", lang)

    // Add pagination parameters
    params.append("page", page.toString())
    params.append("limit", limit.toString())
    params.append("email", session?.user?.email || "")

    console.log(params.toString())

    const response = await fetch(
      `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/v1/resume/jobs?${params.toString()}`,
      {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          "X-API-TOKEN": `${token}`,
        },
      },
    )
    const data = await response.json()
    return { success: data.success, data: data.jobs, pagination: data.pagination }
  } catch (error) {
    console.error(error)
    return { success: false, error: error }
  }
}

export const getJobById = async (jobId: string, lang: string = "en") => {
  try {
    const response = await fetch(
      `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/v1/resume/jobs/${jobId}?lang=${lang}`,
      {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          "X-API-TOKEN": `${token}`,
        },
      },
    )
    const data = await response.json()
    return { success: data.success, data: data.job }
  } catch (error) {
    console.error(error)
    return { success: false, error: error }
  }
}

export const createJobAPI = async (jobData: {
  entity: string
  nationality: string
  gender: string
  job_title: string
  academic_qualification: string
  experience: string
  languages: string
  salary: string
  vacancy_city: string
  working_hours: string
  working_days: string
  application_email: string
  job_description: string
  job_date: string
  link: string
  phone: string
}) => {
  try {
    const response = await fetch(
      `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/v1/resume/jobs`,
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-API-TOKEN": `${token}`,
        },
        body: JSON.stringify(jobData),
      }
    )
    const data = await response.json()
    return { success: response.ok, data: data }
  } catch (error) {
    console.error(error)
    return { success: false, error: error }
  }
}

export const updateJobAPI = async (jobId: string, jobData: {
  entity: string
  nationality: string
  gender: string
  job_title: string
  academic_qualification: string
  experience: string
  languages: string
  salary: string
  vacancy_city: string
  working_hours: string
  working_days: string
  application_email: string
  job_description: string
  job_date: string
  apply_url: string
  phone: string
  source: string
  company_name: string
  website_url: string
  job_type: string
}) => {
  try {
    console.log("Updating job with ID:", jobId, "Data:", jobData);
    const response = await fetch(
      `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/v1/resume/jobs/${jobId}`,
      {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          "X-API-TOKEN": `${token}`,
        },
        body: JSON.stringify({
          job_id: jobId,
          payload: jobData
        }),
      }
    )
    const data = await response.json()
    return { success: response.ok, data: data }
  } catch (error) {
    console.error(error)
    return { success: false, error: error }
  }
}

export const getApplicationsByJobId = async (jobId: string) => {
  try {
    const response = await fetch(
      `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/v1/resume/jobs/${jobId}/applicants-count`,
      {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          "X-API-TOKEN": `${token}`,
        },
      }
    )
    const data = await response.json()
    return { success: response.ok, data: data }
  } catch (error) {
    console.error(error)
    return { success: false, error: error }
  }
}

export const getJobByApiId = async (jobId: string) => {
  try {
    const response = await fetch(
      `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/v1/resume/jobs/${jobId}`,
      {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          "X-API-TOKEN": `${token}`,
        },
      }
    )
    const data = await response.json()
    return { success: response.ok, data: data }
  } catch (error) {
    console.error(error)
    return { success: false, error: error }
  }
}

export const deleteJobAPI = async (jobId: string) => {
  try {
    const response = await fetch(
      `${process.env.NEXT_PUBLIC_BACKEND_URL}/api/v1/resume/jobs/${jobId}`,
      {
        method: "DELETE",
        headers: {
          "Content-Type": "application/json",
          "X-API-TOKEN": `${token}`,
        },
      }
    )
    const data = await response.json()
    return { success: response.ok, data: data }
  } catch (error) {
    console.error(error)
    return { success: false, error: error }
  }
}


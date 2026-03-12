export const transformJobs = (jobs: any) => {
  if (!jobs) return []
  try {
  return jobs.map((job: any) => ({
    id: job.id.toString(),
    title: job.job_title,
    company: job.entity,
    logo: job.logo,
    entity: job.entity,
    location: job.vacancy_city,
    email: job.application_email,
    gender: job.gender,
    experience: job.experience,
    postedTime: job.job_date,
    jobType: job.working_days,
    salary: {
      amount: job.salary || 0,
      currency: "AED",
      period: "month"
    },
    applyUrl: job.apply_url || job.link,
    website: job.website || job.link,
    job: job.source,
    description: job.job_description,
    requirements: job.academic_qualification,
    department: job.job_title,
    team: job.entity,
    match: job.match_score as any,
  })).filter((job: any) => job.title !== "Nan" && job.title !== "nan")
  } catch (error) {
    console.error("Error transforming jobs:", error, jobs)
    return []
  }
}


export const transformJob = (job: any) => {
  return {
    id: job.id.toString(),
    title: job.job_title,
    company: job.entity,
    logo: job.logo,
    entity: job.entity,
    location: job.vacancy_city,
    email: job.application_email,
    gender: job.gender,
    experience: job.experience,
    postedTime: job.job_date,
    jobType: job.working_days,
    salary: {
      amount: job.salary,
      currency: "AED",
      period: "month"
    },
    applyUrl: job.apply_url || job.link,
    website: job.website || job.link,
    job: job.source,
    description: job.job_description,
    requirements: job.academic_qualification,
    department: job.job_title,
    team: job.entity,
    match: job.match_score as any,
  }
}

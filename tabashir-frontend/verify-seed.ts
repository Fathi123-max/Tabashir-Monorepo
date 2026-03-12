import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

async function verifySeed() {
  console.log('🔍 Verifying seeded database...\n')

  const [
    totalUsers,
    adminUsers,
    candidateUsers,
    recruiterUsers,
    totalJobs,
    activeJobs,
    totalApplications,
    totalResumes,
    totalSubscriptions,
    totalCourses,
    totalSavedJobs
  ] = await Promise.all([
    prisma.user.count(),
    prisma.user.count({ where: { userType: 'ADMIN' } }),
    prisma.user.count({ where: { userType: 'CANDIDATE' } }),
    prisma.user.count({ where: { userType: 'RECURITER' } }),
    prisma.job.count(),
    prisma.job.count({ where: { isActive: true } }),
    prisma.jobApplication.count(),
    prisma.resume.count(),
    prisma.subscription.count(),
    prisma.course.count(),
    prisma.savedJobPost.count()
  ])

  console.log('📊 Database Statistics:')
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━')
  console.log(`Total Users:           ${totalUsers}`)
  console.log(`  - Admins:            ${adminUsers}`)
  console.log(`  - Candidates:        ${candidateUsers}`)
  console.log(`  - Recruiters:        ${recruiterUsers}`)
  console.log(`━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`)
  console.log(`Total Jobs:            ${totalJobs}`)
  console.log(`  - Active Jobs:       ${activeJobs}`)
  console.log(`━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`)
  console.log(`Total Applications:    ${totalApplications}`)
  console.log(`Total Resumes:         ${totalResumes}`)
  console.log(`Total Subscriptions:   ${totalSubscriptions}`)
  console.log(`Total Saved Jobs:      ${totalSavedJobs}`)
  console.log(`Total Courses:         ${totalCourses}`)
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n')

  console.log('👥 Sample Users:')
  const sampleUsers = await prisma.user.findMany({
    take: 5,
    select: { name: true, email: true, userType: true }
  })
  sampleUsers.forEach(user => {
    console.log(`   • ${user.name} (${user.email}) - ${user.userType}`)
  })
  console.log('')

  console.log('💼 Sample Jobs:')
  const sampleJobs = await prisma.job.findMany({
    take: 5,
    select: { title: true, company: true, location: true }
  })
  sampleJobs.forEach(job => {
    console.log(`   • ${job.title} at ${job.company} (${job.location})`)
  })
  console.log('')

  console.log('✅ Database verification complete!')
}

verifySeed()
  .then(() => prisma.$disconnect())
  .catch((e) => {
    console.error('❌ Error:', e)
    return prisma.$disconnect()
  })

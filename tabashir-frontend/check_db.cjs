const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

async function main() {
  try {
    // Check saved jobs
    const savedJobs = await prisma.savedJobPost.findMany({
      take: 3,
      include: {
        job: {
          select: {
            id: true,
            externalApiJobId: true,
            title: true,
          }
        }
      }
    })
    
    console.log('Saved Jobs (first 3):')
    console.log(JSON.stringify(savedJobs, null, 2))
    
    // Check if any jobs have externalApiJobId
    const jobsWithExternalId = await prisma.job.findMany({
      where: {
        externalApiJobId: { not: null }
      },
      take: 5
    })
    
    console.log('\nJobs with externalApiJobId (first 5):')
    console.log(JSON.stringify(jobsWithExternalId, null, 2))
    
  } catch (error) {
    console.error('Error:', error)
  } finally {
    await prisma.$disconnect()
  }
}

main()

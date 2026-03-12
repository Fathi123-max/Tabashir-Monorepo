import { PrismaClient, UserType, AdminRole, AdminPermission, JobStatus, AiResumeStatus, SkillLevel, LanguageProficiency, PlanType, SubscriptionStatus, PaymentStatus } from '@prisma/client'
import bcrypt from 'bcryptjs'

const prisma = new PrismaClient()

async function main() {
  console.log('🌱 Starting database seeding...')

  // Clean existing data
  console.log('Cleaning existing data...')
  await prisma.adminPermissionAssignment.deleteMany()
  await prisma.course.deleteMany()
  await prisma.payment.deleteMany()
  await prisma.subscription.deleteMany()
  await prisma.jobApplication.deleteMany()
  await prisma.savedJobPost.deleteMany()
  await prisma.jobLike.deleteMany()
  await prisma.job.deleteMany()
  await prisma.aiResume.deleteMany()
  await prisma.resume.deleteMany()
  await prisma.candidateProfile.deleteMany()
  await prisma.candidate.deleteMany()
  await prisma.recruiter.deleteMany()
  await prisma.owner.deleteMany()
  await prisma.user.deleteMany()

  // Hash password
  const hashedPassword = await bcrypt.hash('password123', 10)

  // 1. Create Admins
  console.log('Creating admins...')
  const admin1 = await prisma.user.create({
    data: {
      name: 'Super Admin',
      email: 'admin@tabashir.com',
      password: hashedPassword,
      userType: UserType.ADMIN,
      adminRole: AdminRole.SUPER_ADMIN,
      adminPermissions: {
        create: Object.values(AdminPermission).map(permission => ({
          permission
        }))
      }
    }
  })

  const admin2 = await prisma.user.create({
    data: {
      name: 'Regular Admin',
      email: 'admin2@tabashir.com',
      password: hashedPassword,
      userType: UserType.ADMIN,
      adminRole: AdminRole.REGULAR_ADMIN,
      adminPermissions: {
        create: [
          { permission: AdminPermission.MANAGE_USERS },
          { permission: AdminPermission.MANAGE_JOBS },
          { permission: AdminPermission.MANAGE_DASHBOARD }
        ]
      }
    }
  })

  // 2. Create Owners
  console.log('Creating owners...')
  const owner1 = await prisma.user.create({
    data: {
      name: 'John Owner',
      email: 'owner1@tabashir.com',
      password: hashedPassword,
      userType: UserType.ADMIN,
      adminRole: AdminRole.REGULAR_ADMIN,
      adminPermissions: {
        create: [
          { permission: AdminPermission.MANAGE_USERS },
          { permission: AdminPermission.MANAGE_JOBS }
        ]
      }
    }
  })

  const owner1Profile = await prisma.owner.create({
    data: {
      userId: owner1.id,
      phone: '+971501234567'
    }
  })

  const owner2 = await prisma.user.create({
    data: {
      name: 'Sarah Owner',
      email: 'owner2@tabashir.com',
      password: hashedPassword,
      userType: UserType.ADMIN,
      adminRole: AdminRole.REGULAR_ADMIN,
      adminPermissions: {
        create: [
          { permission: AdminPermission.MANAGE_APPLICATIONS },
          { permission: AdminPermission.MANAGE_DASHBOARD }
        ]
      }
    }
  })

  const owner2Profile = await prisma.owner.create({
    data: {
      userId: owner2.id,
      phone: '+971507654321'
    }
  })

  // 3. Create Recruiters
  console.log('Creating recruiters...')
  const recruiters = []
  const recruiterData = [
    {
      name: 'Ahmed Al-Rashid',
      email: 'ahmed@techcorp.com',
      companyName: 'TechCorp Solutions',
      contactPersonName: 'Ahmed Al-Rashid',
      phone: '+971501111111'
    },
    {
      name: 'Sarah Johnson',
      email: 'sarah@innovate.io',
      companyName: 'Innovate.io',
      contactPersonName: 'Sarah Johnson',
      phone: '+971502222222'
    },
    {
      name: 'Mohammed Hassan',
      email: 'mohammed@digitalpro.ae',
      companyName: 'Digital Pro',
      contactPersonName: 'Mohammed Hassan',
      phone: '+971503333333'
    },
    {
      name: 'Emma Williams',
      email: 'emma@futuretech.com',
      companyName: 'Future Tech',
      contactPersonName: 'Emma Williams',
      phone: '+971504444444'
    },
    {
      name: 'Khalid Al-Mansoori',
      email: 'khalid@cloudworks.ae',
      companyName: 'CloudWorks',
      contactPersonName: 'Khalid Al-Mansoori',
      phone: '+971505555555'
    }
  ]

  for (const rec of recruiterData) {
    const user = await prisma.user.create({
      data: {
        name: rec.name,
        email: rec.email,
        password: hashedPassword,
        userType: UserType.RECURITER
      }
    })
    const recruiter = await prisma.recruiter.create({
      data: {
        userId: user.id,
        companyName: rec.companyName,
        contactPersonName: rec.contactPersonName,
        phone: rec.phone
      }
    })
    recruiters.push({ user, recruiter })
  }

  // 4. Create Candidates
  console.log('Creating candidates...')
  const candidates = []
  const candidateData = [
    {
      name: 'Profile Test User',
      email: 'profiletest@tabashir.com',
      phone: '+971501234567',
      nationality: 'UAE',
      gender: 'Male',
      age: 27,
      jobType: 'Full-time',
      skills: ['JavaScript', 'React', 'Node.js', 'TypeScript', 'Next.js'],
      experience: '4 years',
      education: 'Bachelor of Computer Science',
      degree: 'BSc Computer Science',
      languages: ['English', 'Arabic']
    },
    {
      name: 'Ali Mohamed',
      email: 'ali@example.com',
      phone: '+971501234568',
      nationality: 'UAE',
      gender: 'Male',
      age: 28,
      jobType: 'Full-time',
      skills: ['JavaScript', 'React', 'Node.js', 'TypeScript'],
      experience: '5 years',
      education: 'Bachelor of Computer Science',
      degree: 'BSc Computer Science',
      languages: ['English', 'Arabic']
    },
    {
      name: 'Fatima Al-Zahra',
      email: 'fatima@example.com',
      phone: '+971501234569',
      nationality: 'UAE',
      gender: 'Female',
      age: 26,
      jobType: 'Full-time',
      skills: ['Python', 'Django', 'PostgreSQL', 'AWS'],
      experience: '3 years',
      education: 'Master of Software Engineering',
      degree: 'MSc Software Engineering',
      languages: ['English', 'Arabic', 'French']
    },
    {
      name: 'Omar Abdullah',
      email: 'omar@example.com',
      phone: '+971501234570',
      nationality: 'UAE',
      gender: 'Male',
      age: 30,
      jobType: 'Full-time',
      skills: ['Java', 'Spring Boot', 'Microservices', 'Kubernetes'],
      experience: '7 years',
      education: 'Bachelor of Computer Engineering',
      degree: 'BEng Computer Engineering',
      languages: ['English', 'Arabic']
    },
    {
      name: 'Aisha Al-Maktoum',
      email: 'aisha@example.com',
      phone: '+971501234571',
      nationality: 'UAE',
      gender: 'Female',
      age: 24,
      jobType: 'Part-time',
      skills: ['UI/UX Design', 'Figma', 'Adobe XD', 'Prototyping'],
      experience: '2 years',
      education: 'Bachelor of Design',
      degree: 'BDes Interaction Design',
      languages: ['English', 'Arabic']
    },
    {
      name: 'Hassan Ali',
      email: 'hassan@example.com',
      phone: '+971501234572',
      nationality: 'UAE',
      gender: 'Male',
      age: 32,
      jobType: 'Full-time',
      skills: ['DevOps', 'Docker', 'Jenkins', 'Terraform'],
      experience: '8 years',
      education: 'Bachelor of Information Technology',
      degree: 'BSc Information Technology',
      languages: ['English', 'Arabic']
    },
    {
      name: 'Layla Ahmed',
      email: 'layla@example.com',
      phone: '+971501234573',
      nationality: 'UAE',
      gender: 'Female',
      age: 27,
      jobType: 'Full-time',
      skills: ['Data Science', 'Machine Learning', 'Python', 'TensorFlow'],
      experience: '4 years',
      education: 'Master of Data Science',
      degree: 'MSc Data Science',
      languages: ['English', 'Arabic', 'Spanish']
    },
    {
      name: 'Youssef Ibrahim',
      email: 'youssef@example.com',
      phone: '+971501234574',
      nationality: 'UAE',
      gender: 'Male',
      age: 29,
      jobType: 'Contract',
      skills: ['Mobile Development', 'Flutter', 'React Native', 'iOS'],
      experience: '6 years',
      education: 'Bachelor of Software Engineering',
      degree: 'BSc Software Engineering',
      languages: ['English', 'Arabic', 'German']
    },
    {
      name: 'Noor Al-Sabah',
      email: 'noor@example.com',
      phone: '+971501234575',
      nationality: 'UAE',
      gender: 'Female',
      age: 25,
      jobType: 'Full-time',
      skills: ['Product Management', 'Agile', 'Scrum', 'Analytics'],
      experience: '3 years',
      education: 'Master of Business Administration',
      degree: 'MBA',
      languages: ['English', 'Arabic']
    },
    {
      name: 'Karim Mahmoud',
      email: 'karim@example.com',
      phone: '+971501234576',
      nationality: 'UAE',
      gender: 'Male',
      age: 31,
      jobType: 'Full-time',
      skills: ['Cybersecurity', 'Network Security', 'CISSP', 'Penetration Testing'],
      experience: '9 years',
      education: 'Bachelor of Cybersecurity',
      degree: 'BSc Cybersecurity',
      languages: ['English', 'Arabic']
    },
    {
      name: 'Zara Khan',
      email: 'zara@example.com',
      phone: '+971501234577',
      nationality: 'UAE',
      gender: 'Female',
      age: 23,
      jobType: 'Full-time',
      skills: ['Digital Marketing', 'SEO', 'Google Ads', 'Analytics'],
      experience: '2 years',
      education: 'Bachelor of Marketing',
      degree: 'BBA Marketing',
      languages: ['English', 'Arabic', 'Urdu']
    }
  ]

  for (const cand of candidateData) {
    const user = await prisma.user.create({
      data: {
        name: cand.name,
        email: cand.email,
        password: hashedPassword,
        userType: UserType.CANDIDATE,
        jobCount: Math.floor(Math.random() * 20),
        aiJobApplyCount: Math.floor(Math.random() * 10)
      }
    })
    const candidate = await prisma.candidate.create({
      data: {
        userId: user.id
      }
    })
    await prisma.candidateProfile.create({
      data: {
        candidateId: candidate.id,
        phone: cand.phone,
        nationality: cand.nationality,
        gender: cand.gender,
        languages: cand.languages,
        age: cand.age,
        jobType: cand.jobType,
        skills: cand.skills,
        experience: cand.experience,
        education: cand.education,
        degree: cand.degree,
        onboardingCompleted: true
      }
    })
    candidates.push({ user, candidate })
  }

  // 5. Create Jobs
  console.log('Creating jobs...')
  const jobs = []
  const jobTitles = [
    'Senior Full Stack Developer',
    'Frontend Developer',
    'Backend Developer',
    'DevOps Engineer',
    'UI/UX Designer',
    'Product Manager',
    'Data Scientist',
    'Mobile App Developer',
    'Cybersecurity Analyst',
    'Digital Marketing Specialist',
    'Cloud Architect',
    'Machine Learning Engineer',
    'Software Engineer',
    'Technical Lead',
    'Business Analyst'
  ]

  const companies = [
    'TechCorp Solutions',
    'Innovate.io',
    'Digital Pro',
    'Future Tech',
    'CloudWorks',
    'DataSystems Inc',
    'AI Technologies',
    'WebServices UAE',
    'MobileFirst',
    'SecureNet',
    'Marketing Plus',
    'DevStudio',
    'CodeCraft',
    'TechVenture',
    'Innovation Hub'
  ]

  for (let i = 0; i < 50; i++) {
    const isFromRecruiter = Math.random() > 0.5
    const randomRecruiter = recruiters[Math.floor(Math.random() * recruiters.length)]
    const randomOwner = Math.random() > 0.5 ? owner1Profile : owner2Profile

    const title = jobTitles[Math.floor(Math.random() * jobTitles.length)]
    const company = companies[Math.floor(Math.random() * companies.length)]
    const salaryMin = 5000 + Math.floor(Math.random() * 10000)
    const salaryMax = salaryMin + 2000 + Math.floor(Math.random() * 15000)
    const location = ['Dubai', 'Abu Dhabi', 'Sharjah', 'Ajman', 'Remote'][Math.floor(Math.random() * 5)]

    const job = await prisma.job.create({
      data: {
        title: `${title} - ${i + 1}`,
        company: company,
        companyDescription: `${company} is a leading technology company specializing in innovative solutions. We offer a dynamic work environment with opportunities for professional growth.`,
        companyLogo: `https://api.dicebear.com/7.x/avataaars/svg?seed=${company}`,
        jobType: ['Full-time', 'Part-time', 'Contract', 'Internship'][Math.floor(Math.random() * 4)],
        salaryMin,
        salaryMax,
        location,
        description: `We are looking for a talented ${title} to join our team. The ideal candidate will have experience in modern technologies and a passion for innovation.`,
        requirements: `• Bachelor's degree in related field\n• 3+ years of experience\n• Strong communication skills\n• Team player\n• Problem-solving abilities`,
        benefits: ['Health Insurance', 'Paid Time Off', 'Professional Development', 'Flexible Working Hours', 'Performance Bonus'],
        requiredSkills: ['JavaScript', 'TypeScript', 'React', 'Node.js', 'SQL'].slice(0, 3 + Math.floor(Math.random() * 3)),
        status: Math.random() > 0.2 ? JobStatus.ACTIVE : JobStatus.PAUSED,
        isActive: Math.random() > 0.1,
        ...(isFromRecruiter
          ? { recruiterId: randomRecruiter.recruiter.id }
          : { ownerId: randomOwner.id })
      }
    })
    jobs.push(job)
  }

  // 6. Create Job Applications
  console.log('Creating job applications...')
  for (const job of jobs) {
    const numApplications = Math.floor(Math.random() * 8) + 1
    for (let i = 0; i < numApplications; i++) {
      const randomCandidate = candidates[Math.floor(Math.random() * candidates.length)]
      const status = ['pending', 'reviewing', 'accepted', 'rejected'][Math.floor(Math.random() * 4)]
      const matchedScore = 60 + Math.floor(Math.random() * 41)

      await prisma.jobApplication.create({
        data: {
          jobId: job.id,
          userId: randomCandidate.user.id,
          status,
          matchedScore,
          applicationType: Math.random() > 0.8 ? 'easy_apply' : 'regular',
          isDismissed: status === 'rejected' && Math.random() > 0.5
        }
      })
    }
  }

  // 7. Create Saved Job Posts
  console.log('Creating saved job posts...')
  for (const candidate of candidates) {
    const numSaved = Math.floor(Math.random() * 10) + 2
    const shuffledJobs = [...jobs].sort(() => 0.5 - Math.random())
    for (let i = 0; i < Math.min(numSaved, shuffledJobs.length); i++) {
      try {
        await prisma.savedJobPost.create({
          data: {
            jobId: shuffledJobs[i].id,
            userId: candidate.user.id
          }
        })
      } catch (e) {
        // Ignore duplicate errors
      }
    }
  }

  // 8. Create Resumes
  console.log('Creating resumes...')
  for (const candidate of candidates) {
    const numResumes = Math.floor(Math.random() * 3) + 1
    for (let i = 0; i < numResumes; i++) {
      await prisma.resume.create({
        data: {
          candidateId: candidate.candidate.id,
          filename: `resume_${candidate.user.name}_${i + 1}.pdf`,
          originalUrl: `https://example.com/resumes/resume_${candidate.user.name}_${i + 1}.pdf`,
          formatedUrl: `https://example.com/resumes/formatted_${candidate.user.name}_${i + 1}.pdf`,
          formatedContent: `<html><body><h1>Resume for ${candidate.user.name}</h1><p>Professional experience...</p></body></html>`,
          isAiResume: Math.random() > 0.7
        }
      })
    }
  }

  // 9. Create AI Resumes
  console.log('Creating AI resumes...')
  for (const candidate of candidates) {
    const numAiResumes = Math.floor(Math.random() * 2)
    for (let i = 0; i < numAiResumes; i++) {
      const aiResume = await prisma.aiResume.create({
        data: {
          candidateId: candidate.candidate.id,
          status: AiResumeStatus.COMPLETED,
          progress: 100,
          paymentStatus: Math.random() > 0.5,
          paymentAmount: 99.99,
          paymentDate: new Date(),
          formatedUrl: `https://example.com/ai-resumes/${candidate.user.name}_ai_${i + 1}.pdf`,
          formatedContent: `<html><body><h1>AI-Optimized Resume for ${candidate.user.name}</h1></body></html>`
        }
      })

      // Create personal details
      await prisma.aiResumePersonalDetails.create({
        data: {
          aiResumeId: aiResume.id,
          fullName: candidate.user.name,
          email: candidate.user.email,
          phone: '+971501234567',
          country: 'UAE',
          city: 'Dubai',
          socialLinks: {
            create: [
              { label: 'LinkedIn', url: `https://linkedin.com/in/${candidate.user.name}` },
              { label: 'GitHub', url: `https://github.com/${candidate.user.name}` }
            ]
          }
        }
      })

      // Create professional details
      await prisma.aiProfessionalDetails.create({
        data: {
          aiResumeId: aiResume.id,
          summary: `Experienced professional with a strong background in technology and innovation.`
        }
      })

      // Create skills
      const skills = ['JavaScript', 'React', 'Node.js', 'TypeScript', 'Python', 'AWS', 'Docker']
      for (const skillName of skills.slice(0, 5)) {
        await prisma.aiSkill.create({
          data: {
            aiResumeId: aiResume.id,
            category: 'Technical Skills',
            name: skillName,
            level: SkillLevel.ADVANCED
          }
        })
      }

      // Create languages
      await prisma.aiLanguage.create({
        data: {
          aiResumeId: aiResume.id,
          name: 'English',
          proficiency: LanguageProficiency.ADVANCED
        }
      })
    }
  }

  // 10. Create Subscriptions
  console.log('Creating subscriptions...')
  const subscriptionPlans = [PlanType.BUSINESS, PlanType.PRO_PLAYER, PlanType.AI_JOB_APPLY]
  for (const candidate of candidates.slice(0, 15)) {
    const plan = subscriptionPlans[Math.floor(Math.random() * subscriptionPlans.length)]
    const subscription = await prisma.subscription.create({
      data: {
        userId: candidate.user.id,
        plan,
        status: SubscriptionStatus.ACTIVE,
        startDate: new Date(Date.now() - Math.random() * 90 * 24 * 60 * 60 * 1000),
        endDate: new Date(Date.now() + Math.random() * 180 * 24 * 60 * 60 * 1000),
        autoRenew: Math.random() > 0.5
      }
    })

    // Create payments for subscription
    const numPayments = Math.floor(Math.random() * 3) + 1
    for (let i = 0; i < numPayments; i++) {
      await prisma.payment.create({
        data: {
          subscriptionId: subscription.id,
          userId: candidate.user.id,
          amount: 99.99 + Math.random() * 200,
          status: PaymentStatus.COMPLETED,
          transactionId: `txn_${Date.now()}_${i}`,
          paymentDate: new Date(Date.now() - Math.random() * 60 * 24 * 60 * 60 * 1000)
        }
      })
    }
  }

  // 11. Create Courses
  console.log('Creating courses...')
  const coursesData = [
    {
      title: 'Complete Web Development Bootcamp',
      subtitle: 'Learn HTML, CSS, JavaScript, React, Node.js',
      description: 'A comprehensive course covering all aspects of modern web development. Perfect for beginners and intermediate developers.',
      imageUrl: 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=400',
      price: 199.99,
      isFree: false,
      courseUrl: 'https://example.com/courses/web-dev-bootcamp',
      studio: 'TechEdu',
      tags: ['BESTSELLER', 'COMPLETE'],
      category: 'Web Development'
    },
    {
      title: 'Python for Data Science',
      subtitle: 'Master Python, Pandas, NumPy, and Machine Learning',
      description: 'Learn Python programming and data science from scratch. Includes hands-on projects and real-world applications.',
      imageUrl: 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=400',
      price: 149.99,
      isFree: false,
      courseUrl: 'https://example.com/courses/python-data-science',
      studio: 'DataLearn',
      tags: ['NEW', 'HANDS-ON'],
      category: 'Data Science'
    },
    {
      title: 'Digital Marketing Fundamentals',
      subtitle: 'SEO, Social Media, Content Marketing',
      description: 'Learn the essentials of digital marketing including SEO, social media marketing, and content strategy.',
      imageUrl: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=400',
      price: 0,
      isFree: true,
      courseUrl: 'https://example.com/courses/digital-marketing',
      studio: 'Marketing Pro',
      tags: ['FREE'],
      category: 'Marketing'
    },
    {
      title: 'AWS Cloud Practitioner Certification',
      subtitle: 'Prepare for AWS Certification Exam',
      description: 'Complete preparation course for AWS Cloud Practitioner certification with practice exams and labs.',
      imageUrl: 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=400',
      price: 299.99,
      isFree: false,
      courseUrl: 'https://example.com/courses/aws-certification',
      studio: 'Cloud Academy',
      tags: ['BESTSELLER', 'CERTIFICATION'],
      category: 'Cloud Computing'
    },
    {
      title: 'UI/UX Design Masterclass',
      subtitle: 'Figma, Adobe XD, User Research',
      description: 'Learn to design beautiful and functional user interfaces with industry-standard tools.',
      imageUrl: 'https://images.unsplash.com/photo-1561070791-2526d30994b5?w=400',
      price: 179.99,
      isFree: false,
      courseUrl: 'https://example.com/courses/ui-ux-design',
      studio: 'Design Studio',
      tags: ['POPULAR'],
      category: 'Design'
    }
  ]

  for (const courseData of coursesData) {
    await prisma.course.create({
      data: {
        ...courseData,
        createdById: admin1.id
      }
    })
  }

  console.log('✅ Database seeding completed successfully!')
  console.log('\n📊 Summary:')
  console.log(`   • ${2} Admins created`)
  console.log(`   • ${2} Owners created`)
  console.log(`   • ${recruiters.length} Recruiters created`)
  console.log(`   • ${candidates.length} Candidates created`)
  console.log(`   • ${jobs.length} Jobs created`)
  console.log('   • Multiple job applications created')
  console.log('   • Multiple saved job posts created')
  console.log('   • Multiple resumes created')
  console.log('   • Multiple AI resumes created')
  console.log('   • Multiple subscriptions created')
  console.log('   • Multiple payments created')
  console.log(`   • ${coursesData.length} Courses created`)
  console.log('\n🔑 Default credentials:')
  console.log('   Admin: admin@tabashir.com / password123')
  console.log('   Recruiter: ahmed@techcorp.com / password123')
  console.log('   Candidate: ali@example.com / password123')
}

main()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (e) => {
    console.error('❌ Error seeding database:', e)
    await prisma.$disconnect()
    process.exit(1)
  })

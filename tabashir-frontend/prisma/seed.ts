import { PrismaClient, UserType, PlanType, SubscriptionStatus, PaymentStatus, JobStatus, AiResumeStatus, SkillLevel, LanguageProficiency, AdminRole, AdminPermission } from "@prisma/client";
import { faker } from "@faker-js/faker";
import * as bcrypt from "bcryptjs";

const prisma = new PrismaClient();

// ─── Constants ───────────────────────────────────────────────────────────────

const DEFAULT_PASSWORD = "Password123!";
const SALT_ROUNDS = 10;

const UAE_LOCATIONS = [
  "Dubai, UAE",
  "Abu Dhabi, UAE",
  "Sharjah, UAE",
  "Ajman, UAE",
  "Ras Al Khaimah, UAE",
  "Al Ain, UAE",
  "DIFC, Dubai, UAE",
  "Dubai Internet City, UAE",
  "Dubai Media City, UAE",
  "Dubai Silicon Oasis, UAE",
];

const GCC_LOCATIONS = [
  "Riyadh, Saudi Arabia",
  "Jeddah, Saudi Arabia",
  "Doha, Qatar",
  "Manama, Bahrain",
  "Muscat, Oman",
  "Kuwait City, Kuwait",
];

const ALL_LOCATIONS = [...UAE_LOCATIONS, ...GCC_LOCATIONS];

const ARABIC_FIRST_NAMES = [
  "Ahmed", "Mohammed", "Fatima", "Aisha", "Omar", "Khalid", "Sara", "Noura",
  "Abdullah", "Mariam", "Hassan", "Layla", "Youssef", "Rania", "Tariq", "Huda",
  "Sultan", "Amira", "Rashid", "Dana", "Faisal", "Salma", "Mansour", "Reem",
  "Ibrahim", "Zahra", "Ali", "Maha", "Hamdan", "Lina",
];

const WESTERN_FIRST_NAMES = [
  "James", "Emma", "Michael", "Sophia", "David", "Olivia", "John", "Isabella",
  "Robert", "Mia", "William", "Charlotte", "Richard", "Amelia", "Joseph", "Harper",
  "Thomas", "Evelyn", "Charles", "Abigail", "Christopher", "Ella", "Daniel", "Scarlett",
  "Matthew", "Grace", "Anthony", "Chloe", "Mark", "Victoria",
];

const ARABIC_LAST_NAMES = [
  "Al Maktoum", "Al Nahyan", "Al Qasimi", "Al Nuaimi", "Al Sharqi", "Al Mualla",
  "Al Mansoori", "Al Ketbi", "Al Mazrouei", "Al Dhaheri", "Al Hammadi", "Al Shamsi",
  "Al Kaabi", "Al Marri", "Al Muhairi", "Al Suwaidi", "Al Blooshi", "Al Falasi",
  "Al Hashimi", "Al Qubaisi",
];

const WESTERN_LAST_NAMES = [
  "Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis",
  "Rodriguez", "Martinez", "Hernandez", "Lopez", "Gonzalez", "Wilson", "Anderson",
  "Thomas", "Taylor", "Moore", "Jackson", "Martin", "Lee", "Perez", "Thompson",
  "White", "Harris", "Sanchez", "Clark", "Ramirez", "Lewis", "Robinson",
];

const COMPANIES = [
  "Emirates Group", "Etihad Airways", "ADNOC", "Emaar Properties", "Dubai Holding",
  "Mubadala Investment", "DP World", "Flydubai", "Dubai Airports", "TAQA",
  "Mashreq Bank", "FAB - First Abu Dhabi Bank", "Emirates NBD", "Dubai Islamic Bank",
  "Etisalat", "du Telecom", "Careem", "Talabat", "Noon", "Souq.com",
  "Microsoft UAE", "Amazon AWS Middle East", "Google Cloud Dubai", "Oracle UAE",
  "IBM Middle East", "Deloitte UAE", "PwC Middle East", "EY Dubai", "KPMG UAE",
  "Accenture Middle East", "McKinsey Dubai", "BCG Abu Dhabi", "Boston Consulting",
  "Siemens UAE", "GE Healthcare ME", "Schneider Electric", "Honeywell ME",
  "Samsung Gulf", "Huawei UAE", "Cisco Systems ME",
];

const JOB_TITLES = [
  "Software Engineer", "Senior Software Engineer", "Lead Software Engineer",
  "Principal Software Engineer", "Junior Software Engineer",
  "Frontend Developer", "Backend Developer", "Full Stack Developer",
  "Mobile Developer", "DevOps Engineer", "Cloud Architect",
  "Data Scientist", "Senior Data Scientist", "Data Engineer", "Data Analyst",
  "Machine Learning Engineer", "AI Research Scientist",
  "Product Manager", "Senior Product Manager", "Director of Product",
  "UX Designer", "Senior UX Designer", "UI/UX Designer", "UX Researcher",
  "Marketing Manager", "Digital Marketing Specialist", "Content Marketing Manager",
  "Sales Director", "Business Development Manager", "Account Executive",
  "HR Specialist", "HR Manager", "Talent Acquisition Specialist",
  "Finance Analyst", "Senior Finance Analyst", "Financial Controller",
  "Project Manager", "Scrum Master", "Agile Coach",
  "QA Engineer", "Senior QA Engineer", "Test Automation Engineer",
  "Security Engineer", "Cybersecurity Analyst", "Information Security Manager",
  "Solutions Architect", "Technical Lead", "Engineering Manager",
  "CTO", "VP of Engineering", "Head of Technology",
];

const SKILLS_POOL = [
  "JavaScript", "TypeScript", "Python", "Java", "C#", "Go", "Rust", "Ruby",
  "PHP", "Swift", "Kotlin", "Dart", "React", "Next.js", "Vue.js", "Angular",
  "Node.js", "Express.js", "Django", "Flask", "FastAPI", "Spring Boot",
  "Flutter", "React Native", "iOS Development", "Android Development",
  "AWS", "Azure", "GCP", "Docker", "Kubernetes", "Terraform", "Ansible",
  "PostgreSQL", "MySQL", "MongoDB", "Redis", "Elasticsearch", "DynamoDB",
  "GraphQL", "REST API", "Microservices", "Serverless", "CI/CD",
  "Git", "GitHub", "GitLab", "Jenkins", "CircleCI",
  "Agile", "Scrum", "Kanban", "Jira", "Confluence",
  "Figma", "Adobe XD", "Sketch", "UI/UX Design", "Design Systems",
  "Machine Learning", "Deep Learning", "NLP", "Computer Vision", "TensorFlow", "PyTorch",
  "SQL", "NoSQL", "Data Analysis", "Data Visualization", "Tableau", "Power BI",
  "Blockchain", "Web3", "Solidity",
  "Communication", "Leadership", "Problem Solving", "Team Management",
];

const BENEFITS_POOL = [
  "Health Insurance", "Dental Insurance", "Vision Insurance",
  "Annual Flight Tickets", "Housing Allowance", "Transportation Allowance",
  "Education Allowance", "Gym Membership", "Free Parking",
  "Flexible Working Hours", "Remote Work Options", "Hybrid Work Model",
  "Annual Leave 30 Days", "End of Service Gratuity", "Life Insurance",
  "Professional Development Budget", "Conference Attendance",
  "Stock Options", "Performance Bonus", "Signing Bonus",
  "Relocation Assistance", "Visa Sponsorship", "Family Visa Support",
  "Childcare Support", "Mental Health Support", "Wellness Program",
];

const NATIONALITIES = [
  "Emirati", "Saudi", "Qatari", "Bahraini", "Omani", "Kuwaiti",
  "Indian", "Pakistani", "Bangladeshi", "Filipino", "Egyptian",
  "Jordanian", "Lebanese", "Syrian", "Iraqi", "Moroccan",
  "British", "American", "Canadian", "Australian", "German",
  "French", "South African", "Kenyan", "Nigerian",
];

const LANGUAGES_POOL = ["English", "Arabic", "Hindi", "Urdu", "Tagalog", "French", "Spanish", "German", "Russian", "Mandarin"];

const EDUCATION_LEVELS = [
  "High School", "Associate Degree", "Bachelor's Degree", "Master's Degree", "PhD", "MBA",
];

const DEGREES = [
  "Computer Science", "Software Engineering", "Information Technology",
  "Business Administration", "Marketing", "Finance", "Accounting",
  "Data Science", "Artificial Intelligence", "Cybersecurity",
  "Electrical Engineering", "Mechanical Engineering", "Civil Engineering",
  "Human Resources", "Communications", "Graphic Design",
];

const JOB_TYPES = ["Full-time", "Part-time", "Contract", "Freelance", "Internship"];

const COURSE_CATEGORIES = ["Technology", "Business", "Design", "Marketing", "Data Science", "AI & ML", "Cloud Computing", "Cybersecurity"];

const NOTIFICATION_TYPES = ["job_match", "application_update", "interview_scheduled", "application_reviewed", "new_job_posted", "subscription_renewal", "payment_received", "profile_viewed"];

// ─── Helpers ─────────────────────────────────────────────────────────────────

function randomFromArray<T>(arr: T[], min = 1, max?: number): T[] {
  const count = faker.number.int({ min, max: max ?? Math.min(arr.length, 8) });
  const shuffled = [...arr].sort(() => 0.5 - Math.random());
  return shuffled.slice(0, count);
}

function randomDate(start: Date, end: Date): Date {
  return new Date(start.getTime() + Math.random() * (end.getTime() - start.getTime()));
}

function generateEmail(firstName: string, lastName: string, index: number): string {
  const domains = ["gmail.com", "outlook.com", "yahoo.com", "hotmail.com", "protonmail.com", "icloud.com"];
  const separators = [".", "_", ""];
  const sep = separators[faker.number.int({ min: 0, max: separators.length - 1 })];
  const domain = domains[faker.number.int({ min: 0, max: domains.length - 1 })];
  return `${firstName.toLowerCase()}${sep}${lastName.toLowerCase()}${index}@${domain}`;
}

async function hashPassword(password: string): Promise<string> {
  return bcrypt.hash(password, SALT_ROUNDS);
}

// ─── Seed Function ───────────────────────────────────────────────────────────

async function main() {
  console.log("🌱 Starting database seed...\n");

  // Clear existing data (in reverse order of dependencies)
  console.log("🗑️  Clearing existing data...");
  await prisma.$transaction([
    prisma.adminPermissionAssignment.deleteMany(),
    prisma.notification.deleteMany(),
    prisma.course.deleteMany(),
    prisma.savedJobPost.deleteMany(),
    prisma.jobApplication.deleteMany(),
    prisma.jobLike.deleteMany(),
    prisma.job.deleteMany(),
    prisma.payment.deleteMany(),
    prisma.subscription.deleteMany(),
    prisma.aiSocialLink.deleteMany(),
    prisma.aiResumePersonalDetails.deleteMany(),
    prisma.aiProfessionalDetails.deleteMany(),
    prisma.aiEmploymentHistory.deleteMany(),
    prisma.aiEducation.deleteMany(),
    prisma.aiSkill.deleteMany(),
    prisma.aiLanguage.deleteMany(),
    prisma.aiResume.deleteMany(),
    prisma.resume.deleteMany(),
    prisma.candidateProfile.deleteMany(),
    prisma.candidate.deleteMany(),
    prisma.recruiter.deleteMany(),
    prisma.owner.deleteMany(),
    prisma.session.deleteMany(),
    prisma.account.deleteMany(),
    prisma.user.deleteMany(),
  ]);
  console.log("✅ Existing data cleared.\n");

  const hashedPassword = await hashPassword(DEFAULT_PASSWORD);

  // ─── Users ───────────────────────────────────────────────────────────────
  console.log("👤 Creating users...");
  const users: { id: string; email: string; name: string; userType: UserType }[] = [];

  // 5 Admin users
  const adminUsers: { id: string; email: string; name: string }[] = [];
  for (let i = 0; i < 5; i++) {
    const firstName = faker.person.firstName();
    const lastName = faker.person.lastName();
    const user = await prisma.user.create({
      data: {
        name: `${firstName} ${lastName}`,
        email: `admin${i}@tabashir.com`,
        password: hashedPassword,
        userType: UserType.ADMIN,
        adminRole: i === 0 ? AdminRole.SUPER_ADMIN : AdminRole.REGULAR_ADMIN,
      },
    });
    adminUsers.push({ id: user.id, email: user.email!, name: user.name! });
    users.push({ id: user.id, email: user.email!, name: user.name!, userType: UserType.ADMIN });
  }

  // 8 Owner users
  const ownerUsers: { id: string; email: string; name: string }[] = [];
  for (let i = 0; i < 8; i++) {
    const firstName = faker.person.firstName();
    const lastName = faker.person.lastName();
    const user = await prisma.user.create({
      data: {
        name: `${firstName} ${lastName}`,
        email: `owner${i}@tabashir.com`,
        password: hashedPassword,
        userType: UserType.ADMIN,
      },
    });
    ownerUsers.push({ id: user.id, email: user.email!, name: user.name! });
    users.push({ id: user.id, email: user.email!, name: user.name!, userType: UserType.ADMIN });
  }

  // 15 Recruiter users
  const recruiterUsers: { id: string; email: string; name: string }[] = [];
  for (let i = 0; i < 15; i++) {
    const firstName = faker.person.firstName();
    const lastName = faker.person.lastName();
    const user = await prisma.user.create({
      data: {
        name: `${firstName} ${lastName}`,
        email: `recruiter${i}@tabashir.com`,
        password: hashedPassword,
        userType: UserType.RECURITER,
      },
    });
    recruiterUsers.push({ id: user.id, email: user.email!, name: user.name! });
    users.push({ id: user.id, email: user.email!, name: user.name!, userType: UserType.RECURITER });
  }

  // 55 Candidate users (mix of Arabic and Western names)
  const candidateUsers: { id: string; email: string; name: string }[] = [];
  for (let i = 0; i < 55; i++) {
    const useArabic = i < 25; // First 25 have Arabic names
    const firstName = useArabic
      ? ARABIC_FIRST_NAMES[faker.number.int({ min: 0, max: ARABIC_FIRST_NAMES.length - 1 })]
      : WESTERN_FIRST_NAMES[faker.number.int({ min: 0, max: WESTERN_FIRST_NAMES.length - 1 })];
    const lastName = useArabic
      ? ARABIC_LAST_NAMES[faker.number.int({ min: 0, max: ARABIC_LAST_NAMES.length - 1 })]
      : WESTERN_LAST_NAMES[faker.number.int({ min: 0, max: WESTERN_LAST_NAMES.length - 1 })];
    const user = await prisma.user.create({
      data: {
        name: `${firstName} ${lastName}`,
        email: generateEmail(firstName, lastName, i),
        password: hashedPassword,
        userType: UserType.CANDIDATE,
        image: faker.image.avatar(),
      },
    });
    candidateUsers.push({ id: user.id, email: user.email!, name: user.name! });
    users.push({ id: user.id, email: user.email!, name: user.name!, userType: UserType.CANDIDATE });
  }

  console.log(`✅ Created ${users.length} users (${adminUsers.length} admins, ${ownerUsers.length} owners, ${recruiterUsers.length} recruiters, ${candidateUsers.length} candidates)\n`);

  // ─── Admin Permissions ───────────────────────────────────────────────────
  console.log("🔑 Assigning admin permissions...");
  const allPermissions = Object.values(AdminPermission);
  for (const admin of adminUsers) {
    const isAdminSuper = admin.email === "admin0@tabashir.com";
    const permissions = isAdminSuper
      ? allPermissions
      : randomFromArray(allPermissions, 3, 7);
    for (const permission of permissions) {
      await prisma.adminPermissionAssignment.create({
        data: { userId: admin.id, permission },
      });
    }
  }
  console.log("✅ Admin permissions assigned.\n");

  // ─── Owners ──────────────────────────────────────────────────────────────
  console.log("🏢 Creating owners...");
  const owners: { id: string; userId: string }[] = [];
  for (const ownerUser of ownerUsers) {
    const owner = await prisma.owner.create({
      data: {
        userId: ownerUser.id,
        phone: faker.phone.number({ style: "international" }),
      },
    });
    owners.push({ id: owner.id, userId: owner.userId });
  }
  console.log(`✅ Created ${owners.length} owners.\n`);

  // ─── Recruiters ──────────────────────────────────────────────────────────
  console.log("🏭 Creating recruiters...");
  const recruiters: { id: string; userId: string; companyName: string }[] = [];
  const usedCompanies = new Set<string>();
  for (const recruiterUser of recruiterUsers) {
    let company = COMPANIES[faker.number.int({ min: 0, max: COMPANIES.length - 1 })];
    while (usedCompanies.has(company)) {
      company = COMPANIES[faker.number.int({ min: 0, max: COMPANIES.length - 1 })];
    }
    usedCompanies.add(company);
    const recruiter = await prisma.recruiter.create({
      data: {
        userId: recruiterUser.id,
        companyName: company,
        contactPersonName: recruiterUser.name,
        phone: faker.phone.number({ style: "international" }),
      },
    });
    recruiters.push({ id: recruiter.id, userId: recruiter.userId, companyName: company });
  }
  console.log(`✅ Created ${recruiters.length} recruiters.\n`);

  // ─── Candidates & Profiles ───────────────────────────────────────────────
  console.log("👨‍💼 Creating candidates and profiles...");
  const candidates: { id: string; userId: string; profileId?: string }[] = [];
  for (const candidateUser of candidateUsers) {
    const candidate = await prisma.candidate.create({
      data: {
        userId: candidateUser.id,
      },
    });

    // 45 out of 55 candidates get profiles
    if (faker.number.int({ min: 0, max: 10 }) < 9) {
      const profile = await prisma.candidateProfile.create({
        data: {
          candidateId: candidate.id,
          phone: faker.phone.number({ style: "international" }),
          nationality: NATIONALITIES[faker.number.int({ min: 0, max: NATIONALITIES.length - 1 })],
          gender: faker.helpers.arrayElement(["Male", "Female", "Other"]),
          languages: randomFromArray(LANGUAGES_POOL, 1, 4),
          age: faker.number.int({ min: 22, max: 55 }),
          profilePicture: faker.image.avatar(),
          jobType: faker.helpers.arrayElement(JOB_TYPES),
          skills: randomFromArray(SKILLS_POOL, 3, 10),
          experience: faker.helpers.arrayElement([
            "0-1 years", "1-3 years", "3-5 years", "5-8 years", "8-12 years", "12+ years",
          ]),
          education: faker.helpers.arrayElement(EDUCATION_LEVELS),
          degree: `${faker.helpers.arrayElement(DEGREES)}`,
          location: faker.helpers.arrayElement(ALL_LOCATIONS),
          linkedin: faker.internet.url(),
          onboardingCompleted: faker.datatype.boolean(0.7),
        },
      });
      candidates.push({ id: candidate.id, userId: candidate.userId, profileId: profile.id });
    } else {
      candidates.push({ id: candidate.id, userId: candidate.userId });
    }
  }
  console.log(`✅ Created ${candidates.length} candidates (${candidates.filter(c => c.profileId).length} with profiles).\n`);

  // ─── Jobs ────────────────────────────────────────────────────────────────
  console.log("💼 Creating jobs...");
  const jobs: { id: string; title: string; company: string }[] = [];
  const now = new Date();

  for (let i = 0; i < 40; i++) {
    const title = JOB_TITLES[faker.number.int({ min: 0, max: JOB_TITLES.length - 1 })];
    const company = COMPANIES[faker.number.int({ min: 0, max: COMPANIES.length - 1 })];
    const isOwnerJob = faker.datatype.boolean(0.3);
    const salaryMin = faker.number.int({ min: 5000, max: 25000 });
    const salaryMax = salaryMin + faker.number.int({ min: 5000, max: 20000 });

    const job = await prisma.job.create({
      data: {
        title,
        company,
        companyDescription: faker.company.catchPhrase() + ". " + faker.lorem.paragraph({ min: 2, max: 4 }),
        companyLogo: faker.image.url(),
        jobType: faker.helpers.arrayElement(JOB_TYPES),
        salaryMin,
        salaryMax,
        location: faker.helpers.arrayElement(ALL_LOCATIONS),
        description: faker.lorem.paragraphs({ min: 3, max: 6 }),
        requirements: faker.lorem.paragraphs({ min: 2, max: 5 }),
        benefits: randomFromArray(BENEFITS_POOL, 3, 8),
        applicationDeadline: faker.datatype.boolean(0.4)
          ? new Date(now.getTime() + faker.number.int({ min: 7, max: 90 }) * 24 * 60 * 60 * 1000)
          : null,
        contactEmail: `careers@${company.toLowerCase().replace(/\s+/g, "")}.com`,
        contactPhone: faker.phone.number({ style: "international" }),
        requiredSkills: randomFromArray(SKILLS_POOL, 3, 8),
        views: faker.number.int({ min: 50, max: 5000 }),
        applicationsCount: faker.number.int({ min: 0, max: 200 }),
        status: faker.helpers.arrayElement([JobStatus.ACTIVE, JobStatus.ACTIVE, JobStatus.ACTIVE, JobStatus.PAUSED, JobStatus.CLOSED]),
        isActive: faker.datatype.boolean(0.85),
        ownerId: isOwnerJob ? owners[faker.number.int({ min: 0, max: owners.length - 1 })].id : null,
        recruiterId: !isOwnerJob ? recruiters[faker.number.int({ min: 0, max: recruiters.length - 1 })].id : null,
      },
    });
    jobs.push({ id: job.id, title: job.title, company: job.company });
  }
  console.log(`✅ Created ${jobs.length} jobs.\n`);

  // ─── Job Applications ────────────────────────────────────────────────────
  console.log("📋 Creating job applications...");
  const applications: { id: string }[] = [];
  const candidateWithProfiles = candidates.filter(c => c.profileId);

  for (let i = 0; i < 60; i++) {
    const candidate = candidateWithProfiles[faker.number.int({ min: 0, max: candidateWithProfiles.length - 1 })];
    const job = jobs[faker.number.int({ min: 0, max: jobs.length - 1 })];

    const application = await prisma.jobApplication.create({
      data: {
        userId: candidate.userId,
        jobId: job.id,
        matchedScore: faker.number.int({ min: 30, max: 98 }),
        status: faker.helpers.arrayElement(["pending", "reviewed", "shortlisted", "interviewed", "rejected", "hired"]),
        applicationType: faker.helpers.arrayElement(["regular", "easy_apply"]),
        isDismissed: faker.datatype.boolean(0.1),
        appliedAt: randomDate(new Date(now.getTime() - 90 * 24 * 60 * 60 * 1000), now),
      },
    });
    applications.push({ id: application.id });
  }
  console.log(`✅ Created ${applications.length} job applications.\n`);

  // ─── Resumes ─────────────────────────────────────────────────────────────
  console.log("📄 Creating resumes...");
  const resumes: { id: string; candidateId: string }[] = [];
  for (let i = 0; i < 25; i++) {
    const candidate = candidates[faker.number.int({ min: 0, max: candidates.length - 1 })];
    const resume = await prisma.resume.create({
      data: {
        candidateId: candidate.id,
        filename: `${faker.person.fullName()}_Resume.pdf`,
        originalUrl: faker.internet.url() + "/resumes/original.pdf",
        formatedUrl: faker.internet.url() + "/resumes/formatted.pdf",
        formatedContent: faker.lorem.paragraphs({ min: 5, max: 15 }),
        isAiResume: faker.datatype.boolean(0.3),
        sourceData: {
          name: faker.person.fullName(),
          email: faker.internet.email(),
          phone: faker.phone.number(),
          skills: randomFromArray(SKILLS_POOL, 3, 8),
        },
      },
    });
    resumes.push({ id: resume.id, candidateId: resume.candidateId });
  }
  console.log(`✅ Created ${resumes.length} resumes.\n`);

  // ─── AI Resumes ──────────────────────────────────────────────────────────
  console.log("🤖 Creating AI resumes...");
  const aiResumes: { id: string; candidateId: string }[] = [];
  for (let i = 0; i < 15; i++) {
    const candidate = candidateWithProfiles[faker.number.int({ min: 0, max: candidateWithProfiles.length - 1 })];
    const status = faker.helpers.arrayElement([AiResumeStatus.DRAFT, AiResumeStatus.IN_PROGRESS, AiResumeStatus.COMPLETED]);
    const progress = status === AiResumeStatus.COMPLETED ? 100 : status === AiResumeStatus.IN_PROGRESS ? faker.number.int({ min: 20, max: 80 }) : faker.number.int({ min: 0, max: 20 });

    const aiResume = await prisma.aiResume.create({
      data: {
        candidateId: candidate.id,
        status,
        progress,
        paymentStatus: faker.datatype.boolean(0.6),
        paymentAmount: faker.datatype.boolean(0.6) ? faker.number.float({ min: 49, max: 199, fractionDigits: 2 }) : null,
        paymentDate: faker.datatype.boolean(0.6) ? randomDate(new Date(now.getTime() - 60 * 24 * 60 * 60 * 1000), now) : null,
        originalUrl: faker.internet.url() + "/ai-resumes/original.pdf",
        formatedUrl: faker.internet.url() + "/ai-resumes/formatted.pdf",
        formatedContent: faker.lorem.paragraphs({ min: 8, max: 20 }),
      },
    });

    // Personal Details
    const fullName = faker.person.fullName();
    const personalDetails = await prisma.aiResumePersonalDetails.create({
      data: {
        aiResumeId: aiResume.id,
        fullName,
        email: faker.internet.email(),
        phone: faker.phone.number({ style: "international" }),
        country: faker.helpers.arrayElement(["UAE", "Saudi Arabia", "Qatar", "Bahrain", "Oman"]),
        city: faker.helpers.arrayElement(["Dubai", "Abu Dhabi", "Riyadh", "Doha", "Manama", "Muscat"]),
      },
    });

    // Social Links
    for (let s = 0; s < faker.number.int({ min: 1, max: 3 }); s++) {
      await prisma.aiSocialLink.create({
        data: {
          personalDetailsId: personalDetails.id,
          label: faker.helpers.arrayElement(["LinkedIn", "GitHub", "Portfolio", "Twitter", "Behance"]),
          url: faker.internet.url(),
        },
      });
    }

    // Professional Details
    await prisma.aiProfessionalDetails.create({
      data: {
        aiResumeId: aiResume.id,
        summary: faker.lorem.paragraphs({ min: 2, max: 4 }),
      },
    });

    // Employment History
    for (let e = 0; e < faker.number.int({ min: 1, max: 4 }); e++) {
      const startDate = randomDate(new Date(2010, 0, 1), new Date(now.getTime() - 365 * 24 * 60 * 60 * 1000));
      const endDate = faker.datatype.boolean(0.3)
        ? null
        : randomDate(new Date(startDate.getTime() + 365 * 24 * 60 * 60 * 1000), now);
      await prisma.aiEmploymentHistory.create({
        data: {
          aiResumeId: aiResume.id,
          company: faker.company.name(),
          position: faker.helpers.arrayElement(JOB_TITLES),
          startDate,
          endDate,
          country: faker.helpers.arrayElement(["UAE", "Saudi Arabia", "India", "UK", "USA"]),
          city: faker.location.city(),
          current: endDate === null,
          description: faker.lorem.paragraphs({ min: 2, max: 4 }),
          achievements: randomFromArray([
            "Increased revenue by 25%",
            "Led team of 10+ engineers",
            "Reduced deployment time by 60%",
            "Implemented CI/CD pipeline",
            "Mentored junior developers",
            "Delivered project 2 weeks ahead of schedule",
            "Improved system performance by 40%",
            "Received Employee of the Year award",
          ], 1, 4),
        },
      });
    }

    // Education
    for (let ed = 0; ed < faker.number.int({ min: 1, max: 3 }); ed++) {
      const startDate = randomDate(new Date(2005, 0, 1), new Date(2020, 0, 1));
      const endDate = randomDate(new Date(startDate.getTime() + 365 * 24 * 60 * 60 * 1000), new Date(2024, 0, 1));
      await prisma.aiEducation.create({
        data: {
          aiResumeId: aiResume.id,
          institution: faker.company.name(),
          degree: faker.helpers.arrayElement(EDUCATION_LEVELS),
          field: faker.helpers.arrayElement(DEGREES),
          city: faker.location.city(),
          startDate,
          endDate,
          current: faker.datatype.boolean(0.1),
          gpa: faker.datatype.boolean(0.7) ? faker.number.float({ min: 2.5, max: 4.0, fractionDigits: 2 }) : null,
          achievements: randomFromArray([
            "Dean's List",
            "Graduated with Honors",
            "Best Project Award",
            "Research Publication",
          ], 0, 2),
        },
      });
    }

    // Skills
    for (let sk = 0; sk < faker.number.int({ min: 3, max: 10 }); sk++) {
      await prisma.aiSkill.create({
        data: {
          aiResumeId: aiResume.id,
          category: faker.helpers.arrayElement(["Programming", "Framework", "Database", "Cloud", "Tool", "Soft Skill"]),
          name: SKILLS_POOL[faker.number.int({ min: 0, max: SKILLS_POOL.length - 1 })],
          level: faker.helpers.arrayElement([SkillLevel.BEGINNER, SkillLevel.INTERMEDIATE, SkillLevel.ADVANCED, SkillLevel.EXPERT]),
        },
      });
    }

    // Languages
    for (let l = 0; l < faker.number.int({ min: 1, max: 4 }); l++) {
      await prisma.aiLanguage.create({
        data: {
          aiResumeId: aiResume.id,
          name: LANGUAGES_POOL[faker.number.int({ min: 0, max: LANGUAGES_POOL.length - 1 })],
          proficiency: faker.helpers.arrayElement([LanguageProficiency.BASIC, LanguageProficiency.INTERMEDIATE, LanguageProficiency.ADVANCED, LanguageProficiency.NATIVE]),
        },
      });
    }

    aiResumes.push({ id: aiResume.id, candidateId: aiResume.candidateId });
  }
  console.log(`✅ Created ${aiResumes.length} AI resumes with full details.\n`);

  // ─── Subscriptions ───────────────────────────────────────────────────────
  console.log("💳 Creating subscriptions...");
  const subscriptions: { id: string; userId: string }[] = [];
  // Mix of candidate and recruiter users
  const subscriptionUsers = [
    ...candidateUsers.slice(0, 10),
    ...recruiterUsers.slice(0, 5),
  ];

  for (const subUser of subscriptionUsers) {
    const startDate = randomDate(new Date(now.getTime() - 180 * 24 * 60 * 60 * 1000), now);
    const planDurationDays = faker.helpers.arrayElement([30, 90, 365]);
    const endDate = new Date(startDate.getTime() + planDurationDays * 24 * 60 * 60 * 1000);

    const subscription = await prisma.subscription.create({
      data: {
        userId: subUser.id,
        plan: faker.helpers.arrayElement([PlanType.BUSINESS, PlanType.PRO_PLAYER, PlanType.AI_JOB_APPLY, PlanType.LINKEDIN_OPTIMIZATION]),
        status: endDate > now
          ? SubscriptionStatus.ACTIVE
          : faker.helpers.arrayElement([SubscriptionStatus.EXPIRED, SubscriptionStatus.CANCELLED]),
        startDate,
        endDate,
        autoRenew: faker.datatype.boolean(0.5),
      },
    });
    subscriptions.push({ id: subscription.id, userId: subscription.userId });
  }
  console.log(`✅ Created ${subscriptions.length} subscriptions.\n`);

  // ─── Payments ────────────────────────────────────────────────────────────
  console.log("💰 Creating payments...");
  const payments: { id: string }[] = [];
  for (const subscription of subscriptions) {
    const paymentCount = faker.number.int({ min: 1, max: 3 });
    for (let p = 0; p < paymentCount; p++) {
      const paymentDate = randomDate(new Date(now.getTime() - 180 * 24 * 60 * 60 * 1000), now);
      const payment = await prisma.payment.create({
        data: {
          userId: subscription.userId,
          subscriptionId: subscription.id,
          amount: faker.number.float({ min: 49, max: 999, fractionDigits: 2 }),
          currency: "AED",
          status: faker.helpers.arrayElement([PaymentStatus.COMPLETED, PaymentStatus.COMPLETED, PaymentStatus.COMPLETED, PaymentStatus.PENDING, PaymentStatus.REFUNDED]),
          paymentMethod: faker.helpers.arrayElement(["stripe", "credit_card", "debit_card", "apple_pay"]),
          transactionId: `txn_${faker.string.alphanumeric(24)}`,
          paymentDate,
        },
      });
      payments.push({ id: payment.id });
    }
  }
  // Also add some standalone payments without subscriptions
  for (let i = 0; i < 5; i++) {
    const randomUser = candidateUsers[faker.number.int({ min: 0, max: candidateUsers.length - 1 })];
    const payment = await prisma.payment.create({
      data: {
        userId: randomUser.id,
        amount: faker.number.float({ min: 29, max: 499, fractionDigits: 2 }),
        currency: "AED",
        status: PaymentStatus.COMPLETED,
        paymentMethod: "stripe",
        transactionId: `txn_${faker.string.alphanumeric(24)}`,
        paymentDate: randomDate(new Date(now.getTime() - 90 * 24 * 60 * 60 * 1000), now),
      },
    });
    payments.push({ id: payment.id });
  }
  console.log(`✅ Created ${payments.length} payments.\n`);

  // ─── Saved Jobs ──────────────────────────────────────────────────────────
  console.log("⭐ Creating saved jobs...");
  const savedJobs: { id: string }[] = [];
  const savedJobSet = new Set<string>();

  for (let i = 0; i < 20; i++) {
    const candidate = candidates[faker.number.int({ min: 0, max: candidates.length - 1 })];
    const job = jobs[faker.number.int({ min: 0, max: jobs.length - 1 })];
    const key = `${candidate.userId}-${job.id}`;
    if (savedJobSet.has(key)) continue;
    savedJobSet.add(key);

    const savedJob = await prisma.savedJobPost.create({
      data: {
        userId: candidate.userId,
        jobId: job.id,
      },
    });
    savedJobs.push({ id: savedJob.id });
  }
  console.log(`✅ Created ${savedJobs.length} saved jobs.\n`);

  // ─── Courses ─────────────────────────────────────────────────────────────
  console.log("📚 Creating courses...");
  const courses: { id: string }[] = [];
  const courseTitles = [
    "Complete Web Development Bootcamp 2025",
    "AWS Certified Solutions Architect",
    "Data Science & Machine Learning with Python",
    "Flutter & Dart - Build Mobile Apps",
    "React Native: Mobile App Development",
    "Advanced TypeScript & Design Patterns",
    "Cybersecurity Fundamentals",
    "UI/UX Design Masterclass with Figma",
    "DevOps & CI/CD Pipeline Mastery",
    "AI Prompt Engineering for Developers",
  ];

  for (let i = 0; i < courseTitles.length; i++) {
    const adminUser = adminUsers[faker.number.int({ min: 0, max: adminUsers.length - 1 })];
    const course = await prisma.course.create({
      data: {
        title: courseTitles[i],
        subtitle: faker.lorem.sentence({ min: 8, max: 15 }),
        description: faker.lorem.paragraphs({ min: 3, max: 6 }),
        imageUrl: faker.image.url(),
        price: faker.datatype.boolean(0.3) ? null : faker.number.float({ min: 29, max: 299, fractionDigits: 2 }),
        isFree: faker.datatype.boolean(0.3),
        courseUrl: faker.internet.url(),
        studio: faker.helpers.arrayElement(["Udemy", "Coursera", "Pluralsight", "LinkedIn Learning", "edX", "Tabashir Academy"]),
        tags: randomFromArray(["BEST SELLER", "NEW", "TRENDING", "TOP RATED", "LIMITED OFFER"], 0, 2),
        category: faker.helpers.arrayElement(COURSE_CATEGORIES),
        isActive: faker.datatype.boolean(0.9),
        createdById: adminUser.id,
      },
    });
    courses.push({ id: course.id });
  }
  console.log(`✅ Created ${courses.length} courses.\n`);

  // ─── Notifications ───────────────────────────────────────────────────────
  console.log("🔔 Creating notifications...");
  const notifications: { id: string }[] = [];
  const notificationUsers = [...candidateUsers.slice(0, 15), ...recruiterUsers.slice(0, 5)];

  for (const notifUser of notificationUsers) {
    const notifCount = faker.number.int({ min: 1, max: 3 });
    for (let n = 0; n < notifCount; n++) {
      const type = faker.helpers.arrayElement(NOTIFICATION_TYPES);
      const notification = await prisma.notification.create({
        data: {
          userId: notifUser.id,
          title: faker.helpers.arrayElement([
            "New Job Match",
            "Application Updated",
            "Interview Scheduled",
            "Profile Viewed",
            "New Job Posted",
            "Subscription Renewal",
            "Payment Confirmed",
            "Application Reviewed",
          ]),
          message: faker.lorem.sentence({ min: 10, max: 25 }),
          type,
          isRead: faker.datatype.boolean(0.4),
          senderId: faker.datatype.boolean(0.5) ? adminUsers[faker.number.int({ min: 0, max: adminUsers.length - 1 })].id : null,
          senderName: faker.datatype.boolean(0.5) ? faker.person.fullName() : null,
          data: {
            jobId: faker.datatype.boolean(0.5) ? jobs[faker.number.int({ min: 0, max: jobs.length - 1 })].id : null,
            applicationId: faker.datatype.boolean(0.3) ? applications[faker.number.int({ min: 0, max: applications.length - 1 })]?.id ?? null : null,
          },
          createdAt: randomDate(new Date(now.getTime() - 30 * 24 * 60 * 60 * 1000), now),
        },
      });
      notifications.push({ id: notification.id });
    }
  }
  console.log(`✅ Created ${notifications.length} notifications.\n`);

  // ─── Summary ─────────────────────────────────────────────────────────────
  console.log("═══════════════════════════════════════════════════════════");
  console.log("🌱 Seed completed successfully!");
  console.log("═══════════════════════════════════════════════════════════");
  console.log(`  Users:              ${users.length}`);
  console.log(`  Admins:             ${adminUsers.length}`);
  console.log(`  Owners:             ${owners.length}`);
  console.log(`  Recruiters:         ${recruiters.length}`);
  console.log(`  Candidates:         ${candidates.length}`);
  console.log(`  Jobs:               ${jobs.length}`);
  console.log(`  Job Applications:   ${applications.length}`);
  console.log(`  Resumes:            ${resumes.length}`);
  console.log(`  AI Resumes:         ${aiResumes.length}`);
  console.log(`  Subscriptions:      ${subscriptions.length}`);
  console.log(`  Payments:           ${payments.length}`);
  console.log(`  Saved Jobs:         ${savedJobs.length}`);
  console.log(`  Courses:            ${courses.length}`);
  console.log(`  Notifications:      ${notifications.length}`);
  console.log("═══════════════════════════════════════════════════════════");
  console.log(`  Default password for all users: ${DEFAULT_PASSWORD}`);
  console.log("═══════════════════════════════════════════════════════════");
}

main()
  .catch((e) => {
    console.error("❌ Seed failed:", e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });

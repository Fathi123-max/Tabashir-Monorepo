"use client";

import { useState, useEffect } from 'react';

// Translation resources
const translations = {
  en: {
    // Navigation
    dashboard: "Dashboard",
    jobs: "Jobs",
    resume: "Resume",
    appliedJobs: "Applied Jobs",
    likedJobs: "Liked Jobs",
    account: "Account",
    interview: "Interview Training",
    courses: "Free Courses",
    community: "WhatsApp Community",
    services: "Service Details",
    aiJobApply: "AI Job Apply",
    aiJobLinkedin: "Apply on LinkedIn",
    
    // Buttons
    login: "Login",
    register: "Register",
    logout: "Logout",
    save: "Save",
    cancel: "Cancel",
    apply: "Apply",
    submit: "Submit",
    edit: "Edit",
    delete: "Delete",
    view: "View",
    download: "Download",
    upload: "Upload",
    next: "Next",
    previous: "Previous",
    back: "Back",
    continue: "Continue",
    finish: "Finish",
    close: "Close",
    confirm: "Confirm",
    search: "Search",
    filter: "Filter",
    clear: "Clear",
    refresh: "Refresh",
    
    // Forms
    firstName: "First Name",
    lastName: "Last Name",
    email: "Email",
    password: "Password",
    phone: "Phone Number",
    address: "Address",
    city: "City",
    country: "Country",
    
    // Status
    loading: "Loading...",
    success: "Success",
    error: "Error",
    pending: "Pending",
    
    // Messages
    welcome: "Welcome",
    noData: "No data available",
    noResults: "No results found",
    
    // Language
    selectLanguage: "Select Language",
    english: "English",
    arabic: "العربية",
    languagePreference: "Language preference will be saved for your next visit",
    chooseLanguage: "Choose your preferred language for the website interface.",
    
    // Navigation
    toggleMenu: "Toggle menu",
    whatsappCommunity: "WhatsApp Community",
    
    // Job-related
    topMatch: "Top Match",
    bestForYou: "Best For You",
    match: "Match",
    views: "views",
    applied: "applied",
    applicationsCount: "applications",
    postedTime: "Posted",
    jobType: "Job Type",
    salary: "Salary",
    location: "Location",
    company: "Company",
    department: "Department",
    team: "Team",
    requirements: "Requirements",
    description: "Description",
    
    // Applied Jobs
    appliedDate: "Applied Date",
    position: "Position",
    status: "Status",
    jobTitle: "Job Title",
    jobId: "Job ID",
    totalApplied: "Total Applied",
    searchJobs: "Search jobs...",
    itemsPerPage: "Items per page",
    showingResults: "Showing results",
    of: "of",
    to: "to",
    results: "results",
    loadingJobs: "Loading jobs...",
    noJobsFound: "No jobs found",
    tryAgain: "Try Again",
    failedToLoad: "Failed to load applied jobs",
    
    // AI Job Apply
    selectResume: "Select Resume",
    pleaseSelectResume: "Please select a resume",
    preferredPositions: "Preferred Positions",
    addPosition: "Add Position",
    preferredLocations: "Preferred Locations",
    nationality: "Nationality",
    gender: "Gender",
    male: "Male",
    female: "Female",
    submitApplication: "Submit Application",
    processingApplication: "Processing Application...",
    applicationSubmitted: "Application submitted successfully!",
    
    // Free Courses
    freeCourses: "Free Courses",
    recommendedVideos: "Recommended Videos",
    topPicksForYou: "Top picks for you",
    searchInVideos: "Search in videos",
    bestSeller: "BEST SELLER",
    new: "NEW",
    
    // Interview Training
    interviewTraining: "Interview Training",
    comingSoon: "Coming Soon",
    masterInterviewSkills: "Master your interview skills with AI-powered practice sessions",
    prepareForSuccess: "Prepare for success with our advanced interview simulator",
    interviewPlatformDescription: "We're building a cutting-edge platform to help you practice and perfect your interview skills with industry-specific questions and real-time feedback.",
    enterYourEmail: "Enter your email",
    notifyMe: "Notify Me",
    
    // WhatsApp Community
    latestUpdateFrom: "To Get the latest update from Tabashir",
    joinWhatsappCommunity: "Join this Whatsapp Community",
    letMeJoinCommunity: "Let me Join Community",
    
    // Job Details
    applyNow: "Apply Now",
    aboutJob: "About Job",
    jobDetails: "Job Details",
    workingDays: "Working Days",
    experienceLevel: "Experience Level",
    qualifications: "Qualifications",
    
    // Search & Filters
    searchPreferences: "Search Preferences",
    filters: "Filters",
    sortBy: "Sort By",
    newest: "Newest",
    oldest: "Oldest",
    salaryAsc: "Salary (Low to High)",
    salaryDesc: "Salary (High to Low)",
    salaryRange: "Salary Range",
    minSalary: "Min Salary",
    maxSalary: "Max Salary",
    
    // Pagination
    page: "Page",
    previousPage: "Previous Page",
    nextPage: "Next Page",
    
    // Common Actions
    likeJob: "Like Job",
    unlikeJob: "Unlike Job",
    viewDetails: "View Details",
    applyToJob: "Apply to Job",
    downloading: "Downloading...",
    
    // Job Status
    newJob: "New Job",
    featuredJob: "Featured Job",
    urgentHiring: "Urgent Hiring",
    fullTime: "Full Time",
    partTime: "Part Time",
    contract: "Contract",
    remote: "Remote",
    onSite: "On Site",
    
    // Resume Sections
    personalInfo: "Personal Information",
    workExperience: "Work Experience",
    education: "Education",
    skills: "Skills",
    languages: "Languages",
    certifications: "Certifications",
    
    // Application States
    easyApply: "Easy Apply",
    saved: "Saved",
    
    // Common Phrases
    seeMore: "See More",
    readMore: "Read More",
    showLess: "Show Less",
    learnMore: "Learn More",
    getStarted: "Get Started",
    tryNow: "Try Now",
    
    // Time
    today: "Today",
    yesterday: "Yesterday",
    thisWeek: "This Week",
    lastWeek: "Last Week",
    thisMonth: "This Month",
    lastMonth: "Last Month",
    daysAgo: "days ago",

    // Courses
    coursesAvailable: "course available",
    coursesAvailablePlural: "courses available",
    noCourses: "No courses available",
    noCoursesFound: "No courses found",
    tryAdjustingSearch: "Try adjusting your search or filter criteria",
    checkBackLater: "Check back later for new courses",
    allCategories: "All Categories",
    searchCourses: "Search courses...",
    startCourse: "Start Course",
    by: "by",
    hoursAgo: "hours ago",
    minutesAgo: "minutes ago",
    
    // Additional Filters and Sorting
    filterBy: "Filter By",
    allJobs: "All Jobs",
    relevance: "Relevance",
    datePosted: "Date Posted",
    
    // Recruiter Section
    myJobs: "My Jobs",
    manageJobPostings: "Manage job postings and applications",
    createNewJob: "Create New Job",
    noJobsPosted: "No jobs posted yet",
    startByCreating: "Start by creating your first job posting to attract top talent",
    createFirstJob: "Create Your First Job",
    applications: "applications",
    viewApplications: "View Applications",
    jobsManagement: "Jobs Management",
    
    // Admin Section
    adminDashboard: "Admin Dashboard",
    manageUsers: "Manage Users",
    manageAdmins: "Manage Admins",
    userManagement: "User Management",
    adminManagement: "Admin Management",
    systemSettings: "System Settings",
    reports: "Reports",
    analytics: "Analytics",
    
    // Forms & Validation
    username: "Username",
    confirmPassword: "Confirm Password",
    forgotPassword: "Forgot Password",
    resetPassword: "Reset Password",
    rememberMe: "Remember Me",
    dontHaveAccount: "Don't have an account?",
    alreadyHaveAccount: "Already have an account?",
    signUp: "Sign Up",
    signIn: "Sign In",
    createAccount: "Create Account",
    
    // Additional Job Fields
    benefits: "Benefits",
    
    // Application Status
    reviewing: "Reviewing",
    interviewStatus: "Interview",
    hired: "Hired",
    rejected: "Rejected",
    
    // Common Actions Extended
    create: "Create",
    update: "Update",
    remove: "Remove",
    manage: "Manage",
    settings: "Settings",
    profile: "Profile",
    preferences: "Preferences",
    notifications: "Notifications",
    help: "Help",
    support: "Support",
    
    // Time & Dates
    createdAt: "Created At",
    updatedAt: "Updated At",

    selectGender: "Select Gender",
    selectNationalities: "Select Nationalities",
    selectCities: "Select Cities",
    selectPositions: "Select Positions",
    
    // Status Messages
    successfullyCreated: "Successfully Created",
    successfullyUpdated: "Successfully Updated",
    successfullyDeleted: "Successfully Deleted",
    operationFailed: "Operation Failed",
    pleaseTryAgain: "Please try again",
    action: "Action",

    minMaxPositions: "Min and Max Positions",
    
    // Navigation & UI
    home: "Home",
    about: "About",
    contact: "Contact Us",
    privacy: "Privacy",
    terms: "Terms",
    menu: "Menu",
    sidebar: "Sidebar",
    header: "Header",
    footer: "Footer",
    
    // Pagination & Lists Extended
    showing: "Showing",
    
    // Forms & Registration Extended
    enterDetailsToCreateAccount: "Enter your details to create your account",
    enterEmailAddress: "Enter your email address",
    enterYourUsername: "Enter your username",
    enterYourPassword: "Enter your password",
    creatingAccount: "Creating account...",
    registrationError: "Registration Error",
    registrationSuccessful: "Registration Successful",
    accountCreatedSuccessfully: "Account created successfully!",
    checkEmailForVerification: "Please check your email for verification instructions",
    somethingWentWrong: "Something went wrong. Please try again.",
    
    whichJobPositionYouPrefer: "Which job position you prefer?",
    citiesYouPrefer: "Cities you prefer?",

    // Account & Profile
    personalDetails: "Personal Details",
    contactInformation: "Contact Information",
    professionalInformation: "Professional Information",
    accountSettings: "Account Settings",
    changePassword: "Change Password",
    currentPassword: "Current Password",
    newPassword: "New Password",
    confirmNewPassword: "Confirm New Password",
    updatePassword: "Update Password",
    profileUpdated: "Profile updated successfully",
    passwordUpdated: "Password updated successfully",
    aiJobApplyRequired: "AI Job Apply is required to apply for jobs",

    
    // Resume Extended
    myResumes: "My Resumes",
    uploadResume: "Upload Resume",
    downloadResume: "Download Resume",
    deleteResume: "Delete Resume",
    aiEnhance: "AI Enhance",
    createResume: "Create Resume",
    resumeUploadedSuccessfully: "Resume uploaded successfully",
    resumeDeletedSuccessfully: "Resume deleted successfully",
    confirmDeleteResume: "Are you sure you want to delete this resume?",
    
    // Jobs & Search Extended
    findJobs: "Find Jobs",
    searchForJobs: "Search for Jobs",
    searchPlaceholder: "Search for jobs, companies, or keywords",
    jobSearch: "Job Search",
    searchResults: "Search Results",
    noJobsMatchCriteria: "No jobs match your search criteria",
    adjustFilters: "Try adjusting your filters or search terms",
    
    // Experience Levels
    experienceLevelFilter: "Experience Level",
    zeroToOne: "0-1 years",
    oneToThree: "1-3 years",
    threeToFive: "3-5 years",
    fiveToTen: "5-10 years",
    tenPlus: "10+ years",
    
    // Education Levels
    educationLevel: "Education Level",
    highSchool: "High School",
    bachelors: "Bachelor's Degree",
    masters: "Master's Degree",
    phd: "PhD",
    other: "Other",
    
    // Additional Form Fields
    addSkill: "Add Skill",
    add: "Add",
    enterNewPassword: "Enter new password",
    passwordsDoNotMatch: "Passwords do not match",
    passwordTooShort: "Password must be at least 8 characters",
    updating: "Updating...",
    
    // Resume Management Extended
    noResumesFound: "No resumes found. Please upload a resume first.",
    uploadFirstResume: "Upload your first resume to get started",
    resumeDownloadedSuccessfully: "Resume downloaded successfully",
    failedToDownloadResume: "Failed to download resume",
    failedToDeleteResume: "Failed to delete resume",
    cvUploadedSuccessfully: "CV uploaded successfully",
    failedToUploadCV: "Failed to upload CV",
    
    // Job Loading Extended
    failedToLoadJobs: "Failed to load jobs",
    
    // Services
    tabashirServices: "Tabashir Services",
    tabashirServicesDesc: "Elevate your career with our AI-powered professional services designed to help you stand out in the job market",
    aiResumeOptimization: "AI Resume Optimization",
    aiResumeOptimizationDesc: "Transform your resume with AI-powered analysis and optimization",
    coverLetterGeneration: "Cover Letter Generation",
    coverLetterGenerationDesc: "Craft compelling and tailored cover letters for any job",
    interviewPreparation: "Interview Preparation",
    interviewPreparationDesc: "Master interview skills with AI-powered practice sessions",
    careerCoaching: "Career Coaching",
    careerCoachingDesc: "Personalized one-on-one career guidance from experts",
    mostPopular: "Most Popular",
    selectService: "Select Service",
    needCustomSolution: "Need a custom solution?",
    needCustomSolutionDesc: "Contact our team for customized services tailored to your specific career needs",
    contactUs: "Contact Us",
    recentPayment: "Recent Payment",
    aed: "AED",
    
    // Service Features
    aiAnalysisMatching: "AI Analysis & Job Matching",
    professionalFormatting: "Professional Formatting",
    keywordOptimization: "Keyword Optimization",
    atsCompatibility: "ATS Compatible",
    instantDownload: "Instant Download",
    personalizedCoverLetter: "Personalized Cover Letter",
    jobSpecificContent: "Job-Specific Content",
    professionalTone: "Professional Tone",
    multipleFormats: "Multiple Formats",
    editableTemplate: "Editable Template",
    commonQuestions: "Common Interview Questions",
    industrySpecificQuestions: "Industry-Specific Questions",
    answerTemplates: "Answer Templates",
    confidenceBuilding: "Confidence Building Tips",
    practiceSimulations: "Practice Simulations",
    oneOnOneSession: "One-on-One Session",
    careerGoalSetting: "Career Goal Setting",
    skillAssessment: "Skill Assessment",
    personalizedPlan: "Personalized Action Plan",
    followUpSupport: "Follow-Up Support",
    
    // Time Periods
    month: "Month",
    year: "Year",
    week: "Week",
    day: "Day",
    hour: "Hour",
    
    // Dashboard & Charts
    totalMatchingJobs: "Total Matching Jobs",
    skillTrends: "Skill Trends",
    globalDemandFor: "Global Demand for",
    flexible: "Flexible",
    
    // Countries
    uae: "United Arab Emirates",
    taiwan: "Taiwan",
    india: "India",
    saudiArabia: "Saudi Arabia",
    
    // Search & Job Filters Extended
    filterJobsChoice: "Filter the jobs of your choice",
    selectLocation: "Select Location",
    selectJobType: "Select Job Type",
    yearsExperience: "2 Years",
    attendance: "Attendance",
    
    // UAE Cities
    "Dubai, UAE": "Dubai, UAE",
    "Abu Dhabi, UAE": "Abu Dhabi, UAE",
    "Sharjah, UAE": "Sharjah, UAE",
    "Ras Al Khaimah, UAE": "Ras Al Khaimah, UAE",
    "Fujairah, UAE": "Fujairah, UAE",
    "Ajman, UAE": "Ajman, UAE",
    "Umm Al Quwain, UAE": "Umm Al Quwain, UAE",
    "Al Ain, UAE": "Al Ain, UAE",
    freelance: "Freelance",
    hideFilters: "Hide Filters",
    showFilters: "Show Filters",
    
    // Dashboard Components
    matchedJobs: "Matched Jobs",
    
    // Resume Builder
    generateNewResume: "Generate New Resume",
    checkGeneratedResume: "Check Generated Resume",
    resumeScore: "Resume Score",
    tips: "Tips",
    generatingYourResume: "Generating Your Resume",
    pleaseWaitWhileGenerating: "Please wait while we generate your professional resume...",
    analyzingInformation: "Analyzing your information...",
    formattingResume: "Formatting your resume...",
    applyingProfessionalStyling: "Applying professional styling...",
    finalizingResume: "Finalizing your resume...",
    
    // Resume Download & Export
    editorMode: "Editor Mode",
    exportAs: "Export Resume",
    wordDocument: "Word Document",
    unlockFullResumeView: "Unlock Full Resume View",
    completePaymentToUnlock: "To view and download your resume without blur, please complete the payment.",
    paymentSuccessful: "Payment Successful!",
    resumeNowUnlocked: "Your resume is now unlocked.",
    resumeUnlockFee: "Resume Unlock Fee",
    cardNumber: "Card Number",
    expiryDate: "Expiry Date",
    cardholderName: "Cardholder Name",
    processing: "Processing...",
    pay: "Pay",
    aiJobApplicationSentSuccess: "AI Job Application Sent Successfully!",
    
    // Job Details Component
    selectResumeToApply: "Select Resume to Apply",
    chooseResumeForJob: "Choose which resume you'd like to use for applying to",
    at: "at",
    applying: "Applying...",
    applicationSubmittedSuccessfully: "Application Submitted Successfully!",
    applicationSubmittedMessage: "Your application for {jobTitle} at {company} has been submitted successfully. You will receive notifications about the status of your application.",
    easyApplyViaTabashir: "Easy Apply via TABASHIR",
    applyThroughCompanyWebsite: "Apply through Company Website",
    forMale: "For Male",
    forFemale: "For Female", 
    forAll: "For all",
    jobDescription: "Job Description",
    noDescriptionProvided: "No description provided.",
    noNationalityRequired: "No nationality required",
    noExperienceRequired: "No experience required",
    noRequirementsProvided: "No requirements provided.",
    aboutTheCompany: "About the Company",
    noCompanyDescriptionProvided: "No company description provided.",
    resumePreview: "Resume Preview",
    uploaded: "Uploaded",
    entity: "Entity",
    private: "Private",
    government: "Government",
    semiGovernment: "Semi-Government",
    notSpecified: "Not Specified",
    tbd: "TBD",
    
    
    // Terms and Conditions
    termsAndConditionsText: "By accessing or using Tabashir's website, app, or related services (\"Services\"), you agree to comply with and be bound by these Terms and Conditions. We reserve the right to update or modify these Terms at any time without prior notice, and your continued use of the Services constitutes acceptance of those changes. You must be at least 18 years old or have parental consent to use our Services. You are responsible for maintaining the confidentiality of your account and for all activities under it. All content provided is owned by Tabashir and protected by intellectual property laws. You may not misuse our Services or interfere with their operation. The Services are provided \"as is\" without warranties, and Tabashir is not liable for any damages resulting from your use. We may include third-party links, which we do not control or endorse. These Terms are governed by the laws of [Your Country/State], and any disputes will be handled in the courts of that jurisdiction. We reserve the right to suspend or terminate your access at any time. For questions, contact us at [support@tabashir.ae].",
    agreeToTermsAndConditions: "I agree on all terms and conditions",

    noResumesFoundUpload: "No resumes found. Please upload a resume first.",
    pleaseUploadResumeToGetStarted: "Please upload a resume to get started",

    profileCompletion: "Profile Completion",
    contentOptimization: "Content Optimization",
    engagementBoost: "Engagement Boost",
    visibilityEnhancement: "Visibility Enhancement",
    linkedinEnhancement: "LinkedIn Enhancement",
    linkedinEnhancementDesc: "Enhance your LinkedIn profile with AI",

    aiJobSearch: "Search for jobs with AI",
    aiJobApplication: "Apply for jobs with AI",
    aiJobTracking: "Track job applications with AI",
    aiJobInterview: "Interview for jobs with AI",
    aiJobOffer: "Offer jobs with AI",

    aiJobApplyDesc: "Apply for jobs with AI",
    aiJobSearchDesc: "Search for jobs with AI",
    aiJobApplicationDesc: "Apply for jobs with AI",
    aiJobTrackingDesc: "Track job applications with AI",

    nationalitiesSelected: "Nationalities Selected",
    positionsSelected: "Positions Selected",
    locationsSelected: "Locations Selected",
    genderSelected: "Gender Selected",
    citiesSelected: "Cities Selected",
    
    aiJobApplyRequiredDesc: "Please complete all required fields to apply for jobs with AI.",
    viewServiceDetails: "View Service Details",

    // Resume Upload Modal
    uploadYourResume: "Upload Your Resume",
    helpRecruiterKnowAboutYou: "Help recruiters know about you",
    dragAndDropOrClickToUpload: "Drag and drop your resume here or click to browse",
    uploadingYourResume: "Uploading your resume...",
    createNewUsingAI: "Create New Using AI",
    uploadAndEnhance: "Upload & Enhance with AI",
    failedToUploadResume: "Failed to upload resume",
    or: "or",

    startApplyingMyApplication: "Start Applying My Application",
  },
  ar: {
    // Navigation
    dashboard: "لوحة التحكم",
    jobs: "الوظائف",
    resume: "السيرة الذاتية", 
    appliedJobs: "الوظائف المتقدم لها",
    likedJobs: "الوظائف المفضلة",
    account: "الحساب",
    interview: "تدريب المقابلة",
    courses: "دورات مجانية",
    community: "مجتمع واتساب",
    services: "تفاصيل الخدمة",
    aiJobApply: "التقديم بالذكاء الاصطناعي",
    
    // Buttons
    login: "تسجيل الدخول",
    register: "التسجيل",
    logout: "تسجيل الخروج",
    save: "حفظ",
    cancel: "إلغاء",
    apply: "تقدم",
    submit: "إرسال",
    edit: "تعديل",
    delete: "حذف",
    view: "عرض",
    download: "تحميل",
    upload: "رفع",
    next: "التالي",
    previous: "السابق",
    back: "رجوع",
    continue: "متابعة",
    finish: "إنهاء",
    close: "إغلاق",
    confirm: "تأكيد",
    search: "بحث",
    filter: "تصفية",
    clear: "مسح",
    refresh: "تحديث",
    
    // Forms
    firstName: "الاسم الأول",
    lastName: "اسم العائلة",
    email: "البريد الإلكتروني",
    password: "كلمة المرور",
    phone: "رقم الهاتف",
    address: "العنوان",
    city: "المدينة",
    country: "البلد",
    
    // Status
    loading: "جاري التحميل...",
    success: "نجح",
    error: "خطأ",
    pending: "قيد الانتظار",
    
    // Messages
    welcome: "مرحباً",
    noData: "لا توجد بيانات متاحة",
    noResults: "لا توجد نتائج",
    
    // Language
    selectLanguage: "اختر اللغة",
    english: "English",
    arabic: "العربية",
    languagePreference: "سيتم حفظ تفضيل اللغة لزيارتك القادمة",
    chooseLanguage: "اختر اللغة المفضلة لديك لواجهة الموقع.",
    aiJobApplicationSentSuccess: "تم إرسال طلب التقديم بالذكاء الاصطناعي بنجاح!",
    nationalitiesSelected: "الجنسيات المختارة",
    positionsSelected: "المناصب المختارة",
    locationsSelected: "المواقع المختارة",
    genderSelected: "الجنس المختار",
    citiesSelected: "المدن المختارة",
    // Navigation
    toggleMenu: "تبديل القائمة",
    whatsappCommunity: "مجتمع واتساب",

    aiJobApplyRequired: "مطلوب التقديم بالذكاء الاصطناعي للتقديم على الوظائف",
    aiJobApplyRequiredDesc: "يرجى شراء خدمة التقديم بالذكاء الاصطناعي لمتابعة التقديم على الوظائف. ستتمكن من التقديم بسهولة على الوظائف باستخدام سيرتك الذاتية المحسنة بالذكاء الاصطناعي.",
    
    // WhatsApp Community
    latestUpdateFrom: "للحصول على آخر التحديثات من تباشير",
    joinWhatsappCommunity: "انضم لمجتمع واتساب هذا",
    letMeJoinCommunity: "دعني أنضم للمجتمع",
    
    // Job-related
    topMatch: "أفضل مطابقة",
    bestForYou: "الأفضل لك",
    match: "مطابقة",
    views: "مشاهدات",
    newJob: "وظيفة جديدة",
    featuredJob: "وظيفة مميزة",
    urgentHiring: "توظيف عاجل",
    fullTime: "دوام كامل",
    partTime: "دوام جزئي",
    contract: "عقد",
    remote: "عن بُعد",
    onSite: "في الموقع",
    
    // Resume
    personalInfo: "المعلومات الشخصية",
    workExperience: "الخبرة العملية",
    education: "التعليم",
    skills: "المهارات",
    languages: "اللغات",
    certifications: "الشهادات",
    
    // Application states
    easyApply: "تقديم سهل",
    applied: "تم التقديم",
    saved: "محفوظ",
    
    // Common phrases
    seeMore: "رؤية المزيد",
    readMore: "اقرأ المزيد",
    showLess: "عرض أقل",
    learnMore: "تعلم المزيد",
    getStarted: "ابدأ الآن",
    tryNow: "جرب الآن",
    comingSoon: "قريباً",
    
    // Free Courses
    freeCourses: "دورات مجانية",
    recommendedVideos: "فيديوهات موصى بها",
    topPicksForYou: "أفضل الاختيارات لك",
    searchInVideos: "البحث في الفيديوهات",
    bestSeller: "الأكثر مبيعاً",
    new: "جديد",
    
    // Interview Training
    interviewTraining: "تدريب المقابلة",
    masterInterviewSkills: "أتقن مهارات المقابلة من خلال جلسات تدريب مدعومة بالذكاء الاصطناعي",
    prepareForSuccess: "استعد للنجاح مع محاكي المقابلات المتطور",
    interviewPlatformDescription: "نحن نبني منصة متطورة لمساعدتك على التدرب وإتقان مهارات المقابلة مع أسئلة خاصة بالصناعة وتعليقات فورية.",
    enterYourEmail: "أدخل بريدك الإلكتروني",
    notifyMe: "أخطرني",
    
    // Time
    today: "اليوم",
    yesterday: "أمس",
    thisWeek: "هذا الأسبوع",
    lastWeek: "الأسبوع الماضي",
    thisMonth: "هذا الشهر",
    lastMonth: "الشهر الماضي",
    daysAgo: "منذ أيام",
    hoursAgo: "منذ ساعات",
    minutesAgo: "منذ دقائق",
    
    // Filters and sorting
    sortBy: "ترتيب حسب",
    filterBy: "تصفية حسب",
    allJobs: "جميع الوظائف",
    relevance: "الصلة",
    datePosted: "تاريخ النشر",
    salaryAsc: "الراتب (من الأقل إلى الأعلى)",
    salaryDesc: "الراتب (من الأعلى إلى الأقل)",
    salaryRange: "نطاق الراتب",
    minSalary: "الحد الأدنى للراتب",
    maxSalary: "الحد الأقصى للراتب",
    
    // Pagination
    page: "صفحة",
    previousPage: "الصفحة السابقة",
    nextPage: "الصفحة التالية",
    
    // Common Actions
    likeJob: "إعجاب بالوظيفة",
    unlikeJob: "إلغاء الإعجاب بالوظيفة",
    viewDetails: "عرض التفاصيل",
    applyToJob: "تقدم للوظيفة",
    downloading: "جاري التحميل...",
    
    // Recruiter Section
    myJobs: "وظائفي",
    manageJobPostings: "إدارة إعلانات الوظائف والطلبات",
    createNewJob: "إنشاء وظيفة جديدة",
    noJobsPosted: "لم يتم نشر وظائف بعد",
    startByCreating: "ابدأ بإنشاء أول إعلان وظيفة لجذب أفضل المواهب",
    createFirstJob: "إنشاء وظيفتك الأولى",
    applications: "طلبات",
    viewApplications: "عرض الطلبات",
    jobsManagement: "إدارة الوظائف",
    
    // Admin Section
    adminDashboard: "لوحة تحكم المدير",
    manageUsers: "إدارة المستخدمين",
    manageAdmins: "إدارة المديرين",
    userManagement: "إدارة المستخدمين",
    adminManagement: "إدارة المديرين",
    systemSettings: "إعدادات النظام",
    reports: "التقارير",
    analytics: "التحليلات",
    selectGender: "اختر الجنس",
    selectNationalities: "اختر الجنسية",
    selectCities: "اختر المدن",
    selectPositions: "اختر المناصب",
    
    // Forms & Validation
    username: "اسم المستخدم",
    confirmPassword: "تأكيد كلمة المرور",
    forgotPassword: "نسيت كلمة المرور",
    resetPassword: "إعادة تعيين كلمة المرور",
    rememberMe: "تذكرني",
    dontHaveAccount: "ليس لديك حساب؟",
    alreadyHaveAccount: "لديك حساب بالفعل؟",
    signUp: "إنشاء حساب",
    signIn: "تسجيل الدخول",
    createAccount: "إنشاء حساب",
    
    // Job Related - duplicate entries removed
    jobTitle: "عنوان الوظيفة",
    company: "الشركة",
    location: "الموقع",
    jobType: "نوع الوظيفة",
    salary: "الراتب",
    description: "الوصف",
    requirements: "المتطلبات",
    benefits: "المميزات",
    // fullTime, partTime, contract, internship, remote, onsite, hybrid already defined earlier
    searchJobs: "البحث عن الوظائف",
    
    // Application Status - duplicate entries removed
    // applied, pending already defined earlier
    reviewing: "قيد المراجعة",
    interviewStatus: "مقابلة",
    hired: "تم التوظيف",
    rejected: "مرفوض",
    
    // Common Actions
    create: "إنشاء",
    update: "تحديث",
    remove: "إزالة",
    manage: "إدارة",
    settings: "الإعدادات",
    profile: "الملف الشخصي",
    preferences: "التفضيلات",
    notifications: "الإشعارات",
    help: "المساعدة",
    support: "الدعم",
    searchPreferences: "البحث عن الوظائف",
    
    // Time & Dates - duplicate entries removed
    // today, yesterday, thisWeek, thisMonth, lastMonth already defined earlier
    createdAt: "تم الإنشاء",
    updatedAt: "تم التحديث",

    appliedDate: "تاريخ التقديم",
    
    // Status Messages
    successfullyCreated: "تم الإنشاء بنجاح",
    successfullyUpdated: "تم التحديث بنجاح",
    successfullyDeleted: "تم الحذف بنجاح",
    operationFailed: "فشلت العملية",
    pleaseTryAgain: "يرجى المحاولة مرة أخرى",
    position: "المنصب",
    status: "الحالة",
    action: "الإجراء",
    
    // Navigation & UI
    home: "الرئيسية",
    about: "حول",
    contact: "اتصل بنا",
    privacy: "الخصوصية",
    terms: "الشروط",
    menu: "القائمة",
    sidebar: "الشريط الجانبي",
    header: "الرأس",
    footer: "التذييل",
    
    // Pagination & Lists
    showing: "عرض",
    to: "إلى",
    of: "من",
    results: "نتائج",
    itemsPerPage: "عناصر لكل صفحة",
    loadingJobs: "جاري تحميل الوظائف...",
    
    // Forms & Registration
    enterDetailsToCreateAccount: "أدخل بياناتك لإنشاء حسابك",
    enterEmailAddress: "أدخل عنوان بريدك الإلكتروني",
    jobId: "رقم الوظيفة",
    enterYourUsername: "أدخل اسم المستخدم",
    enterYourPassword: "أدخل كلمة المرور",
    creatingAccount: "جاري إنشاء الحساب...",
    registrationError: "خطأ في التسجيل",
    registrationSuccessful: "تم التسجيل بنجاح",
    accountCreatedSuccessfully: "تم إنشاء الحساب بنجاح!",
    checkEmailForVerification: "يرجى التحقق من بريدك الإلكتروني للحصول على تعليمات التحقق",
    somethingWentWrong: "حدث خطأ ما. يرجى المحاولة مرة أخرى.",
    
    // Account & Profile
    personalDetails: "التفاصيل الشخصية",
    contactInformation: "معلومات الاتصال",
    professionalInformation: "المعلومات المهنية",
    accountSettings: "إعدادات الحساب",
    changePassword: "تغيير كلمة المرور",
    currentPassword: "كلمة المرور الحالية",
    newPassword: "كلمة المرور الجديدة",
    confirmNewPassword: "تأكيد كلمة المرور الجديدة",
    updatePassword: "تحديث كلمة المرور",
    profileUpdated: "تم تحديث الملف الشخصي بنجاح",
    passwordUpdated: "تم تحديث كلمة المرور بنجاح",
    
    // Resume
    myResumes: "سيرتي الذاتية",
    uploadResume: "رفع السيرة الذاتية",
    downloadResume: "تحميل السيرة الذاتية",
    deleteResume: "حذف السيرة الذاتية",
    aiEnhance: "تحسين بالذكاء الاصطناعي",
    createResume: "إنشاء سيرة ذاتية",
    resumeUploadedSuccessfully: "تم رفع السيرة الذاتية بنجاح",
    resumeDeletedSuccessfully: "تم حذف السيرة الذاتية بنجاح",
    confirmDeleteResume: "هل أنت متأكد من حذف هذه السيرة الذاتية؟",
    
    // Jobs & Search
    findJobs: "البحث عن وظائف",
    searchForJobs: "البحث عن وظائف",
    searchPlaceholder: "ابحث عن وظائف أو شركات أو كلمات مفتاحية",
    jobSearch: "البحث عن وظائف",
    searchResults: "نتائج البحث",
    noJobsMatchCriteria: "لا توجد وظائف تطابق معايير البحث",
    adjustFilters: "جرب تعديل المرشحات أو مصطلحات البحث",
    
    // Experience Levels
    experienceLevelFilter: "مستوى الخبرة",
    zeroToOne: "0-1 سنة",
    oneToThree: "1-3 سنوات",
    threeToFive: "3-5 سنوات",
    fiveToTen: "5-10 سنوات",
    tenPlus: "10+ سنوات",
    
    // Education Levels
    educationLevel: "المستوى التعليمي",
    highSchool: "الثانوية العامة",
    bachelors: "درجة البكالوريوس",
    viewServiceDetails: "عرض تفاصيل الخدمة",
    masters: "درجة الماجستير",
    phd: "درجة الدكتوراه",
    other: "أخرى",
    
    // Gender - duplicate entries removed
    // gender, male, female, other already defined earlier
    
    // Additional Form Fields
    addSkill: "أضف مهارة",
    add: "إضافة",
    enterNewPassword: "أدخل كلمة المرور الجديدة",
    passwordsDoNotMatch: "كلمات المرور غير متطابقة",
    passwordTooShort: "يجب أن تكون كلمة المرور 8 أحرف على الأقل",
    updating: "جاري التحديث...",
    
    // Resume Management
    noResumesFound: "لم يتم العثور على سير ذاتية. يرجى رفع سيرة ذاتية أولاً.",
    uploadFirstResume: "ارفع سيرتك الذاتية الأولى للبدء",
    resumeDownloadedSuccessfully: "تم تحميل السيرة الذاتية بنجاح",
    failedToDownloadResume: "فشل في تحميل السيرة الذاتية",
    failedToDeleteResume: "فشل في حذف السيرة الذاتية",
    cvUploadedSuccessfully: "تم رفع السيرة الذاتية بنجاح",
    failedToUploadCV: "فشل في رفع السيرة الذاتية",
    
    // Job Loading
    whichJobPositionYouPrefer: "ما هي المناصب الوظيفية التي تفضلها؟",
    citiesYouPrefer: "ما هي المدن التي تفضلها؟",
    failedToLoadJobs: "فشل في تحميل الوظائف",
    
    // Services
    tabashirServices: "خدمات تباشير",
    tabashirServicesDesc: "عزز مسيرتك المهنية مع خدماتنا المهنية المدعومة بالذكاء الاصطناعي والمصممة لمساعدتك على التميز في سوق العمل",
    aiResumeOptimization: "تحسين السيرة الذاتية بالذكاء الاصطناعي",
    aiResumeOptimizationDesc: "حوّل سيرتك الذاتية بالتحليل والتحسين المدعوم بالذكاء الاصطناعي",
    coverLetterGeneration: "إنشاء خطاب التقديم",
    coverLetterGenerationDesc: "اكتب خطابات تقديم مقنعة ومخصصة لأي وظيفة",
    interviewPreparation: "التحضير للمقابلة",
    interviewPreparationDesc: "أتقن مهارات المقابلة مع جلسات تدريب مدعومة بالذكاء الاصطناعي",
    careerCoaching: "التوجيه المهني",
    careerCoachingDesc: "إرشاد مهني مخصص وجهاً لوجه من الخبراء",
    mostPopular: "الأكثر شعبية",
    selectService: "اختر الخدمة",
    needCustomSolution: "تحتاج حلاً مخصصاً؟",
    needCustomSolutionDesc: "تواصل مع فريقنا للحصول على خدمات مخصصة تناسب احتياجاتك المهنية المحددة",
    contactUs: "اتصل بنا",
    recentPayment: "دفعة حديثة",
    aed: "درهم",
    experience: "الخبرة",

    applicationsCount: "التقديمات",
    postedTime: "تاريخ النشر",
    department: "القسم",
    team: "الفريق",
    nationality: "الجنسية",
    
    // Service Features
    aiAnalysisMatching: "تحليل الذكاء الاصطناعي ومطابقة الوظائف",
    professionalFormatting: "تنسيق مهني",
    keywordOptimization: "تحسين الكلمات المفتاحية",
    atsCompatibility: "متوافق مع أنظمة تتبع المتقدمين",
    instantDownload: "تحميل فوري",
    personalizedCoverLetter: "خطاب تقديم مخصص",
    jobSpecificContent: "محتوى خاص بالوظيفة",
    professionalTone: "نبرة مهنية",
    multipleFormats: "تنسيقات متعددة",
    editableTemplate: "قالب قابل للتعديل",
    commonQuestions: "أسئلة شائعة في المقابلات",
    industrySpecificQuestions: "أسئلة خاصة بالصناعة",
    gender: "الجنس",
    answerTemplates: "قوالب إجابات",
    confidenceBuilding: "نصائح بناء الثقة",
    practiceSimulations: "محاكاة التدريب",
    oneOnOneSession: "جلسة فردية",
    careerGoalSetting: "تحديد الأهداف المهنية",
    skillAssessment: "تقييم المهارات",
    personalizedPlan: "خطة عمل مخصصة",
    followUpSupport: "دعم المتابعة",
    
    // Time Periods
    month: "شهر",
    year: "سنة", 
    week: "أسبوع",
    day: "يوم",
    hour: "ساعة",
    
    // Dashboard & Charts
    totalMatchingJobs: "إجمالي الوظائف المطابقة",
    skillTrends: "اتجاهات المهارات",
    globalDemandFor: "الطلب العالمي على",
    flexible: "مرن",
    
    // Countries
    uae: "الإمارات العربية المتحدة",
    taiwan: "تايوان",
    india: "الهند",
    saudiArabia: "المملكة العربية السعودية",
    
    // Search & Job Filters
    filterJobsChoice: "قم بتصفية الوظائف التي تختارها",
    selectLocation: "اختر الموقع",
    selectJobType: "اختر نوع الوظيفة",
    yearsExperience: "سنتين",
    attendance: "الحضور",
    
    // UAE Cities
    "Dubai, UAE": "دبي، الإمارات العربية المتحدة",
    "Abu Dhabi, UAE": "أبو ظبي، الإمارات العربية المتحدة",
    "Sharjah, UAE": "الشارقة، الإمارات العربية المتحدة",
    "Ras Al Khaimah, UAE": "رأس الخيمة، الإمارات العربية المتحدة",
    "Fujairah, UAE": "الفجيرة، الإمارات العربية المتحدة",
    "Ajman, UAE": "عجمان، الإمارات العربية المتحدة",
    "Umm Al Quwain, UAE": "أم القيوين، الإمارات العربية المتحدة",
    "Al Ain, UAE": "العين، الإمارات العربية المتحدة",
    freelance: "العمل الحر",
    hideFilters: "إخفاء المرشحات",
    showFilters: "إظهار المرشحات",
    
    // Dashboard Components
    matchedJobs: "الوظائف المطابقة",
    
    // Resume Builder
    generateNewResume: "إنشاء سيرة ذاتية جديدة",
    checkGeneratedResume: "تحقق من السيرة الذاتية المُنشأة",
    resumeScore: "نقاط السيرة الذاتية",
    tips: "نصائح",
    generatingYourResume: "جاري إنشاء سيرتك الذاتية",
    pleaseWaitWhileGenerating: "يرجى الانتظار بينما ننشئ سيرتك الذاتية المهنية...",
    analyzingInformation: "جاري تحليل معلوماتك...",
    formattingResume: "جاري تنسيق سيرتك الذاتية...",
    applyingProfessionalStyling: "جاري تطبيق التصميم المهني...",
    finalizingResume: "جاري إنهاء سيرتك الذاتية...",
    
    // Resume Download & Export
    editorMode: "وضع التحرير",
    exportAs: "تصدير كـ",
    wordDocument: "مستند وورد",
    unlockFullResumeView: "إلغاء قفل عرض السيرة الذاتية الكامل",
    completePaymentToUnlock: "لعرض وتحميل سيرتك الذاتية بدون تشويش، يرجى إتمام الدفع.",
    paymentSuccessful: "تم الدفع بنجاح!",
    resumeNowUnlocked: "تم إلغاء قفل سيرتك الذاتية الآن.",
    resumeUnlockFee: "رسوم إلغاء قفل السيرة الذاتية",
    cardNumber: "رقم البطاقة",
    expiryDate: "تاريخ الانتهاء",
    cardholderName: "اسم حامل البطاقة",
    processing: "جاري المعالجة...",
    pay: "ادفع",
    
    // Job Details Component
    selectResumeToApply: "اختر السيرة الذاتية للتقديم",
    chooseResumeForJob: "اختر السيرة الذاتية التي تريد استخدامها للتقديم على",
    at: "في",
    applying: "جاري التقديم...",
    applicationSubmittedSuccessfully: "تم إرسال الطلب بنجاح!",
    applicationSubmittedMessage: "تم إرسال طلبك لوظيفة {jobTitle} في {company} بنجاح. ستتلقى إشعارات حول حالة طلبك.",
    easyApplyViaTabashir: "تقديم سهل عبر تباشير",
    applyThroughCompanyWebsite: "تقدم عبر موقع الشركة",
    forMale: "للذكور",
    forFemale: "للإناث",
    forAll: "للجميع",
    jobDescription: "وصف الوظيفة",
    noDescriptionProvided: "لم يتم توفير وصف.",
    noNationalityRequired: "لا يوجد متطلب جنسية",
    noExperienceRequired: "لا يوجد متطلب خبرة",
    noRequirementsProvided: "لم يتم توفير متطلبات.",
    aboutTheCompany: "حول الشركة",
    noCompanyDescriptionProvided: "لم يتم توفير وصف للشركة.",
    resumePreview: "معاينة السيرة الذاتية",
    uploaded: "تم الرفع",
    entity: "الكيان",
    private: "خاص",
    selectResume: "اختر السيرة الذاتية",
    government: "حكومي",
    semiGovernment: "شبه حكومي",
    notSpecified: "غير محدد",
    tbd: "سيتم تحديده",
    
    // Terms and Conditions
    termsAndConditionsText: "من خلال الوصول إلى أو استخدام موقع تباشير الإلكتروني أو التطبيق أو الخدمات ذات الصلة (\"الخدمات\")، فإنك توافق على الامتثال لهذه الشروط والأحكام والالتزام بها. نحتفظ بالحق في تحديث أو تعديل هذه الشروط في أي وقت دون إشعار مسبق، واستمرار استخدامك للخدمات يشكل قبولاً لتلك التغييرات. يجب أن تكون بعمر 18 عاماً على الأقل أو تحصل على موافقة الوالدين لاستخدام خدماتنا. أنت مسؤول عن الحفاظ على سرية حسابك وعن جميع الأنشطة التي تتم تحته. جميع المحتويات المقدمة مملوكة لتباشير ومحمية بقوانين الملكية الفكرية. لا يجوز لك إساءة استخدام خدماتنا أو التدخل في تشغيلها. يتم توفير الخدمات \"كما هي\" دون ضمانات، وتباشير غير مسؤولة عن أي أضرار ناتجة عن استخدامك. قد نتضمن روابط لأطراف ثالثة، والتي لا نتحكم فيها أو نؤيدها. تخضع هذه الشروط لقوانين [بلدك/ولايتك]، وستتم معالجة أي نزاعات في محاكم تلك الولاية القضائية. نحتفظ بالحق في تعليق أو إنهاء وصولك في أي وقت. للأسئلة، اتصل بنا على [support@tabashir.ae].",
    agreeToTermsAndConditions: "أوافق على جميع الشروط والأحكام",

    noResumesFoundUpload: "لم يتم العثور على سيرة ذاتية. يرجى رفع سيرة ذاتية أولاً.",

    pleaseUploadResumeToGetStarted: "يرجى رفع سيرة ذاتية أولاً للبدء",

    profileCompletion: "تكملة الملف الشخصي",
    contentOptimization: "تحسين المحتوى",
    engagementBoost: "تعزيز التفاعل",
    visibilityEnhancement: "تعزيز الظهور",
    linkedinEnhancement: "تحسين ملفك الشخصي على LinkedIn",
    linkedinEnhancementDesc: "تحسين ملفك الشخصي على LinkedIn بالذكاء الاصطناعي",

    aiJobSearch: "📝 إعداد سيرة ذاتية ATS مجانية",
    aiJobApplication: "📄 خطاب وظيفي مجاني لكل وظيفة",
    aiJobTracking: "🏛 التقديم على الوظائف الحكومية",
    aiJobInterview: "🏢 التقديم على وظائف القطاع الخاص",
    aiJobOffer: "📊 متابعة حالة الطلبات وإرسال تقرير لك",
    aiJobLinkedin: "💼 التقديم على وظائف LinkedIn",

    aiJobApplyDesc: "💡 تقديم على 200 وظيفة بالذكاء الاصطناعي ",

    aiJobSearchDesc: "📝 إعداد سيرة ذاتية ATS مجانية",
    aiJobApplicationDesc: "📄 خطاب وظيفي مجاني لكل وظيفة",
    aiJobTrackingDesc: "تتبع طلبات الوظائف بالذكاء الاصطناعي",
    
    // Resume Upload Modal
    uploadYourResume: "ارفع سيرتك الذاتية",
    helpRecruiterKnowAboutYou: "ساعد أصحاب العمل على معرفة المزيد عنك",
    dragAndDropOrClickToUpload: "اسحب وأفلت سيرتك الذاتية هنا أو انقر للتصفح",
    uploadingYourResume: "جاري رفع سيرتك الذاتية...",
    createNewUsingAI: "إنشاء جديد باستخدام الذكاء الاصطناعي",
    uploadAndEnhance: "رفع وتحسين بالذكاء الاصطناعي",
    failedToUploadResume: "فشل في رفع السيرة الذاتية",
    or: "أو",

    startApplyingMyApplication: "ابدأ التقديم على سيرتي",

    // Courses
    coursesAvailable: "دورة متاحة",
    coursesAvailablePlural: "دورات متاحة",
    noCourses: "لا توجد دورات متاحة",
    noCoursesFound: "لم يتم العثور على دورات",
    tryAdjustingSearch: "حاول تعديل معايير البحث أو التصفية",
    checkBackLater: "تحقق لاحقاً من الدورات الجديدة",
    allCategories: "جميع الفئات",
    searchCourses: "البحث في الدورات...",
    startCourse: "ابدأ الدورة",
    by: "بواسطة",
    newest: "الأحدث",
    oldest: "الأقدم",
    minMaxPositions: "الحد الأدنى والحد الأقصى للمناصب",
  }
};

export function useTranslation() {
  const [language, setLanguage] = useState<'en' | 'ar'>('ar');
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Load saved language preference
    const savedLanguage = localStorage.getItem('preferred-language');
    if (savedLanguage && ['en', 'ar'].includes(savedLanguage)) {
      setLanguage(savedLanguage as 'en' | 'ar');
      setLoading(false);
    }

    // Listen for language changes
    const handleLanguageChange = (event: CustomEvent) => {
      const newLanguage = event.detail.language;
      if (['en', 'ar'].includes(newLanguage)) {
        setLanguage(newLanguage);
      }
    };

    window.addEventListener('languageChanged', handleLanguageChange as EventListener);

    return () => {
      window.removeEventListener('languageChanged', handleLanguageChange as EventListener);
    };
  }, []);

  const t = (key: string): string => {
    return (translations[language] as any)[key] || (translations.en as any)[key] || key;
  };

  return {
    t,
    language,
    loading,
    isRTL: language === 'ar',
  };
} 
/// API endpoints configuration
/// Centralized location for all API endpoint URLs
class ApiEndpoints {
  ApiEndpoints._();

  // ==========================================
  // Base URLs
  // ==========================================
  static const String appBaseUrl = 'http://localhost:5001';
  static const String backendBaseUrl = 'http://localhost:5001';

  // ==========================================
  // Auth Endpoints
  // ==========================================
  static const String authLogin = '/api/mobile/auth/login';
  static const String authRegister = '/api/mobile/auth/register';
  static const String authVerifyEmail = '/api/auth/verify-email';

  // ==========================================
  // User Management Endpoints
  // ==========================================
  static const String userProfile = '/api/user/profile';
  static const String candidatePersonalInfo =
      '/api/candidate/onboarding/personal-info';
  static const String candidateProfessionalInfo =
      '/api/candidate/onboarding/professional-info';

  // ==========================================
  // Subscription Endpoints
  // ==========================================
  static const String subscriptionLatest = '/api/subscription/latest';
  static const String subscriptionDebug = '/api/subscription/debug';
  static const String subscriptionTest = '/api/subscription/test';

  // ==========================================
  // Payment Endpoints
  // ==========================================
  static const String paymentIntent = '/api/payment-intent';
  static const String stripeCheckoutSession =
      '/api/stripe/create-checkout-session';
  static const String paymentLatest = '/api/payments/latest';

  // ==========================================
  // File Upload Endpoints
  // ==========================================
  static const String uploadThing = '/api/uploadthing';

  // ==========================================
  // AI Resume Endpoints
  // ==========================================
  static const String aiResumeCreate = '/api/ai-resume/create';

  // ==========================================
  // Resume & Job Processing Endpoints
  // (backend.tabashir.ae)
  // ==========================================
  static const String resumeAppliedJobs = '/api/v1/resume/applied-jobs';
  static const String resumeAppliedJobsCount =
      '/api/v1/resume/applied-jobs-count';
  static const String resumeApply = '/api/v1/resume/apply';
  static const String resumeFormat = '/api/v1/resume/format';
  static const String resumeFormatCvObject = '/api/v1/resume/format-cv-object';
  static const String resumeTranslate = '/api/v1/resume/translate';
  static const String resumeSendLinkedInEmail =
      '/api/v1/resume/send-linkedin-email';
  static const String resumeHealth = '/api/v1/resume/health';

  // ==========================================
  // Job Endpoints
  // ==========================================
  static const String jobs = '/api/v1/resume/jobs';
  static const String jobsCountByCity = '/api/v1/resume/jobs/count-by-city';
  static const String jobsMonthlyCount = '/api/v1/resume/jobs/monthly-count';
  static String jobsById(String jobId) => '/api/v1/resume/jobs/$jobId';
  static String jobsApplicantsCount(String jobId) =>
      '/api/v1/resume/jobs/$jobId/applicants-count';
  static const String jobsCreate = '/api/v1/resume/jobs';
  static String jobsUpdate(String jobId) => '/api/v1/resume/jobs/$jobId';
  static String jobApply(String jobId) => '/api/v1/resume/$jobId/apply';
}

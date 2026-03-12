import 'package:flutter_dotenv/flutter_dotenv.dart';

/// API endpoints configuration
/// Centralized location for all API endpoint URLs
class ApiEndpoints {
  ApiEndpoints._();

  // ==========================================
  // Base URLs
  // ==========================================
  static String get appBaseUrl => dotenv.env['API_BASE_URL'] ?? 'http://10.0.2.2:5050';
  static String get backendBaseUrl => appBaseUrl;

  // ==========================================
  // Auth Endpoints
  // ==========================================
  static const String authLogin = '/api/v1/auth/login';
  static const String authRegister = '/api/v1/auth/register';
  static const String authVerifyEmail = '/api/v1/auth/verify-email';
  static const String authRefresh = '/api/v1/auth/refresh';

  // ==========================================
  // User Management Endpoints
  // ==========================================
  static const String userProfile = '/api/v1/user/profile';
  static const String userMobileMe = '/api/v1/user/mobile/me';
  static const String candidatePersonalInfo =
      '/api/v1/mobile/candidate/onboarding/personal-info';
  static const String candidateProfessionalInfo =
      '/api/v1/mobile/candidate/onboarding/professional-info';

  // ==========================================
  // Subscription Endpoints
  // ==========================================
  static const String subscriptionLatest = '/api/v1/mobile/subscription/latest';
  static const String subscriptionDebug = '/api/v1/mobile/subscription/debug';
  static const String subscriptionTest = '/api/v1/mobile/subscription/test';

  // ==========================================
  // Payment Endpoints
  // ==========================================
  static const String paymentIntent = '/api/v1/mobile/payment-intent';
  static const String stripeCheckoutSession =
      '/api/v1/mobile/stripe/create-checkout-session';
  static const String paymentLatest = '/api/v1/mobile/payments/latest';

  // ==========================================
  // File Upload Endpoints
  // ==========================================
  static const String uploadThing = '/api/v1/mobile/uploadthing';

  // ==========================================
  // AI Resume Endpoints
  // ==========================================
  static const String aiResumeCreate = '/api/v1/mobile/ai-resume/create';

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

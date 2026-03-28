import 'package:flutter_dotenv/flutter_dotenv.dart';

/// API endpoints configuration
/// Centralized location for all API endpoint URLs
class ApiEndpoints {
  ApiEndpoints._();

  // ==========================================
  // Base URLs
  // ==========================================
  static String get appBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'http://10.0.2.2:5050';
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
  static const String userProfile = '/api/v1/users/profile';
  static const String userMobileMe = '/api/v1/users/me';
  static const String candidatePersonalInfo =
      '/api/v1/candidates/onboarding/personal-info';
  static const String candidateProfessionalInfo =
      '/api/v1/candidates/onboarding/professional-info';

  // ==========================================
  // Subscription Endpoints
  // ==========================================
  static const String subscriptionLatest = '/api/v1/subscriptions/latest';
  static const String subscriptionDebug = '/api/v1/subscriptions/debug';
  static const String subscriptionTest = '/api/v1/subscriptions/test';

  // ==========================================
  // Payment Endpoints
  // ==========================================
  static const String paymentIntent = '/api/v1/payments/payment-intent';
  static const String stripeCheckoutSession =
      '/api/v1/payments/stripe/create-checkout-session';
  static const String paymentLatest = '/api/v1/payments/latest';

  // ==========================================
  // File Upload Endpoints
  // ==========================================
  static const String uploadThing = '/api/v1/uploads/uploadthing';

  // ==========================================
  // AI Resume Endpoints
  // ==========================================
  static const String aiResumeCreate = '/api/v1/resumes/ai-resume/create';

  // ==========================================
  // Resume & Job Processing Endpoints
  // (backend.tabashir.ae)
  // ==========================================
  static const String resumeAppliedJobs = '/api/v1/resumes/applied-jobs';
  static const String resumeAppliedJobsCount =
      '/api/v1/resumes/applied-jobs-count';
  static const String resumeApply = '/api/v1/resumes/apply';
  static const String resumeFormat = '/api/v1/resumes/format';
  static const String resumeFormatCvObject = '/api/v1/resumes/format-cv-object';
  static const String resumeTranslate = '/api/v1/resumes/translate';
  static const String resumeSendLinkedInEmail =
      '/api/v1/resumes/send-linkedin-email';
  static const String resumeClient = '/api/v1/resumes/client';
  static const String resumeHealth = '/api/v1/resumes/health';

  // ==========================================
  // Job Endpoints
  // ==========================================
  static const String jobs = '/api/v1/resumes/jobs';
  static const String jobsCountByCity = '/api/v1/resumes/jobs/count-by-city';
  static const String jobsMonthlyCount = '/api/v1/resumes/jobs/monthly-count';
  static const String jobsMatched = '/api/v1/resumes/jobs/matched';
  static String jobsById(String jobId) => '/api/v1/resumes/jobs/$jobId';
  static String jobsApplicantsCount(String jobId) =>
      '/api/v1/resumes/jobs/$jobId/applicants-count';
  static const String jobsCreate = '/api/v1/resumes/jobs';
  static String jobsUpdate(String jobId) => '/api/v1/resumes/jobs/$jobId';
  static String jobApply(String jobId) => '/api/v1/resumes/$jobId/apply';
}

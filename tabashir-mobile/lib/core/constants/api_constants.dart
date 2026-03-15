import 'package:flutter_dotenv/flutter_dotenv.dart';

/// API constants for the application
class ApiConstants {
  /// Base API URL (Main API) - Using Flask for local development
  static String get baseUrl => dotenv.env['API_BASE_URL'] ?? 'http://10.0.2.2:5050';

  /// Production Backend URL for CV processing and job matching
  /// Used by TabashirApiService for: format, translate, apply, jobs
  static String get productionBackendUrl =>
      '$baseUrl/api/v1/resumes';

  /// Development Backend URL for generic CRUD operations
  static String get devBackendUrl => '$baseUrl/api/v1';

  /// Authentication endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String refreshTokenEndpoint = '/auth/refresh';
  static const String forgotPasswordEndpoint = '/auth/forgot-password';
  static const String resetPasswordEndpoint = '/auth/reset-password';

  /// User endpoints
  static const String userProfileEndpoint = '/users/profile';
  static const String updateUserEndpoint = '/users/update';

  /// Candidate endpoints
  static const String candidatesEndpoint = '/candidates';
  static const String candidateProfileEndpoint = '/candidates/profile';
  static const String candidateApplicationsEndpoint =
      '/candidates/applications';

  /// Recruiter endpoints
  static const String recruitersEndpoint = '/recruiters';
  static const String recruiterJobsEndpoint = '/recruiters/jobs';

  /// Job endpoints
  static const String jobsEndpoint = '/jobs';
  static const String jobDetailEndpoint = '/jobs/detail';
  static const String searchJobsEndpoint = '/jobs/search';

  /// Job applications endpoints
  static const String jobApplicationsEndpoint = '/job-applications';
  static const String applyJobEndpoint = '/job-applications/apply';

  /// AI resume generation endpoints
  static const String aiResumeEndpoint = '/ai/resume';
  static const String aiResumeAnalysisEndpoint = '/ai/resume/analyze';

  /// Resume endpoints
  static const String resumeEndpoint = '/resumes';
  static const String uploadResumeEndpoint = '/resumes/upload';

  /// Subscription endpoints
  static const String subscriptionsEndpoint = '/subscriptions';
  static const String paymentIntentEndpoint = '/payments/create-intent';

  /// Admin endpoints
  static const String adminDashboardEndpoint = '/admin/dashboard';
  static const String adminUsersEndpoint = '/admin/users';

  /// Timeouts
  static const Duration connectTimeout = Duration(seconds: 120);
  static const Duration receiveTimeout = Duration(seconds: 120);
  static const Duration sendTimeout = Duration(seconds: 120);

  /// Headers
  static const String contentTypeHeader = 'Content-Type';
  static const String authorizationHeader = 'Authorization';
  static const String applicationJson = 'application/json';

  /// Query parameters
  static const String limitQueryParam = 'limit';
  static const String offsetQueryParam = 'offset';
  static const String searchQueryParam = 'search';
  static const String pageQueryParam = 'page';
}

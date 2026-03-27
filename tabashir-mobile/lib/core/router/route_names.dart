/// Route names for the application
class RouteNames {
  /// Authentication routes
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  /// Main feature routes
  static const String home = '/home';
  static const String jobs = '/jobs';
  static const String jobDetail = '/job-detail';
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';
  static const String changePassword = '/profile/change-password';
  static const String companyProfile = '/company-profile';
  static const String applications = '/applications';
  static const String aiResume = '/ai-resume';
  static const String aiResumeBuilder = '/ai-resume-builder';
  static const String aiResumeBuilderSuccess = '/ai-resume-builder/success';
  static const String aiJobApply = '/ai-job-apply';
  static const String aiJobApplyTargetRoles = '/ai-job-apply/target-roles';
  static const String aiJobApplyLocationPreferences =
      '/ai-job-apply/location-preferences';
  static const String aiJobApplyPersonalDetails =
      '/ai-job-apply/personal-details';
  static const String aiJobApplyReview = '/ai-job-apply/review';
  static const String resumeBuilder = '/resume-builder';
  static const String resumeVault = '/profile/resume-vault';
  static const String subscriptions = '/subscriptions';
  static const String payment = '/payment';

  static const String interviewTrainingScreen = '/interview-training-screen';

  static const String services = '/services';
  static const String adminDashboard = '/admin-dashboard';

  /// Additional routes
  static const String search = '/search';
  static const String settings = '/settings';
  static const String notifications = '/notifications';
  static const String messages = '/messages';
  static const String savedJobs = '/saved-jobs';

  /// Onboarding routes
  static const String resumeImport = '/resume-import';
  static const String onboardingWizard = '/onboarding-wizard';

  /// Resume routes
  static const String resumePreview = '/resume-preview';
  static const String resumeReview = '/resume-review';
}

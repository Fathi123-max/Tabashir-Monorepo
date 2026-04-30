/// Storage keys for local storage
class StorageKeys {
  /// Authentication
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userCredentials = 'user_credentials';
  static const String isLoggedIn = 'is_logged_in';

  /// User preferences
  static const String themeMode = 'theme_mode';
  static const String languageCode = 'language_code';
  static const String countryCode = 'country_code';

  /// Cache keys
  static const String cachedUserProfile = 'cached_user_profile';
  static const String cachedJobsList = 'cached_jobs_list';
  static const String cachedCandidatesList = 'cached_candidates_list';
  static const String cachedApplicationsList = 'cached_applications_list';

  /// Device info
  static const String deviceId = 'device_id';
  static const String deviceToken = 'device_token';
  static const String installationId = 'installation_id';

  /// Onboarding
  static const String hasCompletedOnboarding = 'has_completed_onboarding';
  static const String hasSeenTutorial = 'has_seen_tutorial';
  static const String resumeParsedPrefill = 'resume_parsed_prefill';

  /// Setup flow (post-signup: resume upload → wizard → addClient API)
  static const String hasCompletedSetup = 'has_completed_setup';

  /// Notifications
  static const String notificationSettings = 'notification_settings';
  static const String enablePushNotifications = 'enable_push_notifications';
  static const String enableEmailNotifications = 'enable_email_notifications';

  /// Analytics
  static const String hasGivenAnalyticsPermission =
      'has_given_analytics_permission';
  static const String sessionId = 'session_id';
}

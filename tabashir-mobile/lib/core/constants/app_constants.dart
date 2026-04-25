/// Application constants
class AppConstants {
  /// App name
  static const String appName = 'Tabashir';

  /// Version
  static const String version = '1.0.0';

  /// Environment
  static const String environment = String.fromEnvironment(
    'ENV',
    defaultValue: 'development',
  );

  /// Default values
  static const int defaultPageSize = 20;
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration shortAnimationDuration = Duration(milliseconds: 150);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  /// Regex patterns
  static const String emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$';
  static const String phonePattern = r'^[\+]?[1-9][\d]{0,15}$';

  /// Validation messages
  static const String emailValidationError =
      'Please enter a valid email address';
  static const String passwordValidationError =
      'Password must be at least 8 characters';
  static const String requiredFieldError = 'This field is required';

  /// Assets paths
  static const String userPlaceholderAsset =
      'assets/images/user_placeholder.png';
  static const String companyPlaceholderAsset =
      'assets/images/company_placeholder.png';

  /// URLs
  static const String privacyPolicyUrl = 'https://tabashir.com/privacy-policy';
  static const String termsOfServiceUrl =
      'https://tabashir.com/terms-of-service';
  static const String supportEmail = 'support@tabashir.com';

  /// Notifications
  static const int maxNotificationCount = 100;

  /// Cache
  static const Duration cacheExpiry = Duration(hours: 24);
  static const Duration shortCacheExpiry = Duration(minutes: 5);

  /// Debounce durations
  static const Duration searchDebounceDuration = Duration(milliseconds: 500);
  static const Duration scrollDebounceDuration = Duration(milliseconds: 250);

  /// OneSignal Configuration
  static const String oneSignalAppId = 'bf2fbe39-0ab0-41e1-a9cb-1ecefe72474c';

  /// Google Sign-In Configuration
  static const String googleSignInServerClientId = String.fromEnvironment(
    'GOOGLE_SIGN_IN_SERVER_CLIENT_ID',
    defaultValue: '908457286237-sl5h3g85uf350uje8k39f55t6ankopjc.apps.googleusercontent.com',
  );
}

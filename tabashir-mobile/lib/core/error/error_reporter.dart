import 'package:firebase_crashlytics/firebase_crashlytics.dart';

/// Service to handle error reporting
class ErrorReporter {
  ErrorReporter._();
  static ErrorReporter? _instance;
  static ErrorReporter get instance => _instance ??= ErrorReporter._();

  /// Reports an error to Crashlytics
  Future<void> reportError(
    Object error,
    StackTrace stackTrace, {
    String? reason,
    bool fatal = false,
  }) async {
    await FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      reason: reason,
      fatal: fatal,
    );
  }

  /// Reports an exception to Crashlytics
  Future<void> reportException(
    Exception exception, {
    String? reason,
    bool fatal = false,
  }) async {
    await FirebaseCrashlytics.instance.recordError(
      exception,
      StackTrace.current,
      reason: reason,
      fatal: fatal,
    );
  }

  /// Sets user identifier for crash reports
  Future<void> setUserIdentifier(String identifier) async {
    await FirebaseCrashlytics.instance.setUserIdentifier(identifier);
  }

  /// Sets custom key-value pairs for crash reports
  Future<void> setCustomKey(String key, Object value) async {
    await FirebaseCrashlytics.instance.setCustomKey(key, value);
  }

  /// Logs a message that will appear in the crash report
  Future<void> log(String message) async {
    await FirebaseCrashlytics.instance.log(message);
  }

  /// Checks if crash reporting is enabled
  bool get isCrashlyticsCollectionEnabled =>
      FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled;

  /// Enables/disables crash reporting
  Future<void> setCrashlyticsCollectionEnabled(bool enabled) async {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(enabled);
  }
}

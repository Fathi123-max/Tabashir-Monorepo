import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Centralized logging utility that suppresses logs in release builds.
/// Use this instead of print() to avoid leaking sensitive data.
class AppLogger {
  /// Log a debug message
  static void debug(String message, {String tag = 'App'}) {
    if (kDebugMode) {
      developer.log(
        message,
        name: tag,
        level: 500, // FINE
      );
    }
  }

  /// Log an informational message
  static void info(String message, {String tag = 'App'}) {
    if (kDebugMode) {
      developer.log(
        message,
        name: tag,
        level: 800, // INFO
      );
    }
  }

  /// Log a warning message
  static void warning(String message, {String tag = 'App'}) {
    if (kDebugMode) {
      developer.log(
        message,
        name: tag,
        level: 900, // WARNING
      );
    }
  }

  /// Log an error message with optional stack trace
  static void error(
    String message, {
    String tag = 'App',
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      developer.log(
        message,
        name: tag,
        level: 1000, // SEVERE
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}

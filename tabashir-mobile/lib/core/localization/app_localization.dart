import 'package:flutter/material.dart';

/// Application localization configuration
class AppLocalization {
  AppLocalization._(); // Private constructor to prevent instantiation

  /// Supported locales for the application
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'), // English
    Locale('ar'), // Arabic
    Locale('es'), // Spanish
  ];

  /// Fallback locale when translation is not available
  static const Locale fallbackLocale = Locale('en');

  /// Path to translation files
  static const String translationPath = 'assets/translations';

  /// Get locale from language code
  static Locale getLocaleFromLanguageCode(String languageCode) {
    try {
      final parts = languageCode.split('_');
      if (parts.length == 2) {
        return Locale(parts[0], parts[1]);
      } else {
        return Locale(parts[0]);
      }
    } on Exception {
      return fallbackLocale;
    }
  }

  /// Get language code from locale
  static String getLanguageCodeFromLocale(Locale locale) {
    final countryCode = locale.countryCode;
    return countryCode != null
        ? '${locale.languageCode}_$countryCode'
        : locale.languageCode;
  }

  /// Check if locale is supported
  static bool isSupportedLocale(Locale locale) => supportedLocales.any(
    (supportedLocale) => supportedLocale.languageCode == locale.languageCode,
  );
}

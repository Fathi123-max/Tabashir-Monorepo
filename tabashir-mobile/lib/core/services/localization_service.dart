import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabashir/core/services/ai_job_apply_config_service.dart';

/// Supported languages for the app
enum SupportedLanguage {
  english('en', 'English'),
  arabic('ar', 'العربية'),
  spanish('es', 'Español');

  const SupportedLanguage(this.code, this.displayName);
  final String code;
  final String displayName;
}

/// Localization service for AI Job Apply feature
/// Provides multi-language support for roles, locations, and other content
class LocalizationService {
  LocalizationService._();

  static const String _languageKey = 'ai_job_apply_language';

  /// Get current language code
  static Future<String> getCurrentLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_languageKey) ?? SupportedLanguage.english.code;
    } catch (e) {
      if (kDebugMode) {
        print('[Localization] Error getting language: $e');
      }
      return SupportedLanguage.english.code;
    }
  }

  /// Set current language
  static Future<void> setLanguage(SupportedLanguage language) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, language.code);
      if (kDebugMode) {
        print('[Localization] Language set to: ${language.displayName}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('[Localization] Error setting language: $e');
      }
    }
  }

  /// Get localized role name
  /// Returns the role name in the current language
  static String getLocalizedRole(String role, {String? languageCode}) {
    final roleTranslations = _getRoleTranslations();
    final lang = languageCode ?? SupportedLanguage.english.code;

    // For English, return as-is
    if (lang == SupportedLanguage.english.code) {
      return role;
    }

    // Check if translation exists
    if (roleTranslations[lang]?[role] != null) {
      return roleTranslations[lang]![role]!;
    }

    // Fallback to English
    return role;
  }

  /// Get localized location name
  static String getLocalizedLocation(String location, {String? languageCode}) {
    final locationTranslations = _getLocationTranslations();
    final lang = languageCode ?? SupportedLanguage.english.code;

    // For English, return as-is
    if (lang == SupportedLanguage.english.code) {
      return location;
    }

    // Check if translation exists
    if (locationTranslations[lang]?[location] != null) {
      return locationTranslations[lang]![location]!;
    }

    // Fallback to English
    return location;
  }

  /// Get localized nationality name
  static String getLocalizedNationality(
    String nationality, {
    String? languageCode,
  }) {
    final nationalityTranslations = _getNationalityTranslations();
    final lang = languageCode ?? SupportedLanguage.english.code;

    // For English, return as-is
    if (lang == SupportedLanguage.english.code) {
      return nationality;
    }

    // Check if translation exists
    if (nationalityTranslations[lang]?[nationality] != null) {
      return nationalityTranslations[lang]![nationality]!;
    }

    // Fallback to English
    return nationality;
  }

  /// Get list of roles in current language
  static Future<List<String>> getLocalizedRoles() async {
    final lang = await getCurrentLanguage();
    final roles = AiJobApplyConfigService.popularRoles;

    if (lang == SupportedLanguage.english.code) {
      return roles;
    }

    return roles.map((role) => getLocalizedRole(role)).toList();
  }

  /// Get list of locations in current language
  static Future<List<String>> getLocalizedLocations() async {
    final lang = await getCurrentLanguage();
    final locations = AiJobApplyConfigService.popularLocations;

    if (lang == SupportedLanguage.english.code) {
      return locations;
    }

    return locations.map((loc) => getLocalizedLocation(loc)).toList();
  }

  /// Get list of nationalities in current language
  static Future<List<String>> getLocalizedNationalities() async {
    final lang = await getCurrentLanguage();
    final nationalities = AiJobApplyConfigService.nationalities;

    if (lang == SupportedLanguage.english.code) {
      return nationalities;
    }

    return nationalities.map((nat) => getLocalizedNationality(nat)).toList();
  }

  /// Get all supported languages
  static List<SupportedLanguage> getSupportedLanguages() {
    return SupportedLanguage.values;
  }

  /// Check if language is RTL (right-to-left)
  static bool isRTLLanguage(String languageCode) {
    return languageCode == SupportedLanguage.arabic.code;
  }

  /// Get role translations
  /// Format: {languageCode: {englishName: translatedName}}
  static Map<String, Map<String, String>> _getRoleTranslations() {
    return {
      // Arabic translations
      SupportedLanguage.arabic.code: {
        'Software Engineer': 'مهندس برمجيات',
        'Frontend Developer': 'مطور واجهات أمامية',
        'Backend Developer': 'مطور خلفي',
        'Full Stack Developer': 'مطور شامل',
        'Mobile Developer': 'مطور تطبيقات',
        'Data Scientist': 'عالم بيانات',
        'Product Manager': 'مدير منتج',
        'UI/UX Designer': 'مصمم واجهات',
        'DevOps Engineer': 'مهندس DevOps',
        'Project Manager': 'مدير مشروع',
        'Business Analyst': 'محلل أعمال',
        'QA Engineer': 'مهندس جودة',
        'Machine Learning Engineer': 'مهندس تعلم آلي',
        'Cloud Architect': 'مهندس معمارية سحابية',
        'Cybersecurity Specialist': 'أمن سيبراني',
      },
      // Spanish translations
      SupportedLanguage.spanish.code: {
        'Software Engineer': 'Ingeniero de Software',
        'Frontend Developer': 'Desarrollador Frontend',
        'Backend Developer': 'Desarrollador Backend',
        'Full Stack Developer': 'Desarrollador Full Stack',
        'Mobile Developer': 'Desarrollador Móvil',
        'Data Scientist': 'Científico de Datos',
        'Product Manager': 'Gerente de Producto',
        'UI/UX Designer': 'Diseñador UI/UX',
        'DevOps Engineer': 'Ingeniero DevOps',
        'Project Manager': 'Gerente de Proyecto',
        'Business Analyst': 'Analista de Negocios',
        'QA Engineer': 'Ingeniero de Calidad',
        'Machine Learning Engineer': 'Ingeniero de ML',
        'Cloud Architect': 'Arquitecto de Nube',
        'Cybersecurity Specialist': 'Especialista en Ciberseguridad',
      },
    };
  }

  /// Get location translations
  static Map<String, Map<String, String>> _getLocationTranslations() {
    return {
      // Arabic translations
      SupportedLanguage.arabic.code: {
        'Dubai': 'دبي',
        'Abu Dhabi': 'أبوظبي',
        'Sharjah': 'الشارقة',
        'Ajman': 'عجمان',
        'Ras Al Khaimah': 'رأس الخيمة',
        'Umm Al Quwain': 'أم القيوين',
        'Fujairah': 'الفجيرة',
        'Remote': 'عن بُعد',
        'Hybrid': 'هجين',
      },
      // Spanish translations
      SupportedLanguage.spanish.code: {
        'Dubai': 'Dubái',
        'Abu Dhabi': 'Abu Dabi',
        'Sharjah': 'Sharjah',
        'Ajman': 'Ajman',
        'Ras Al Khaimah': 'Ras Al Khaima',
        'Umm Al Quwain': 'Umm Al Quwain',
        'Fujairah': 'Fuyaira',
        'Remote': 'Remoto',
        'Hybrid': 'Híbrido',
      },
    };
  }

  /// Get nationality translations
  static Map<String, Map<String, String>> _getNationalityTranslations() {
    return {
      // Arabic translations
      SupportedLanguage.arabic.code: {
        'United Arab Emirates': 'الإمارات العربية المتحدة',
        'Saudi Arabia': 'المملكة العربية السعودية',
        'Egypt': 'مصر',
        'India': 'الهند',
        'Pakistan': 'باكستان',
        'Philippines': 'الفلبين',
        'United Kingdom': 'المملكة المتحدة',
        'United States': 'الولايات المتحدة',
        'Canada': 'كندا',
        'Australia': 'أستراليا',
        'Jordan': 'الأردن',
        'Lebanon': 'لبنان',
        'Nigeria': 'نيجيريا',
        'Bangladesh': 'بنغلاديش',
        'Sri Lanka': 'سريلانكا',
      },
      // Spanish translations
      SupportedLanguage.spanish.code: {
        'United Arab Emirates': 'Emiratos Árabes Unidos',
        'Saudi Arabia': 'Arabia Saudí',
        'Egypt': 'Egipto',
        'India': 'India',
        'Pakistan': 'Pakistán',
        'Philippines': 'Filipinas',
        'United Kingdom': 'Reino Unido',
        'United States': 'Estados Unidos',
        'Canada': 'Canadá',
        'Australia': 'Australia',
        'Jordan': 'Jordania',
        'Lebanon': 'Líbano',
        'Nigeria': 'Nigeria',
        'Bangladesh': 'Bangladés',
        'Sri Lanka': 'Sri Lanka',
      },
    };
  }

  /// Get localized strings for UI elements
  static Map<String, Map<String, String>> getUITranslations() {
    return {
      // Arabic UI translations
      SupportedLanguage.arabic.code: {
        'next': 'التالي',
        'back': 'السابق',
        'submit': 'إرسال',
        'cancel': 'إلغاء',
        'save': 'حفظ',
        'loading': 'جارٍ التحميل...',
        'error': 'خطأ',
        'success': 'نجح',
        'select': 'اختر',
        'selected': 'مُحدد',
        'role': 'الدور',
        'location': 'الموقع',
        'nationality': 'الجنسية',
        'resume': 'السيرة الذاتية',
        'review': 'مراجعة',
      },
      // Spanish UI translations
      SupportedLanguage.spanish.code: {
        'next': 'Siguiente',
        'back': 'Atrás',
        'submit': 'Enviar',
        'cancel': 'Cancelar',
        'save': 'Guardar',
        'loading': 'Cargando...',
        'error': 'Error',
        'success': 'Éxito',
        'select': 'Seleccionar',
        'selected': 'Seleccionado',
        'role': 'Rol',
        'location': 'Ubicación',
        'nationality': 'Nacionalidad',
        'resume': 'Currículum',
        'review': 'Revisar',
      },
    };
  }

  /// Get localized UI string
  static Future<String> getLocalizedString(String key) async {
    final lang = await getCurrentLanguage();
    final translations = getUITranslations();

    if (translations[lang]?[key] != null) {
      return translations[lang]![key]!;
    }

    // Fallback to English
    return key;
  }

  /// Check if localization is enabled
  static bool isLocalizationEnabled() {
    // Can be enabled/disabled based on app settings
    return true;
  }
}

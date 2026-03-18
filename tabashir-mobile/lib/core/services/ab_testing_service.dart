import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ai_job_apply_config_service.dart';

/// A/B Test configuration
class ABTestConfig {
  const ABTestConfig({
    required this.testName,
    required this.variantA,
    required this.variantB,
    this.variantAPercentage = 0.5,
    this.enabled = true,
  });

  factory ABTestConfig.fromJson(Map<String, dynamic> json) => ABTestConfig(
    testName: (json['testName'] as String?) ?? '',
    variantA: (json['variantA'] as String?) ?? '',
    variantB: (json['variantB'] as String?) ?? '',
    variantAPercentage: (json['variantAPercentage'] as double?) ?? 0.5,
    enabled: (json['enabled'] as bool?) ?? true,
  );
  final String testName;
  final String variantA;
  final String variantB;
  final double variantAPercentage; // 0.0 to 1.0
  final bool enabled;

  Map<String, dynamic> toJson() => {
    'testName': testName,
    'variantA': variantA,
    'variantB': variantB,
    'variantAPercentage': variantAPercentage,
    'enabled': enabled,
  };
}

/// A/B Testing service for dynamic configuration testing
/// Allows testing different configurations with different user groups
class ABTestingService {
  ABTestingService._();

  static const String _testConfigKey = 'ai_job_apply_ab_test_config';
  static const String _userVariantKey = 'ai_job_apply_ab_test_variant';
  static final Random _random = Random();

  /// Register a new A/B test configuration
  static Future<void> registerTest(ABTestConfig config) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final configJson = config.toJson().toString();
      await prefs.setString(_testConfigKey, configJson);

      if (kDebugMode) {
        print('[ABTesting] Registered test: ${config.testName}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('[ABTesting] Error registering test: $e');
      }
    }
  }

  /// Get user's variant for a specific test
  /// Returns 'A' or 'B' based on user assignment
  static Future<String> getUserVariant(
    String testName, {
    String? userId,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final variantKey =
          '${_userVariantKey}_${testName}_${userId ?? 'default'}';

      final savedVariant = prefs.getString(variantKey);
      if (savedVariant != null) {
        return savedVariant;
      }

      // Get test configuration
      final configJson = prefs.getString(_testConfigKey);
      if (configJson == null) {
        return 'A'; // Default to variant A
      }

      // Parse configuration (simplified)
      final config = ABTestConfig(
        testName: testName,
        variantA: 'A',
        variantB: 'B',
      );

      // Assign variant based on percentage
      final assignedVariant = _random.nextDouble() < config.variantAPercentage
          ? 'A'
          : 'B';

      // Save assignment
      await prefs.setString(variantKey, assignedVariant);

      if (kDebugMode) {
        print(
          '[ABTesting] Assigned variant $assignedVariant for test $testName',
        );
      }

      return assignedVariant;
    } catch (e) {
      if (kDebugMode) {
        print('[ABTesting] Error getting variant: $e');
      }
      return 'A'; // Default to variant A on error
    }
  }

  /// Get configuration value based on user's variant
  /// Returns variantAValue if user is in variant A, variantBValue if in variant B
  static Future<T> getVariantValue<T>(
    String testName,
    T variantAValue,
    T variantBValue, {
    String? userId,
  }) async {
    final variant = await getUserVariant(testName, userId: userId);
    return variant == 'A' ? variantAValue : variantBValue;
  }

  /// Get maximum roles to show based on A/B test
  static Future<int> getMaxRolesToShow({String? userId}) async =>
      getVariantValue(
        'max_roles_display',
        6, // Variant A: 6 roles
        8, // Variant B: 8 roles
        userId: userId,
      );

  /// Get maximum locations to show based on A/B test
  static Future<int> getMaxLocationsToShow({String? userId}) async =>
      getVariantValue(
        'max_locations_display',
        5, // Variant A: 5 locations
        7, // Variant B: 7 locations
        userId: userId,
      );

  /// Get default AI confidence based on A/B test
  static Future<int> getDefaultAiConfidence({String? userId}) async =>
      getVariantValue(
        'ai_confidence',
        85, // Variant A: 85
        90, // Variant B: 90
        userId: userId,
      );

  /// Get animation quality based on A/B test
  static Future<String> getAnimationQuality({String? userId}) async =>
      getVariantValue(
        'animation_quality',
        'auto', // Variant A: auto-detect
        'user_preference', // Variant B: user preference
        userId: userId,
      );

  /// Check if analytics tracking is enabled based on A/B test
  static Future<bool> isAnalyticsEnabled({String? userId}) async =>
      getVariantValue(
        'analytics_tracking',
        true, // Variant A: enabled
        false, // Variant B: disabled
        userId: userId,
      );

  /// Get popular roles list based on A/B test
  static Future<List<String>> getPopularRoles({String? userId}) async {
    final variant = await getUserVariant('popular_roles_order', userId: userId);

    final roles = AiJobApplyConfigService.popularRoles;

    if (variant == 'A') {
      // Variant A: Default order
      return roles;
    } else {
      // Variant B: Shuffle order for testing
      final shuffled = List<String>.from(roles);
      shuffled.shuffle(_random);
      return shuffled;
    }
  }

  /// Get popular locations list based on A/B test
  static Future<List<String>> getPopularLocations({String? userId}) async {
    final variant = await getUserVariant(
      'popular_locations_order',
      userId: userId,
    );

    final locations = AiJobApplyConfigService.popularLocations;

    if (variant == 'A') {
      // Variant A: Default order
      return locations;
    } else {
      // Variant B: Shuffle order for testing
      final shuffled = List<String>.from(locations);
      shuffled.shuffle(_random);
      return shuffled;
    }
  }

  /// Track test conversion (when user completes desired action)
  static Future<void> trackConversion(
    String testName,
    String variant, {
    String? userId,
  }) async {
    try {
      final conversionKey =
          '${_userVariantKey}_${testName}_${variant}_conversion';
      final prefs = await SharedPreferences.getInstance();
      final currentCount = prefs.getInt(conversionKey) ?? 0;
      await prefs.setInt(conversionKey, currentCount + 1);

      if (kDebugMode) {
        print(
          '[ABTracking] Conversion tracked for $testName ($variant): ${currentCount + 1}',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('[ABTracking] Error tracking conversion: $e');
      }
    }
  }

  /// Get conversion rate for a test variant
  static Future<Map<String, double>> getConversionRate(String testName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final variantAConversions =
          prefs.getInt('${_userVariantKey}_${testName}_A_conversion') ?? 0;
      final variantBConversions =
          prefs.getInt('${_userVariantKey}_${testName}_B_conversion') ?? 0;

      // For simplicity, return conversion counts as rates
      // In production, calculate based on total users in each variant
      return {
        'A': variantAConversions.toDouble(),
        'B': variantBConversions.toDouble(),
      };
    } catch (e) {
      if (kDebugMode) {
        print('[ABTracking] Error getting conversion rate: $e');
      }
      return {'A': 0.0, 'B': 0.0};
    }
  }

  /// Get all active test configurations
  static Future<List<ABTestConfig>> getActiveTests() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final configJson = prefs.getString(_testConfigKey);

      if (configJson == null) {
        return _getDefaultTests();
      }

      // Return default tests for now
      // In production, parse and return actual tests
      return _getDefaultTests();
    } catch (e) {
      if (kDebugMode) {
        print('[ABTesting] Error getting active tests: $e');
      }
      return _getDefaultTests();
    }
  }

  /// Get default test configurations
  static List<ABTestConfig> _getDefaultTests() => [
    const ABTestConfig(
      testName: 'max_roles_display',
      variantA: '6_roles',
      variantB: '8_roles',
    ),
    const ABTestConfig(
      testName: 'max_locations_display',
      variantA: '5_locations',
      variantB: '7_locations',
    ),
    const ABTestConfig(
      testName: 'ai_confidence',
      variantA: '85',
      variantB: '90',
    ),
    const ABTestConfig(
      testName: 'popular_roles_order',
      variantA: 'default_order',
      variantB: 'shuffled_order',
    ),
    const ABTestConfig(
      testName: 'analytics_tracking',
      variantA: 'enabled',
      variantB: 'disabled',
    ),
  ];

  /// Clear all test data
  static Future<void> clearTests() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_testConfigKey);

      // Clear all user variants
      final keys = prefs.getKeys();
      for (final key in keys) {
        if (key.startsWith(_userVariantKey)) {
          await prefs.remove(key);
        }
      }

      if (kDebugMode) {
        print('[ABTesting] All test data cleared');
      }
    } catch (e) {
      if (kDebugMode) {
        print('[ABTesting] Error clearing tests: $e');
      }
    }
  }

  /// Get test results summary
  static Future<Map<String, dynamic>> getTestResultsSummary() async {
    final tests = await getActiveTests();
    final results = <String, dynamic>{};

    for (final test in tests) {
      final conversionRates = await getConversionRate(test.testName);
      results[test.testName] = {
        'config': test.toJson(),
        'conversionRates': conversionRates,
      };
    }

    return results;
  }

  /// Check if a specific test is enabled
  static Future<bool> isTestEnabled(String testName) async {
    final tests = await getActiveTests();
    return tests.any((test) => test.testName == testName && test.enabled);
  }

  /// Force a specific variant for testing
  static Future<void> forceVariant(
    String testName,
    String variant, {
    String? userId,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final variantKey =
          '${_userVariantKey}_${testName}_${userId ?? 'default'}';
      await prefs.setString(variantKey, variant);

      if (kDebugMode) {
        print('[ABTesting] Forced variant $variant for test $testName');
      }
    } catch (e) {
      if (kDebugMode) {
        print('[ABTesting] Error forcing variant: $e');
      }
    }
  }
}

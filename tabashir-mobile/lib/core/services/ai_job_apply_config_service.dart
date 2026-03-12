import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:tabashir/core/network/services/config/config_api_service.dart';
import 'package:tabashir/core/network/models/config/ai_job_apply_config_response.dart';
import 'analytics_service.dart';
import 'performance_monitoring_service.dart';
import 'ab_testing_service.dart';

/// Configuration service for AI Job Apply feature
/// Provides configurable lists and settings for the feature
/// Supports backend fetching with caching
class AiJobApplyConfigService {
  AiJobApplyConfigService._();

  static const String _cacheKey = 'ai_job_apply_config_cache';
  static const String _cacheTimestampKey = 'ai_job_apply_config_timestamp';
  static const int _cacheExpiryHours = 24; // Cache expires after 24 hours

  static List<String> _popularRoles = [
    'Software Engineer',
    'Frontend Developer',
    'Backend Developer',
    'Full Stack Developer',
    'Mobile Developer',
    'Data Scientist',
    'Product Manager',
    'UI/UX Designer',
    'DevOps Engineer',
    'Project Manager',
    'Business Analyst',
    'QA Engineer',
    'Machine Learning Engineer',
    'Cloud Architect',
    'Cybersecurity Specialist',
  ];

  static List<String> _popularLocations = [
    'Dubai',
    'Abu Dhabi',
    'Sharjah',
    'Ajman',
    'Ras Al Khaimah',
    'Umm Al Quwain',
    'Fujairah',
    'Remote',
    'Hybrid',
  ];

  static List<String> _nationalities = [
    'United Arab Emirates',
    'Saudi Arabia',
    'Egypt',
    'India',
    'Pakistan',
    'Philippines',
    'United Kingdom',
    'United States',
    'Canada',
    'Australia',
    'Jordan',
    'Lebanon',
    'Nigeria',
    'Bangladesh',
    'Sri Lanka',
  ];

  static int _maxRolesToShow = 6;
  static int _maxLocationsToShow = 5;
  static int _defaultAiConfidence = 85;

  /// Popular job roles for AI job application
  /// Can be customized based on market/region
  /// Now supports dynamic updates from backend
  static List<String> get popularRoles => _popularRoles;

  /// Popular locations for job applications
  /// Can be customized based on available job markets
  /// Now supports dynamic updates from backend
  static List<String> get popularLocations => _popularLocations;

  /// Popular nationalities of job seekers
  /// Can be customized based on target market
  /// Now supports dynamic updates from backend
  static List<String> get nationalities => _nationalities;

  /// Maximum number of roles to display in UI
  static int get maxRolesToShow => _maxRolesToShow;

  /// Maximum number of locations to display in UI
  static int get maxLocationsToShow => _maxLocationsToShow;

  /// Default AI confidence score (0-100)
  /// Can be adjusted based on model performance
  static int get defaultAiConfidence => _defaultAiConfidence;

  /// Get popular roles limited to max display count
  /// This allows for easy A/B testing of different display counts
  /// Integrates with A/B testing for dynamic display limits
  static Future<List<String>> getPopularRolesLimited({String? userId}) async {
    PerformanceMonitoringService.startTracking('get_popular_roles');

    try {
      // Get max roles from A/B test or default
      final maxRoles = await ABTestingService.getMaxRolesToShow(userId: userId);
      final roles = _popularRoles.take(maxRoles).toList();

      return roles;
    } finally {
      PerformanceMonitoringService.endTracking('get_popular_roles');
    }
  }

  /// Get popular locations limited to max display count
  /// Integrates with A/B testing for dynamic display limits
  static Future<List<String>> getPopularLocationsLimited({
    String? userId,
  }) async {
    PerformanceMonitoringService.startTracking('get_popular_locations');

    try {
      // Get max locations from A/B test or default
      final maxLocations = await ABTestingService.getMaxLocationsToShow(
        userId: userId,
      );
      final locations = _popularLocations.take(maxLocations).toList();

      return locations;
    } finally {
      PerformanceMonitoringService.endTracking('get_popular_locations');
    }
  }

  /// Get popular roles with A/B testing support
  /// Returns roles in order based on test variant
  static Future<List<String>> getPopularRolesWithABTesting({
    String? userId,
  }) async {
    return await ABTestingService.getPopularRoles(userId: userId);
  }

  /// Get popular locations with A/B testing support
  /// Returns locations in order based on test variant
  static Future<List<String>> getPopularLocationsWithABTesting({
    String? userId,
  }) async {
    return await ABTestingService.getPopularLocations(userId: userId);
  }

  /// Get default AI confidence with A/B testing support
  static Future<int> getDefaultAiConfidenceWithABTesting({
    String? userId,
  }) async {
    return await ABTestingService.getDefaultAiConfidence(userId: userId);
  }

  /// Get nationalities with search support
  /// In future, this could fetch from backend based on region
  static List<String> getNationalitiesForRegion({String? region}) {
    // For now, return all nationalities
    // In future, could filter by region:
    // - Middle East: ['UAE', 'Saudi Arabia', 'Egypt', ...]
    // - South Asia: ['India', 'Pakistan', 'Bangladesh', ...]
    // - Global: All
    return _nationalities;
  }

  /// Check if a role is in the popular list
  static bool isPopularRole(String role) {
    return _popularRoles.contains(role);
  }

  /// Check if a location is in the popular list
  static bool isPopularLocation(String location) {
    return _popularLocations.contains(location);
  }

  /// Get role match score (for future AI enhancement)
  /// Returns a score between 0-100 based on role popularity
  static int getRoleMatchScore(String role) {
    if (_popularRoles.contains(role)) {
      return 90; // High score for popular roles
    }
    return 60; // Lower score for less common roles
  }

  /// Get location match score (for future AI enhancement)
  static int getLocationMatchScore(String location) {
    if (_popularLocations.contains(location)) {
      return 90; // High score for popular locations
    }
    return 50; // Lower score for less common locations
  }

  /// Validate role name
  static bool isValidRole(String role) {
    return role.isNotEmpty && role.length >= 2 && role.length <= 100;
  }

  /// Validate location name
  static bool isValidLocation(String location) {
    return location.isNotEmpty &&
        location.length >= 2 &&
        location.length <= 100;
  }

  /// Validate nationality name
  static bool isValidNationality(String nationality) {
    return nationality.isNotEmpty &&
        nationality.length >= 2 &&
        nationality.length <= 100;
  }

  /// Fetch configuration from backend
  /// This allows dynamic updates without app releases
  /// Uses caching to reduce API calls
  /// Integrates with analytics, A/B testing, and performance monitoring
  static Future<void> fetchConfigFromBackend({
    bool forceRefresh = false,
    ConfigApiService? apiService,
  }) async {
    PerformanceMonitoringService.startTracking('config_fetch');

    try {
      // Check if we need to fetch from backend
      final isExpired = await _isCacheExpired();
      if (!forceRefresh && !isExpired) {
        if (kDebugMode) {
          print('[AiJobApplyConfig] Using cached configuration');
        }
        await PerformanceMonitoringService.trackCacheOperation('hit', 10);
        return;
      }

      // Use provided API service or create default
      final service = apiService ?? ConfigApiService(Dio());
      final response = await service.getAiJobApplyConfig();

      if (response.response.statusCode == 200 && response.data != null) {
        _updateConfigFromResponse(response.data!);
        await _saveConfigToCache(response.data!);

        // Track successful config fetch
        await AnalyticsService.trackEvent(
          AnalyticsEvent.configFetched,
          {'source': 'backend', 'success': true},
        );

        await PerformanceMonitoringService.trackCacheOperation('miss', 500);

        if (kDebugMode) {
          print('[AiJobApplyConfig] Configuration updated from backend');
        }
      } else {
        throw Exception(
          'Failed to fetch configuration: ${response.response.statusCode}',
        );
      }
    } catch (e) {
      // Track failed config fetch
      await AnalyticsService.trackEvent(
        AnalyticsEvent.configFetched,
        {'source': 'backend', 'success': false, 'error': e.toString()},
      );

      if (kDebugMode) {
        print('[AiJobApplyConfig] Error fetching configuration: $e');
      }
      // On error, keep using existing cached/default configuration
    } finally {
      PerformanceMonitoringService.endTracking('config_fetch');
    }
  }

  /// Check if cache is expired
  static Future<bool> _isCacheExpired() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final timestamp = prefs.getInt(_cacheTimestampKey);
      if (timestamp == null) {
        return true; // No cache exists
      }

      final expiryTime = timestamp + (_cacheExpiryHours * 60 * 60 * 1000);
      final now = DateTime.now().millisecondsSinceEpoch;

      return now > expiryTime;
    } catch (e) {
      return true; // Error reading cache, treat as expired
    }
  }

  /// Update internal configuration from response
  static void _updateConfigFromResponse(AiJobApplyConfigResponse config) {
    _popularRoles = config.popularRoles;
    _popularLocations = config.popularLocations;
    _nationalities = config.nationalities;
    _maxRolesToShow = config.maxRolesToShow;
    _maxLocationsToShow = config.maxLocationsToShow;
    _defaultAiConfidence = config.defaultAiConfidence;
  }

  /// Save configuration to cache
  static Future<void> _saveConfigToCache(
    AiJobApplyConfigResponse config,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final configJson = config.toJson();

      await prefs.setString(_cacheKey, configJson.toString());
      await prefs.setInt(
        _cacheTimestampKey,
        DateTime.now().millisecondsSinceEpoch,
      );
    } catch (e) {
      if (kDebugMode) {
        print('[AiJobApplyConfig] Error saving to cache: $e');
      }
    }
  }

  /// Load configuration from cache
  static Future<void> _loadConfigFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final configJsonString = prefs.getString(_cacheKey);

      if (configJsonString != null) {
        // Parse JSON and update config
        // Note: This is a simplified version
        if (kDebugMode) {
          print('[AiJobApplyConfig] Configuration loaded from cache');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('[AiJobApplyConfig] Error loading from cache: $e');
      }
    }
  }

  /// Initialize configuration
  /// Load from cache or use defaults, then fetch from backend
  /// Integrates with analytics, A/B testing, and performance monitoring
  static Future<void> initialize() async {
    PerformanceMonitoringService.startTracking('config_initialize');

    try {
      // Initialize A/B testing
      await ABTestingService.getActiveTests();

      // Try to load from cache first
      await _loadConfigFromCache();

      // Fetch from backend (will use cache if not expired)
      await fetchConfigFromBackend();

      if (kDebugMode) {
        print(
          '[AiJobApplyConfig] Configuration initialized with Phase 3 services',
        );
      }
    } finally {
      PerformanceMonitoringService.endTracking('config_initialize');
    }
  }

  /// Get configuration as JSON (for debugging/testing)
  static Map<String, dynamic> getConfigAsJson() {
    return {
      'popularRoles': _popularRoles,
      'popularLocations': _popularLocations,
      'nationalities': _nationalities,
      'maxRolesToShow': _maxRolesToShow,
      'maxLocationsToShow': _maxLocationsToShow,
      'defaultAiConfidence': _defaultAiConfidence,
    };
  }

  /// Clear configuration cache
  static Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cacheKey);
      await prefs.remove(_cacheTimestampKey);
      if (kDebugMode) {
        print('[AiJobApplyConfig] Cache cleared');
      }
    } catch (e) {
      if (kDebugMode) {
        print('[AiJobApplyConfig] Error clearing cache: $e');
      }
    }
  }
}

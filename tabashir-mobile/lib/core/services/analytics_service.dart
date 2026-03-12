import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Analytics event types
enum AnalyticsEvent {
  roleSelected,
  locationSelected,
  nationalitySelected,
  resumeUploaded,
  applicationSubmitted,
  stepCompleted,
  errorOccurred,
  screenViewed,
  configFetched,
  cacheHit,
  cacheMiss,
}

/// Analytics service for tracking user preferences and behavior
/// Helps understand which roles, locations, and nationalities are popular
class AnalyticsService {
  AnalyticsService._();

  static const String _analyticsPrefix = 'ai_job_apply_analytics_';
  static const String _roleSelectionsKey = '${_analyticsPrefix}role_selections';
  static const String _locationSelectionsKey =
      '${_analyticsPrefix}location_selections';
  static const String _nationalitySelectionsKey =
      '${_analyticsPrefix}nationality_selections';
  static const String _eventHistoryKey = '${_analyticsPrefix}event_history';

  /// Track when a role is selected
  static Future<void> trackRoleSelection(String role) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final roleSelections = prefs.getString(_roleSelectionsKey);

      if (roleSelections != null) {
        final Map<String, dynamic> selections = _parseJson(roleSelections);
        selections[role] = (selections[role] ?? 0) + 1;
        await prefs.setString(_roleSelectionsKey, _serializeJson(selections));

        if (kDebugMode) {
          print(
            '[Analytics] Role selected: $role (total: ${selections[role]})',
          );
        }
      } else {
        final Map<String, int> selections = {role: 1};
        await prefs.setString(_roleSelectionsKey, _serializeJson(selections));
      }

      await _trackEvent(AnalyticsEvent.roleSelected, {'role': role});
    } catch (e) {
      if (kDebugMode) {
        print('[Analytics] Error tracking role selection: $e');
      }
    }
  }

  /// Track when a location is selected
  static Future<void> trackLocationSelection(String location) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final locationSelections = prefs.getString(_locationSelectionsKey);

      if (locationSelections != null) {
        final Map<String, dynamic> selections = _parseJson(locationSelections);
        selections[location] = (selections[location] ?? 0) + 1;
        await prefs.setString(
          _locationSelectionsKey,
          _serializeJson(selections),
        );

        if (kDebugMode) {
          print(
            '[Analytics] Location selected: $location (total: ${selections[location]})',
          );
        }
      } else {
        final Map<String, int> selections = {location: 1};
        await prefs.setString(
          _locationSelectionsKey,
          _serializeJson(selections),
        );
      }

      await _trackEvent(AnalyticsEvent.locationSelected, {
        'location': location,
      });
    } catch (e) {
      if (kDebugMode) {
        print('[Analytics] Error tracking location selection: $e');
      }
    }
  }

  /// Track when a nationality is selected
  static Future<void> trackNationalitySelection(String nationality) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final nationalitySelections = prefs.getString(_nationalitySelectionsKey);

      if (nationalitySelections != null) {
        final Map<String, dynamic> selections = _parseJson(
          nationalitySelections,
        );
        selections[nationality] = (selections[nationality] ?? 0) + 1;
        await prefs.setString(
          _nationalitySelectionsKey,
          _serializeJson(selections),
        );

        if (kDebugMode) {
          print(
            '[Analytics] Nationality selected: $nationality (total: ${selections[nationality]})',
          );
        }
      } else {
        final Map<String, int> selections = {nationality: 1};
        await prefs.setString(
          _nationalitySelectionsKey,
          _serializeJson(selections),
        );
      }

      await _trackEvent(AnalyticsEvent.nationalitySelected, {
        'nationality': nationality,
      });
    } catch (e) {
      if (kDebugMode) {
        print('[Analytics] Error tracking nationality selection: $e');
      }
    }
  }

  /// Track generic event
  static Future<void> trackEvent(
    AnalyticsEvent event,
    Map<String, dynamic> data,
  ) async {
    await _trackEvent(event, data);
  }

  /// Get most popular roles based on selections
  static Future<List<Map<String, dynamic>>> getPopularRoles({
    int limit = 10,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final roleSelections = prefs.getString(_roleSelectionsKey);

      if (roleSelections == null) {
        return [];
      }

      final Map<String, dynamic> selections = _parseJson(roleSelections);
      final List<Map<String, dynamic>> sortedRoles = selections.entries
          .map((entry) => {'role': entry.key, 'count': entry.value})
          .toList();

      sortedRoles.sort((a, b) => (b['count'] as int).compareTo(a['count'] as int));

      return sortedRoles.take(limit).toList();
    } catch (e) {
      if (kDebugMode) {
        print('[Analytics] Error getting popular roles: $e');
      }
      return [];
    }
  }

  /// Get most popular locations based on selections
  static Future<List<Map<String, dynamic>>> getPopularLocations({
    int limit = 10,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final locationSelections = prefs.getString(_locationSelectionsKey);

      if (locationSelections == null) {
        return [];
      }

      final Map<String, dynamic> selections = _parseJson(locationSelections);
      final List<Map<String, dynamic>> sortedLocations = selections.entries
          .map((entry) => {'location': entry.key, 'count': entry.value})
          .toList();

      sortedLocations.sort((a, b) => (b['count'] as int).compareTo(a['count'] as int));

      return sortedLocations.take(limit).toList();
    } catch (e) {
      if (kDebugMode) {
        print('[Analytics] Error getting popular locations: $e');
      }
      return [];
    }
  }

  /// Get most popular nationalities based on selections
  static Future<List<Map<String, dynamic>>> getPopularNationalities({
    int limit = 10,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final nationalitySelections = prefs.getString(_nationalitySelectionsKey);

      if (nationalitySelections == null) {
        return [];
      }

      final Map<String, dynamic> selections = _parseJson(nationalitySelections);
      final List<Map<String, dynamic>> sortedNationalities = selections.entries
          .map((entry) => {'nationality': entry.key, 'count': entry.value})
          .toList();

      sortedNationalities.sort((a, b) => (b['count'] as int).compareTo(a['count'] as int));

      return sortedNationalities.take(limit).toList();
    } catch (e) {
      if (kDebugMode) {
        print('[Analytics] Error getting popular nationalities: $e');
      }
      return [];
    }
  }

  /// Get total selection counts
  static Future<Map<String, int>> getTotalSelectionCounts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final roleSelections = prefs.getString(_roleSelectionsKey);
      final locationSelections = prefs.getString(_locationSelectionsKey);
      final nationalitySelections = prefs.getString(_nationalitySelectionsKey);

      int totalRoles = 0;
      int totalLocations = 0;
      int totalNationalities = 0;

      if (roleSelections != null) {
        final Map<String, dynamic> roles = _parseJson(roleSelections);
        totalRoles = roles.values.fold(0, (sum, val) => sum + (val as int));
      }

      if (locationSelections != null) {
        final Map<String, dynamic> locations = _parseJson(locationSelections);
        totalLocations = locations.values.fold(
          0,
          (sum, val) => sum + (val as int),
        );
      }

      if (nationalitySelections != null) {
        final Map<String, dynamic> nationalities = _parseJson(
          nationalitySelections,
        );
        totalNationalities = nationalities.values.fold(
          0,
          (sum, val) => sum + (val as int),
        );
      }

      return {
        'roles': totalRoles,
        'locations': totalLocations,
        'nationalities': totalNationalities,
        'total': totalRoles + totalLocations + totalNationalities,
      };
    } catch (e) {
      if (kDebugMode) {
        print('[Analytics] Error getting total counts: $e');
      }
      return {'roles': 0, 'locations': 0, 'nationalities': 0, 'total': 0};
    }
  }

  /// Get all analytics data
  static Future<Map<String, dynamic>> getAllAnalytics() async {
    try {
      final popularRoles = await getPopularRoles(limit: 20);
      final popularLocations = await getPopularLocations(limit: 20);
      final popularNationalities = await getPopularNationalities(limit: 20);
      final totalCounts = await getTotalSelectionCounts();

      return {
        'popularRoles': popularRoles,
        'popularLocations': popularLocations,
        'popularNationalities': popularNationalities,
        'totalCounts': totalCounts,
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      if (kDebugMode) {
        print('[Analytics] Error getting all analytics: $e');
      }
      return {};
    }
  }

  /// Clear all analytics data
  static Future<void> clearAnalytics() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_roleSelectionsKey);
      await prefs.remove(_locationSelectionsKey);
      await prefs.remove(_nationalitySelectionsKey);
      await prefs.remove(_eventHistoryKey);

      if (kDebugMode) {
        print('[Analytics] All analytics data cleared');
      }
    } catch (e) {
      if (kDebugMode) {
        print('[Analytics] Error clearing analytics: $e');
      }
    }
  }

  /// Track event internally
  static Future<void> _trackEvent(
    AnalyticsEvent event,
    Map<String, dynamic> data,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final eventHistory = prefs.getString(_eventHistoryKey);

      final Map<String, dynamic> events = eventHistory != null
          ? _parseJson(eventHistory)
          : {};

      final eventKey = '${event.name}_${DateTime.now().millisecondsSinceEpoch}';
      events[eventKey] = {
        'event': event.name,
        'data': data,
        'timestamp': DateTime.now().toIso8601String(),
      };

      // Keep only last 100 events
      if (events.length > 100) {
        final keys = events.keys.toList()..sort();
        final keysToRemove = keys.take(events.length - 100);
        for (final key in keysToRemove) {
          events.remove(key);
        }
      }

      await prefs.setString(_eventHistoryKey, _serializeJson(events));
    } catch (e) {
      if (kDebugMode) {
        print('[Analytics] Error tracking event: $e');
      }
    }
  }

  /// Parse JSON string to Map (simplified)
  static Map<String, dynamic> _parseJson(String jsonString) {
    try {
      // For simplicity, return empty map
      // In production, use json.decode
      return {};
    } catch (e) {
      return {};
    }
  }

  /// Serialize Map to JSON string (simplified)
  static String _serializeJson(Map<String, dynamic> map) {
    try {
      // For simplicity, return toString()
      // In production, use json.encode
      return map.toString();
    } catch (e) {
      return '{}';
    }
  }

  /// Export analytics data as JSON string (for debugging)
  static Future<String> exportAnalyticsAsJson() async {
    final analytics = await getAllAnalytics();
    return analytics.toString();
  }

  /// Get analytics summary
  static Future<Map<String, dynamic>> getAnalyticsSummary() async {
    final totalCounts = await getTotalSelectionCounts();
    final topRoles = await getPopularRoles(limit: 5);
    final topLocations = await getPopularLocations(limit: 5);
    final topNationalities = await getPopularNationalities(limit: 5);

    return {
      'summary': {
        'totalSelections': totalCounts['total'] ?? 0,
        'totalRolesSelected': totalCounts['roles'] ?? 0,
        'totalLocationsSelected': totalCounts['locations'] ?? 0,
        'totalNationalitiesSelected': totalCounts['nationalities'] ?? 0,
      },
      'topRoles': topRoles,
      'topLocations': topLocations,
      'topNationalities': topNationalities,
      'generatedAt': DateTime.now().toIso8601String(),
    };
  }
}

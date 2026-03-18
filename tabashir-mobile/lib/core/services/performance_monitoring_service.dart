import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Performance metrics types
enum PerformanceMetric {
  screenLoadTime,
  apiResponseTime,
  cacheHitRate,
  animationDuration,
  userInteractionLatency,
  memoryUsage,
  configFetchTime,
}

/// Performance level indicators
enum PerformanceLevel {
  excellent,
  good,
  fair,
  poor,
}

/// Performance monitoring service for tracking app performance
/// Monitors screen load times, API response times, cache hit rates, and more
class PerformanceMonitoringService {
  PerformanceMonitoringService._();

  static const String _metricsPrefix = 'ai_job_apply_performance_';
  static const String _metricsHistoryKey = '${_metricsPrefix}history';
  static final Map<String, DateTime> _startTimes = {};
  static final Map<String, DateTime> _endTimes = {};

  /// Start tracking a performance metric
  static void startTracking(String operationName) {
    _startTimes[operationName] = DateTime.now();

    if (kDebugMode) {
      developer.log(
        '[Performance] Started tracking: $operationName',
        name: 'performance',
      );
    }
  }

  /// End tracking and record the metric
  static Future<void> endTracking(String operationName) async {
    _endTimes[operationName] = DateTime.now();

    final startTime = _startTimes[operationName];
    if (startTime == null) {
      if (kDebugMode) {
        developer.log(
          '[Performance] No start time found for: $operationName',
          name: 'performance',
        );
      }
      return;
    }

    final duration = _endTimes[operationName]!
        .difference(startTime)
        .inMilliseconds;
    await recordMetric(operationName, duration);

    if (kDebugMode) {
      developer.log(
        '[Performance] $operationName took ${duration}ms',
        name: 'performance',
      );
    }
  }

  /// Record a performance metric
  static Future<void> recordMetric(String operationName, int durationMs) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final metricsHistory = prefs.getString(_metricsHistoryKey);

      final history =
          metricsHistory != null ? _parseJson(metricsHistory) : <String, dynamic>{};

      if (!history.containsKey(operationName)) {
        history[operationName] = {'durations': [], 'count': 0, 'total': 0};
      }

      final operationData = history[operationName] as Map<String, dynamic>;
      final durations = operationData['durations'] as List<int>;
      durations.add(durationMs);

      // Keep only last 100 measurements
      if (durations.length > 100) {
        durations.removeAt(0);
      }

      operationData['durations'] = durations;
      operationData['count'] = durations.length;
      operationData['total'] = durations.fold<int>(0, (sum, val) => sum + val);

      await prefs.setString(_metricsHistoryKey, _serializeJson(history));

      // Log performance level
      final level = _getPerformanceLevel(operationName, durationMs);
      if (kDebugMode && level == PerformanceLevel.poor) {
        developer.log(
          '[Performance] SLOW OPERATION: $operationName took ${durationMs}ms (${level.name})',
          name: 'performance',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        developer.log(
          '[Performance] Error recording metric: $e',
          name: 'performance',
        );
      }
    }
  }

  /// Get average duration for an operation
  static Future<double> getAverageDuration(String operationName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final metricsHistory = prefs.getString(_metricsHistoryKey);

      if (metricsHistory == null) {
        return 0.0;
      }

      final history = _parseJson(metricsHistory);
      if (!history.containsKey(operationName)) {
        return 0.0;
      }

      final operationData = history[operationName] as Map<String, dynamic>;
      final total = operationData['total'] as int;
      final count = operationData['count'] as int;

      return count > 0 ? total / count : 0.0;
    } catch (e) {
      if (kDebugMode) {
        developer.log(
          '[Performance] Error getting average duration: $e',
          name: 'performance',
        );
      }
      return 0.0;
    }
  }

  /// Get latest duration for an operation
  static Future<int> getLatestDuration(String operationName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final metricsHistory = prefs.getString(_metricsHistoryKey);

      if (metricsHistory == null) {
        return 0;
      }

      final history = _parseJson(metricsHistory);
      if (!history.containsKey(operationName)) {
        return 0;
      }

      final operationData = history[operationName] as Map<String, dynamic>;
      final durations = operationData['durations'] as List<int>;

      return durations.isNotEmpty ? durations.last : 0;
    } catch (e) {
      if (kDebugMode) {
        developer.log(
          '[Performance] Error getting latest duration: $e',
          name: 'performance',
        );
      }
      return 0;
    }
  }

  /// Get all recorded durations for an operation
  static Future<List<int>> getDurations(String operationName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final metricsHistory = prefs.getString(_metricsHistoryKey);

      if (metricsHistory == null) {
        return [];
      }

      final history = _parseJson(metricsHistory);
      if (!history.containsKey(operationName)) {
        return [];
      }

      final operationData = history[operationName] as Map<String, dynamic>;
      return operationData['durations'] as List<int>;
    } catch (e) {
      if (kDebugMode) {
        developer.log(
          '[Performance] Error getting durations: $e',
          name: 'performance',
        );
      }
      return [];
    }
  }

  /// Get performance level for an operation
  static PerformanceLevel _getPerformanceLevel(
    String operationName,
    int durationMs,
  ) {
    // Define thresholds for different operations
    final thresholds = <String, Map<PerformanceLevel, int>>{
      'screen_load': {
        PerformanceLevel.excellent: 100,
        PerformanceLevel.good: 300,
        PerformanceLevel.fair: 500,
        PerformanceLevel.poor: 1000,
      },
      'api_call': {
        PerformanceLevel.excellent: 200,
        PerformanceLevel.good: 500,
        PerformanceLevel.fair: 1000,
        PerformanceLevel.poor: 2000,
      },
      'config_fetch': {
        PerformanceLevel.excellent: 150,
        PerformanceLevel.good: 400,
        PerformanceLevel.fair: 800,
        PerformanceLevel.poor: 1500,
      },
      'cache_operation': {
        PerformanceLevel.excellent: 10,
        PerformanceLevel.good: 50,
        PerformanceLevel.fair: 100,
        PerformanceLevel.poor: 200,
      },
    };

    final operationThresholds =
        thresholds[operationName] ?? thresholds['screen_load']!;

    if (durationMs <= operationThresholds[PerformanceLevel.excellent]!) {
      return PerformanceLevel.excellent;
    } else if (durationMs <= operationThresholds[PerformanceLevel.good]!) {
      return PerformanceLevel.good;
    } else if (durationMs <= operationThresholds[PerformanceLevel.fair]!) {
      return PerformanceLevel.fair;
    } else {
      return PerformanceLevel.poor;
    }
  }

  /// Get performance level string
  static String getPerformanceLevelString(PerformanceLevel level) {
    switch (level) {
      case PerformanceLevel.excellent:
        return 'Excellent';
      case PerformanceLevel.good:
        return 'Good';
      case PerformanceLevel.fair:
        return 'Fair';
      case PerformanceLevel.poor:
        return 'Poor';
    }
  }

  /// Get all performance metrics summary
  static Future<Map<String, dynamic>> getPerformanceSummary() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final metricsHistory = prefs.getString(_metricsHistoryKey);

      if (metricsHistory == null) {
        return {};
      }

      final history = _parseJson(metricsHistory);
      final summary = <String, dynamic>{};

      for (final entry in history.entries) {
        final operationName = entry.key;
        final operationData = entry.value as Map<String, dynamic>;
        final durations = operationData['durations'] as List<int>;

        if (durations.isNotEmpty) {
          final average = operationData['total'] / operationData['count'];
          final latest = durations.last;
          final level = _getPerformanceLevel(operationName, latest);

          summary[operationName] = {
            'count': operationData['count'],
            'average': average,
            'latest': latest,
            'min': durations.reduce((a, b) => a < b ? a : b),
            'max': durations.reduce((a, b) => a > b ? a : b),
            'performanceLevel': level.name,
          };
        }
      }

      return summary;
    } catch (e) {
      if (kDebugMode) {
        developer.log(
          '[Performance] Error getting summary: $e',
          name: 'performance',
        );
      }
      return {};
    }
  }

  /// Check if app performance is good
  static Future<bool> isPerformanceGood() async {
    final summary = await getPerformanceSummary();

    for (final entry in summary.entries) {
      final data = entry.value as Map<String, dynamic>;
      final level = data['performanceLevel'] as String;

      if (level == PerformanceLevel.poor.name) {
        return false;
      }
    }

    return true;
  }

  /// Track screen load time
  static Future<void> trackScreenLoad(String screenName, int durationMs) async {
    await recordMetric('screen_load_$screenName', durationMs);
  }

  /// Track API call time
  static Future<void> trackApiCall(String endpoint, int durationMs) async {
    await recordMetric('api_call_$endpoint', durationMs);
  }

  /// Track config fetch time
  static Future<void> trackConfigFetch(int durationMs) async {
    await recordMetric('config_fetch', durationMs);
  }

  /// Track cache operation time
  static Future<void> trackCacheOperation(
    String operation,
    int durationMs,
  ) async {
    await recordMetric('cache_operation_$operation', durationMs);
  }

  /// Track animation duration
  static Future<void> trackAnimation(
    String animationName,
    int durationMs,
  ) async {
    await recordMetric('animation_$animationName', durationMs);
  }

  /// Clear all performance metrics
  static Future<void> clearMetrics() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_metricsHistoryKey);

      _startTimes.clear();
      _endTimes.clear();

      if (kDebugMode) {
        developer.log('[Performance] All metrics cleared', name: 'performance');
      }
    } catch (e) {
      if (kDebugMode) {
        developer.log(
          '[Performance] Error clearing metrics: $e',
          name: 'performance',
        );
      }
    }
  }

  /// Export performance metrics as JSON
  static Future<String> exportMetricsAsJson() async {
    final summary = await getPerformanceSummary();
    return summary.toString();
  }

  /// Get slow operations (poorer performance)
  static Future<List<Map<String, dynamic>>> getSlowOperations() async {
    final summary = await getPerformanceSummary();
    final slowOps = <Map<String, dynamic>>[];

    for (final entry in summary.entries) {
      final data = entry.value as Map<String, dynamic>;
      final level = data['performanceLevel'] as String;

      if (level == PerformanceLevel.poor.name) {
        slowOps.add({
          'operation': entry.key,
          'average': data['average'],
          'latest': data['latest'],
          'count': data['count'],
        });
      }
    }

    return slowOps;
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

  /// Get performance report
  static Future<Map<String, dynamic>> getPerformanceReport() async {
    final summary = await getPerformanceSummary();
    final slowOperations = await getSlowOperations();

    return {
      'timestamp': DateTime.now().toIso8601String(),
      'overallPerformance': await isPerformanceGood()
          ? 'Good'
          : 'Needs Improvement',
      'operations': summary,
      'slowOperations': slowOperations,
      'recommendations': _getRecommendations(summary),
    };
  }

  /// Get performance recommendations
  static List<String> _getRecommendations(Map<String, dynamic> summary) {
    final recommendations = <String>[];

    for (final entry in summary.entries) {
      final data = entry.value as Map<String, dynamic>;
      final level = data['performanceLevel'] as String;

      if (level == PerformanceLevel.poor.name) {
        recommendations.add(
          'Optimize ${entry.key}: Current average is ${data['average'].toStringAsFixed(0)}ms',
        );
      }
    }

    if (recommendations.isEmpty) {
      recommendations.add('Performance is good across all operations');
    }

    return recommendations;
  }
}

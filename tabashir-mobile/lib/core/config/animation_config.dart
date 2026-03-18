/// Centralized animation configuration for the app
/// This allows for easy tuning of animation timings and values
/// without searching through multiple files
library;

import 'package:tabashir/core/services/device_capability_service.dart';

class AnimationConfig {
  // Private constructor to prevent instantiation
  AnimationConfig._();

  // ===========================================================================
  // Navigation Animations
  // ===========================================================================

  /// Delay before starting navigation animation (milliseconds)
  static const int navigationDelayMs = 50;

  /// Delay before starting transition animation (milliseconds)
  static const int transitionDelayMs = 300;

  /// Duration of page transition animations (milliseconds)
  static const int transitionDurationMs = 800;

  /// Delay before showing next animation step (milliseconds)
  static const int nextAnimationDelayMs = 800;

  // ===========================================================================
  // Animation Factors
  // ===========================================================================

  /// Factor for animation value calculation
  /// Used in: 0.9 * animationValue
  static const double animationFactor = 0.9;

  /// Factor for glow animation
  /// Used in: 0.3 * glowAnimation.value
  static const double glowFactor = 0.3;

  // ===========================================================================
  // AI Job Apply Specific
  // ===========================================================================

  /// Points or steps in AI job apply flow
  /// Used in: const points = 5
  static const int aiJobApplySteps = 5;

  /// Duration for AI processing simulation (seconds)
  /// Used in: Future.delayed(Duration(seconds: 2))
  static const int aiProcessingDelaySeconds = 2;

  /// Default resume expiration days
  /// Used in: const Duration(days: 14)
  static const int resumeExpirationDays = 14;

  // ===========================================================================
  // Helper Methods
  // ===========================================================================

  /// Get navigation delay as Duration
  static Duration get navigationDelay =>
      const Duration(milliseconds: navigationDelayMs);

  /// Get transition delay as Duration
  static Duration get transitionDelay =>
      const Duration(milliseconds: transitionDelayMs);

  /// Get transition duration as Duration
  static Duration get transitionDuration =>
      const Duration(milliseconds: transitionDurationMs);

  /// Get next animation delay as Duration
  static Duration get nextAnimationDelay =>
      const Duration(milliseconds: nextAnimationDelayMs);

  /// Get AI processing delay as Duration
  static Duration get aiProcessingDelay =>
      const Duration(seconds: aiProcessingDelaySeconds);

  /// Get resume expiration as Duration
  static Duration get resumeExpiration =>
      const Duration(days: resumeExpirationDays);

  /// Get all animation timings as a map (for debugging/testing)
  static Map<String, dynamic> getAllTimings() => {
    'navigationDelayMs': navigationDelayMs,
    'transitionDelayMs': transitionDelayMs,
    'transitionDurationMs': transitionDurationMs,
    'nextAnimationDelayMs': nextAnimationDelayMs,
    'animationFactor': animationFactor,
    'glowFactor': glowFactor,
    'aiJobApplySteps': aiJobApplySteps,
    'aiProcessingDelaySeconds': aiProcessingDelaySeconds,
    'resumeExpirationDays': resumeExpirationDays,
  };

  /// Check if animations should be optimized for low-end devices
  /// Uses DeviceCapabilityService for detection
  static Future<bool> isLowEndDevice() async =>
      DeviceCapabilityService.isLowEndDevice();

  /// Get optimized timings for low-end devices
  /// Automatically detects device capability and adjusts timings
  static Future<Map<String, dynamic>> getOptimizedTimings() async {
    final isLowEnd = await DeviceCapabilityService.isLowEndDevice();

    if (!isLowEnd) {
      return getAllTimings();
    }

    // Reduce durations for low-end devices
    return {
      'navigationDelayMs': (navigationDelayMs * 0.5).round(),
      'transitionDelayMs': (transitionDelayMs * 0.5).round(),
      'transitionDurationMs': (transitionDurationMs * 0.5).round(),
      'nextAnimationDelayMs': (nextAnimationDelayMs * 0.5).round(),
      'animationFactor': animationFactor,
      'glowFactor': glowFactor,
      'aiJobApplySteps': aiJobApplySteps,
      'aiProcessingDelaySeconds': aiProcessingDelaySeconds,
      'resumeExpirationDays': resumeExpirationDays,
    };
  }
}

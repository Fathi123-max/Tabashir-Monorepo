import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'device_capability_service.dart';

/// Animation quality levels
enum AnimationQuality {
  /// High quality animations (full effects)
  high,

  /// Medium quality animations (reduced effects)
  medium,

  /// Low quality animations (minimal effects)
  low,
}

/// Animation quality settings service
/// Manages animation quality preferences based on device capabilities
class AnimationQualityService {
  AnimationQualityService._();

  static const String _qualityKey = 'animation_quality_preference';
  static const String _autoDetectKey = 'animation_quality_auto_detect';

  /// Get recommended animation quality for current device
  /// Returns the optimal quality based on device capabilities
  static Future<AnimationQuality> getRecommendedQuality() async {
    try {
      final deviceTier = await DeviceCapabilityService.detectDeviceTier();
      switch (deviceTier) {
        case DeviceTier.low:
          return AnimationQuality.low;
        case DeviceTier.medium:
          return AnimationQuality.medium;
        case DeviceTier.high:
          return AnimationQuality.high;
      }
    } catch (e) {
      // Default to medium quality on error
      return AnimationQuality.medium;
    }
  }

  /// Get user preference for animation quality
  /// Returns null if auto-detect is enabled
  static Future<AnimationQuality?> getUserQualityPreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final autoDetect = prefs.getBool(_autoDetectKey) ?? true;

      if (autoDetect) {
        return null; // Auto-detect enabled
      }

      final qualityString = prefs.getString(_qualityKey);
      if (qualityString == null) {
        return null;
      }

      return _parseQualityString(qualityString);
    } catch (e) {
      if (kDebugMode) {
        print('[AnimationQuality] Error getting preference: $e');
      }
      return null;
    }
  }

  /// Set animation quality preference
  /// If quality is null, enables auto-detect mode
  static Future<void> setQualityPreference(AnimationQuality? quality) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      if (quality == null) {
        // Enable auto-detect mode
        await prefs.setBool(_autoDetectKey, true);
        await prefs.remove(_qualityKey);
      } else {
        // Set manual quality preference
        await prefs.setBool(_autoDetectKey, false);
        await prefs.setString(_qualityKey, _qualityToString(quality));
      }

      if (kDebugMode) {
        print(
          '[AnimationQuality] Quality preference set to: ${quality ?? 'auto-detect'}',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('[AnimationQuality] Error setting preference: $e');
      }
    }
  }

  /// Get effective animation quality (user preference or recommended)
  /// This is what should actually be used for animations
  static Future<AnimationQuality> getEffectiveQuality() async {
    final userPreference = await getUserQualityPreference();

    if (userPreference != null) {
      return userPreference;
    }

    // Use recommended quality
    return getRecommendedQuality();
  }

  /// Get animation quality as string
  static Future<String> getQualityString() async {
    final quality = await getEffectiveQuality();
    return _qualityToString(quality);
  }

  /// Check if high quality animations are enabled
  static Future<bool> isHighQualityEnabled() async {
    final quality = await getEffectiveQuality();
    return quality == AnimationQuality.high;
  }

  /// Check if low quality mode is enabled
  static Future<bool> isLowQualityEnabled() async {
    final quality = await getEffectiveQuality();
    return quality == AnimationQuality.low;
  }

  /// Get animation intensity multiplier (0.0 to 1.0)
  /// 1.0 = full intensity, 0.5 = reduced, 0.3 = minimal
  static Future<double> getIntensityMultiplier() async {
    final quality = await getEffectiveQuality();

    switch (quality) {
      case AnimationQuality.high:
        return 1.0;
      case AnimationQuality.medium:
        return 0.6;
      case AnimationQuality.low:
        return 0.3;
    }
  }

  /// Get animation duration multiplier
  /// Low quality = faster animations (less noticeable)
  static Future<double> getDurationMultiplier() async {
    final quality = await getEffectiveQuality();

    switch (quality) {
      case AnimationQuality.high:
        return 1.0;
      case AnimationQuality.medium:
        return 0.85;
      case AnimationQuality.low:
        return 0.7;
    }
  }

  /// Check if particle effects should be enabled
  static Future<bool> shouldShowParticleEffects() async {
    final quality = await getEffectiveQuality();
    return quality != AnimationQuality.low;
  }

  /// Check if glow effects should be enabled
  static Future<bool> shouldShowGlowEffects() async {
    final quality = await getEffectiveQuality();
    return quality == AnimationQuality.high;
  }

  /// Check if shadows should be enabled
  static Future<bool> shouldShowShadows() async {
    final quality = await getEffectiveQuality();
    return quality != AnimationQuality.low;
  }

  /// Get quality description for UI
  static Future<String> getQualityDescription() async {
    final userPreference = await getUserQualityPreference();
    final effectiveQuality = await getEffectiveQuality();

    if (userPreference != null) {
      return 'Manual: ${_qualityToString(userPreference)}';
    }

    return 'Auto: ${_qualityToString(effectiveQuality)} (recommended)';
  }

  /// Parse quality from string
  static AnimationQuality _parseQualityString(String qualityString) {
    switch (qualityString.toLowerCase()) {
      case 'high':
        return AnimationQuality.high;
      case 'medium':
        return AnimationQuality.medium;
      case 'low':
        return AnimationQuality.low;
      default:
        return AnimationQuality.medium;
    }
  }

  /// Convert quality to string
  static String _qualityToString(AnimationQuality quality) {
    switch (quality) {
      case AnimationQuality.high:
        return 'high';
      case AnimationQuality.medium:
        return 'medium';
      case AnimationQuality.low:
        return 'low';
    }
  }

  /// Get all available quality options
  static List<AnimationQuality> getAllQualityOptions() => [
    AnimationQuality.high,
    AnimationQuality.medium,
    AnimationQuality.low,
  ];

  /// Get quality display names
  static String getQualityDisplayName(AnimationQuality quality) {
    switch (quality) {
      case AnimationQuality.high:
        return 'High';
      case AnimationQuality.medium:
        return 'Medium';
      case AnimationQuality.low:
        return 'Low';
    }
  }

  /// Get quality descriptions
  static String getQualityDescriptionText(AnimationQuality quality) {
    switch (quality) {
      case AnimationQuality.high:
        return 'Full animations with all effects';
      case AnimationQuality.medium:
        return 'Balanced animations with reduced effects';
      case AnimationQuality.low:
        return 'Minimal animations for better performance';
    }
  }

  /// Reset to auto-detect mode
  static Future<void> resetToAutoDetect() async {
    await setQualityPreference(null);
  }

  /// Get animation quality settings as JSON
  static Future<Map<String, dynamic>> getSettingsAsJson() async {
    final userPreference = await getUserQualityPreference();
    final effectiveQuality = await getEffectiveQuality();
    final intensityMultiplier = await getIntensityMultiplier();
    final durationMultiplier = await getDurationMultiplier();

    return {
      'userPreference': userPreference != null
          ? _qualityToString(userPreference)
          : null,
      'effectiveQuality': _qualityToString(effectiveQuality),
      'intensityMultiplier': intensityMultiplier,
      'durationMultiplier': durationMultiplier,
      'particleEffectsEnabled': await shouldShowParticleEffects(),
      'glowEffectsEnabled': await shouldShowGlowEffects(),
      'shadowsEnabled': await shouldShowShadows(),
    };
  }
}

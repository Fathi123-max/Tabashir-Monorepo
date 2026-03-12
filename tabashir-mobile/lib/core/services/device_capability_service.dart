import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

/// Device performance tiers
enum DeviceTier {
  /// Low-end device (limited performance)
  low,

  /// Mid-range device (moderate performance)
  medium,

  /// High-end device (excellent performance)
  high,
}

/// Device capability detection service
/// Determines if a device is low-end, mid-range, or high-end
/// Used to optimize animations and performance
class DeviceCapabilityService {
  DeviceCapabilityService._();

  static DeviceTier? _cachedTier;

  /// Detect device capability
  /// Returns the performance tier of the device
  static Future<DeviceTier> detectDeviceTier() async {
    // Return cached result if available
    if (_cachedTier != null) {
      return _cachedTier!;
    }

    try {
      final deviceInfo = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;

        // Determine tier based on Android version and hardware
        // Newer Android versions (30+) typically indicate newer/more capable devices
        final sdkInt = androidInfo.version.sdkInt;

        // Get approximate tier based on SDK version and model
        DeviceTier tier = _classifyAndroidDevice(
          sdkInt: sdkInt,
          model: androidInfo.model,
          hardware: androidInfo.hardware,
        );

        _cachedTier = tier;
        return tier;
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;

        // Determine tier based on device model
        DeviceTier tier = _classifyIOSDevice(
          model: iosInfo.model,
          version: iosInfo.systemVersion,
        );

        _cachedTier = tier;
        return tier;
      }

      // Default to medium tier for unknown platforms
      return DeviceTier.medium;
    } catch (e) {
      if (kDebugMode) {
        print('[DeviceCapability] Error detecting device tier: $e');
      }
      return DeviceTier.medium; // Default to medium tier
    }
  }

  /// Classify Android device tier
  static DeviceTier _classifyAndroidDevice({
    required int sdkInt,
    required String model,
    required String hardware,
  }) {
    // High-end devices: Recent Android version (30+) with modern hardware
    // Snapdragon 8 series, MediaTek Dimensity, Exynos high-end, etc.
    final String modelLower = model.toLowerCase();
    final String hardwareLower = hardware.toLowerCase();

    // Check for high-end indicators
    final bool isHighEndProcessor = hardwareLower.contains('kona') || // Snapdragon 8
        hardwareLower.contains('lahaina') || // Snapdragon 7
        hardwareLower.contains('pineapple') || // Snapdragon 6
        hardwareLower.contains('dimensity') || // MediaTek high-end
        hardwareLower.contains('exynos') && !hardwareLower.contains('7870') && !hardwareLower.contains('7580'); // Exynos high-end

    final bool isRecentAndroid = sdkInt >= 30; // Android 11+
    final bool isVeryRecentAndroid = sdkInt >= 33; // Android 13+

    if ((isHighEndProcessor && isRecentAndroid) || isVeryRecentAndroid) {
      return DeviceTier.high;
    }

    // Low-end devices: Old Android version or low-end hardware
    final bool isLowEndProcessor = hardwareLower.contains('msm8916') ||
        hardwareLower.contains('msm8937') ||
        hardwareLower.contains('mt6737') ||
        hardwareLower.contains('mt6580') ||
        hardwareLower.contains('sc7731') ||
        hardwareLower.contains('sc9832');

    final bool isOldAndroid = sdkInt < 26; // Android 8.0-

    if (isLowEndProcessor || isOldAndroid) {
      return DeviceTier.low;
    }

    // Medium tier for everything else
    return DeviceTier.medium;
  }

  /// Classify iOS device tier
  static DeviceTier _classifyIOSDevice({
    required String model,
    required String version,
  }) {
    // High-end iOS devices
    if (model.contains('iPhone 15') ||
        model.contains('iPhone 14') ||
        model.contains('iPad Pro')) {
      return DeviceTier.high;
    }

    // Low-end iOS devices (older models)
    if (model.contains('iPhone 8') ||
        model.contains('iPhone SE') ||
        model.contains('iPhone 6') ||
        model.contains('iPhone SE 2') ||
        model.contains('iPhone SE 3')) {
      return DeviceTier.low;
    }

    // Medium tier for everything else
    return DeviceTier.medium;
  }

  /// Check if device is low-end
  static Future<bool> isLowEndDevice() async {
    final tier = await detectDeviceTier();
    return tier == DeviceTier.low;
  }

  /// Check if device is high-end
  static Future<bool> isHighEndDevice() async {
    final tier = await detectDeviceTier();
    return tier == DeviceTier.high;
  }

  /// Get device tier as string
  static Future<String> getDeviceTierString() async {
    final tier = await detectDeviceTier();
    switch (tier) {
      case DeviceTier.low:
        return 'low';
      case DeviceTier.medium:
        return 'medium';
      case DeviceTier.high:
        return 'high';
    }
  }

  /// Get recommended animation quality for device
  /// Returns: 'high', 'medium', or 'low'
  static Future<String> getRecommendedAnimationQuality() async {
    final tier = await detectDeviceTier();

    switch (tier) {
      case DeviceTier.low:
        return 'low';
      case DeviceTier.medium:
        return 'medium';
      case DeviceTier.high:
        return 'high';
    }
  }

  /// Check if device supports high-quality animations
  static Future<bool> supportsHighQualityAnimations() async {
    final tier = await detectDeviceTier();
    return tier == DeviceTier.high;
  }

  /// Get optimized animation factor based on device capability
  /// Returns a value between 0.5 and 1.0
  static Future<double> getOptimizedAnimationFactor() async {
    final tier = await detectDeviceTier();

    switch (tier) {
      case DeviceTier.low:
        return 0.5; // Reduce animation quality by 50%
      case DeviceTier.medium:
        return 0.75; // Reduce animation quality by 25%
      case DeviceTier.high:
        return 1.0; // Full quality
    }
  }

  /// Get optimized animation duration multiplier
  /// Low-end devices get faster animations (less noticeable)
  static Future<double> getAnimationDurationMultiplier() async {
    final tier = await detectDeviceTier();

    switch (tier) {
      case DeviceTier.low:
        return 0.7; // 30% faster
      case DeviceTier.medium:
        return 0.85; // 15% faster
      case DeviceTier.high:
        return 1.0; // Normal speed
    }
  }

  /// Get device information for debugging
  static Future<Map<String, dynamic>> getDeviceInfo() async {
    try {
      final deviceInfo = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return {
          'platform': 'android',
          'model': androidInfo.model,
          'version': androidInfo.version.release,
          'sdkInt': androidInfo.version.sdkInt,
          'tier': (await getDeviceTierString()),
        };
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return {
          'platform': 'ios',
          'model': iosInfo.model,
          'version': iosInfo.systemVersion,
          'tier': (await getDeviceTierString()),
        };
      }

      return {
        'platform': 'unknown',
        'tier': 'medium',
      };
    } catch (e) {
      return {
        'platform': 'unknown',
        'tier': 'medium',
        'error': e.toString(),
      };
    }
  }

  /// Clear cached device tier (force re-detection)
  static void clearCache() {
    _cachedTier = null;
  }
}

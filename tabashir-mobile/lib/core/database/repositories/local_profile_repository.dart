import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/database/models/local_profile.dart';
import 'package:tabashir/core/services/local_persistence_service.dart';
import 'package:tabashir/core/utils/app_logger.dart';

/// Repository for managing profile data in SharedPreferences
/// Provides caching functionality for offline access
class LocalProfileRepository {
  LocalProfileRepository(this._persistenceService);

  final LocalPersistenceService _persistenceService;

  static const String _profileKey = 'cached_profile';

  /// Save profile to SharedPreferences
  Future<void> saveProfile(LocalProfile profile) async {
    final prefs = _persistenceService.prefs;
    final profileJson = json.encode(profile.toJson());
    await prefs.setString(_profileKey, profileJson);
  }

  /// Get the cached profile
  Future<LocalProfile?> getLatestProfile() async {
    final prefs = _persistenceService.prefs;
    final profileJson = prefs.getString(_profileKey);
    if (profileJson == null) return null;

    try {
      final profileMap = json.decode(profileJson) as Map<String, dynamic>;
      final profile = LocalProfile.fromJson(profileMap);

      // Convert updatedAt back from string if needed
      if (profileMap['updatedAt'] is String) {
        profile.updatedAt = DateTime.parse(profileMap['updatedAt'] as String);
      }

      return profile;
    } catch (e) {
      AppLogger.error('[LocalProfileRepository] Error parsing cached profile: $e', tag: 'Database', error: e);
      return null;
    }
  }

  /// Delete all profiles (clear cache)
  Future<void> clearAllProfiles() async {
    final prefs = _persistenceService.prefs;
    await prefs.remove(_profileKey);
  }

  /// Check if profile exists
  Future<bool> hasProfile() async {
    final prefs = _persistenceService.prefs;
    return prefs.containsKey(_profileKey);
  }
}

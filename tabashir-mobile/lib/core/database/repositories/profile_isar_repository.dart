import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/database/models/profile_isar.dart';
import 'package:tabashir/core/services/isar_service.dart';

/// Repository for managing profile data in SharedPreferences
/// Provides caching functionality for offline access
class ProfileIsarRepository {
  ProfileIsarRepository(this._isarService);

  final IsarService _isarService;

  static const String _profileKey = 'cached_profile';

  /// Save profile to SharedPreferences
  Future<void> saveProfile(ProfileIsar profile) async {
    final prefs = _isarService.prefs;
    final profileJson = json.encode(profile.toJson());
    await prefs.setString(_profileKey, profileJson);
  }

  /// Get the cached profile
  Future<ProfileIsar?> getLatestProfile() async {
    final prefs = _isarService.prefs;
    final profileJson = prefs.getString(_profileKey);
    if (profileJson == null) return null;

    try {
      final profileMap = json.decode(profileJson) as Map<String, dynamic>;
      final profile = ProfileIsar.fromJson(profileMap);

      // Convert updatedAt back from string if needed
      if (profileMap['updatedAt'] is String) {
        profile.updatedAt = DateTime.parse(profileMap['updatedAt'] as String);
      }

      return profile;
    } catch (e) {
      print('[ProfileIsarRepository] Error parsing cached profile: $e');
      return null;
    }
  }

  /// Delete all profiles (clear cache)
  Future<void> clearAllProfiles() async {
    final prefs = _isarService.prefs;
    await prefs.remove(_profileKey);
  }

  /// Check if profile exists
  Future<bool> hasProfile() async {
    final prefs = _isarService.prefs;
    return prefs.containsKey(_profileKey);
  }
}

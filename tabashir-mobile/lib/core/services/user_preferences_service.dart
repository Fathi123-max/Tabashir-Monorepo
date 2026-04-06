import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabashir/features/ai_job_apply/data/models/target_role_model.dart';
import 'package:tabashir/features/ai_job_apply/data/models/location_preference_model.dart';
import 'package:tabashir/core/utils/app_logger.dart';

/// User preferences service
/// Manages sync between user profile and AI job apply feature
/// Handles nationality and other preferences
class UserPreferencesService {
  UserPreferencesService._();

  static const String _nationalityKey = 'ai_job_apply_nationality';
  static const String _selectedRolesKey = 'ai_job_apply_selected_roles';
  static const String _selectedLocationsKey = 'ai_job_apply_selected_locations';

  /// Save user's nationality preference for AI job apply
  /// Also updates user profile if available
  static Future<void> saveNationality({
    required String nationality,
    bool syncToProfile = true,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_nationalityKey, nationality);

      if (kDebugMode) {
        AppLogger.debug('[UserPreferences] Nationality saved: $nationality', tag: 'Service');
      }

      // TODO: Sync to user profile if syncToProfile is true
      // This would require calling the user API to update profile
      if (syncToProfile) {
        // await _syncNationalityToProfile(nationality);
      }
    } catch (e) {
      if (kDebugMode) {
        AppLogger.error('[UserPreferences] Error saving nationality: $e', tag: 'Service', error: e);
      }
    }
  }

  /// Get user's nationality preference
  /// Returns null if not set
  static Future<String?> getNationality() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_nationalityKey);
    } catch (e) {
      if (kDebugMode) {
        AppLogger.error('[UserPreferences] Error getting nationality: $e', tag: 'Service', error: e);
      }
      return null;
    }
  }

  /// Save user's selected roles for AI job apply
  static Future<void> saveSelectedRoles(List<TargetRoleModel> roles) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final rolesJson = roles.map((role) => role.toJson()).toList();
      await prefs.setString(_selectedRolesKey, rolesJson.toString());

      if (kDebugMode) {
        AppLogger.debug('[UserPreferences] Saved ${roles.length} selected roles', tag: 'Service');
      }
    } catch (e) {
      if (kDebugMode) {
        AppLogger.error('[UserPreferences] Error saving selected roles: $e', tag: 'Service', error: e);
      }
    }
  }

  /// Get user's selected roles
  /// Returns empty list if not set
  static Future<List<TargetRoleModel>> getSelectedRoles() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final rolesJsonString = prefs.getString(_selectedRolesKey);

      if (rolesJsonString == null || rolesJsonString.isEmpty) {
        return [];
      }

      // Parse JSON and convert to TargetRoleModel
      // This is a simplified version - actual implementation would parse JSON properly
      if (kDebugMode) {
        AppLogger.debug('[UserPreferences] Loaded selected roles from cache', tag: 'Service');
      }

      return [];
    } catch (e) {
      if (kDebugMode) {
        AppLogger.error('[UserPreferences] Error getting selected roles: $e', tag: 'Service', error: e);
      }
      return [];
    }
  }

  /// Save user's selected locations for AI job apply
  static Future<void> saveSelectedLocations(
    List<LocationPreferenceModel> locations,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final locationsJson = locations.map((loc) => loc.toJson()).toList();
      await prefs.setString(_selectedLocationsKey, locationsJson.toString());

      if (kDebugMode) {
        AppLogger.debug('[UserPreferences] Saved ${locations.length} selected locations', tag: 'Service');
      }
    } catch (e) {
      if (kDebugMode) {
        AppLogger.error('[UserPreferences] Error saving selected locations: $e', tag: 'Service', error: e);
      }
    }
  }

  /// Get user's selected locations
  /// Returns empty list if not set
  static Future<List<LocationPreferenceModel>> getSelectedLocations() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final locationsJsonString = prefs.getString(_selectedLocationsKey);

      if (locationsJsonString == null || locationsJsonString.isEmpty) {
        return [];
      }

      // Parse JSON and convert to LocationPreferenceModel
      // This is a simplified version - actual implementation would parse JSON properly
      if (kDebugMode) {
        AppLogger.debug('[UserPreferences] Loaded selected locations from cache', tag: 'Service');
      }

      return [];
    } catch (e) {
      if (kDebugMode) {
        AppLogger.error('[UserPreferences] Error getting selected locations: $e', tag: 'Service', error: e);
      }
      return [];
    }
  }

  /// Clear all AI job apply preferences
  static Future<void> clearAllPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_nationalityKey);
      await prefs.remove(_selectedRolesKey);
      await prefs.remove(_selectedLocationsKey);

      if (kDebugMode) {
        AppLogger.debug('[UserPreferences] All preferences cleared', tag: 'Service');
      }
    } catch (e) {
      if (kDebugMode) {
        AppLogger.error('[UserPreferences] Error clearing preferences: $e', tag: 'Service', error: e);
      }
    }
  }

  /// Check if preferences exist
  static Future<bool> hasPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(_nationalityKey) ||
          prefs.containsKey(_selectedRolesKey) ||
          prefs.containsKey(_selectedLocationsKey);
    } catch (e) {
      return false;
    }
  }

  /// Get all preferences as JSON (for debugging)
  static Future<Map<String, dynamic>> getAllPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'nationality': prefs.getString(_nationalityKey),
      'selectedRoles': prefs.getString(_selectedRolesKey),
      'selectedLocations': prefs.getString(_selectedLocationsKey),
    };
  }

  /// Sync nationality from user profile
  /// This would typically fetch from user API
  /// For now, it's a placeholder
  static Future<String?> syncNationalityFromProfile() async {
    try {
      if (kDebugMode) {
        AppLogger.debug('[UserPreferences] Syncing nationality from profile...', tag: 'Service');
      }

      // TODO: Implement actual API call to fetch user profile
      // Example:
      // final response = await userApiService.getUserProfile();
      // final nationality = response.data?.nationality;
      // if (nationality != null) {
      //   await saveNationality(nationality, syncToProfile: false);
      //   return nationality;
      // }

      return null;
    } catch (e) {
      if (kDebugMode) {
        AppLogger.error('[UserPreferences] Error syncing from profile: $e', tag: 'Service', error: e);
      }
      return null;
    }
  }

  /// Sync nationality to user profile
  /// Updates the user's profile with AI job apply nationality
  static Future<bool> syncNationalityToProfile(String nationality) async {
    try {
      if (kDebugMode) {
        AppLogger.debug('[UserPreferences] Syncing nationality to profile...', tag: 'Service');
      }

      // TODO: Implement actual API call to update user profile
      // Example:
      // await userApiService.updateProfile(UpdateProfileRequest(
      //   nationality: nationality,
      // ));

      return true;
    } catch (e) {
      if (kDebugMode) {
        AppLogger.error('[UserPreferences] Error syncing to profile: $e', tag: 'Service', error: e);
      }
      return false;
    }
  }

  /// Initialize preferences from user profile
  /// Called when app starts or user logs in
  static Future<void> initializeFromProfile() async {
    try {
      final profileNationality = await syncNationalityFromProfile();

      if (profileNationality != null) {
        await saveNationality(
          nationality: profileNationality,
          syncToProfile: false,
        );
        if (kDebugMode) {
          AppLogger.debug('[UserPreferences] Initialized from profile: $profileNationality', tag: 'Service');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        AppLogger.error('[UserPreferences] Error initializing from profile: $e', tag: 'Service', error: e);
      }
    }
  }
}

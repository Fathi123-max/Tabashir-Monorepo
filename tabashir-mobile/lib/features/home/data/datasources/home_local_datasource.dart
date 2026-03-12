import 'package:injectable/injectable.dart';
import 'package:tabashir/core/services/local_storage_service.dart';
import 'package:tabashir/core/network/models/user/user_profile_response.dart';

/// Local data source for home screen
/// Handles caching of user profile and home data
@injectable
class HomeLocalDataSource {
  HomeLocalDataSource(this._localStorageService);

  final LocalStorageService _localStorageService;

  static const String _userProfileKey = 'cached_user_profile';
  static const String _homeDataKey = 'cached_home_data';
  static const String _cacheTimestampKey = 'cache_timestamp';

  static const Duration _cacheExpiry = Duration(minutes: 5);

  /// Cache user profile data
  Future<void> cacheUserProfile(UserProfileResponse profile) async {
    print('[HOME_LOCAL_DS] Caching user profile');
    await _localStorageService.setString(
      _userProfileKey,
      profile.toJson().toString(),
    );
    await _localStorageService.setString(
      _cacheTimestampKey,
      DateTime.now().millisecondsSinceEpoch.toString(),
    );
  }

  /// Get cached user profile
  Future<UserProfileResponse?> getCachedUserProfile() async {
    try {
      final profileJson = _localStorageService.getString(_userProfileKey);
      final timestampStr = _localStorageService.getString(_cacheTimestampKey);

      if (profileJson == null || timestampStr == null) {
        return null;
      }

      final timestamp = int.tryParse(timestampStr);
      if (timestamp == null) {
        return null;
      }

      final age = DateTime.now().millisecondsSinceEpoch - timestamp;
      if (age > _cacheExpiry.inMilliseconds) {
        print('[HOME_LOCAL_DS] Cache expired, clearing');
        await clearCache();
        return null;
      }

      print('[HOME_LOCAL_DS] Returning cached user profile');
      // Note: In a real implementation, you'd parse the JSON back to the object
      // For now, returning null to force fresh API call
      return null;
    } catch (e) {
      print('[HOME_LOCAL_DS] Error reading cache: $e');
      return null;
    }
  }

  /// Cache home dashboard data
  Future<void> cacheHomeData(Map<String, dynamic> data) async {
    print('[HOME_LOCAL_DS] Caching home data');
    await _localStorageService.setString(
      _homeDataKey,
      data.toString(),
    );
  }

  /// Get cached home data
  Future<Map<String, dynamic>?> getCachedHomeData() async {
    try {
      final dataStr = _localStorageService.getString(_homeDataKey);
      if (dataStr == null) {
        return null;
      }
      print('[HOME_LOCAL_DS] Returning cached home data');
      // Note: In a real implementation, you'd parse the JSON
      return null;
    } catch (e) {
      print('[HOME_LOCAL_DS] Error reading home cache: $e');
      return null;
    }
  }

  /// Clear all cached data
  Future<void> clearCache() async {
    print('[HOME_LOCAL_DS] Clearing cache');
    await _localStorageService.remove(_userProfileKey);
    await _localStorageService.remove(_homeDataKey);
    await _localStorageService.remove(_cacheTimestampKey);
  }
}

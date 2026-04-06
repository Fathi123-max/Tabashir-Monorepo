import 'package:injectable/injectable.dart';
import 'package:tabashir/core/services/local_storage_service.dart';
import 'package:tabashir/core/network/models/user/user_profile_response.dart';
import 'package:tabashir/core/utils/app_logger.dart';

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
    AppLogger.debug('[HOME_LOCAL_DS] Caching user profile', tag: 'Home');
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
        AppLogger.debug('[HOME_LOCAL_DS] Cache expired, clearing', tag: 'Home');
        await clearCache();
        return null;
      }

      AppLogger.debug('[HOME_LOCAL_DS] Returning cached user profile', tag: 'Home');
      // Note: In a real implementation, you'd parse the JSON back to the object
      // For now, returning null to force fresh API call
      return null;
    } catch (e) {
      AppLogger.error('[HOME_LOCAL_DS] Error reading cache: $e', tag: 'Home', error: e);
      return null;
    }
  }

  /// Cache home dashboard data
  Future<void> cacheHomeData(Map<String, dynamic> data) async {
    AppLogger.debug('[HOME_LOCAL_DS] Caching home data', tag: 'Home');
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
      AppLogger.debug('[HOME_LOCAL_DS] Returning cached home data', tag: 'Home');
      // Note: In a real implementation, you'd parse the JSON
      return null;
    } catch (e) {
      AppLogger.error('[HOME_LOCAL_DS] Error reading home cache: $e', tag: 'Home', error: e);
      return null;
    }
  }

  /// Clear all cached data
  Future<void> clearCache() async {
    AppLogger.debug('[HOME_LOCAL_DS] Clearing cache', tag: 'Home');
    await _localStorageService.remove(_userProfileKey);
    await _localStorageService.remove(_homeDataKey);
    await _localStorageService.remove(_cacheTimestampKey);
  }
}

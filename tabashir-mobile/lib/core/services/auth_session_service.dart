import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabashir/core/constants/storage_keys.dart';
import 'package:tabashir/core/network/models/auth/refresh_token_response.dart';
import 'package:tabashir/core/network/services/auth/auth_api_service.dart';
import 'package:tabashir/core/network/_config/api_config.dart';

/// Service to manage authentication session state
/// Handles secure token storage and retrieval for authenticated API calls
///
/// IMPORTANT: Uses flutter_secure_storage for tokens (encrypted)
/// and SharedPreferences only for the isLoggedIn boolean flag
class AuthSessionService {
  AuthSessionService._();
  static AuthSessionService? _instance;
  static AuthSessionService get instance =>
      _instance ??= AuthSessionService._();

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  /// Check if user is currently authenticated
  /// Only checks the boolean flag in SharedPreferences (not secure data)
  Future<bool> get isAuthenticated async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(StorageKeys.isLoggedIn) ?? false;
  }

  /// Get the stored access token
  /// Returns null if no token is stored
  /// Tokens are stored encrypted using flutter_secure_storage
  Future<String?> get accessToken async {
    try {
      return await _secureStorage.read(key: StorageKeys.accessToken);
    } on Exception catch (_) {
      // Handle errors (e.g., keychain not available)
      return null;
    }
  }

  /// Get the stored refresh token
  /// Returns null if no token is stored
  /// Tokens are stored encrypted using flutter_secure_storage
  Future<String?> get refreshToken async {
    try {
      final token = await _secureStorage.read(key: StorageKeys.refreshToken);
      print(
        '[AUTH_SESSION] Reading refresh token from storage: ${token != null ? "present (${token.length} chars)" : "NULL"}',
      );
      if (token == null) {
        print(
          '[AUTH_SESSION] ⚠️ WARNING: refreshToken is NULL in secure storage',
        );
      }
      return token;
    } on Exception catch (e) {
      print('[AUTH_SESSION] ❌ ERROR reading refresh token: $e');
      return null;
    }
  }

  /// Set user as logged in with token
  /// [token] - The access token received from login/register API
  /// [refreshToken] - Optional refresh token (if provided by backend)
  ///
  /// Tokens are stored encrypted in flutter_secure_storage
  /// Only the isLoggedIn boolean flag is stored in SharedPreferences
  Future<void> setLoggedIn({
    String? token,
    String? refreshToken,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(StorageKeys.isLoggedIn, true);

    // Debug logging
    print('[AUTH_SESSION] Storing tokens:');
    print(
      '[AUTH_SESSION] - accessToken: ${token != null ? "present (${token.length} chars)" : "NULL"}',
    );
    print(
      '[AUTH_SESSION] - refreshToken: ${refreshToken != null ? "present (${refreshToken.length} chars)" : "NULL"}',
    );

    // Store tokens securely using flutter_secure_storage (encrypted)
    if (token != null) {
      await _secureStorage.write(
        key: StorageKeys.accessToken,
        value: token,
      );
      print('[AUTH_SESSION] ✅ Access token stored successfully');
    } else {
      print('[AUTH_SESSION] ⚠️ WARNING: No access token to store!');
    }

    if (refreshToken != null) {
      await _secureStorage.write(
        key: StorageKeys.refreshToken,
        value: refreshToken,
      );
      print('[AUTH_SESSION] ✅ Refresh token stored successfully');
    } else {
      print('[AUTH_SESSION] ⚠️ WARNING: No refresh token to store!');
    }
  }

  /// Set user as logged out and clear all auth data
  /// Clears both secure storage (tokens) and SharedPreferences (flags)
  Future<void> setLoggedOut() async {
    print('[AUTH_SESSION] 🔴 setLoggedOut() called - Clearing all auth data');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(StorageKeys.isLoggedIn, false);

    // Clear all auth-related data from secure storage
    await _secureStorage.delete(key: StorageKeys.accessToken);
    print('[AUTH_SESSION] 🔴 Deleted accessToken from storage');
    await _secureStorage.delete(key: StorageKeys.refreshToken);
    print('[AUTH_SESSION] 🔴 Deleted refreshToken from storage');
    await prefs.remove(StorageKeys.userCredentials);
    print('[AUTH_SESSION] 🔴 Cleared all auth data');
  }

  /// Check if secure storage is available
  /// Returns true if tokens can be read/written
  Future<bool> get isSecureStorageAvailable async {
    try {
      await _secureStorage.read(key: 'test_key');
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  /// Refresh the access token using the refresh token
  /// Returns the new access token, or null if refresh fails
  Future<String?> refreshAccessToken() async {
    try {
      final currentRefreshToken = await refreshToken;
      if (currentRefreshToken == null) {
        print('[AUTH_SESSION] No refresh token available');
        return null;
      }

      // Create a Dio instance for the refresh request
      final dio = Dio(
        BaseOptions(
          baseUrl: '${dotenv.env['API_BASE_URL']}',
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      print('[AUTH_SESSION] Sending refresh request to backend...');
      print(
        '[AUTH_SESSION] Refresh token length: ${currentRefreshToken.length} chars',
      );
      print(
        '[AUTH_SESSION] Refresh token (first 20 chars): ${currentRefreshToken.substring(0, 20)}...',
      );

      final response = await dio.post(
        '/api/v1/auth/refresh',
        data: {'refreshToken': currentRefreshToken},
      );

      print('[AUTH_SESSION] Refresh response status: ${response.statusCode}');
      print('[AUTH_SESSION] Refresh response data: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        // Parse using the RefreshTokenResponse model
        final refreshResponse = RefreshTokenResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
        final newAccessToken = refreshResponse.accessToken;

        // Update the stored access token
        await _secureStorage.write(
          key: StorageKeys.accessToken,
          value: newAccessToken,
        );
        print('[AUTH_SESSION] Successfully refreshed access token');
        return newAccessToken;
      }

      print('[AUTH_SESSION] Failed to refresh token - invalid response');
      return null;
    } on DioException catch (e) {
      print('[AUTH_SESSION] ❌ DioException during refresh:');
      print('[AUTH_SESSION] - Type: ${e.type}');
      print('[AUTH_SESSION] - Status Code: ${e.response?.statusCode}');
      print('[AUTH_SESSION] - Error: ${e.message}');
      if (e.response?.data != null) {
        print('[AUTH_SESSION] - Response Data: ${e.response?.data}');
      }
      return null;
    } catch (e) {
      print('[AUTH_SESSION] ❌ Generic error during refresh: $e');
      return null;
    }
  }
}

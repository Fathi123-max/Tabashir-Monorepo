import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabashir/core/constants/storage_keys.dart';
import 'package:tabashir/core/network/models/auth/refresh_token_response.dart';
import 'package:tabashir/core/network/services/auth/auth_api_service.dart';
import 'package:tabashir/core/network/_config/api_config.dart';
import 'package:tabashir/core/utils/app_logger.dart';

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

  // Synchronization for token refresh
  bool _isRefreshing = false;
  Completer<String?>? _refreshCompleter;

  // Stream for auth state changes
  final _authStateController = StreamController<bool>.broadcast();
  Stream<bool> get authStateStream => _authStateController.stream;

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
    } on Exception catch (e) {
      AppLogger.error('ERROR reading access token', tag: 'AuthSession', error: e);
      return null;
    }
  }

  /// Get the stored refresh token
  /// Returns null if no token is stored
  /// Tokens are stored encrypted using flutter_secure_storage
  Future<String?> get refreshToken async {
    try {
      final token = await _secureStorage.read(key: StorageKeys.refreshToken);
      return token;
    } on Exception catch (e) {
      AppLogger.error('ERROR reading refresh token', tag: 'AuthSession', error: e);
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
    _authStateController.add(true);

    // Store tokens securely using flutter_secure_storage (encrypted)
    if (token != null) {
      await _secureStorage.write(
        key: StorageKeys.accessToken,
        value: token,
      );
    }

    if (refreshToken != null) {
      await _secureStorage.write(
        key: StorageKeys.refreshToken,
        value: refreshToken,
      );
    }
    AppLogger.info('Tokens stored successfully', tag: 'AuthSession');
  }

  /// Set user as logged out and clear all auth data
  /// Clears both secure storage (tokens) and SharedPreferences (flags)
  Future<void> setLoggedOut() async {
    AppLogger.info('setLoggedOut() - Clearing all auth data', tag: 'AuthSession');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(StorageKeys.isLoggedIn, false);
    _authStateController.add(false);

    // Clear all auth-related data from secure storage
    await _secureStorage.delete(key: StorageKeys.accessToken);
    await _secureStorage.delete(key: StorageKeys.refreshToken);
    await prefs.remove(StorageKeys.userCredentials);
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
  /// Returns the new access token
  /// Returns null ONLY if the refresh token is invalid/expired (401)
  /// Throws an exception for network or server errors
  /// Uses a synchronized approach to prevent multiple concurrent refreshes
  Future<String?> refreshAccessToken() async {
    // If a refresh is already in progress, wait for it
    if (_isRefreshing) {
      AppLogger.debug('Refresh already in progress, waiting...', tag: 'AuthSession');
      return _refreshCompleter?.future;
    }

    _isRefreshing = true;
    _refreshCompleter = Completer<String?>();

    try {
      final currentRefreshToken = await refreshToken;
      if (currentRefreshToken == null) {
        AppLogger.warning('No refresh token available', tag: 'AuthSession');
        _isRefreshing = false;
        _refreshCompleter?.complete(null);
        return null;
      }

      // Create a Dio instance for the refresh request (avoid interceptors)
      final baseUrl = dotenv.env['API_BASE_URL'];
      if (baseUrl == null) {
        AppLogger.error('API_BASE_URL is not set', tag: 'AuthSession');
        _isRefreshing = false;
        final error = Exception('API_BASE_URL is not set');
        _refreshCompleter?.completeError(error);
        throw error;
      }

      final dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      AppLogger.debug('Sending refresh request...', tag: 'AuthSession');
      final response = await dio.post(
        '/api/v1/auth/refresh',
        data: {'refreshToken': currentRefreshToken},
      );

      if (response.statusCode == 200 && response.data != null) {
        final refreshResponse = RefreshTokenResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
        final newAccessToken = refreshResponse.accessToken;

        await _secureStorage.write(
          key: StorageKeys.accessToken,
          value: newAccessToken,
        );
        AppLogger.info('Successfully refreshed access token', tag: 'AuthSession');

        _isRefreshing = false;
        _refreshCompleter?.complete(newAccessToken);
        return newAccessToken;
      }

      AppLogger.warning('Unexpected status code: ${response.statusCode}', tag: 'AuthSession');
      _isRefreshing = false;
      final error = Exception(
        'Failed to refresh token: Status ${response.statusCode}',
      );
      _refreshCompleter?.completeError(error);
      throw error;
    } on DioException catch (e) {
      AppLogger.error('DioException during refresh: ${e.message}', tag: 'AuthSession', error: e);
      _isRefreshing = false;

      final statusCode = e.response?.statusCode;
      // 400, 401, 403, 404 all indicate the token is definitively invalid or user doesn't exist
      if (statusCode != null && statusCode >= 400 && statusCode < 500) {
        AppLogger.warning(
          'Refresh token invalid, expired, or user not found ($statusCode)',
          tag: 'AuthSession',
        );
        _refreshCompleter?.complete(null);
        return null;
      }

      // For network errors or 5xx server errors, throw so interceptor doesn't logout
      AppLogger.warning(
        'Network or server error during refresh. Not logging out.',
        tag: 'AuthSession',
      );
      _refreshCompleter?.completeError(e);
      rethrow;
    } catch (e) {
      AppLogger.error('Generic error during refresh: $e', tag: 'AuthSession', error: e);
      _isRefreshing = false;
      _refreshCompleter?.completeError(e);
      rethrow;
    } finally {
      _isRefreshing = false;
    }
  }
}

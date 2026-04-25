import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabashir/core/constants/storage_keys.dart';

/// Service to handle local storage operations
class LocalStorageService {
  LocalStorageService._();
  static LocalStorageService? _instance;
  static LocalStorageService get instance =>
      _instance ??= LocalStorageService._();

  static bool _isInitialized = false;

  late FlutterSecureStorage _secureStorage;
  late SharedPreferences _sharedPrefs;

  /// Initializes all storage mechanisms
  Future<void> init() async {
    // Initialize secure storage
    _secureStorage = const FlutterSecureStorage();

    // Initialize shared preferences
    _sharedPrefs = await SharedPreferences.getInstance();

    // Note: local database initialization removed - currently using SharedPreferences via LocalPersistenceService

    _isInitialized = true;
  }

  /// Ensures the service is initialized
  void _ensureInitialized() {
    if (!_isInitialized) {
      throw Exception(
        'LocalStorageService is not initialized. Call init() first.',
      );
    }
  }

  /// Secure storage operations
  Future<void> setSecureString(String key, String value) {
    _ensureInitialized();
    return _secureStorage.write(key: key, value: value);
  }

  Future<String?> getSecureString(String key) {
    _ensureInitialized();
    return _secureStorage.read(key: key);
  }

  Future<void> deleteSecureString(String key) {
    _ensureInitialized();
    return _secureStorage.delete(key: key);
  }

  /// Deletes all data stored in the secure storage.
  ///
  /// This operation cannot be undone. All key-value pairs in the secure storage
  /// will be permanently removed.
  ///
  /// ```dart
  /// await localStorage.clearSecureStorage();
  /// ```
  Future<void> clearSecureStorage() async {
    _ensureInitialized();
    await _secureStorage.deleteAll();
  }

  /// Shared preferences operations
  Future<bool> setString(String key, String value) {
    _ensureInitialized();
    return _sharedPrefs.setString(key, value);
  }

  String? getString(String key) {
    _ensureInitialized();
    return _sharedPrefs.getString(key);
  }

  Future<bool> setInt(String key, int value) {
    _ensureInitialized();
    return _sharedPrefs.setInt(key, value);
  }

  int? getInt(String key) {
    _ensureInitialized();
    return _sharedPrefs.getInt(key);
  }

  Future<bool> setBool(String key, bool value) {
    _ensureInitialized();
    return _sharedPrefs.setBool(key, value);
  }

  bool? getBool(String key) {
    _ensureInitialized();
    return _sharedPrefs.getBool(key);
  }

  Future<bool> setDouble(String key, double value) {
    _ensureInitialized();
    return _sharedPrefs.setDouble(key, value);
  }

  double? getDouble(String key) {
    _ensureInitialized();
    return _sharedPrefs.getDouble(key);
  }

  Future<bool> setStringList(String key, List<String> value) {
    _ensureInitialized();
    return _sharedPrefs.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    _ensureInitialized();
    return _sharedPrefs.getStringList(key);
  }

  Future<bool> remove(String key) {
    _ensureInitialized();
    return _sharedPrefs.remove(key);
  }

  Future<bool> clear() {
    _ensureInitialized();
    return _sharedPrefs.clear();
  }

  /// Get authentication token from secure storage
  Future<String?> getToken() {
    _ensureInitialized();
    return getSecureString(StorageKeys.accessToken);
  }

  /// Set authentication token in secure storage
  Future<void> setToken(String token) {
    _ensureInitialized();
    return setSecureString(StorageKeys.accessToken, token);
  }

  /// Delete authentication token from secure storage
  Future<void> deleteToken() {
    _ensureInitialized();
    return deleteSecureString(StorageKeys.accessToken);
  }
}

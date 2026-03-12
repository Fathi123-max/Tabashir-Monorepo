/// Repository interface for settings operations
/// Defines the contract for user settings data operations
abstract class SettingsRepository {
  /// Get all settings as a map
  /// Returns [Map<String, dynamic>] containing all settings
  Future<Map<String, dynamic>> getSettings();

  /// Get a specific setting value by key
  /// Returns the setting value or null if not found
  Future<T?> getSetting<T>({
    required String key,
  });

  /// Save a setting value
  /// Returns void when operation is complete
  Future<void> setSetting<T>({
    required String key,
    required T value,
  });

  /// Save multiple settings at once
  /// Returns void when operation is complete
  Future<void> setSettings({
    required Map<String, dynamic> settings,
  });

  /// Remove a setting by key
  /// Returns void when operation is complete
  Future<void> removeSetting({
    required String key,
  });

  /// Clear all settings
  /// Returns void when operation is complete
  Future<void> clearSettings();

  /// Check if a setting key exists
  /// Returns true if the key exists, false otherwise
  Future<bool> hasSetting({
    required String key,
  });
}

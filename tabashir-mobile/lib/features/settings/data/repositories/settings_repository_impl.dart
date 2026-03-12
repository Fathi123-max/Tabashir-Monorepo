import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:tabashir/core/services/local_storage_service.dart';
import 'package:tabashir/features/settings/domain/repositories/settings_repository.dart';

/// Implementation of [SettingsRepository]
/// Handles settings operations using [LocalStorageService]
@Injectable(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._localStorageService);

  final LocalStorageService _localStorageService;

  static const String _settingsKey = 'user_settings';

  @override
  Future<Map<String, dynamic>> getSettings() async {
    try {
      final settingsJson = _localStorageService.getString(_settingsKey);
      if (settingsJson == null || settingsJson.isEmpty) {
        return <String, dynamic>{};
      }

      final decoded = jsonDecode(settingsJson) as Map<String, dynamic>;
      return decoded;
    } catch (e) {
      throw Exception('Failed to get settings: $e');
    }
  }

  @override
  Future<T?> getSetting<T>({
    required String key,
  }) async {
    try {
      final settings = await getSettings();
      if (!settings.containsKey(key)) {
        return null;
      }

      return settings[key] as T?;
    } catch (e) {
      throw Exception('Failed to get setting: $e');
    }
  }

  @override
  Future<void> setSetting<T>({
    required String key,
    required T value,
  }) async {
    try {
      final settings = await getSettings();
      settings[key] = value;
      await _saveSettings(settings);
    } catch (e) {
      throw Exception('Failed to set setting: $e');
    }
  }

  @override
  Future<void> setSettings({
    required Map<String, dynamic> settings,
  }) async {
    try {
      await _saveSettings(settings);
    } catch (e) {
      throw Exception('Failed to set settings: $e');
    }
  }

  @override
  Future<void> removeSetting({
    required String key,
  }) async {
    try {
      final settings = await getSettings();
      settings.remove(key);
      await _saveSettings(settings);
    } catch (e) {
      throw Exception('Failed to remove setting: $e');
    }
  }

  @override
  Future<void> clearSettings() async {
    try {
      await _localStorageService.remove(_settingsKey);
    } catch (e) {
      throw Exception('Failed to clear settings: $e');
    }
  }

  @override
  Future<bool> hasSetting({
    required String key,
  }) async {
    try {
      final settings = await getSettings();
      return settings.containsKey(key);
    } catch (e) {
      throw Exception('Failed to check setting: $e');
    }
  }

  /// Save settings to storage
  Future<void> _saveSettings(Map<String, dynamic> settings) async {
    final settingsJson = jsonEncode(settings);
    await _localStorageService.setString(_settingsKey, settingsJson);
  }
}

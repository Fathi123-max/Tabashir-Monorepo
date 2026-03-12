import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/features/settings/domain/repositories/settings_repository.dart';

part 'settings_state.dart';
part 'settings_cubit.freezed.dart';
part 'settings_cubit.g.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._repository) : super(const SettingsState());

  final SettingsRepository _repository;

  /// Load all settings
  Future<void> loadSettings() async {
    emit(state.copyWith(isLoading: true, hasError: false));

    try {
      final settings = await _repository.getSettings();

      emit(
        state.copyWith(
          status: SettingsStatus.loaded,
          isLoading: false,
          settings: settings,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SettingsStatus.error,
          isLoading: false,
          hasError: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Get a specific setting value
  Future<T?> getSetting<T>({required String key}) async {
    try {
      return await _repository.getSetting<T>(key: key);
    } catch (e) {
      emit(
        state.copyWith(
          hasError: true,
          errorMessage: e.toString(),
        ),
      );
      return null;
    }
  }

  /// Set a specific setting value
  Future<void> setSetting<T>({required String key, required T value}) async {
    try {
      await _repository.setSetting<T>(key: key, value: value);

      // Update local state
      final updatedSettings = Map<String, dynamic>.from(state.settings);
      updatedSettings[key] = value;

      emit(
        state.copyWith(settings: updatedSettings),
      );
    } catch (e) {
      emit(
        state.copyWith(
          hasError: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Set multiple settings at once
  Future<void> setSettings({required Map<String, dynamic> settings}) async {
    try {
      await _repository.setSettings(settings: settings);
      emit(state.copyWith(settings: settings));
    } catch (e) {
      emit(
        state.copyWith(
          hasError: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Remove a setting
  Future<void> removeSetting({required String key}) async {
    try {
      await _repository.removeSetting(key: key);

      final updatedSettings = Map<String, dynamic>.from(state.settings);
      updatedSettings.remove(key);

      emit(
        state.copyWith(settings: updatedSettings),
      );
    } catch (e) {
      emit(
        state.copyWith(
          hasError: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Clear all settings
  Future<void> clearSettings() async {
    try {
      await _repository.clearSettings();
      emit(
        state.copyWith(settings: {}),
      );
    } catch (e) {
      emit(
        state.copyWith(
          hasError: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Check if a setting exists
  Future<bool> hasSetting({required String key}) async {
    try {
      return await _repository.hasSetting(key: key);
    } catch (e) {
      return false;
    }
  }

  /// Helper method to toggle a boolean setting
  Future<void> toggleSetting({required String key}) async {
    try {
      final currentValue = await getSetting<bool>(key: key) ?? false;
      await setSetting(key: key, value: !currentValue);
    } catch (e) {
      emit(
        state.copyWith(
          hasError: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

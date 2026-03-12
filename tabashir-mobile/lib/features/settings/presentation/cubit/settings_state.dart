part of 'settings_cubit.dart';

@freezed
sealed class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(SettingsStatus.initial) SettingsStatus status,
    @Default({}) Map<String, dynamic> settings,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
  }) = _SettingsState;

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);
}

enum SettingsStatus {
  initial,
  loading,
  loaded,
  error,
}

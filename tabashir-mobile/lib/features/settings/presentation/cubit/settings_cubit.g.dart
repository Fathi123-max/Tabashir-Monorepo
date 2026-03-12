// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettingsState _$SettingsStateFromJson(Map<String, dynamic> json) =>
    _SettingsState(
      status:
          $enumDecodeNullable(_$SettingsStatusEnumMap, json['status']) ??
          SettingsStatus.initial,
      settings: json['settings'] as Map<String, dynamic>? ?? const {},
      isLoading: json['isLoading'] as bool? ?? false,
      hasError: json['hasError'] as bool? ?? false,
      errorMessage: json['errorMessage'] as String? ?? '',
    );

Map<String, dynamic> _$SettingsStateToJson(_SettingsState instance) =>
    <String, dynamic>{
      'status': _$SettingsStatusEnumMap[instance.status]!,
      'settings': instance.settings,
      'isLoading': instance.isLoading,
      'hasError': instance.hasError,
      'errorMessage': instance.errorMessage,
    };

const _$SettingsStatusEnumMap = {
  SettingsStatus.initial: 'initial',
  SettingsStatus.loading: 'loading',
  SettingsStatus.loaded: 'loaded',
  SettingsStatus.error: 'error',
};

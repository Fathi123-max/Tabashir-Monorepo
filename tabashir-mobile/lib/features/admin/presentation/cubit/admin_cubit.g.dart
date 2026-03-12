// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdminState _$AdminStateFromJson(Map<String, dynamic> json) => _AdminState(
  status:
      $enumDecodeNullable(_$AdminStatusEnumMap, json['status']) ??
      AdminStatus.initial,
  errorMessage: json['errorMessage'] as String? ?? '',
  adminProfile: json['adminProfile'] == null
      ? null
      : AdminUser.fromJson(json['adminProfile'] as Map<String, dynamic>),
  dashboardStats: json['dashboardStats'] == null
      ? null
      : AdminStats.fromJson(json['dashboardStats'] as Map<String, dynamic>),
  users:
      (json['users'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const [],
  jobs:
      (json['jobs'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const [],
  applications:
      (json['applications'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const [],
  systemLogs:
      (json['systemLogs'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const [],
  analytics: json['analytics'] as Map<String, dynamic>?,
  exportDataUrl: json['exportDataUrl'] as String?,
);

Map<String, dynamic> _$AdminStateToJson(_AdminState instance) =>
    <String, dynamic>{
      'status': _$AdminStatusEnumMap[instance.status]!,
      'errorMessage': instance.errorMessage,
      'adminProfile': instance.adminProfile,
      'dashboardStats': instance.dashboardStats,
      'users': instance.users,
      'jobs': instance.jobs,
      'applications': instance.applications,
      'systemLogs': instance.systemLogs,
      'analytics': instance.analytics,
      'exportDataUrl': instance.exportDataUrl,
    };

const _$AdminStatusEnumMap = {
  AdminStatus.initial: 'initial',
  AdminStatus.loading: 'loading',
  AdminStatus.loaded: 'loaded',
  AdminStatus.error: 'error',
};

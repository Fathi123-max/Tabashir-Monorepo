// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdminUser _$AdminUserFromJson(Map<String, dynamic> json) => _AdminUser(
  id: json['id'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  role: json['role'] as String,
  permissions:
      (json['permissions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  lastLogin: json['lastLogin'] == null
      ? null
      : DateTime.parse(json['lastLogin'] as String),
  isActive: json['isActive'] as bool? ?? true,
);

Map<String, dynamic> _$AdminUserToJson(_AdminUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'permissions': instance.permissions,
      'lastLogin': instance.lastLogin?.toIso8601String(),
      'isActive': instance.isActive,
    };

_AdminStats _$AdminStatsFromJson(Map<String, dynamic> json) => _AdminStats(
  totalUsers: (json['totalUsers'] as num).toInt(),
  totalJobs: (json['totalJobs'] as num).toInt(),
  totalApplications: (json['totalApplications'] as num).toInt(),
  activeSubscriptions: (json['activeSubscriptions'] as num).toInt(),
  dailySignups:
      (json['dailySignups'] as List<dynamic>?)
          ?.map((e) => Map<String, int>.from(e as Map))
          .toList() ??
      const [],
  jobPostingStats:
      (json['jobPostingStats'] as List<dynamic>?)
          ?.map((e) => Map<String, int>.from(e as Map))
          .toList() ??
      const [],
);

Map<String, dynamic> _$AdminStatsToJson(_AdminStats instance) =>
    <String, dynamic>{
      'totalUsers': instance.totalUsers,
      'totalJobs': instance.totalJobs,
      'totalApplications': instance.totalApplications,
      'activeSubscriptions': instance.activeSubscriptions,
      'dailySignups': instance.dailySignups,
      'jobPostingStats': instance.jobPostingStats,
    };

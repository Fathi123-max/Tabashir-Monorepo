// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DashboardData _$DashboardDataFromJson(Map<String, dynamic> json) =>
    _DashboardData(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userEmail: json['userEmail'] as String,
      userAvatar: json['userAvatar'] as String?,
      quickActions:
          (json['quickActions'] as List<dynamic>?)
              ?.map((e) => QuickAction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      recentActivities:
          (json['recentActivities'] as List<dynamic>?)
              ?.map((e) => RecentActivity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      jobRecommendations:
          (json['jobRecommendations'] as List<dynamic>?)
              ?.map(
                (e) => JobRecommendation.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      totalApplications: (json['totalApplications'] as num?)?.toInt() ?? 0,
      savedJobs: (json['savedJobs'] as num?)?.toInt() ?? 0,
      profileViews: (json['profileViews'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$DashboardDataToJson(_DashboardData instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'userEmail': instance.userEmail,
      'userAvatar': instance.userAvatar,
      'quickActions': instance.quickActions,
      'recentActivities': instance.recentActivities,
      'jobRecommendations': instance.jobRecommendations,
      'totalApplications': instance.totalApplications,
      'savedJobs': instance.savedJobs,
      'profileViews': instance.profileViews,
    };

_QuickAction _$QuickActionFromJson(Map<String, dynamic> json) => _QuickAction(
  id: json['id'] as String,
  title: json['title'] as String,
  icon: json['icon'] as String,
  route: json['route'] as String,
);

Map<String, dynamic> _$QuickActionToJson(_QuickAction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'icon': instance.icon,
      'route': instance.route,
    };

_RecentActivity _$RecentActivityFromJson(Map<String, dynamic> json) =>
    _RecentActivity(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      type: json['type'] as String,
    );

Map<String, dynamic> _$RecentActivityToJson(_RecentActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'timestamp': instance.timestamp.toIso8601String(),
      'type': instance.type,
    };

_JobRecommendation _$JobRecommendationFromJson(Map<String, dynamic> json) =>
    _JobRecommendation(
      id: json['id'] as String,
      title: json['title'] as String,
      company: json['company'] as String,
      location: json['location'] as String,
      matchPercentage: (json['matchPercentage'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$JobRecommendationToJson(_JobRecommendation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'company': instance.company,
      'location': instance.location,
      'matchPercentage': instance.matchPercentage,
    };

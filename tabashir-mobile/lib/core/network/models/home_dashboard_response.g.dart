// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_dashboard_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeDashboardResponse _$HomeDashboardResponseFromJson(
  Map<String, dynamic> json,
) => _HomeDashboardResponse(
  featuredJobs: (json['featuredJobs'] as List<dynamic>)
      .map((e) => JobDetailsResponse.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalMatches: (json['totalMatches'] as num).toInt(),
  companiesViewed: (json['companiesViewed'] as num).toInt(),
  inReview: (json['inReview'] as num).toInt(),
  interviews: (json['interviews'] as num).toInt(),
  offers: (json['offers'] as num).toInt(),
  rejected: (json['rejected'] as num).toInt(),
  matchDistribution: json['matchDistribution'] as String,
  profileCompletionPercentage: (json['profileCompletionPercentage'] as num)
      .toInt(),
  applicationSuccessRate: (json['applicationSuccessRate'] as num).toInt(),
  jobsByCity: (json['jobsByCity'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, (e as num).toInt()),
  ),
  monthlyJobCounts: (json['monthlyJobCounts'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, (e as num).toInt()),
  ),
);

Map<String, dynamic> _$HomeDashboardResponseToJson(
  _HomeDashboardResponse instance,
) => <String, dynamic>{
  'featuredJobs': instance.featuredJobs,
  'totalMatches': instance.totalMatches,
  'companiesViewed': instance.companiesViewed,
  'inReview': instance.inReview,
  'interviews': instance.interviews,
  'offers': instance.offers,
  'rejected': instance.rejected,
  'matchDistribution': instance.matchDistribution,
  'profileCompletionPercentage': instance.profileCompletionPercentage,
  'applicationSuccessRate': instance.applicationSuccessRate,
  'jobsByCity': instance.jobsByCity,
  'monthlyJobCounts': instance.monthlyJobCounts,
};

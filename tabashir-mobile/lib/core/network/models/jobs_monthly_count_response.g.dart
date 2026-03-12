// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_monthly_count_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobsMonthlyCountResponse _$JobsMonthlyCountResponseFromJson(
  Map<String, dynamic> json,
) => _JobsMonthlyCountResponse(
  success: json['success'] as bool,
  data: (json['data'] as List<dynamic>)
      .map((e) => MonthlyCount.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$JobsMonthlyCountResponseToJson(
  _JobsMonthlyCountResponse instance,
) => <String, dynamic>{'success': instance.success, 'data': instance.data};

_MonthlyCount _$MonthlyCountFromJson(Map<String, dynamic> json) =>
    _MonthlyCount(
      month: json['month'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$MonthlyCountToJson(_MonthlyCount instance) =>
    <String, dynamic>{'month': instance.month, 'count': instance.count};

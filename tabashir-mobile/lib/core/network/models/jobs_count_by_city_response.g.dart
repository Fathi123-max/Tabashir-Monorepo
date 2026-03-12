// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_count_by_city_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobsCountByCityResponse _$JobsCountByCityResponseFromJson(
  Map<String, dynamic> json,
) => _JobsCountByCityResponse(
  success: json['success'] as bool,
  data: (json['data'] as List<dynamic>)
      .map((e) => CityCount.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$JobsCountByCityResponseToJson(
  _JobsCountByCityResponse instance,
) => <String, dynamic>{'success': instance.success, 'data': instance.data};

_CityCount _$CityCountFromJson(Map<String, dynamic> json) => _CityCount(
  vacancyCity: json['vacancy_city'] as String,
  count: (json['count'] as num).toInt(),
);

Map<String, dynamic> _$CityCountToJson(_CityCount instance) =>
    <String, dynamic>{
      'vacancy_city': instance.vacancyCity,
      'count': instance.count,
    };

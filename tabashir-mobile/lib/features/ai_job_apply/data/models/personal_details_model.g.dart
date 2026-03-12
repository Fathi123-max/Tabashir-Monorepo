// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PersonalDetailsModel _$PersonalDetailsModelFromJson(
  Map<String, dynamic> json,
) => _PersonalDetailsModel(
  nationality: json['nationality'] as String?,
  gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
  requiresVisaSponsorship: json['requiresVisaSponsorship'] as bool? ?? false,
);

Map<String, dynamic> _$PersonalDetailsModelToJson(
  _PersonalDetailsModel instance,
) => <String, dynamic>{
  'nationality': instance.nationality,
  'gender': _$GenderEnumMap[instance.gender],
  'requiresVisaSponsorship': instance.requiresVisaSponsorship,
};

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.preferNotToSay: 'prefer_not_to_say',
};

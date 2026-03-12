// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileUpdateRequest _$ProfileUpdateRequestFromJson(
  Map<String, dynamic> json,
) => _ProfileUpdateRequest(
  name: json['name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  nationality: json['nationality'] as String,
  gender: json['gender'] as String,
  jobTitle: json['jobTitle'] as String,
  location: json['location'] as String?,
  company: json['company'] as String,
  education: json['education'] as String,
  linkedin: json['linkedin'] as String?,
);

Map<String, dynamic> _$ProfileUpdateRequestToJson(
  _ProfileUpdateRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
  'nationality': instance.nationality,
  'gender': instance.gender,
  'jobTitle': instance.jobTitle,
  'location': instance.location,
  'company': instance.company,
  'education': instance.education,
  'linkedin': instance.linkedin,
};

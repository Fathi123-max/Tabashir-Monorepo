// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_info_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PersonalInfoRequest _$PersonalInfoRequestFromJson(Map<String, dynamic> json) =>
    _PersonalInfoRequest(
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      country: json['country'] as String,
      city: json['city'] as String,
      dateOfBirth: json['dateOfBirth'] as String?,
      nationality: json['nationality'] as String?,
      gender: json['gender'] as String?,
      profilePicture: json['profilePicture'] as String?,
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      age: (json['age'] as num?)?.toInt(),
      skills: (json['skills'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PersonalInfoRequestToJson(
  _PersonalInfoRequest instance,
) => <String, dynamic>{
  'fullName': instance.fullName,
  'email': instance.email,
  'phone': instance.phone,
  'country': instance.country,
  'city': instance.city,
  'dateOfBirth': instance.dateOfBirth,
  'nationality': instance.nationality,
  'gender': instance.gender,
  'profilePicture': instance.profilePicture,
  'languages': instance.languages,
  'age': instance.age,
  'skills': instance.skills,
};

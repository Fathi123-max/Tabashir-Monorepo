// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_isar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileIsar _$ProfileIsarFromJson(Map<String, dynamic> json) => ProfileIsar(
  name: json['name'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  nationality: json['nationality'] as String?,
  gender: json['gender'] as String?,
  jobTitle: json['jobTitle'] as String?,
  location: json['location'] as String?,
  company: json['company'] as String?,
  education: json['education'] as String?,
  linkedin: json['linkedin'] as String?,
  userType: json['userType'] as String?,
  profileStrength: (json['profileStrength'] as num?)?.toInt(),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ProfileIsarToJson(ProfileIsar instance) =>
    <String, dynamic>{
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
      'userType': instance.userType,
      'profileStrength': instance.profileStrength,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

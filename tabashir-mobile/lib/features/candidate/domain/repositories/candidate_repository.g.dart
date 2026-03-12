// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidate_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CandidateProfile _$CandidateProfileFromJson(Map<String, dynamic> json) =>
    _CandidateProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      location: json['location'] as String,
      skills: (json['skills'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      experienceLevel: json['experienceLevel'] as String,
      resumeUrls:
          (json['resumeUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      jobApplications:
          (json['jobApplications'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CandidateProfileToJson(_CandidateProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'location': instance.location,
      'skills': instance.skills,
      'experienceLevel': instance.experienceLevel,
      'resumeUrls': instance.resumeUrls,
      'jobApplications': instance.jobApplications,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

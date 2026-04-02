// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobDetails _$JobDetailsFromJson(Map<String, dynamic> json) => _JobDetails(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  company: json['company'] as String,
  location: json['location'] as String,
  salary: json['salary'] as String,
  matchPercentage: json['matchPercentage'] as String,
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  requirements: (json['requirements'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  skills: (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
  employmentType: json['employmentType'] as String?,
  experienceLevel: json['experienceLevel'] as String?,
  workingHours: json['workingHours'] as String?,
  workingDays: json['workingDays'] as String?,
  phone: json['phone'] as String?,
  applyUrl: json['applyUrl'] as String?,
  applicationEmail: json['applicationEmail'] as String?,
  source: json['source'] as String?,
  nationality: json['nationality'] as String?,
  gender: json['gender'] as String?,
  academicQualification: json['academicQualification'] as String?,
  postedDate: json['postedDate'] as String?,
  isSaved: json['isSaved'] as bool?,
);

Map<String, dynamic> _$JobDetailsToJson(_JobDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'company': instance.company,
      'location': instance.location,
      'salary': instance.salary,
      'matchPercentage': instance.matchPercentage,
      'tags': instance.tags,
      'requirements': instance.requirements,
      'skills': instance.skills,
      'employmentType': instance.employmentType,
      'experienceLevel': instance.experienceLevel,
      'workingHours': instance.workingHours,
      'workingDays': instance.workingDays,
      'phone': instance.phone,
      'applyUrl': instance.applyUrl,
      'applicationEmail': instance.applicationEmail,
      'source': instance.source,
      'nationality': instance.nationality,
      'gender': instance.gender,
      'academicQualification': instance.academicQualification,
      'postedDate': instance.postedDate,
      'isSaved': instance.isSaved,
    };

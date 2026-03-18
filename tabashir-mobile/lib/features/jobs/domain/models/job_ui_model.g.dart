// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_ui_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobUI _$JobUIFromJson(Map<String, dynamic> json) => _JobUI(
  id: json['id'] as String,
  title: json['title'] as String,
  company: json['company'] as String,
  location: json['location'] as String,
  salary: json['salary'] as String,
  matchPercentage: json['matchPercentage'] as String,
  skillsMatch: json['skillsMatch'] as String,
  salaryValue: (json['salaryValue'] as num?)?.toInt() ?? 0,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  isSaved: json['isSaved'] as bool? ?? false,
  isApplied: json['isApplied'] as bool? ?? false,
  jobType: json['jobType'] as String?,
  experienceLevel: json['experienceLevel'] as String?,
  skills:
      (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  workMode: json['workMode'] as String?,
  description: json['description'] as String?,
  requirements:
      (json['requirements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  postedDate: json['postedDate'] as String?,
  workingDays: json['workingDays'] as String?,
);

Map<String, dynamic> _$JobUIToJson(_JobUI instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'company': instance.company,
  'location': instance.location,
  'salary': instance.salary,
  'matchPercentage': instance.matchPercentage,
  'skillsMatch': instance.skillsMatch,
  'salaryValue': instance.salaryValue,
  'tags': instance.tags,
  'isSaved': instance.isSaved,
  'isApplied': instance.isApplied,
  'jobType': instance.jobType,
  'experienceLevel': instance.experienceLevel,
  'skills': instance.skills,
  'workMode': instance.workMode,
  'description': instance.description,
  'requirements': instance.requirements,
  'postedDate': instance.postedDate,
  'workingDays': instance.workingDays,
};

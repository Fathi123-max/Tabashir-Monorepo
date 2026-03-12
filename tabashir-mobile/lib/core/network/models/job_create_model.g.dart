// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_create_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobCreate _$JobCreateFromJson(Map<String, dynamic> json) => _JobCreate(
  jobTitle: json['jobTitle'] as String,
  jobDate: json['jobDate'] as String,
  entity: json['entity'] as String?,
  nationality: json['nationality'] as String?,
  gender: json['gender'] as String?,
  academicQualification: json['academicQualification'] as String?,
  experience: json['experience'] as String?,
  languages: json['languages'] as String?,
  salary: json['salary'] as String?,
  vacancyCity: json['vacancyCity'] as String?,
  workingHours: json['workingHours'] as String?,
  workingDays: json['workingDays'] as String?,
  applicationEmail: json['applicationEmail'] as String?,
  jobDescription: json['jobDescription'] as String?,
  phone: json['phone'] as String?,
  applyUrl: json['applyUrl'] as String?,
  companyName: json['companyName'] as String?,
  websiteUrl: json['websiteUrl'] as String?,
  jobType: json['jobType'] as String?,
);

Map<String, dynamic> _$JobCreateToJson(_JobCreate instance) =>
    <String, dynamic>{
      'jobTitle': instance.jobTitle,
      'jobDate': instance.jobDate,
      'entity': instance.entity,
      'nationality': instance.nationality,
      'gender': instance.gender,
      'academicQualification': instance.academicQualification,
      'experience': instance.experience,
      'languages': instance.languages,
      'salary': instance.salary,
      'vacancyCity': instance.vacancyCity,
      'workingHours': instance.workingHours,
      'workingDays': instance.workingDays,
      'applicationEmail': instance.applicationEmail,
      'jobDescription': instance.jobDescription,
      'phone': instance.phone,
      'applyUrl': instance.applyUrl,
      'companyName': instance.companyName,
      'websiteUrl': instance.websiteUrl,
      'jobType': instance.jobType,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobDetailsResponse _$JobDetailsResponseFromJson(Map<String, dynamic> json) =>
    _JobDetailsResponse(
      jobId: (json['id'] as num?)?.toInt(),
      jobTitle: json['job_title'] as String?,
      companyName: json['entity'] as String?,
      jobDescription: json['job_description'] as String?,
      location: json['vacancy_city'] as String?,
      salary: json['salary'] as String?,
      jobType: json['job_type'] as String?,
      applyUrl: json['apply_url'] as String?,
      academicQualification: json['academic_qualification'] as String?,
      experience: json['experience'] as String?,
      languages: json['languages'] as String?,
      workingHours: json['working_hours'] as String?,
      workingDays: json['working_days'] as String?,
      applicationEmail: json['application_email'] as String?,
      jobDate: json['job_date'] as String?,
      phone: json['phone'] as String?,
      source: json['source'] as String?,
      nationality: json['nationality'] as String?,
      gender: json['gender'] as String?,
      matchPercentage: json['match_percentage'] as String?,
    );

Map<String, dynamic> _$JobDetailsResponseToJson(_JobDetailsResponse instance) =>
    <String, dynamic>{
      'id': instance.jobId,
      'job_title': instance.jobTitle,
      'entity': instance.companyName,
      'job_description': instance.jobDescription,
      'vacancy_city': instance.location,
      'salary': instance.salary,
      'job_type': instance.jobType,
      'apply_url': instance.applyUrl,
      'academic_qualification': instance.academicQualification,
      'experience': instance.experience,
      'languages': instance.languages,
      'working_hours': instance.workingHours,
      'working_days': instance.workingDays,
      'application_email': instance.applicationEmail,
      'job_date': instance.jobDate,
      'phone': instance.phone,
      'source': instance.source,
      'nationality': instance.nationality,
      'gender': instance.gender,
      'match_percentage': instance.matchPercentage,
    };

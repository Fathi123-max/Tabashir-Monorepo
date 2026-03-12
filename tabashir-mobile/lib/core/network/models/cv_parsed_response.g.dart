// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cv_parsed_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CVParsedResponse _$CVParsedResponseFromJson(Map<String, dynamic> json) =>
    _CVParsedResponse(
      personalInfo: json['personalInfo'] == null
          ? null
          : PersonalInfo.fromJson(json['personalInfo'] as Map<String, dynamic>),
      education: (json['education'] as List<dynamic>?)
          ?.map((e) => Education.fromJson(e as Map<String, dynamic>))
          .toList(),
      experience: (json['experience'] as List<dynamic>?)
          ?.map((e) => Experience.fromJson(e as Map<String, dynamic>))
          .toList(),
      skills: (json['skills'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CVParsedResponseToJson(_CVParsedResponse instance) =>
    <String, dynamic>{
      'personalInfo': instance.personalInfo,
      'education': instance.education,
      'experience': instance.experience,
      'skills': instance.skills,
    };

_PersonalInfo _$PersonalInfoFromJson(Map<String, dynamic> json) =>
    _PersonalInfo(
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$PersonalInfoToJson(_PersonalInfo instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
    };

_Education _$EducationFromJson(Map<String, dynamic> json) => _Education(
  degree: json['degree'] as String?,
  institution: json['institution'] as String?,
  year: json['year'] as String?,
);

Map<String, dynamic> _$EducationToJson(_Education instance) =>
    <String, dynamic>{
      'degree': instance.degree,
      'institution': instance.institution,
      'year': instance.year,
    };

_Experience _$ExperienceFromJson(Map<String, dynamic> json) => _Experience(
  jobTitle: json['jobTitle'] as String?,
  company: json['company'] as String?,
  startDate: json['startDate'] as String?,
  endDate: json['endDate'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$ExperienceToJson(_Experience instance) =>
    <String, dynamic>{
      'jobTitle': instance.jobTitle,
      'company': instance.company,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'description': instance.description,
    };

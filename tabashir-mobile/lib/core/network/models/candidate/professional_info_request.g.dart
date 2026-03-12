// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'professional_info_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfessionalInfoRequest _$ProfessionalInfoRequestFromJson(
  Map<String, dynamic> json,
) => _ProfessionalInfoRequest(
  summary: json['summary'] as String,
  jobType: json['jobType'] as String?,
  experience: json['experience'] as String?,
  education: json['education'] as String?,
  degree: json['degree'] as String?,
  employmentHistory: (json['employmentHistory'] as List<dynamic>?)
      ?.map((e) => EmploymentHistoryItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  educationList: (json['educationList'] as List<dynamic>?)
      ?.map((e) => EducationItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  skills: (json['skills'] as List<dynamic>?)
      ?.map((e) => SkillItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  languages: (json['languages'] as List<dynamic>?)
      ?.map((e) => LanguageItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ProfessionalInfoRequestToJson(
  _ProfessionalInfoRequest instance,
) => <String, dynamic>{
  'summary': instance.summary,
  'jobType': instance.jobType,
  'experience': instance.experience,
  'education': instance.education,
  'degree': instance.degree,
  'employmentHistory': instance.employmentHistory,
  'educationList': instance.educationList,
  'skills': instance.skills,
  'languages': instance.languages,
};

_EmploymentHistoryItem _$EmploymentHistoryItemFromJson(
  Map<String, dynamic> json,
) => _EmploymentHistoryItem(
  company: json['company'] as String?,
  position: json['position'] as String?,
  startDate: json['startDate'] as String?,
  endDate: json['endDate'] as String?,
  country: json['country'] as String?,
  city: json['city'] as String?,
  current: json['current'] as bool?,
  description: json['description'] as String?,
  achievements: (json['achievements'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$EmploymentHistoryItemToJson(
  _EmploymentHistoryItem instance,
) => <String, dynamic>{
  'company': instance.company,
  'position': instance.position,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'country': instance.country,
  'city': instance.city,
  'current': instance.current,
  'description': instance.description,
  'achievements': instance.achievements,
};

_EducationItem _$EducationItemFromJson(Map<String, dynamic> json) =>
    _EducationItem(
      institution: json['institution'] as String?,
      degree: json['degree'] as String?,
      field: json['field'] as String?,
      city: json['city'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      current: json['current'] as bool?,
      gpa: (json['gpa'] as num?)?.toDouble(),
      achievements: (json['achievements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$EducationItemToJson(_EducationItem instance) =>
    <String, dynamic>{
      'institution': instance.institution,
      'degree': instance.degree,
      'field': instance.field,
      'city': instance.city,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'current': instance.current,
      'gpa': instance.gpa,
      'achievements': instance.achievements,
    };

_SkillItem _$SkillItemFromJson(Map<String, dynamic> json) => _SkillItem(
  category: json['category'] as String,
  name: json['name'] as String,
  level: json['level'] as String?,
);

Map<String, dynamic> _$SkillItemToJson(_SkillItem instance) =>
    <String, dynamic>{
      'category': instance.category,
      'name': instance.name,
      'level': instance.level,
    };

_LanguageItem _$LanguageItemFromJson(Map<String, dynamic> json) =>
    _LanguageItem(
      name: json['name'] as String,
      proficiency: json['proficiency'] as String,
    );

Map<String, dynamic> _$LanguageItemToJson(_LanguageItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'proficiency': instance.proficiency,
    };

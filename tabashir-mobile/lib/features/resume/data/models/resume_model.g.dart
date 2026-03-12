// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Resume _$ResumeFromJson(Map<String, dynamic> json) => _Resume(
  id: json['id'] as String,
  userId: json['userId'] as String,
  title: json['title'] as String,
  fullName: json['fullName'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String?,
  summary: json['summary'] as String?,
  experience:
      (json['experience'] as List<dynamic>?)
          ?.map((e) => WorkExperience.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  education:
      (json['education'] as List<dynamic>?)
          ?.map((e) => Education.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  skills:
      (json['skills'] as List<dynamic>?)
          ?.map((e) => Skill.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  certifications:
      (json['certifications'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  languages:
      (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  profileImageUrl: json['profileImageUrl'] as String?,
  status:
      $enumDecodeNullable(_$ResumeStatusEnumMap, json['status']) ??
      ResumeStatus.draft,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ResumeToJson(_Resume instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'title': instance.title,
  'fullName': instance.fullName,
  'email': instance.email,
  'phone': instance.phone,
  'summary': instance.summary,
  'experience': instance.experience,
  'education': instance.education,
  'skills': instance.skills,
  'certifications': instance.certifications,
  'languages': instance.languages,
  'profileImageUrl': instance.profileImageUrl,
  'status': _$ResumeStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$ResumeStatusEnumMap = {
  ResumeStatus.draft: 'draft',
  ResumeStatus.active: 'active',
  ResumeStatus.archived: 'archived',
};

_WorkExperience _$WorkExperienceFromJson(Map<String, dynamic> json) =>
    _WorkExperience(
      company: json['company'] as String,
      position: json['position'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isCurrent: json['isCurrent'] as bool? ?? false,
      description: json['description'] as String?,
      location: json['location'] as String?,
    );

Map<String, dynamic> _$WorkExperienceToJson(_WorkExperience instance) =>
    <String, dynamic>{
      'company': instance.company,
      'position': instance.position,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'isCurrent': instance.isCurrent,
      'description': instance.description,
      'location': instance.location,
    };

_Education _$EducationFromJson(Map<String, dynamic> json) => _Education(
  institution: json['institution'] as String,
  degree: json['degree'] as String,
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  fieldOfStudy: json['fieldOfStudy'] as String?,
  gpa: json['gpa'] as String?,
);

Map<String, dynamic> _$EducationToJson(_Education instance) =>
    <String, dynamic>{
      'institution': instance.institution,
      'degree': instance.degree,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'fieldOfStudy': instance.fieldOfStudy,
      'gpa': instance.gpa,
    };

_Skill _$SkillFromJson(Map<String, dynamic> json) => _Skill(
  name: json['name'] as String,
  level: $enumDecode(_$SkillLevelEnumMap, json['level']),
  category: json['category'] as String,
);

Map<String, dynamic> _$SkillToJson(_Skill instance) => <String, dynamic>{
  'name': instance.name,
  'level': _$SkillLevelEnumMap[instance.level]!,
  'category': instance.category,
};

const _$SkillLevelEnumMap = {
  SkillLevel.beginner: 'beginner',
  SkillLevel.intermediate: 'intermediate',
  SkillLevel.advanced: 'advanced',
  SkillLevel.expert: 'expert',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompanyProfile _$CompanyProfileFromJson(Map<String, dynamic> json) =>
    _CompanyProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      industry: json['industry'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      website: json['website'] as String?,
      logoUrl: json['logoUrl'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      size:
          $enumDecodeNullable(_$CompanySizeEnumMap, json['size']) ??
          CompanySize.small,
      type:
          $enumDecodeNullable(_$CompanyTypeEnumMap, json['type']) ??
          CompanyType.private,
      foundedYear: (json['foundedYear'] as num?)?.toInt(),
      specializations:
          (json['specializations'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      benefits:
          (json['benefits'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      employeeCount: (json['employeeCount'] as num?)?.toInt(),
      rating:
          $enumDecodeNullable(_$CompanyRatingEnumMap, json['rating']) ??
          CompanyRating.one,
      postedJobs:
          (json['postedJobs'] as List<dynamic>?)
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

Map<String, dynamic> _$CompanyProfileToJson(_CompanyProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'industry': instance.industry,
      'description': instance.description,
      'location': instance.location,
      'website': instance.website,
      'logoUrl': instance.logoUrl,
      'coverImageUrl': instance.coverImageUrl,
      'size': _$CompanySizeEnumMap[instance.size]!,
      'type': _$CompanyTypeEnumMap[instance.type]!,
      'foundedYear': instance.foundedYear,
      'specializations': instance.specializations,
      'benefits': instance.benefits,
      'employeeCount': instance.employeeCount,
      'rating': _$CompanyRatingEnumMap[instance.rating]!,
      'postedJobs': instance.postedJobs,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$CompanySizeEnumMap = {
  CompanySize.startup: 'startup',
  CompanySize.small: 'small',
  CompanySize.medium: 'medium',
  CompanySize.large: 'large',
  CompanySize.enterprise: 'enterprise',
};

const _$CompanyTypeEnumMap = {
  CompanyType.private: 'private',
  CompanyType.public: 'public',
  CompanyType.nonprofit: 'nonprofit',
  CompanyType.government: 'government',
  CompanyType.partnership: 'partnership',
};

const _$CompanyRatingEnumMap = {
  CompanyRating.one: 'one',
  CompanyRating.two: 'two',
  CompanyRating.three: 'three',
  CompanyRating.four: 'four',
  CompanyRating.five: 'five',
};

_CompanyReview _$CompanyReviewFromJson(Map<String, dynamic> json) =>
    _CompanyReview(
      id: json['id'] as String,
      companyId: json['companyId'] as String,
      reviewerName: json['reviewerName'] as String,
      reviewerEmail: json['reviewerEmail'] as String,
      overallRating: $enumDecode(_$CompanyRatingEnumMap, json['overallRating']),
      cultureRating: $enumDecode(_$CompanyRatingEnumMap, json['cultureRating']),
      salaryRating: $enumDecode(_$CompanyRatingEnumMap, json['salaryRating']),
      workLifeBalanceRating: $enumDecode(
        _$CompanyRatingEnumMap,
        json['workLifeBalanceRating'],
      ),
      title: json['title'] as String,
      content: json['content'] as String,
      status:
          $enumDecodeNullable(_$ReviewStatusEnumMap, json['status']) ??
          ReviewStatus.pending,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CompanyReviewToJson(_CompanyReview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'reviewerName': instance.reviewerName,
      'reviewerEmail': instance.reviewerEmail,
      'overallRating': _$CompanyRatingEnumMap[instance.overallRating]!,
      'cultureRating': _$CompanyRatingEnumMap[instance.cultureRating]!,
      'salaryRating': _$CompanyRatingEnumMap[instance.salaryRating]!,
      'workLifeBalanceRating':
          _$CompanyRatingEnumMap[instance.workLifeBalanceRating]!,
      'title': instance.title,
      'content': instance.content,
      'status': _$ReviewStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$ReviewStatusEnumMap = {
  ReviewStatus.pending: 'pending',
  ReviewStatus.approved: 'approved',
  ReviewStatus.rejected: 'rejected',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompanyState _$CompanyStateFromJson(Map<String, dynamic> json) =>
    _CompanyState(
      status:
          $enumDecodeNullable(_$CompanyStatusEnumMap, json['status']) ??
          CompanyStatus.initial,
      errorMessage: json['errorMessage'] as String? ?? '',
      companies:
          (json['companies'] as List<dynamic>?)
              ?.map((e) => CompanyProfile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      currentCompany: json['currentCompany'] == null
          ? null
          : CompanyProfile.fromJson(
              json['currentCompany'] as Map<String, dynamic>,
            ),
      reviews:
          (json['reviews'] as List<dynamic>?)
              ?.map((e) => CompanyReview.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CompanyStateToJson(_CompanyState instance) =>
    <String, dynamic>{
      'status': _$CompanyStatusEnumMap[instance.status]!,
      'errorMessage': instance.errorMessage,
      'companies': instance.companies,
      'currentCompany': instance.currentCompany,
      'reviews': instance.reviews,
    };

const _$CompanyStatusEnumMap = {
  CompanyStatus.initial: 'initial',
  CompanyStatus.loading: 'loading',
  CompanyStatus.loaded: 'loaded',
  CompanyStatus.error: 'error',
};

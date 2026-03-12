// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OnboardingState _$OnboardingStateFromJson(Map<String, dynamic> json) =>
    _OnboardingState(
      status:
          $enumDecodeNullable(_$OnboardingStatusEnumMap, json['status']) ??
          OnboardingStatus.initial,
      errorMessage: json['errorMessage'] as String? ?? '',
      pages:
          (json['pages'] as List<dynamic>?)
              ?.map(
                (e) => OnboardingPageModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      currentPageIndex: (json['currentPageIndex'] as num?)?.toInt() ?? 0,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$OnboardingStateToJson(_OnboardingState instance) =>
    <String, dynamic>{
      'status': _$OnboardingStatusEnumMap[instance.status]!,
      'errorMessage': instance.errorMessage,
      'pages': instance.pages,
      'currentPageIndex': instance.currentPageIndex,
      'isCompleted': instance.isCompleted,
    };

const _$OnboardingStatusEnumMap = {
  OnboardingStatus.initial: 'initial',
  OnboardingStatus.loading: 'loading',
  OnboardingStatus.loaded: 'loaded',
  OnboardingStatus.error: 'error',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionState _$SubscriptionStateFromJson(Map<String, dynamic> json) =>
    _SubscriptionState(
      status:
          $enumDecodeNullable(_$SubscriptionStatusEnumMap, json['status']) ??
          SubscriptionStatus.initial,
      errorMessage: json['errorMessage'] as String? ?? '',
      subscription: json['subscription'] == null
          ? null
          : SubscriptionResponse.fromJson(
              json['subscription'] as Map<String, dynamic>,
            ),
      debugData: json['debugData'] == null
          ? null
          : SubscriptionDebugResponse.fromJson(
              json['debugData'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$SubscriptionStateToJson(_SubscriptionState instance) =>
    <String, dynamic>{
      'status': _$SubscriptionStatusEnumMap[instance.status]!,
      'errorMessage': instance.errorMessage,
      'subscription': instance.subscription,
      'debugData': instance.debugData,
    };

const _$SubscriptionStatusEnumMap = {
  SubscriptionStatus.initial: 'initial',
  SubscriptionStatus.loading: 'loading',
  SubscriptionStatus.loaded: 'loaded',
  SubscriptionStatus.testSuccess: 'testSuccess',
  SubscriptionStatus.debugSuccess: 'debugSuccess',
  SubscriptionStatus.error: 'error',
};

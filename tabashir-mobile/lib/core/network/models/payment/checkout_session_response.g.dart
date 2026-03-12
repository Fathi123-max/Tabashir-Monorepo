// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_session_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CheckoutSessionResponse _$CheckoutSessionResponseFromJson(
  Map<String, dynamic> json,
) => _CheckoutSessionResponse(
  success: json['success'] as bool,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : CheckoutSessionData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CheckoutSessionResponseToJson(
  _CheckoutSessionResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

_CheckoutSessionData _$CheckoutSessionDataFromJson(Map<String, dynamic> json) =>
    _CheckoutSessionData(
      sessionId: json['sessionId'] as String?,
      url: json['url'] as String?,
      paymentIntentId: json['paymentIntentId'] as String?,
    );

Map<String, dynamic> _$CheckoutSessionDataToJson(
  _CheckoutSessionData instance,
) => <String, dynamic>{
  'sessionId': instance.sessionId,
  'url': instance.url,
  'paymentIntentId': instance.paymentIntentId,
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentState _$PaymentStateFromJson(Map<String, dynamic> json) =>
    _PaymentState(
      status:
          $enumDecodeNullable(_$PaymentStatusEnumMap, json['status']) ??
          PaymentStatus.initial,
      errorMessage: json['errorMessage'] as String? ?? '',
      paymentIntent: json['paymentIntent'] == null
          ? null
          : PaymentIntentResponse.fromJson(
              json['paymentIntent'] as Map<String, dynamic>,
            ),
      checkoutSession: json['checkoutSession'] == null
          ? null
          : CheckoutSessionResponse.fromJson(
              json['checkoutSession'] as Map<String, dynamic>,
            ),
      latestPayment: json['latestPayment'] == null
          ? null
          : LatestPaymentResponse.fromJson(
              json['latestPayment'] as Map<String, dynamic>,
            ),
      paymentSheetInitialized:
          json['paymentSheetInitialized'] as bool? ?? false,
      paymentSuccessful: json['paymentSuccessful'] as bool? ?? false,
    );

Map<String, dynamic> _$PaymentStateToJson(_PaymentState instance) =>
    <String, dynamic>{
      'status': _$PaymentStatusEnumMap[instance.status]!,
      'errorMessage': instance.errorMessage,
      'paymentIntent': instance.paymentIntent,
      'checkoutSession': instance.checkoutSession,
      'latestPayment': instance.latestPayment,
      'paymentSheetInitialized': instance.paymentSheetInitialized,
      'paymentSuccessful': instance.paymentSuccessful,
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.initial: 'initial',
  PaymentStatus.loading: 'loading',
  PaymentStatus.processing: 'processing',
  PaymentStatus.success: 'success',
  PaymentStatus.failed: 'failed',
  PaymentStatus.canceled: 'canceled',
  PaymentStatus.requiresAction: 'requiresAction',
};

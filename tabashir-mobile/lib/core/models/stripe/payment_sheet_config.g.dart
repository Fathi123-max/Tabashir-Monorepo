// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_sheet_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentSheetConfig _$PaymentSheetConfigFromJson(Map<String, dynamic> json) =>
    _PaymentSheetConfig(
      paymentIntentClientSecret: json['paymentIntentClientSecret'] as String,
      customerId: json['customerId'] as String,
      merchantDisplayName: json['merchantDisplayName'] as String,
      customerEphemeralKeySecret: json['customerEphemeralKeySecret'] as String?,
      allowsDelayedPaymentMethods:
          json['allowsDelayedPaymentMethods'] as bool? ?? false,
      defaultCountry: json['defaultCountry'] as String?,
      headers:
          (json['headers'] as List<dynamic>?)
              ?.map(
                (e) => PaymentSheetHeader.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PaymentSheetConfigToJson(_PaymentSheetConfig instance) =>
    <String, dynamic>{
      'paymentIntentClientSecret': instance.paymentIntentClientSecret,
      'customerId': instance.customerId,
      'merchantDisplayName': instance.merchantDisplayName,
      'customerEphemeralKeySecret': instance.customerEphemeralKeySecret,
      'allowsDelayedPaymentMethods': instance.allowsDelayedPaymentMethods,
      'defaultCountry': instance.defaultCountry,
      'headers': instance.headers,
    };

_PaymentSheetHeader _$PaymentSheetHeaderFromJson(Map<String, dynamic> json) =>
    _PaymentSheetHeader(
      text: json['text'] as String,
      expandable: json['expandable'] as bool? ?? false,
    );

Map<String, dynamic> _$PaymentSheetHeaderToJson(_PaymentSheetHeader instance) =>
    <String, dynamic>{'text': instance.text, 'expandable': instance.expandable};

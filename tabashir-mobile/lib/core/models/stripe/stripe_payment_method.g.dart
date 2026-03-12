// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stripe_payment_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StripePaymentMethod _$StripePaymentMethodFromJson(Map<String, dynamic> json) =>
    _StripePaymentMethod(
      id: json['id'] as String,
      type: json['type'] as String,
      card: json['card'] == null
          ? null
          : CardDetails.fromJson(json['card'] as Map<String, dynamic>),
      isDefault: json['isDefault'] as bool,
      billingDetails: json['billingDetails'] == null
          ? null
          : BillingDetails.fromJson(
              json['billingDetails'] as Map<String, dynamic>,
            ),
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
    );

Map<String, dynamic> _$StripePaymentMethodToJson(
  _StripePaymentMethod instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'card': instance.card,
  'isDefault': instance.isDefault,
  'billingDetails': instance.billingDetails,
  'created': instance.created?.toIso8601String(),
};

_CardDetails _$CardDetailsFromJson(Map<String, dynamic> json) => _CardDetails(
  brand: json['brand'] as String,
  expMonth: (json['expMonth'] as num).toInt(),
  expYear: (json['expYear'] as num).toInt(),
  last4: json['last4'] as String?,
  fingerprint: json['fingerprint'] as String?,
);

Map<String, dynamic> _$CardDetailsToJson(_CardDetails instance) =>
    <String, dynamic>{
      'brand': instance.brand,
      'expMonth': instance.expMonth,
      'expYear': instance.expYear,
      'last4': instance.last4,
      'fingerprint': instance.fingerprint,
    };

_BillingDetails _$BillingDetailsFromJson(Map<String, dynamic> json) =>
    _BillingDetails(
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BillingDetailsToJson(_BillingDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
    };

_Address _$AddressFromJson(Map<String, dynamic> json) => _Address(
  line1: json['line1'] as String?,
  line2: json['line2'] as String?,
  city: json['city'] as String?,
  state: json['state'] as String?,
  postalCode: json['postalCode'] as String?,
  country: json['country'] as String?,
);

Map<String, dynamic> _$AddressToJson(_Address instance) => <String, dynamic>{
  'line1': instance.line1,
  'line2': instance.line2,
  'city': instance.city,
  'state': instance.state,
  'postalCode': instance.postalCode,
  'country': instance.country,
};

import 'package:freezed_annotation/freezed_annotation.dart';

part 'stripe_payment_method.freezed.dart';
part 'stripe_payment_method.g.dart';

/// Stripe payment method model
@freezed
sealed class StripePaymentMethod with _$StripePaymentMethod {
  const factory StripePaymentMethod({
    required String id,
    required String type,
    required CardDetails? card,
    required bool isDefault,
    BillingDetails? billingDetails,
    DateTime? created,
  }) = _StripePaymentMethod;

  factory StripePaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$StripePaymentMethodFromJson(json);
}

/// Card details from Stripe
@freezed
sealed class CardDetails with _$CardDetails {
  const factory CardDetails({
    required String brand,
    required int expMonth,
    required int expYear,
    String? last4,
    String? fingerprint,
  }) = _CardDetails;

  factory CardDetails.fromJson(Map<String, dynamic> json) =>
      _$CardDetailsFromJson(json);
}

/// Billing details for payment
@freezed
sealed class BillingDetails with _$BillingDetails {
  const factory BillingDetails({
    String? name,
    String? email,
    String? phone,
    Address? address,
  }) = _BillingDetails;

  factory BillingDetails.fromJson(Map<String, dynamic> json) =>
      _$BillingDetailsFromJson(json);
}

/// Address for billing details
@freezed
sealed class Address with _$Address {
  const factory Address({
    String? line1,
    String? line2,
    String? city,
    String? state,
    String? postalCode,
    String? country,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

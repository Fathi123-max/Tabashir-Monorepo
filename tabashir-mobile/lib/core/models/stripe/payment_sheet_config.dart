import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_sheet_config.freezed.dart';
part 'payment_sheet_config.g.dart';

/// Configuration for Stripe Payment Sheet
@freezed
sealed class PaymentSheetConfig with _$PaymentSheetConfig {
  const factory PaymentSheetConfig({
    required String paymentIntentClientSecret,
    required String customerId,
    required String merchantDisplayName,
    String? customerEphemeralKeySecret,
    @Default(false) bool allowsDelayedPaymentMethods,
    String? defaultCountry,
    @Default([]) List<PaymentSheetHeader> headers,
  }) = _PaymentSheetConfig;

  factory PaymentSheetConfig.fromJson(Map<String, dynamic> json) =>
      _$PaymentSheetConfigFromJson(json);
}

/// Header for payment sheet
@freezed
sealed class PaymentSheetHeader with _$PaymentSheetHeader {
  const factory PaymentSheetHeader({
    required String text,
    @Default(false) bool expandable,
  }) = _PaymentSheetHeader;

  factory PaymentSheetHeader.fromJson(Map<String, dynamic> json) =>
      _$PaymentSheetHeaderFromJson(json);
}

/// Payment method types
enum PaymentMethodType {
  card('card'),
  applePay('apple_pay'),
  googlePay('google_pay'),
  bankTransfer('bank_transfer'),
  ideal('ideal'),
  sofort('sofort'),
  usBankAccount('us_bank_account');

  const PaymentMethodType(this.value);
  final String value;
}

/// Payment status enum
enum PaymentStatus {
  initial,
  loading,
  processing,
  success,
  failed,
  canceled,
  requiresAction,
}

/// Card brands
enum CardBrand {
  visa('visa'),
  mastercard('mastercard'),
  amex('american_express'),
  discover('discover'),
  jcb('jcb'),
  dinersClub('diners_club'),
  unknown('unknown');

  const CardBrand(this.value);
  final String value;

  static CardBrand fromString(String brand) => CardBrand.values.firstWhere(
    (b) => b.value == brand.toLowerCase(),
    orElse: () => CardBrand.unknown,
  );
}

/// Payment sheet result status
enum PaymentSheetResultStatus { success, canceled, failed }

/// Payment intent statuses
enum PaymentIntentStatus {
  requiresPaymentMethod,
  requiresConfirmation,
  requiresAction,
  processing,
  requiresCapture,
  canceled,
  succeeded;

  static PaymentIntentStatus fromString(String status) =>
      PaymentIntentStatus.values.firstWhere(
        (s) => s.name == status,
        orElse: () => PaymentIntentStatus.requiresPaymentMethod,
      );
}

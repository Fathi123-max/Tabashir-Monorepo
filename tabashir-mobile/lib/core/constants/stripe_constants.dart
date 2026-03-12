/// Stripe payment configuration constants
/// Contains keys, environment settings, and configuration for Stripe integration
class StripeConstants {
  StripeConstants._();

  /// Publishable keys (safe to include in client-side code)
  /// Replace with your actual Stripe publishable keys
  static const String publishableKeyTest =
      'pk_test_51234567890abcdef...'; // Test mode key
  static const String publishableKeyLive =
      'pk_live_51234567890abcdef...'; // Production key

  /// Secret keys (NEVER include in client-side code)
  /// These should only be used in your backend
  static const String secretKeyTest = 'sk_test_51234567890abcdef...';
  static const String secretKeyLive = 'sk_live_51234567890abcdef...';

  /// Determines which environment to use
  /// Set to true for test mode, false for production
  static const bool isTestMode = true;

  /// Get appropriate publishable key based on environment
  static String get publishableKey =>
      isTestMode ? publishableKeyTest : publishableKeyLive;

  /// Stripe-supported currencies
  static const String defaultCurrency = 'usd';
  static const List<String> supportedCurrencies = [
    'usd',
    'eur',
    'gbp',
    'cad',
    'aud',
  ];

  /// Payment method types
  static const String paymentMethodTypeCard = 'card';
  static const String paymentMethodTypeApplePay = 'apple_pay';
  static const String paymentMethodTypeGooglePay = 'google_pay';

  /// Appearance configuration for Payment Sheet
  static const Map<String, dynamic> appearanceConfig = {
    'primary': {
      'color': '#0D56E1', // Primary blue color from app theme
    },
    'backgroundColor': '#FFFFFF',
    'cancelButtonColor': '#34D399', // Accent green from app theme
    'default/applePay': {
      'text': 'default',
      'color': '#0D56E1',
    },
    'errorColor': '#FF0000',
    'fontFamily': 'Roboto',
  };

  /// Webhook endpoints
  /// Your backend should handle these webhook events:
  /// - payment_intent.succeeded
  /// - payment_intent.payment_failed
  /// - checkout.session.completed
  static const String webhookEndpoint = '/api/stripe/webhook';

  /// API versions
  static const String apiVersion = '2024-06-20';

  /// Default payment values
  static const int defaultTimeout = 30000; // 30 seconds
  static const int confirmTimeout = 60000; // 60 seconds

  /// Locale for Stripe
  /// Use system locale or specific locale like 'en'
  static const String defaultLocale = 'en';

  /// Maximum allowed payment amount in cents
  /// For most use cases, this is $999,999.99
  static const int maxAmount = 99999999;

  /// Minimum allowed payment amount in cents
  /// Stripe requires at least $0.50 for most cards
  static const int minAmount = 50;
}

/// Stripe webhook event types
class StripeWebhookEvents {
  StripeWebhookEvents._();

  static const String paymentIntentSucceeded = 'payment_intent.succeeded';
  static const String paymentIntentPaymentFailed =
      'payment_intent.payment_failed';
  static const String paymentIntentProcessing = 'payment_intent.processing';
  static const String paymentIntentRequiresAction =
      'payment_intent.requires_action';
  static const String checkoutSessionCompleted = 'checkout.session.completed';
  static const String customerSubscriptionCreated =
      'customer.subscription.created';
  static const String customerSubscriptionUpdated =
      'customer.subscription.updated';
  static const String customerSubscriptionDeleted =
      'customer.subscription.deleted';
}

/// Stripe error codes
class StripeErrorCodes {
  StripeErrorCodes._();

  static const String cardDeclined = 'card_declined';
  static const String expiredCard = 'expired_card';
  static const String incorrectCvc = 'incorrect_cvc';
  static const String insufficientFunds = 'insufficient_funds';
  static const String invalidExpiryMonth = 'invalid_expiry_month';
  static const String invalidExpiryYear = 'invalid_expiry_year';
  static const String invalidNumber = 'invalid_number';
  static const String processingError = 'processing_error';
  static const String rateLimit = 'rate_limit';
}

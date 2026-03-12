import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/payment/payment_intent_request.dart';
import '../../models/payment/payment_intent_response.dart';
import '../../models/payment/checkout_session_request.dart';
import '../../models/payment/checkout_session_response.dart';
import '../../models/payment/latest_payment_response.dart';

part 'payment_api_service.g.dart';

/// Payment API client
@RestApi(baseUrl: '/api/v1/mobile')
abstract class PaymentApiService {
  factory PaymentApiService(Dio dio) = _PaymentApiService;

  /// Create payment intent
  @POST('/payment-intent')
  Future<HttpResponse<PaymentIntentResponse>> createPaymentIntent(
    @Body() PaymentIntentRequest request,
  );

  /// Create Stripe checkout session
  @POST('/stripe/create-checkout-session')
  Future<HttpResponse<CheckoutSessionResponse>> createCheckoutSession(
    @Body() CheckoutSessionRequest request,
  );

  /// Get latest payment info
  @GET('/payments/latest')
  Future<HttpResponse<LatestPaymentResponse>> getLatestPayment();
}

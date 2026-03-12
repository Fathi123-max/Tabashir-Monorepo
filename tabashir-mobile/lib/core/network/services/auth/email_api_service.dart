import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/auth/email_verification_request.dart';
import '../../models/auth/email_verification_response.dart';

part 'email_api_service.g.dart';

/// Email API client
@RestApi(baseUrl: '/api/v1/auth')
abstract class EmailApiService {
  factory EmailApiService(Dio dio) = _EmailApiService;

  /// Verify email
  @GET('/verify-email')
  Future<HttpResponse<EmailVerificationResponse>> verifyEmail(
    @Query('email') String email,
    @Query('token') String? token,
  );

  /// Send verification email
  @POST('/verify-email')
  Future<HttpResponse<EmailVerificationResponse>> sendVerificationEmail(
    @Body() EmailVerificationRequest request,
  );
}

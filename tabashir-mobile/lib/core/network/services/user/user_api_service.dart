import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter/foundation.dart';

import '../../models/user/user_profile_response.dart';
import '../../models/candidate/personal_info_request.dart';
import '../../models/candidate/professional_info_request.dart';
import '../../models/candidate/onboarding_response.dart';
import '../../models/profile/profile_update_request.dart';
import '../../models/profile/profile_update_response.dart';

part 'user_api_service.g.dart';

/// User management API client
@RestApi(baseUrl: '/api/v1')
abstract class UserApiService {
  factory UserApiService(Dio dio) = _UserApiService;

  /// Get comprehensive user profile data from unified API
  @GET('/users/me')
  Future<HttpResponse<UserProfileResponse>> getUserProfile();

  /// Update user profile (name, email, phone, etc.)
  @PUT('/users/profile')
  Future<HttpResponse<ProfileUpdateResponse>> updateProfile(
    @Body() ProfileUpdateRequest profileUpdate,
  );

  /// Update candidate personal info
  @POST('/candidates/onboarding/personal-info')
  Future<HttpResponse<OnboardingResponse>> updatePersonalInfo(
    @Body() PersonalInfoRequest personalInfo,
  );

  /// Update candidate professional info
  @POST('/candidates/onboarding/professional-info')
  Future<HttpResponse<OnboardingResponse>> updateProfessionalInfo(
    @Body() ProfessionalInfoRequest professionalInfo,
  );
}

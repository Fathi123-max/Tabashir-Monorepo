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
@RestApi(baseUrl: 'http://localhost:5001/api')
abstract class UserApiService {
  factory UserApiService(Dio dio) = _UserApiService;

  /// Get comprehensive user profile data from mobile API
  @GET('/mobile/me')
  Future<HttpResponse<UserProfileResponse>> getUserProfile();

  /// Update user profile (name, email, phone, etc.)
  @PUT('/mobile/profile')
  Future<HttpResponse<ProfileUpdateResponse>> updateProfile(
    @Body() ProfileUpdateRequest profileUpdate,
  );

  /// Update candidate personal info
  @POST('/candidate/onboarding/personal-info')
  Future<HttpResponse<OnboardingResponse>> updatePersonalInfo(
    @Body() PersonalInfoRequest personalInfo,
  );

  /// Update candidate professional info
  @POST('/mobile/candidate/onboarding/professional-info')
  Future<HttpResponse<OnboardingResponse>> updateProfessionalInfo(
    @Body() ProfessionalInfoRequest professionalInfo,
  );
}

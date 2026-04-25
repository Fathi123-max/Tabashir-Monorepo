import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/database/models/local_profile.dart';
import 'package:tabashir/core/database/repositories/local_profile_repository.dart';
import 'package:tabashir/core/network/models/user/user_profile_response.dart';
import 'package:tabashir/core/network/models/candidate/personal_info_request.dart';
import 'package:tabashir/core/network/models/candidate/professional_info_request.dart';
import 'package:tabashir/core/network/models/candidate/onboarding_response.dart';
import 'package:tabashir/core/network/models/profile/profile_update_request.dart';
import 'package:tabashir/core/network/models/job/ai_client_response.dart';
import 'package:tabashir/core/network/services/job/tabashir_api_service.dart';
import 'package:tabashir/core/network/services/user/user_api_service.dart';
import 'package:tabashir/core/network/services/auth/auth_api_service.dart';
import 'package:tabashir/features/profile/domain/repositories/profile_repository.dart';
import 'package:tabashir/core/utils/app_logger.dart';

/// Implementation of [ProfileRepository]
/// Handles profile operations using [UserApiService] with local caching
@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(
    this._userApiService,
    this._authApiService,
    this._localProfileRepository,
    this._tabashirApiService,
  );

  final UserApiService _userApiService;
  final AuthApiService _authApiService;
  final LocalProfileRepository _localProfileRepository;
  final TabashirApiService _tabashirApiService;

  @override
  Future<UserProfileResponse> getUserProfile() async {
    AppLogger.debug('\n\n########## [PROFILE_REPO] GET USER PROFILE CALLED ##########', tag: 'Profile');
    try {
      // Try to load from cache first for better UX
      AppLogger.debug('[PROFILE_REPO] Checking local cache...', tag: 'Profile');
      final cachedProfile = await _localProfileRepository.getLatestProfile();
      if (cachedProfile != null) {
        AppLogger.debug('[PROFILE_REPO] ✅ Found cached profile', tag: 'Profile');
      } else {
        AppLogger.debug('[PROFILE_REPO] No cached profile found', tag: 'Profile');
      }

      // Fetch from API
      AppLogger.debug('[PROFILE_REPO] Calling UserApiService.getUserProfile()...', tag: 'Profile');
      AppLogger.debug('[PROFILE_REPO] Using comprehensive unified API: /api/v1/users/me', tag: 'Profile');
      final response = await _userApiService.getUserProfile();

      AppLogger.debug('\n[PROFILE_REPO] ✅ API call completed', tag: 'Profile');
      AppLogger.debug('[PROFILE_REPO] Response status: ${response.response.statusCode}', tag: 'Profile');

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        AppLogger.debug('[PROFILE_REPO] ✅ Comprehensive profile loaded successfully', tag: 'Profile');
        AppLogger.debug('[PROFILE_REPO] User data: ${response.data.user.name}', tag: 'Profile');
        AppLogger.debug('[PROFILE_REPO] User type: ${response.data.user.userType}', tag: 'Profile');
        AppLogger.debug('[PROFILE_REPO] Total resumes: ${response.data.counts?.totalResumes ?? 0}', tag: 'Profile');
        AppLogger.debug('[PROFILE_REPO] Has subscription: ${response.data.subscription != null}', tag: 'Profile');
        AppLogger.debug('[PROFILE_REPO] Admin permissions: ${response.data.adminPermissions.length}', tag: 'Profile');

        // Save to local cache
        AppLogger.debug('[PROFILE_REPO] Saving profile to local cache...', tag: 'Profile');
        await _saveToLocal(response.data);
        AppLogger.debug('[PROFILE_REPO] ✅ Profile saved to cache', tag: 'Profile');

        AppLogger.debug('########## [PROFILE_REPO] SUCCESS ##########\n\n', tag: 'Profile');
        return response.data;
      } else {
        AppLogger.error('[PROFILE_REPO] ❌ API returned error status: ${response.response.statusCode}', tag: 'Profile');

        // If API fails but we have cache, return cache
        if (cachedProfile != null) {
          AppLogger.error('[PROFILE_REPO] Using cached profile due to API error', tag: 'Profile');
          AppLogger.debug('########## [PROFILE_REPO] SUCCESS (CACHE) ##########\n\n', tag: 'Profile');
          return _convertFromLocal(cachedProfile);
        }

        throw Exception(
          'Failed to get user profile with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      AppLogger.error('\n[PROFILE_REPO] ❌ DioException occurred', tag: 'Profile');
      AppLogger.debug('[PROFILE_REPO] Type: ${e.type}', tag: 'Profile');
      AppLogger.debug('[PROFILE_REPO] Message: ${e.message}', tag: 'Profile');
      if (e.response != null) {
        AppLogger.debug('[PROFILE_REPO] Response status: ${e.response?.statusCode}', tag: 'Profile');
        AppLogger.debug('[PROFILE_REPO] Response data: ${e.response?.data}', tag: 'Profile');
      }

      // Try to return cached profile on error
      final cachedProfile = await _localProfileRepository.getLatestProfile();
      if (cachedProfile != null) {
        AppLogger.error('[PROFILE_REPO] Returning cached profile due to error', tag: 'Profile');
        AppLogger.debug('########## [PROFILE_REPO] SUCCESS (CACHE) ##########\n\n', tag: 'Profile');
        return _convertFromLocal(cachedProfile);
      }

      AppLogger.error('########## [PROFILE_REPO] FAILED ##########\n\n', tag: 'Profile');
      throw _handleDioError(e);
    } catch (e) {
      AppLogger.error('\n[PROFILE_REPO] ❌ Unexpected exception: $e', tag: 'Profile', error: e);

      // Try to return cached profile on error
      final cachedProfile = await _localProfileRepository.getLatestProfile();
      if (cachedProfile != null) {
        AppLogger.error('[PROFILE_REPO] Returning cached profile due to error', tag: 'Profile');
        AppLogger.debug('########## [PROFILE_REPO] SUCCESS (CACHE) ##########\n\n', tag: 'Profile');
        return _convertFromLocal(cachedProfile);
      }

      AppLogger.error('########## [PROFILE_REPO] FAILED ##########\n\n', tag: 'Profile');
      throw Exception('Failed to get user profile: $e');
    }
  }

  @override
  Future<OnboardingResponse> updatePersonalInfo({
    required PersonalInfoRequest personalInfo,
  }) async {
    try {
      final response = await _userApiService.updatePersonalInfo(
        personalInfo,
      );

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(
          'Failed to update personal info with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to update personal info: $e');
    }
  }

  @override
  Future<OnboardingResponse> updateProfessionalInfo({
    required ProfessionalInfoRequest professionalInfo,
  }) async {
    try {
      final response = await _userApiService.updateProfessionalInfo(
        professionalInfo,
      );

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(
          'Failed to update professional info with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to update professional info: $e');
    }
  }

  @override
  Future<void> updateProfile({
    required ProfileUpdateRequest profileUpdate,
  }) async {
    AppLogger.debug('\n\n########## [PROFILE_REPO] UPDATE PROFILE CALLED ##########', tag: 'Profile');
    try {
      AppLogger.debug('[PROFILE_REPO] Calling UserApiService.updateProfile()...', tag: 'Profile');
      AppLogger.debug('[PROFILE_REPO] Data: ${profileUpdate.toJson()}', tag: 'Profile');
      final response = await _userApiService.updateProfile(profileUpdate);

      AppLogger.debug('\n[PROFILE_REPO] ✅ API call completed', tag: 'Profile');
      AppLogger.debug('[PROFILE_REPO] Response status: ${response.response.statusCode}', tag: 'Profile');

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        AppLogger.debug('[PROFILE_REPO] ✅ Profile updated successfully', tag: 'Profile');
        AppLogger.debug('[PROFILE_REPO] Response data: ${response.data}', tag: 'Profile');

        // Update local cache with new data
        AppLogger.debug('[PROFILE_REPO] Updating local cache...', tag: 'Profile');
        final localProfile = LocalProfile(
          name: profileUpdate.name,
          email: profileUpdate.email,
          phone: profileUpdate.phone,
          nationality: profileUpdate.nationality,
          gender: profileUpdate.gender,
          jobTitle: profileUpdate.jobTitle,
          location: profileUpdate.location,
          company: profileUpdate.company,
          education: profileUpdate.education,
          linkedin: profileUpdate.linkedin,
          updatedAt: DateTime.now(),
        );
        await _localProfileRepository.saveProfile(localProfile);
        AppLogger.debug('[PROFILE_REPO] ✅ Cache updated', tag: 'Profile');

        AppLogger.debug('########## [PROFILE_REPO] SUCCESS ##########\n\n', tag: 'Profile');
        return;
      } else {
        AppLogger.error('[PROFILE_REPO] ❌ API returned error status: ${response.response.statusCode}', tag: 'Profile');
        throw Exception(
          'Failed to update profile with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      AppLogger.error('\n[PROFILE_REPO] ❌ DioException occurred', tag: 'Profile');
      AppLogger.debug('[PROFILE_REPO] Type: ${e.type}', tag: 'Profile');
      AppLogger.debug('[PROFILE_REPO] Message: ${e.message}', tag: 'Profile');
      if (e.response != null) {
        AppLogger.debug('[PROFILE_REPO] Response status: ${e.response?.statusCode}', tag: 'Profile');
        AppLogger.debug('[PROFILE_REPO] Response data: ${e.response?.data}', tag: 'Profile');
      }
      AppLogger.error('########## [PROFILE_REPO] FAILED ##########\n\n', tag: 'Profile');
      throw _handleDioError(e);
    } catch (e) {
      AppLogger.error('\n[PROFILE_REPO] ❌ Unexpected exception: $e', tag: 'Profile', error: e);
      AppLogger.error('########## [PROFILE_REPO] FAILED ##########\n\n', tag: 'Profile');
      throw Exception('Failed to update profile: $e');
    }
  }

  @override
  Future<void> updateClient({
    required String email,
    required String nationality,
    required String gender,
    required List<String> locations,
    required List<String> positions,
    String? cvPath,
  }) async {
    AppLogger.debug('\n\n########## [PROFILE_REPO] UPDATE CLIENT CALLED ##########', tag: 'Profile');
    try {
      AppLogger.debug('[PROFILE_REPO] Calling TabashirApiService.updateClient()...', tag: 'Profile');
      final file = cvPath != null && cvPath.isNotEmpty
          ? await MultipartFile.fromFile(cvPath)
          : null;

      final response = await _tabashirApiService.updateClient(
        email,
        file,
        nationality,
        gender,
        locations,
        positions,
      );

      AppLogger.debug('\n[PROFILE_REPO] ✅ API call completed', tag: 'Profile');
      AppLogger.debug('[PROFILE_REPO] Response status: ${response.response.statusCode}', tag: 'Profile');

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        AppLogger.debug('[PROFILE_REPO] ✅ Client updated successfully', tag: 'Profile');
        AppLogger.debug('########## [PROFILE_REPO] SUCCESS ##########\n\n', tag: 'Profile');
        return;
      } else {
        AppLogger.error('[PROFILE_REPO] ❌ API returned error status: ${response.response.statusCode}', tag: 'Profile');
        throw Exception(
          'Failed to update client with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      AppLogger.error('\n[PROFILE_REPO] ❌ DioException occurred', tag: 'Profile');
      AppLogger.debug('[PROFILE_REPO] Type: ${e.type}', tag: 'Profile');
      AppLogger.debug('[PROFILE_REPO] Message: ${e.message}', tag: 'Profile');
      if (e.response != null) {
        AppLogger.debug('[PROFILE_REPO] Response status: ${e.response?.statusCode}', tag: 'Profile');
        AppLogger.debug('[PROFILE_REPO] Response data: ${e.response?.data}', tag: 'Profile');
      }
      AppLogger.error('########## [PROFILE_REPO] FAILED ##########\n\n', tag: 'Profile');
      throw _handleDioError(e);
    } catch (e) {
      AppLogger.error('\n[PROFILE_REPO] ❌ Unexpected exception: $e', tag: 'Profile', error: e);
      AppLogger.error('########## [PROFILE_REPO] FAILED ##########\n\n', tag: 'Profile');
      throw Exception('Failed to update client: $e');
    }
  }

  @override
  Future<AiClientData?> getClient() async {
    AppLogger.debug('\n\n########## [PROFILE_REPO] GET CLIENT CALLED ##########', tag: 'Profile');
    try {
      final response = await _tabashirApiService.getClient();
      if (response.response.statusCode == 200) {
        AppLogger.debug('[PROFILE_REPO] ✅ Client data fetched', tag: 'Profile');
        return response.data.data;
      } else if (response.response.statusCode == 404) {
        AppLogger.debug('[PROFILE_REPO] Client profile not found in AI DB', tag: 'Profile');
        return null;
      } else {
        throw Exception('Unexpected status: ${response.response.statusCode}');
      }
    } on DioException catch (e) {
      AppLogger.error('[PROFILE_REPO] ❌ DioException: ${e.message}', tag: 'Profile');
      return null; // Non-fatal - AI profile may not exist yet
    } catch (e) {
      AppLogger.error('[PROFILE_REPO] ❌ Error fetching client: $e', tag: 'Profile', error: e);
      return null;
    }
  }

  @override
  Future<void> deleteAccount() async {
    AppLogger.debug('\n\n########## [PROFILE_REPO] DELETE ACCOUNT CALLED ##########', tag: 'Profile');
    try {
      AppLogger.debug('[PROFILE_REPO] Calling AuthApiService.deleteAccount()...', tag: 'Profile');
      await _authApiService.deleteAccount();

      AppLogger.debug('\n[PROFILE_REPO] ✅ API call completed', tag: 'Profile');

      // Clear local cache
      AppLogger.debug('[PROFILE_REPO] Clearing local profile cache...', tag: 'Profile');
      await _localProfileRepository.clearAllProfiles();
      AppLogger.debug('[PROFILE_REPO] ✅ Cache cleared', tag: 'Profile');

      AppLogger.debug('########## [PROFILE_REPO] SUCCESS ##########\n\n', tag: 'Profile');
      return;
    } on DioException catch (e) {
      AppLogger.error('\n[PROFILE_REPO] ❌ DioException occurred during account deletion', tag: 'Profile');
      AppLogger.debug('[PROFILE_REPO] Type: ${e.type}', tag: 'Profile');
      AppLogger.debug('[PROFILE_REPO] Message: ${e.message}', tag: 'Profile');
      if (e.response != null) {
        AppLogger.debug('[PROFILE_REPO] Response status: ${e.response?.statusCode}', tag: 'Profile');
        AppLogger.debug('[PROFILE_REPO] Response data: ${e.response?.data}', tag: 'Profile');
      }
      AppLogger.error('########## [PROFILE_REPO] FAILED ##########\n\n', tag: 'Profile');
      throw _handleDioError(e);
    } catch (e) {
      AppLogger.error('\n[PROFILE_REPO] ❌ Unexpected exception during account deletion: $e', tag: 'Profile', error: e);
      AppLogger.error('########## [PROFILE_REPO] FAILED ##########\n\n', tag: 'Profile');
      throw Exception('Failed to delete account: $e');
    }
  }

  /// Save UserProfileResponse to local
  Future<void> _saveToLocal(UserProfileResponse response) async {
    final user = response.user;
    final candidateProfile = response.candidateProfile;

    final localProfile = LocalProfile(
      name: user.name,
      email: user.email,
      phone: candidateProfile?.phone,
      nationality: candidateProfile?.nationality,
      gender: candidateProfile?.gender,
      jobTitle: candidateProfile?.experience,
      location: '', // Not in API response - use empty string
      company: response.recruiterProfile?.companyName,
      education: candidateProfile?.education,
      linkedin: '', // Not in API response - use empty string
      userType: user.userType,
      profileStrength: _calculateProfileStrength(user, candidateProfile),
      updatedAt: DateTime.now(),
    );

    await _localProfileRepository.saveProfile(localProfile);
  }

  /// Convert LocalProfile back to UserProfileResponse
  /// Note: This creates a simplified response with minimal data
  UserProfileResponse _convertFromLocal(LocalProfile profile) {
    // Create minimal UserProfileResponse from cached data
    // This is used as a fallback when API is unavailable
    final user = UserData(
      id: 'cached',
      email: profile.email ?? '',
      name: profile.name ?? '',
      userType: profile.userType ?? 'CANDIDATE',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final candidateProfile = CandidateProfileData(
      id: 'cached',
      phone: profile.phone,
      nationality: profile.nationality,
      gender: profile.gender,
      experience: profile.jobTitle,
      skills: [],
      education: profile.education,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    return UserProfileResponse(
      user: user,
      candidateProfile: candidateProfile,
      adminPermissions: [],
      connectedAccounts: [],
    );
  }

  /// Calculate profile strength based on available data
  int _calculateProfileStrength(
    UserData user,
    CandidateProfileData? candidate,
  ) {
    var strength = 0;
    if (user.name != null) strength += 15;
    if (user.email != null) strength += 15;
    if (candidate?.phone != null) strength += 10;
    if (candidate?.nationality != null) strength += 10;
    if (candidate?.gender != null) strength += 10;
    if (candidate?.education != null) strength += 15;
    if (candidate?.experience != null) strength += 15;
    if (candidate?.skills != null && candidate!.skills!.isNotEmpty) {
      strength += 10;
    }
    return strength;
  }

  /// Handle Dio errors and convert to meaningful exceptions
  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case final DioExceptionType receiveTimeout:
        return Exception('Connection timeout. Please try again.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        // Try to extract error message from various possible response structures
        var message = 'Request failed';
        try {
          if (e.response?.data != null) {
            final data = e.response!.data;
            if (data is Map<String, dynamic>) {
              // Try common error message fields
              message =
                  data['message']?.toString() ??
                  data['error']?.toString() ??
                  data['error_message']?.toString() ??
                  'Request failed';
            } else if (data is String) {
              message = data;
            }
          }
        } catch (_) {
          // If we can't parse the error, use a generic message
          message = 'Request failed';
        }

        // Handle specific status codes
        switch (statusCode) {
          case 400:
            return Exception('$message (Status: $statusCode)');
          case 401:
            return Exception('Session expired. Please log in again.');
          case 403:
            return Exception("Access forbidden. You don't have permission.");
          case 404:
            return Exception(
              'Profile feature is not available yet. Please check back later.',
            );
          case 409:
            return Exception(
              'A conflict occurred. The resource may have been modified.',
            );
          case 422:
            return Exception('Invalid data: $message');
          case 429:
            return Exception('Too many requests. Please try again later.');
          case 500:
            return Exception('Server error. Please try again later.');
          case 502:
            return Exception('Bad gateway. Please try again later.');
          case 503:
            return Exception('Service unavailable. Please try again later.');
          case 504:
            return Exception('Gateway timeout. Please try again later.');
          default:
            return Exception('$message (Status: $statusCode)');
        }
      case DioExceptionType.cancel:
        return Exception('Request was cancelled');
      case DioExceptionType.connectionError:
        return Exception('No internet connection. Please check your network.');
      default:
        return Exception('An unexpected error occurred: ${e.message}');
    }
  }
}

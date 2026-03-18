import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/database/models/profile_isar.dart';
import 'package:tabashir/core/database/repositories/profile_isar_repository.dart';
import 'package:tabashir/core/network/models/user/user_profile_response.dart';
import 'package:tabashir/core/network/models/candidate/personal_info_request.dart';
import 'package:tabashir/core/network/models/candidate/professional_info_request.dart';
import 'package:tabashir/core/network/models/candidate/onboarding_response.dart';
import 'package:tabashir/core/network/models/profile/profile_update_request.dart';
import 'package:tabashir/core/network/services/user/user_api_service.dart';
import 'package:tabashir/core/network/services/auth/auth_api_service.dart';
import 'package:tabashir/features/profile/domain/repositories/profile_repository.dart';

/// Implementation of [ProfileRepository]
/// Handles profile operations using [UserApiService] with Isar caching
@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(
    this._userApiService,
    this._authApiService,
    this._profileIsarRepository,
  );

  final UserApiService _userApiService;
  final AuthApiService _authApiService;
  final ProfileIsarRepository _profileIsarRepository;

  @override
  Future<UserProfileResponse> getUserProfile() async {
    print('\n\n########## [PROFILE_REPO] GET USER PROFILE CALLED ##########');
    try {
      // Try to load from cache first for better UX
      print('[PROFILE_REPO] Checking Isar cache...');
      final cachedProfile = await _profileIsarRepository.getLatestProfile();
      if (cachedProfile != null) {
        print('[PROFILE_REPO] ✅ Found cached profile');
      } else {
        print('[PROFILE_REPO] No cached profile found');
      }

      // Fetch from API
      print('[PROFILE_REPO] Calling UserApiService.getUserProfile()...');
      print('[PROFILE_REPO] Using comprehensive unified API: /api/v1/users/me');
      final response = await _userApiService.getUserProfile();

      print('\n[PROFILE_REPO] ✅ API call completed');
      print('[PROFILE_REPO] Response status: ${response.response.statusCode}');

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        print('[PROFILE_REPO] ✅ Comprehensive profile loaded successfully');
        print('[PROFILE_REPO] User data: ${response.data.user.name}');
        print('[PROFILE_REPO] User type: ${response.data.user.userType}');
        print(
          '[PROFILE_REPO] Total resumes: ${response.data.counts?.totalResumes ?? 0}',
        );
        print(
          '[PROFILE_REPO] Has subscription: ${response.data.subscription != null}',
        );
        print(
          '[PROFILE_REPO] Admin permissions: ${response.data.adminPermissions.length}',
        );

        // Save to Isar cache
        print('[PROFILE_REPO] Saving profile to Isar cache...');
        await _saveToIsar(response.data);
        print('[PROFILE_REPO] ✅ Profile saved to cache');

        print('########## [PROFILE_REPO] SUCCESS ##########\n\n');
        return response.data;
      } else {
        print(
          '[PROFILE_REPO] ❌ API returned error status: ${response.response.statusCode}',
        );

        // If API fails but we have cache, return cache
        if (cachedProfile != null) {
          print('[PROFILE_REPO] Using cached profile due to API error');
          print('########## [PROFILE_REPO] SUCCESS (CACHE) ##########\n\n');
          return _convertFromIsar(cachedProfile);
        }

        throw Exception(
          'Failed to get user profile with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      print('\n[PROFILE_REPO] ❌ DioException occurred');
      print('[PROFILE_REPO] Type: ${e.type}');
      print('[PROFILE_REPO] Message: ${e.message}');
      if (e.response != null) {
        print('[PROFILE_REPO] Response status: ${e.response?.statusCode}');
        print('[PROFILE_REPO] Response data: ${e.response?.data}');
      }

      // Try to return cached profile on error
      final cachedProfile = await _profileIsarRepository.getLatestProfile();
      if (cachedProfile != null) {
        print('[PROFILE_REPO] Returning cached profile due to error');
        print('########## [PROFILE_REPO] SUCCESS (CACHE) ##########\n\n');
        return _convertFromIsar(cachedProfile);
      }

      print('########## [PROFILE_REPO] FAILED ##########\n\n');
      throw _handleDioError(e);
    } catch (e) {
      print('\n[PROFILE_REPO] ❌ Unexpected exception: $e');

      // Try to return cached profile on error
      final cachedProfile = await _profileIsarRepository.getLatestProfile();
      if (cachedProfile != null) {
        print('[PROFILE_REPO] Returning cached profile due to error');
        print('########## [PROFILE_REPO] SUCCESS (CACHE) ##########\n\n');
        return _convertFromIsar(cachedProfile);
      }

      print('########## [PROFILE_REPO] FAILED ##########\n\n');
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
    print('\n\n########## [PROFILE_REPO] UPDATE PROFILE CALLED ##########');
    try {
      print('[PROFILE_REPO] Calling UserApiService.updateProfile()...');
      print('[PROFILE_REPO] Data: ${profileUpdate.toJson()}');
      final response = await _userApiService.updateProfile(profileUpdate);

      print('\n[PROFILE_REPO] ✅ API call completed');
      print('[PROFILE_REPO] Response status: ${response.response.statusCode}');

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        print('[PROFILE_REPO] ✅ Profile updated successfully');
        print('[PROFILE_REPO] Response data: ${response.data}');

        // Update Isar cache with new data
        print('[PROFILE_REPO] Updating Isar cache...');
        final profileIsar = ProfileIsar(
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
        await _profileIsarRepository.saveProfile(profileIsar);
        print('[PROFILE_REPO] ✅ Cache updated');

        print('########## [PROFILE_REPO] SUCCESS ##########\n\n');
        return;
      } else {
        print(
          '[PROFILE_REPO] ❌ API returned error status: ${response.response.statusCode}',
        );
        throw Exception(
          'Failed to update profile with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      print('\n[PROFILE_REPO] ❌ DioException occurred');
      print('[PROFILE_REPO] Type: ${e.type}');
      print('[PROFILE_REPO] Message: ${e.message}');
      if (e.response != null) {
        print('[PROFILE_REPO] Response status: ${e.response?.statusCode}');
        print('[PROFILE_REPO] Response data: ${e.response?.data}');
      }
      print('########## [PROFILE_REPO] FAILED ##########\n\n');
      throw _handleDioError(e);
    } catch (e) {
      print('\n[PROFILE_REPO] ❌ Unexpected exception: $e');
      print('########## [PROFILE_REPO] FAILED ##########\n\n');
      throw Exception('Failed to update profile: $e');
    }
  }

  @override
  Future<void> deleteAccount() async {
    print('\n\n########## [PROFILE_REPO] DELETE ACCOUNT CALLED ##########');
    try {
      print('[PROFILE_REPO] Calling AuthApiService.deleteAccount()...');
      await _authApiService.deleteAccount();

      print('\n[PROFILE_REPO] ✅ API call completed');

      // Clear local cache
      print('[PROFILE_REPO] Clearing local profile cache...');
      await _profileIsarRepository.clearAllProfiles();
      print('[PROFILE_REPO] ✅ Cache cleared');

      print('########## [PROFILE_REPO] SUCCESS ##########\n\n');
      return;
    } on DioException catch (e) {
      print('\n[PROFILE_REPO] ❌ DioException occurred during account deletion');
      print('[PROFILE_REPO] Type: ${e.type}');
      print('[PROFILE_REPO] Message: ${e.message}');
      if (e.response != null) {
        print('[PROFILE_REPO] Response status: ${e.response?.statusCode}');
        print('[PROFILE_REPO] Response data: ${e.response?.data}');
      }
      print('########## [PROFILE_REPO] FAILED ##########\n\n');
      throw _handleDioError(e);
    } catch (e) {
      print(
        '\n[PROFILE_REPO] ❌ Unexpected exception during account deletion: $e',
      );
      print('########## [PROFILE_REPO] FAILED ##########\n\n');
      throw Exception('Failed to delete account: $e');
    }
  }

  /// Save UserProfileResponse to Isar
  Future<void> _saveToIsar(UserProfileResponse response) async {
    final user = response.user;
    final candidateProfile = response.candidateProfile;

    final profileIsar = ProfileIsar(
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

    await _profileIsarRepository.saveProfile(profileIsar);
  }

  /// Convert ProfileIsar back to UserProfileResponse
  /// Note: This creates a simplified response with minimal data
  UserProfileResponse _convertFromIsar(ProfileIsar profile) {
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

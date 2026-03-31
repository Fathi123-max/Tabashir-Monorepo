import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabashir/core/services/auth_session_service.dart';
import 'package:tabashir/core/network/models/user/user_profile_response.dart';
import 'package:tabashir/core/network/models/profile/profile_update_request.dart';
import 'package:tabashir/core/constants/storage_keys.dart';
import 'package:tabashir/features/profile/domain/repositories/profile_repository.dart';
import 'package:tabashir/core/network/models/candidate/professional_info_request.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/features/home/presentation/cubit/home_cubit.dart';
import 'package:tabashir/features/home/presentation/cubit/app_initialization_cubit.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

/// Custom validator for LinkedIn URL
/// Now optional - only validates if a value is provided
String? linkedinUrlValidator(AbstractControl<dynamic> control) {
  final value = control.value as String?;

  // Allow empty values (optional field)
  if (value == null || value.isEmpty) {
    return null;
  }

  final uri = Uri.tryParse(value);
  if (uri == null) {
    return 'linkedinUrl';
  }

  final isLinkedinDomain = uri.host.contains('linkedin.com');
  final hasValidPath =
      uri.path.startsWith('/in/') || uri.path.startsWith('/company/');

  if (!isLinkedinDomain || !hasValidPath) {
    return 'linkedinUrl';
  }

  return null;
}

@lazySingleton
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._repository) : super(ProfileState.initial());

  final ProfileRepository _repository;
  bool _isDataLoaded = false;
  bool _isInitialized = false; // Track initialization state

  /// Get the current user ID from the loaded profile
  /// Returns null if profile is not loaded yet
  String? get currentUserId => state.userProfileResponse?.user.id;

  /// Initialize profile data (called once, typically from AppInitializationCubit)
  Future<void> initializeWithProfileData(
    UserProfileResponse profileData,
  ) async {
    if (_isInitialized) {
      print('[PROFILE_CUBIT] Already initialized, skipping');
      return;
    }

    print('[PROFILE_CUBIT] Initializing with shared profile data...');

    final baseProfile = _mapUserProfileToUI(profileData);
    if (isClosed) return;
    emit(
      state.copyWith(
        status: ProfileStatus.success,
        profile: baseProfile,
        userProfileResponse: profileData,
      ),
    );

    _isInitialized = true;
    _isDataLoaded = true;
    print('[PROFILE_CUBIT] ✅ Profile initialized with shared data');
  }

  Future<void> loadProfileData({bool force = false}) async {
    // Prevent duplicate loads unless forced
    if (!force && _isDataLoaded && state.profile != null) {
      print('[PROFILE_CUBIT] Data already loaded, skipping duplicate load');
      return;
    }

    // If not initialized yet, don't auto-load - wait for initializeWithProfileData
    if (!_isInitialized && !force) {
      print(
        '[PROFILE_CUBIT] Not initialized yet, skipping auto-load. Call initializeWithProfileData() first.',
      );
      return;
    }

    print('[PROFILE_CUBIT] Loading profile data...');
    if (isClosed) return;
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      final response = await _repository.getUserProfile();

      // Map to UI format
      final profile = _mapUserProfileToUI(response);
      if (isClosed) return;
      emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: profile,
          userProfileResponse: response,
        ),
      );

      // Mark data as loaded
      _isDataLoaded = true;
      print('[PROFILE_CUBIT] Profile data loaded successfully');
    } on Exception catch (e) {
      final errorMessage = e.toString();

      // Check if this is an authentication error
      if (errorMessage.contains('Session expired') ||
          errorMessage.contains('Unauthorized') ||
          errorMessage.contains('Please log in again')) {
        // Emit a special error state so UI can show login if needed
        // But don't clear the session here - interceptor handles it
        if (isClosed) return;
        emit(
          state.copyWith(
            status: ProfileStatus.failure,
            errorMessage: 'Session expired. Please log in again.',
            requiresReauth: true,
          ),
        );
      } else {
        if (isClosed) return;
        emit(
          state.copyWith(
            status: ProfileStatus.failure,
            errorMessage: errorMessage,
          ),
        );
      }
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> logout() async {
    if (isClosed) return;
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      // Simulate API call to logout
      await Future.delayed(const Duration(milliseconds: 300));

      // Clear authentication state
      await AuthSessionService.instance.setLoggedOut();

      // Clear profile data
      if (isClosed) return;
      emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: null,
        ),
      );

      // Trigger full app state reset
      getIt<AppInitializationCubit>().reset();
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteAccount() async {
    if (isClosed) return;
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      // Call repository to delete account
      await _repository.deleteAccount();

      // Clear authentication state
      await AuthSessionService.instance.setLoggedOut();

      // Clear profile data
      if (isClosed) return;
      emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: null,
        ),
      );

      // Trigger full app state reset
      getIt<AppInitializationCubit>().reset();
    } on Exception catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage:
              'An unexpected error occurred while deleting your account.',
        ),
      );
    }
  }

  Future<void> navigateToScreen(String screen) async {
    // Handle navigation to different profile-related screens
    // This would typically trigger navigation events
  }

  /// Pre-fill profile data from parsed resume
  Future<void> prefillFromParsedResume(Map<String, dynamic> parsedData) async {
    print(
      '\n\n########## [PROFILE_CUBIT] PREFILL FROM PARSED RESUME CALLED ##########',
    );
    print('[PROFILE_CUBIT] Parsed data: $parsedData');

    if (isClosed) return;
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      // 1. Store parsed data for later use correctly as JSON
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        StorageKeys.resumeParsedPrefill,
        jsonEncode(parsedData),
      );
      print('[PROFILE_CUBIT] 1/5 Parsed data saved to SharedPreferences');

      // 2. Create profile update request (Basic Info)
      final experienceList = (parsedData['experience'] as List?)
          ?.cast<Map<String, dynamic>>();
      final experience = experienceList?.isNotEmpty ?? false
          ? experienceList!.first
          : null;

      final educationList = (parsedData['education'] as List?)
          ?.cast<Map<String, dynamic>>();
      final firstEducation = educationList?.isNotEmpty ?? false
          ? educationList!.first
          : null;

      final updateRequest = ProfileUpdateRequest(
        name:
            parsedData['name'] as String? ??
            parsedData['fullName'] as String? ??
            '',
        email: parsedData['email'] as String? ?? '',
        phone: parsedData['phone'] as String? ?? '',
        nationality: parsedData['nationality'] as String? ?? '',
        gender: '', // Not usually parsed reliably
        jobTitle: experience?['position'] as String? ?? '',
        company: experience?['company'] as String? ?? '',
        education: firstEducation != null
            ? '${firstEducation['degree'] ?? ''} at ${firstEducation['institution'] ?? ''}'
                  .trim()
            : '',
        location:
            (parsedData['location'] as String? ??
                    parsedData['address'] as String? ??
                    '')
                .trim(),
        linkedin: (parsedData['linkedin'] as String? ?? '').trim(),
      );

      print(
        '[PROFILE_CUBIT] 2/5 Updating Basic Profile: ${updateRequest.toJson()}',
      );

      // Try to update profile, but handle email conflict gracefully
      try {
        await _repository.updateProfile(profileUpdate: updateRequest);
        print('[PROFILE_CUBIT] ✅ Basic profile updated');
      } catch (e) {
        // Check if it's an email conflict error
        if (e.toString().contains('Email already in use') ||
            e.toString().contains('duplicate') ||
            e.toString().contains('unique constraint')) {
          print(
            '[PROFILE_CUBIT] ⚠️ Email already in use, updating profile without email',
          );
          // Create a new request without the email
          final updateRequestWithoutEmail = ProfileUpdateRequest(
            name: updateRequest.name,
            email: '', // Keep current email
            phone: updateRequest.phone,
            nationality: updateRequest.nationality,
            gender: updateRequest.gender,
            jobTitle: updateRequest.jobTitle,
            location: updateRequest.location,
            company: updateRequest.company,
            education: updateRequest.education,
            linkedin: updateRequest.linkedin,
          );
          await _repository.updateProfile(
            profileUpdate: updateRequestWithoutEmail,
          );
          print('[PROFILE_CUBIT] ✅ Basic profile updated (without email)');
        } else {
          // Re-throw if it's a different error
          rethrow;
        }
      }

      // 3. Create Professional Info Request (Detailed)
      final skillsList = (parsedData['skills'] as List?)?.cast<String>() ?? [];
      final skillsItems = skillsList
          .map((s) => SkillItem(category: 'General', name: s))
          .toList();

      final employmentHistory = experienceList
          ?.map(
            (e) => EmploymentHistoryItem(
              company: e['company'] as String?,
              position: e['position'] as String?,
              startDate: e['startDate'] as String?,
              endDate: e['endDate'] as String?,
              description: e['description'] as String?,
              // Defaulting to false if not specified, logic can be improved if data has "current"
              current: false,
            ),
          )
          .toList();

      final educationItems = educationList
          ?.map(
            (e) => EducationItem(
              institution: e['institution'] as String?,
              degree: e['degree'] as String?,
              // Mapping other fields if available in parsed data, otherwise null
              startDate: e['startDate'] as String?,
              endDate: e['endDate'] as String?,
            ),
          )
          .toList();

      final professionalInfo = ProfessionalInfoRequest(
        summary: parsedData['summary'] as String? ?? '',
        skills: skillsItems,
        employmentHistory: employmentHistory,
        educationList: educationItems,
        // Using the first experience position as current job type if available
        jobType: experience?['position'] as String?,
      );

      print(
        '[PROFILE_CUBIT] 3/5 Updating Professional Info: ${professionalInfo.toJson()}',
      );

      // Try to update professional info, but don't fail if it errors
      // This allows basic profile data to be saved even if professional info fails
      try {
        // We ignore the response here as we'll reload the full profile anyway
        await _repository.updateProfessionalInfo(
          professionalInfo: professionalInfo,
        );
        print('[PROFILE_CUBIT] ✅ Professional info updated');
      } catch (e) {
        print(
          '[PROFILE_CUBIT] ⚠️ Professional info update failed (non-critical): $e',
        );
      }

      // 4. Reload profile data to get the updated values
      print('[PROFILE_CUBIT] 4/5 Reloading profile data...');
      await loadProfileData(force: true); // Force reload after update
      print('[PROFILE_CUBIT] ✅✅ All updates completed successfully');
    } catch (e, stackTrace) {
      print('[PROFILE_CUBIT] ❌ Error pre-filling from parsed resume: $e');
      print('[PROFILE_CUBIT] Stack trace: $stackTrace');

      // Extract meaningful error message
      var errorMessage = e.toString();
      if (errorMessage.contains('Email already in use')) {
        errorMessage =
            'The email from the resume is already registered. Other details have been updated.';
      } else if (errorMessage.contains('Connection timeout')) {
        errorMessage =
            'Connection timeout. Please check your internet and try again.';
      }

      if (isClosed) return;
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: 'Failed to update profile from resume: $errorMessage',
        ),
      );
      // Rethrow if needed or handle gracefully.
      // Emitting failure state should be enough for the UI to show error.
    }
  }

  /// Load and apply any stored parsed resume data
  Future<void> loadStoredParsedResume() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedData = prefs.getString(StorageKeys.resumeParsedPrefill);

      if (storedData != null && storedData.isNotEmpty) {
        // Parse the stored JSON string back to Map
        final parsedData = jsonDecode(storedData) as Map<String, dynamic>;

        await prefillFromParsedResume(parsedData);

        // Clear the stored data after applying
        await prefs.remove(StorageKeys.resumeParsedPrefill);
      }
    } catch (e) {
      print('[PROFILE_CUBIT] Error loading stored parsed resume: $e');
    }
  }

  FormGroup getEditForm(ProfileData profile) {
    print('[PROFILE_CUBIT] getEditForm() called with profile: ${profile.name}');

    /// Clean "Not specified" values to empty strings
    String cleanValue(String? value) {
      if (value == null || value.isEmpty || value == 'Not specified') {
        return '';
      }
      return value;
    }

    return FormGroup({
      'name': FormControl<String>(value: cleanValue(profile.name)),
      'email': FormControl<String>(value: cleanValue(profile.email)),
      'nationality': FormControl<String>(
        value: cleanValue(profile.nationality),
      ),
      'gender': FormControl<String>(value: cleanValue(profile.gender)),
      'location': FormControl<String>(value: cleanValue(profile.location)),
      'jobTitle': FormControl<String>(value: cleanValue(profile.jobTitle)),
      'cv': FormControl<String>(value: cleanValue(profile.cvFilename)),
    });
  }

  Future<void> updateProfile(FormGroup form) async {
    if (isClosed) return;
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      final isTargetDetailsUpdate =
          form.contains('cv') &&
          form.contains('location') &&
          form.contains('jobTitle');

      if (isTargetDetailsUpdate) {
        final cvValue = form.control('cv').value as String?;
        // Only treat as CV path if it looks like a local file system path (has / or \)
        final isLocalFile =
            cvValue != null &&
            (cvValue.contains('/') || cvValue.contains('\\'));
        final cvPath = isLocalFile ? cvValue : null;

        final locStr = form.control('location').value as String? ?? '';
        final locs = locStr.isNotEmpty
            ? locStr.split(',').map((e) => e.trim()).toList()
            : <String>[];

        final posStr = form.control('jobTitle').value as String? ?? '';
        final posList = posStr.isNotEmpty
            ? posStr.split(',').map((e) => e.trim()).toList()
            : <String>[];

        await _repository.updateClient(
          email: form.control('email').value as String,
          cvPath: cvPath,
          nationality: form.control('nationality').value as String,
          gender: form.control('gender').value as String,
          locations: locs,
          positions: posList,
        );
      }

      final profileUpdate = ProfileUpdateRequest(
        name: form.control('name').value as String,
        email: form.control('email').value as String,
        phone: state.profile?.phone ?? '',
        nationality: form.control('nationality').value as String,
        gender: form.control('gender').value as String,
        jobTitle: form.contains('jobTitle')
            ? (form.control('jobTitle').value as String? ?? '')
            : (state.profile?.jobTitle ?? ''),
        location: form.contains('location')
            ? (form.control('location').value as String? ?? '')
            : (state.profile?.location ?? ''),
        company: state.profile?.company ?? '',
        education: state.profile?.education ?? '',
        linkedin: state.profile?.linkedin ?? '',
      );

      await _repository.updateProfile(profileUpdate: profileUpdate);

      // Trigger home dashboard refresh
      getIt<HomeCubit>().loadHomeData(forceRefresh: true);

      // Reload profile data from server to get updated information (both Web and AI)
      await loadProfileData(force: true);
    } on Exception catch (e) {
      // Check if this is an authentication error
      final errorMessage = e.toString();
      if (errorMessage.contains('Session expired') ||
          errorMessage.contains('Unauthorized') ||
          errorMessage.contains('Please log in again')) {
        await AuthSessionService.instance.setLoggedOut();
        if (isClosed) return;
        emit(
          state.copyWith(
            status: ProfileStatus.failure,
            errorMessage: 'Session expired. Please log in again.',
            requiresReauth: true,
          ),
        );
      } else {
        if (isClosed) return;
        emit(
          state.copyWith(
            status: ProfileStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Map comprehensive API user profile to UI format
  ProfileData _mapUserProfileToUI(
    UserProfileResponse response,
  ) {
    final user = response.user;
    final candidateProfile = response.candidateProfile;

    // Extract job title prioritizing jobType (where AI extracted positions go) or experience
    final jobTitle = candidateProfile?.jobType ?? candidateProfile?.experience ?? '';

    // Extract company from recruiter profile (for recruiters) or use empty string
    final company = response.recruiterProfile?.companyName ?? '';

    // Extract education
    final education = candidateProfile?.education ?? '';

    // Extract location and linkedin from candidate profile
    final location = candidateProfile?.location ?? '';
    final linkedin = candidateProfile?.linkedin ?? '';

    // Use candidate profile for nationality and gender (now supported by Python backend)
    final nationality = candidateProfile?.nationality ?? '';
    final gender = candidateProfile?.gender ?? '';

    // Calculate profile strength based on available data
    var profileStrength = 0;
    if (user.name != null) profileStrength += 15;
    if (user.email != null) profileStrength += 15;
    if (candidateProfile?.phone != null) profileStrength += 10;
    if (candidateProfile?.nationality != null &&
        candidateProfile!.nationality!.isNotEmpty) profileStrength += 10;
    if (candidateProfile?.gender != null &&
        candidateProfile!.gender!.isNotEmpty) profileStrength += 10;
    if (candidateProfile?.education != null) profileStrength += 15;
    if (candidateProfile?.experience != null) profileStrength += 15;
    if (candidateProfile?.skills != null &&
        candidateProfile!.skills!.isNotEmpty) {
      profileStrength += 10;
    }

    // Get profile image from user data first, then candidate profile if needed
    var profileImage = user.image;
    if (profileImage == null || profileImage.isEmpty) {
      profileImage = candidateProfile?.profilePicture;
    }

    return ProfileData(
      name: user.name ?? 'Unknown User',
      jobTitle: jobTitle,
      location: location,
      email: user.email ?? '',
      phone: candidateProfile?.phone ?? '',
      nationality: nationality,
      gender: gender,
      company: company,
      education: education,
      linkedin: linkedin,
      profileStrength: profileStrength,
      profileImage: profileImage,
      cvFilename: candidateProfile?.latestResume?.fileName,
      userType: user.userType,
      subscriptionPlan: response.subscription?.plan,
      subscriptionStatus: response.subscription?.status,
      totalResumes: response.counts?.totalResumes ?? 0,
      totalApplications: response.counts?.totalApplications ?? 0,
      savedJobs: response.counts?.savedJobs ?? 0,
      adminPermissions: response.adminPermissions,
      paymentStats: response.paymentStats,
      jobStats: response.jobStats,
      connectedAccounts: response.connectedAccounts,
      aiResumeStats: response.aiResumeStats,
      security: response.security,
    );
  }

  /// Reset the cubit state (for logout/session change)
  void reset() {
    print('[PROFILE_CUBIT] Resetting profile data...');
    _isInitialized = false;
    _isDataLoaded = false;
    if (!isClosed) {
      emit(ProfileState.initial());
    }
  }
}

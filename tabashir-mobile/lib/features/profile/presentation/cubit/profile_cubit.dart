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
  String? get currentUserId {
    return state.userProfileResponse?.user?.id;
  }

  /// Initialize profile data (called once, typically from AppInitializationCubit)
  Future<void> initializeWithProfileData(UserProfileResponse profileData) async {
    if (_isInitialized) {
      print('[PROFILE_CUBIT] Already initialized, skipping');
      return;
    }

    print('[PROFILE_CUBIT] Initializing with shared profile data...');
    final profile = _mapUserProfileToUI(profileData);

    emit(
      state.copyWith(
        status: ProfileStatus.success,
        profile: profile,
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
      print('[PROFILE_CUBIT] Not initialized yet, skipping auto-load. Call initializeWithProfileData() first.');
      return;
    }

    print('[PROFILE_CUBIT] Loading profile data...');
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      final response = await _repository.getUserProfile();

      // New API returns UserProfileResponse directly
      // Map it to UI format
      final profile = _mapUserProfileToUI(response);
      emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: profile,
          userProfileResponse: response, // Store raw response
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
        // Clear auth state and emit a special error state
        await AuthSessionService.instance.setLoggedOut();
        emit(
          state.copyWith(
            status: ProfileStatus.failure,
            errorMessage: 'Session expired. Please log in again.',
            requiresReauth: true,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: ProfileStatus.failure,
            errorMessage: errorMessage,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      // Simulate API call to logout
      await Future.delayed(const Duration(milliseconds: 300));

      // Clear authentication state
      await AuthSessionService.instance.setLoggedOut();

      // Clear profile data
      emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteAccount() async {
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      // Call repository to delete account
      await _repository.deleteAccount();

      // Clear authentication state
      await AuthSessionService.instance.setLoggedOut();

      // Clear profile data
      emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: null,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: 'An unexpected error occurred while deleting your account.',
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
      final experience = experienceList?.isNotEmpty == true
          ? experienceList!.first
          : null;

      final educationList = (parsedData['education'] as List?)
          ?.cast<Map<String, dynamic>>();
      final firstEducation = educationList?.isNotEmpty == true
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
          print('[PROFILE_CUBIT] ⚠️ Email already in use, updating profile without email');
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
          await _repository.updateProfile(profileUpdate: updateRequestWithoutEmail);
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

      final employmentHistory = experienceList?.map((e) {
        return EmploymentHistoryItem(
          company: e['company'] as String?,
          position: e['position'] as String?,
          startDate: e['startDate'] as String?,
          endDate: e['endDate'] as String?,
          description: e['description'] as String?,
          // Defaulting to false if not specified, logic can be improved if data has "current"
          current: false,
        );
      }).toList();

      final educationItems = educationList?.map((e) {
        return EducationItem(
          institution: e['institution'] as String?,
          degree: e['degree'] as String?,
          // Mapping other fields if available in parsed data, otherwise null
          startDate: e['startDate'] as String?,
          endDate: e['endDate'] as String?,
        );
      }).toList();

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
        print('[PROFILE_CUBIT] ⚠️ Professional info update failed (non-critical): $e');
      }

      // 4. Reload profile data to get the updated values
      print('[PROFILE_CUBIT] 4/5 Reloading profile data...');
      await loadProfileData(force: true); // Force reload after update
      print('[PROFILE_CUBIT] ✅✅ All updates completed successfully');
    } catch (e, stackTrace) {
      print('[PROFILE_CUBIT] ❌ Error pre-filling from parsed resume: $e');
      print('[PROFILE_CUBIT] Stack trace: $stackTrace');

      // Extract meaningful error message
      String errorMessage = e.toString();
      if (errorMessage.contains('Email already in use')) {
        errorMessage = 'The email from the resume is already registered. Other details have been updated.';
      } else if (errorMessage.contains('Connection timeout')) {
        errorMessage = 'Connection timeout. Please check your internet and try again.';
      }

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
      'jobTitle': FormControl<String>(value: cleanValue(profile.jobTitle)),
      'location': FormControl<String>(value: cleanValue(profile.location)),
      'email': FormControl<String>(value: cleanValue(profile.email)),
      'phone': FormControl<String>(value: cleanValue(profile.phone)),
      'nationality': FormControl<String>(value: cleanValue(profile.nationality)),
      'gender': FormControl<String>(value: cleanValue(profile.gender)),
      'company': FormControl<String>(value: cleanValue(profile.company)),
      'education': FormControl<String>(value: cleanValue(profile.education)),
      'linkedin': FormControl<String>(value: cleanValue(profile.linkedin)),
    });
  }

  Future<void> updateProfile(FormGroup form) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      final linkedinValue = form.control('linkedin').value as String? ?? '';
      final normalizedLinkedin = _normalizeLinkedInUrl(linkedinValue);

      // Clean up "Not specified" values
      String? cleanValue(dynamic value) {
        final str = value as String?;
        if (str == null || str.isEmpty || str == 'Not specified') {
          return '';
        }
        return str;
      }

      final profileUpdate = ProfileUpdateRequest(
        name: form.control('name').value as String,
        email: form.control('email').value as String,
        phone: form.control('phone').value as String,
        nationality: form.control('nationality').value as String,
        gender: form.control('gender').value as String,
        jobTitle: form.control('jobTitle').value as String,
        location: cleanValue(form.control('location').value) ?? '',
        company: cleanValue(form.control('company').value) ?? '',
        education: cleanValue(form.control('education').value) ?? '',
        linkedin: normalizedLinkedin,
      );

      await _repository.updateProfile(profileUpdate: profileUpdate);

      // Reload profile data from server to get updated information
      final response = await _repository.getUserProfile();
      final updatedProfile = _mapUserProfileToUI(response);

      emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: updatedProfile,
          userProfileResponse: response,
        ),
      );
    } on Exception catch (e) {
      // Check if this is an authentication error
      final errorMessage = e.toString();
      if (errorMessage.contains('Session expired') ||
          errorMessage.contains('Unauthorized') ||
          errorMessage.contains('Please log in again')) {
        await AuthSessionService.instance.setLoggedOut();
        emit(
          state.copyWith(
            status: ProfileStatus.failure,
            errorMessage: 'Session expired. Please log in again.',
            requiresReauth: true,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: ProfileStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Normalizes LinkedIn URL to standard format
  String _normalizeLinkedInUrl(String url) {
    if (url.isEmpty) return url;

    var normalizedUrl = url.trim();

    // Add https:// if missing protocol
    if (!normalizedUrl.startsWith('http://') &&
        !normalizedUrl.startsWith('https://')) {
      normalizedUrl = 'https://$normalizedUrl';
    }

    // Ensure it's linkedin.com domain
    final uri = Uri.parse(normalizedUrl);
    if (!uri.host.contains('linkedin.com')) {
      return normalizedUrl;
    }

    return normalizedUrl;
  }

  /// Map comprehensive API user profile to UI format
  ProfileData _mapUserProfileToUI(UserProfileResponse response) {
    final user = response.user;
    final candidateProfile = response.candidateProfile;

    // Extract job title from experience or use default
    final jobTitle = candidateProfile?.experience ?? '';

    // Extract company from recruiter profile (for recruiters) or use empty string
    final company = response.recruiterProfile?.companyName ?? '';

    // Extract education
    final education = candidateProfile?.education ?? '';

    // Extract location and linkedin from candidate profile
    final location = candidateProfile?.location ?? '';
    final linkedin = candidateProfile?.linkedin ?? '';

    // Calculate profile strength based on available data
    var profileStrength = 0;
    if (user.name != null) profileStrength += 15;
    if (user.email != null) profileStrength += 15;
    if (candidateProfile?.phone != null) profileStrength += 10;
    if (candidateProfile?.nationality != null) profileStrength += 10;
    if (candidateProfile?.gender != null) profileStrength += 10;
    if (candidateProfile?.education != null) profileStrength += 15;
    if (candidateProfile?.experience != null) profileStrength += 15;
    if (candidateProfile?.skills != null &&
        candidateProfile!.skills!.isNotEmpty) {
      profileStrength += 10;
    }

    // Get profile image from user data first, then candidate profile if needed
    String? profileImage = user.image;
    if (profileImage == null || profileImage.isEmpty) {
      profileImage = candidateProfile?.profilePicture;
    }

    return ProfileData(
      name: user.name ?? 'Unknown User',
      jobTitle: jobTitle,
      location: location,
      email: user.email ?? '',
      phone: candidateProfile?.phone ?? '',
      nationality: candidateProfile?.nationality ?? '',
      gender: candidateProfile?.gender ?? '',
      company: company,
      education: education,
      linkedin: linkedin,
      profileStrength: profileStrength,
      profileImage: profileImage,
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
}

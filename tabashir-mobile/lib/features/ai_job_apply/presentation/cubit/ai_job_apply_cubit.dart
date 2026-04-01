import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:injectable/injectable.dart';

import 'package:tabashir/features/ai_job_apply/data/models/personal_details_model.dart';
import 'package:tabashir/features/ai_job_apply/data/models/target_role_model.dart';
import 'package:tabashir/features/ai_job_apply/data/models/resume_selection_model.dart';
import 'package:tabashir/features/ai_job_apply/data/models/location_preference_model.dart';
import 'package:tabashir/features/ai_job_apply/domain/repositories/ai_job_apply_repository.dart';
import 'package:tabashir/features/resume/domain/repositories/resume_vault_repository.dart';
import 'package:tabashir/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/features/home/presentation/cubit/home_cubit.dart';

import 'ai_job_apply_state.dart';

/// Unified cubit for AI job application flow
/// Combines all functionality from AiApplyCubit, TargetRolesCubit,
/// LocationPreferencesCubit, and PersonalDetailsCubit
@injectable
class AiJobApplyCubit extends Cubit<AiJobApplyState> {
  /// Creates the AI job apply cubit
  AiJobApplyCubit(
    this._repository,
    this._resumeVaultRepository,
    this._profileCubit,
  ) : super(const AiJobApplyState());

  final AiJobApplyRepository _repository;
  final ResumeVaultRepository _resumeVaultRepository;
  final ProfileCubit _profileCubit;

  /// Get the current user ID from profile cubit
  /// Throws an exception if user ID is not available
  String get _currentUserId {
    final userId = _profileCubit.currentUserId;
    if (userId == null || userId.isEmpty) {
      throw Exception(
        'User ID not available. Please ensure you are logged in.',
      );
    }
    return userId;
  }

  /// Get the default nationality from user profile or config
  /// Returns null if not available
  String? get _defaultNationality {
    // Try to get from profile cubit
    final profileState = _profileCubit.state;
    final profile = profileState.profile;

    if (profile != null && profile.nationality.isNotEmpty) {
      return profile.nationality.toLowerCase().replaceAll(' ', '_');
    }

    // If not in profile, could check user profile response
    // For now, return null to allow UI to handle default
    return null;
  }

  // ============ Resume Selection Methods ============

  /// Load available resumes
  Future<void> loadResumes() async {
    emit(state.copyWith(isLoading: true));

    try {
      // Load resumes from vault
      final resumes = await _resumeVaultRepository.getUserResumes();

      // Convert to selection model
      final selectionModels = resumes
          .map(
            (r) => ResumeSelectionModel(
              id: r.id,
              title: r.name.isNotEmpty ? r.name : r.filename,
              lastUpdated: r.updatedAt,
              description:
                  '${r.fileType} • ${(r.fileSize / 1024 / 1024).toStringAsFixed(2)} MB',
            ),
          )
          .toList();

      emit(
        state.copyWith(
          isLoading: false,
          resumes: selectionModels,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          hasError: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Select a resume
  void selectResume(String resumeId) {
    emit(state.copyWith(selectedResumeId: resumeId));
  }

  /// Continue with selected resume
  Future<void> continueWithSelectedResume() async {
    if (state.selectedResumeId == null) return;

    emit(state.copyWith(isSubmitting: true));

    try {
      // Save the selected resume
      final userId = _currentUserId;
      final selectedResume = state.resumes.firstWhere(
        (r) => r.id == state.selectedResumeId,
      );
      await _repository.saveResumeSelection(
        userId: userId,
        resume: selectedResume,
      );

      emit(state.copyWith(isSubmitting: false));
    } catch (e) {
      emit(
        state.copyWith(
          isSubmitting: false,
          hasError: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Submit application
  Future<void> submitApplication({required String email}) async {
    if (state.selectedResumeId == null) {
      emit(
        state.copyWith(
          submissionError: 'Please select a resume first',
          hasError: true,
        ),
      );
      return;
    }

    emit(state.copyWith(isSubmittingApplication: true, submissionError: ''));

    try {
      // 1. Get resume file details
      final resumes = await _resumeVaultRepository.getUserResumes();
      final selectedResume = resumes.firstWhere(
        (r) => r.id == state.selectedResumeId,
        orElse: () => throw Exception('Selected resume not found'),
      );

      // 2. Read file bytes (handle both local and cloud resumes)
      late final Uint8List fileBytes;

      // Check if resume is cloud-stored (has originalUrl) or local
      if (selectedResume.originalUrl != null &&
          selectedResume.originalUrl!.isNotEmpty) {
        // Cloud resume - download from URL
        print(
          '🌐 [AI_JOB_APPLY] Downloading cloud resume from: ${selectedResume.originalUrl}',
        );
        fileBytes = await _repository.downloadResumeFromCloud(
          resumeUrl: selectedResume.originalUrl!,
        );
        print(
          '✅ [AI_JOB_APPLY] Downloaded ${fileBytes.length} bytes from cloud',
        );
      } else {
        // Local resume - read from file path
        final file = File(selectedResume.filePath);

        if (!await file.exists()) {
          // Try to find the file in common document directories
          final possiblePaths = [
            selectedResume.filePath,
            // Add fallback paths if needed
          ];

          File? foundFile;
          for (final path in possiblePaths) {
            final testFile = File(path);
            if (await testFile.exists()) {
              foundFile = testFile;
              break;
            }
          }

          if (foundFile == null) {
            throw Exception(
              'Resume file not found. Please re-upload your resume. The file path "${selectedResume.filePath}" is no longer valid.',
            );
          }

          fileBytes = await foundFile.readAsBytes();
        } else {
          fileBytes = await file.readAsBytes();
        }
        print(
          '📁 [AI_JOB_APPLY] Read ${fileBytes.length} bytes from local file',
        );
      }

      // 3. Prepare data
      final positions = state.selectedRoles.map((r) => r.title).toList();
      if (state.customRoleTitle.isNotEmpty) {
        positions.add(state.customRoleTitle);
      }

      final locations = state.selectedLocations.map((l) => l.name).toList();
      final email = getIt<ProfileCubit>().state.profile?.email ?? '';

      // 4. Call API
      final response = await _repository.applyToJobs(
        email: email,
        fileBytes: fileBytes,
        fileName: selectedResume.filename,
        positions: positions,
        locations: locations,
        nationality: state.nationality ?? 'usa',
        gender:
            state.gender?.name.toUpperCase() ??
            'MALE', // Default or handle null
      );

      // Trigger home data refresh
      if (email.isNotEmpty) {
        getIt<HomeCubit>().refreshHomeData(userProfile: null);
      }

      emit(
        state.copyWith(
          isSubmittingApplication: false,
          submissionResult: response,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isSubmittingApplication: false,
          submissionError: e.toString(),
        ),
      );
    }
  }

  /// Onboard a new client and submit application in one step
  Future<void> onboardClientAndApply({required String email}) async {
    if (state.selectedResumeId == null) {
      emit(
        state.copyWith(
          submissionError: 'Please select a resume first',
          hasError: true,
        ),
      );
      return;
    }

    emit(state.copyWith(isSubmittingApplication: true, submissionError: ''));

    try {
      // 1. Get resume file details
      final resumes = await _resumeVaultRepository.getUserResumes();
      final selectedResume = resumes.firstWhere(
        (r) => r.id == state.selectedResumeId,
        orElse: () => throw Exception('Selected resume not found'),
      );

      // 2. Read file bytes
      late final Uint8List fileBytes;

      if (selectedResume.originalUrl != null &&
          selectedResume.originalUrl!.isNotEmpty) {
        fileBytes = await _repository.downloadResumeFromCloud(
          resumeUrl: selectedResume.originalUrl!,
        );
      } else {
        final file = File(selectedResume.filePath);
        if (!await file.exists()) {
          throw Exception(
            'Resume file not found. Please re-upload your resume.',
          );
        }
        fileBytes = await file.readAsBytes();
      }

      // 3. Prepare data
      final positions = state.selectedRoles.map((r) => r.title).toList();
      if (state.customRoleTitle.isNotEmpty) {
        positions.add(state.customRoleTitle);
      }

      final locations = state.selectedLocations.map((l) => l.name).toList();
      final email = getIt<ProfileCubit>().state.profile?.email ?? '';

      // 4. Call addClient instead of applyToJobs
      final response = await _repository.addClient(
        email: email,
        fileBytes: fileBytes,
        fileName: selectedResume.filename,
        positions: positions,
        locations: locations,
        nationality: state.nationality ?? 'usa',
        gender: state.gender?.name.toUpperCase() ?? 'MALE',
      );

      // Trigger home data refresh
      if (email.isNotEmpty) {
        getIt<HomeCubit>().refreshHomeData(userProfile: null);
      }

      emit(
        state.copyWith(
          isSubmittingApplication: false,
          submissionResult: response,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isSubmittingApplication: false,
          submissionError: e.toString(),
        ),
      );
    }
  }

  // ============ Target Roles Methods ============

  /// Load available roles
  Future<void> loadAvailableRoles() async {
    emit(state.copyWith(isLoading: true));

    try {
      final userId = _currentUserId;
      final roles = await _repository.getTargetRoles(userId: userId);

      emit(
        state.copyWith(
          isLoading: false,
          availableRoles: roles,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          hasErrorRole: true,
          errorMessageRole: e.toString(),
        ),
      );
    }
  }

  /// Toggle a role selection
  void toggleRole(TargetRoleModel role) {
    final isSelected = state.selectedRoles.any((r) => r.id == role.id);

    if (isSelected) {
      emit(
        state.copyWith(
          selectedRoles: state.selectedRoles
              .where((r) => r.id != role.id)
              .toList(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          selectedRoles: [...state.selectedRoles, role],
        ),
      );
    }
  }

  /// Remove a custom role
  void removeRole(String roleId) {
    emit(
      state.copyWith(
        selectedRoles: state.selectedRoles
            .where((r) => r.id != roleId)
            .toList(),
      ),
    );
  }

  /// Update custom role title
  void updateCustomRoleTitle(String title) {
    emit(state.copyWith(customRoleTitle: title));
  }

  /// Add custom role
  void addCustomRole(String title) {
    final newRole = TargetRoleModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      isCustom: true,
    );

    emit(
      state.copyWith(
        selectedRoles: [...state.selectedRoles, newRole],
        customRoleTitle: '',
      ),
    );
  }

  /// Continue with selected roles
  Future<void> continueWithSelectedRoles() async {
    if (state.selectedRoles.isEmpty) return;

    emit(state.copyWith(isSubmittingRole: true));

    try {
      // Save the selected roles
      final userId = _currentUserId;
      await _repository.saveTargetRoles(
        userId: userId,
        roles: state.selectedRoles,
      );

      emit(state.copyWith(isSubmittingRole: false));
    } catch (e) {
      emit(
        state.copyWith(
          isSubmittingRole: false,
          hasErrorRole: true,
          errorMessageRole: e.toString(),
        ),
      );
    }
  }

  // ============ Location Preferences Methods ============

  /// Load available locations
  Future<void> loadAvailableLocations() async {
    emit(state.copyWith(isLoading: true));

    try {
      final userId = _currentUserId;
      final locations = await _repository.getLocationPreferences(
        userId: userId,
      );

      emit(
        state.copyWith(
          isLoading: false,
          availableLocations: locations,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          hasErrorLocation: true,
          errorMessageLocation: e.toString(),
        ),
      );
    }
  }

  /// Toggle a location selection
  void toggleLocation(LocationPreferenceModel location) {
    final isSelected = state.selectedLocations.any((l) => l.id == location.id);

    if (isSelected) {
      emit(
        state.copyWith(
          selectedLocations: state.selectedLocations
              .where((l) => l.id != location.id)
              .toList(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          selectedLocations: [...state.selectedLocations, location],
        ),
      );
    }
  }

  /// Add location from dropdown
  void addLocationFromDropdown(String locationId) {
    final location = state.availableLocations.firstWhere(
      (l) => l.id == locationId,
    );

    emit(
      state.copyWith(
        selectedLocations: [...state.selectedLocations, location],
        dropdownSelection: '',
      ),
    );
  }

  /// Continue with selected locations
  Future<void> continueWithSelectedLocations() async {
    if (state.selectedLocations.isEmpty) return;

    emit(state.copyWith(isSubmittingLocation: true));

    try {
      // Save the selected locations
      final userId = _currentUserId;
      await _repository.saveLocationPreferences(
        userId: userId,
        preferences: state.selectedLocations,
      );

      emit(state.copyWith(isSubmittingLocation: false));
    } catch (e) {
      emit(
        state.copyWith(
          isSubmittingLocation: false,
          hasErrorLocation: true,
          errorMessageLocation: e.toString(),
        ),
      );
    }
  }

  // ============ Personal Details Methods ============

  /// Update nationality
  void updateNationality(String nationality) {
    emit(state.copyWith(nationality: nationality));
  }

  /// Update gender
  void updateGender(Gender gender) {
    emit(state.copyWith(gender: gender));
  }

  /// Toggle visa sponsorship requirement
  void toggleVisaSponsorship() {
    emit(
      state.copyWith(
        requiresVisaSponsorship: !state.requiresVisaSponsorship,
      ),
    );
  }

  /// Continue to review
  Future<void> continueToReview() async {
    if (state.nationality == null || state.nationality!.isEmpty) return;

    emit(state.copyWith(isSubmittingDetails: true));

    try {
      // Save the personal details
      final userId = _currentUserId;
      final personalDetails = PersonalDetailsModel(
        nationality: state.nationality ?? 'usa', // Default fallback if null
        gender: state.gender ?? Gender.male,
        requiresVisaSponsorship: state.requiresVisaSponsorship,
      );
      await _repository.savePersonalDetails(
        userId: userId,
        details: personalDetails,
      );

      emit(state.copyWith(isSubmittingDetails: false));
    } catch (e) {
      emit(
        state.copyWith(
          isSubmittingDetails: false,
          hasErrorDetails: true,
          errorMessageDetails: e.toString(),
        ),
      );
    }
  }

  // ============ Application Submission Methods ============

  /// Apply to a specific job using default resume
  Future<void> applyToSpecificJob({
    required String jobId,
    required String email,
    String? nationality,
    String? gender,
  }) async {
    emit(state.copyWith(isSubmittingApplication: true, submissionError: ''));

    try {
      // 1. Get default resume (first available)
      final resumes = await _resumeVaultRepository.getUserResumes();
      if (resumes.isEmpty) {
        throw Exception('No resumes found. Please upload a resume first.');
      }

      final defaultResume = resumes.first;

      // 2. Read file bytes (handle both local and cloud resumes)
      late final Uint8List fileBytes;

      // Check if resume is cloud-stored (has originalUrl) or local
      if (defaultResume.originalUrl != null &&
          defaultResume.originalUrl!.isNotEmpty) {
        // Cloud resume - download from URL
        fileBytes = await _repository.downloadResumeFromCloud(
          resumeUrl: defaultResume.originalUrl!,
        );
      } else {
        // Local resume - read from file path
        final file = File(defaultResume.filePath);

        if (!await file.exists()) {
          throw Exception(
            'Default resume file not found. Please re-upload your resume.',
          );
        }

        fileBytes = await file.readAsBytes();
      }

      // 3. Call API
      final email = getIt<ProfileCubit>().state.profile?.email ?? '';
      final response = await _repository.applyToSpecificJob(
        jobId: jobId,
        email: email,
        fileBytes: fileBytes,
        fileName: defaultResume.filename,
        nationality: nationality,
        gender: gender,
      );

      // Trigger home data refresh
      if (email.isNotEmpty) {
        getIt<HomeCubit>().refreshHomeData(userProfile: null);
      }

      emit(
        state.copyWith(
          isSubmittingApplication: false,
          submissionResult: response,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isSubmittingApplication: false,
          submissionError: e.toString(),
        ),
      );
    }
  }

  // ===========================================================================
  // Private Helpers
  // ===========================================================================

  // Mock data helpers removed as they are no longer used
}

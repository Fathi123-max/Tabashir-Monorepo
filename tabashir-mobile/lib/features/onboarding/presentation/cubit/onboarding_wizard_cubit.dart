import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/router/app_state.dart';
import 'package:tabashir/features/ai_job_apply/domain/repositories/ai_job_apply_repository.dart';
import 'package:tabashir/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:tabashir/features/profile/presentation/cubit/profile_cubit.dart';
import 'onboarding_wizard_state.dart';

@injectable
class OnboardingWizardCubit extends Cubit<OnboardingWizardState> {
  OnboardingWizardCubit(
    this._repository,
    this._profileCubit,
    this._authCubit,
  ) : super(const OnboardingWizardState());
  final AiJobApplyRepository _repository;
  final ProfileCubit _profileCubit;
  final AuthCubit _authCubit;

  static const List<String> uaeCities = [
    'Dubai',
    'Abu Dhabi',
    'Sharjah',
    'Ajman',
    'Umm Al Quwain',
    'Ras Al Khaimah',
    'Fujairah',
  ];

  Future<void> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
        withData: true,
      );

      if (result != null && result.files.single.bytes != null) {
        final file = result.files.single;
        emit(
          state.copyWith(
            fileBytes: file.bytes,
            fileName: file.name,
            isLoading: true,
            errorMessage: null,
          ),
        );

        try {
          final suggestions = await _repository.suggestJobTitles(
            fileBytes: file.bytes!,
            fileName: file.name,
          );

          emit(
            state.copyWith(
              suggestedRoles: suggestions,
              isLoading: false,
              currentStep: 2, // Move to roles step
            ),
          );
        } catch (e) {
          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: 'Failed to suggest job titles: $e',
              currentStep: 2, // Still move to roles step
            ),
          );
        }
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void toggleRole(String role) {
    final selectedRoles = List<String>.from(state.selectedRoles);
    if (selectedRoles.contains(role)) {
      selectedRoles.remove(role);
    } else {
      selectedRoles.add(role);
    }
    emit(state.copyWith(selectedRoles: selectedRoles));
  }

  void toggleLocation(String location) {
    final selectedLocations = List<String>.from(state.selectedLocations);
    if (selectedLocations.contains(location)) {
      selectedLocations.remove(location);
    } else {
      selectedLocations.add(location);
    }
    emit(state.copyWith(selectedLocations: selectedLocations));
  }

  void addCustomRole(String role) {
    if (role.trim().isEmpty) return;

    final formattedRole = role.trim();
    final suggested = List<String>.from(state.suggestedRoles);
    if (!suggested.contains(formattedRole)) {
      suggested.insert(0, formattedRole);
    }

    final selected = List<String>.from(state.selectedRoles);
    if (!selected.contains(formattedRole)) {
      selected.add(formattedRole);
    }

    emit(
      state.copyWith(
        suggestedRoles: suggested,
        selectedRoles: selected,
      ),
    );
  }

  void updatePersonalDetails({String? nationality, String? gender}) {
    emit(
      state.copyWith(
        nationality: nationality ?? state.nationality,
        gender: gender ?? state.gender,
      ),
    );
  }

  void nextStep() {
    if (state.currentStep < 5) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void previousStep() {
    if (state.currentStep > 1) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  Future<void> submitOnboarding() async {
    if (state.fileBytes == null || state.fileName == null) {
      emit(state.copyWith(errorMessage: 'Please upload a resume first'));
      return;
    }

    emit(
      state.copyWith(isProcessing: true, errorMessage: null, currentStep: 5),
    );

    try {
      // Try to get email from profile
      var email = _profileCubit.state.userProfileResponse?.user.email ?? '';

      // If profile email is empty, try force loading it (maybe it's not initialized yet)
      if (email.isEmpty) {
        try {
          await _profileCubit.loadProfileData(force: true);
          email = _profileCubit.state.userProfileResponse?.user.email ?? '';
        } catch (_) {
          // Ignore error and try next fallback
        }
      }

      // If still empty, try fallback from AuthCubit (especially for new registrations)
      if (email.isEmpty) {
        email = _authCubit.state.email;
      }

      if (email.isEmpty) {
        emit(
          state.copyWith(
            isProcessing: false,
            errorMessage:
                'Could not find your email. Please try logging in again.',
          ),
        );
        return;
      }

      final result = await _repository.addClient(
        email: email,
        fileBytes: state.fileBytes!,
        fileName: state.fileName!,
        positions: state.selectedRoles,
        locations: state.selectedLocations,
        nationality: state.nationality,
        gender: state.gender,
      );

      // Mark setup as complete — persists to SharedPreferences and notifies
      // the GoRouter so Gate 3 is lifted on this and all future launches.
      await AppState.instance.setSetupComplete();

      emit(
        state.copyWith(
          isProcessing: false,
          submissionResult: result,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isProcessing: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

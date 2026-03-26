import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/features/ai_job_apply/domain/repositories/ai_job_apply_repository.dart';
import 'package:tabashir/features/profile/presentation/cubit/profile_cubit.dart';
import 'onboarding_wizard_state.dart';

@injectable
class OnboardingWizardCubit extends Cubit<OnboardingWizardState> {
  final AiJobApplyRepository _repository;
  final ProfileCubit _profileCubit;

  OnboardingWizardCubit(
    this._repository,
    this._profileCubit,
  ) : super(const OnboardingWizardState());

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
        emit(state.copyWith(
          fileBytes: file.bytes,
          fileName: file.name,
          isLoading: true,
          errorMessage: null,
        ));

        try {
          final suggestions = await _repository.suggestJobTitles(
            fileBytes: file.bytes!,
            fileName: file.name,
          );

          emit(state.copyWith(
            suggestedRoles: suggestions,
            isLoading: false,
            currentStep: 2, // Move to roles step
          ));
        } catch (e) {
          emit(state.copyWith(
            isLoading: false,
            errorMessage: 'Failed to suggest job titles: ${e.toString()}',
            currentStep: 2, // Still move to roles step
          ));
        }
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
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

  void updatePersonalDetails({String? nationality, String? gender}) {
    emit(state.copyWith(
      nationality: nationality ?? state.nationality,
      gender: gender ?? state.gender,
    ));
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

    emit(state.copyWith(isProcessing: true, errorMessage: null, currentStep: 5));

    try {
      final email = _profileCubit.state.userProfileResponse?.user.email ?? '';
      
      final result = await _repository.addClient(
        email: email,
        fileBytes: state.fileBytes!,
        fileName: state.fileName!,
        positions: state.selectedRoles,
        locations: state.selectedLocations,
        nationality: state.nationality,
        gender: state.gender,
      );

      emit(state.copyWith(
        isProcessing: false,
        submissionResult: result,
      ));
    } catch (e) {
      emit(state.copyWith(
        isProcessing: false,
        errorMessage: e.toString(),
      ));
    }
  }
}

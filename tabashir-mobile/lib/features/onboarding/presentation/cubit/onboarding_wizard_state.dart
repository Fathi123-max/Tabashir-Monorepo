import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/network/models/jobs_match_response.dart';

part 'onboarding_wizard_state.freezed.dart';

@freezed
sealed class OnboardingWizardState with _$OnboardingWizardState {
  const OnboardingWizardState._();

  const factory OnboardingWizardState({
    @Default(1) int currentStep,
    Uint8List? fileBytes,
    String? fileName,
    @Default([]) List<String> suggestedRoles,
    @Default([]) List<String> selectedRoles,
    @Default([
      'Dubai',
      'Abu Dhabi',
      'Sharjah',
      'Ajman',
      'Umm Al Quwain',
      'Ras Al Khaimah',
      'Fujairah',
    ])
    List<String> selectedLocations,
    @Default('ae') String nationality,
    @Default('male') String gender,
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? errorMessage,
    JobsMatchResponse? submissionResult,
  }) = _OnboardingWizardState;

  factory OnboardingWizardState.initial() => const OnboardingWizardState();

  @override
  String toString() {
    final bytesLength = fileBytes != null ? '${fileBytes!.length} bytes' : 'null';
    return 'OnboardingWizardState(currentStep: $currentStep, fileBytes: [$bytesLength], fileName: $fileName, suggestedRoles: $suggestedRoles, selectedRoles: $selectedRoles, selectedLocations: $selectedLocations, nationality: $nationality, gender: $gender, isLoading: $isLoading, isProcessing: $isProcessing, errorMessage: $errorMessage, submissionResult: $submissionResult)';
  }
}

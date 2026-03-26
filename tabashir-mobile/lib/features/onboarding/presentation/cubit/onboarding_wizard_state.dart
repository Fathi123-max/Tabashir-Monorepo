import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/core/network/models/jobs_match_response.dart';

part 'onboarding_wizard_state.freezed.dart';

@freezed
class OnboardingWizardState with _$OnboardingWizardState {
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
}

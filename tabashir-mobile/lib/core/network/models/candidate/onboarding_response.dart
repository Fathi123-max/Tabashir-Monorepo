import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_response.freezed.dart';
part 'onboarding_response.g.dart';

/// Onboarding update response model
@freezed
sealed class OnboardingResponse with _$OnboardingResponse {
  const factory OnboardingResponse({
    required bool success,
    String? message,
    OnboardingData? data,
  }) = _OnboardingResponse;

  factory OnboardingResponse.fromJson(Map<String, dynamic> json) =>
      _$OnboardingResponseFromJson(json);
}

/// Onboarding data
@freezed
sealed class OnboardingData with _$OnboardingData {
  const factory OnboardingData({
    String? id,
    String? candidateId,
    String? fullName,
    String? email,
    String? phone,
    String? country,
    String? city,
    bool? onboardingCompleted,
    String? createdAt,
    String? updatedAt,
  }) = _OnboardingData;

  factory OnboardingData.fromJson(Map<String, dynamic> json) =>
      _$OnboardingDataFromJson(json);
}

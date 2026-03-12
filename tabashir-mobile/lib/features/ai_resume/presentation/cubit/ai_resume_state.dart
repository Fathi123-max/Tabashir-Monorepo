part of 'ai_resume_cubit.dart';

@freezed
sealed class AiResumeState with _$AiResumeState {
  const factory AiResumeState({
    @Default(AiResumeStatus.initial) AiResumeStatus status,
    @Default('') String errorMessage,
    CreateAiResumeResponse? resume,
  }) = _AiResumeState;

  factory AiResumeState.fromJson(Map<String, dynamic> json) =>
      _$AiResumeStateFromJson(json);
}

enum AiResumeStatus {
  initial,
  loading,
  success,
  error,
}

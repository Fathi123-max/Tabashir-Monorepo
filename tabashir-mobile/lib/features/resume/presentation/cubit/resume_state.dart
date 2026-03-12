part of 'resume_cubit.dart';

@freezed
sealed class ResumeState with _$ResumeState {
  const factory ResumeState({
    @Default(ResumeCubitStatus.initial) ResumeCubitStatus status,
    @Default('') String errorMessage,
    @Default([]) List<Resume> resumes,
    Resume? currentResume,
    String? exportUrl,
  }) = _ResumeState;

  factory ResumeState.fromJson(Map<String, dynamic> json) =>
      _$ResumeStateFromJson(json);
}

enum ResumeCubitStatus {
  initial,
  loading,
  loaded,
  error,
}

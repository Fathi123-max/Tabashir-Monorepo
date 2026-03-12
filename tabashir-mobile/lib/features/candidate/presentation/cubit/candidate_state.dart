part of 'candidate_cubit.dart';

@freezed
sealed class CandidateState with _$CandidateState {
  const factory CandidateState({
    @Default(CandidateStatus.initial) CandidateStatus status,
    @Default('') String errorMessage,
    CandidateProfile? profile,
    @Default([]) List<CandidateProfile> allCandidates,
    @Default([]) List<CandidateProfile> searchResults,
    @Default([]) List<String> resumes,
    @Default([]) List<String> jobApplications,
  }) = _CandidateState;

  factory CandidateState.fromJson(Map<String, dynamic> json) =>
      _$CandidateStateFromJson(json);
}

enum CandidateStatus {
  initial,
  loading,
  loaded,
  error,
}

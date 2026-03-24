import 'package:freezed_annotation/freezed_annotation.dart';

part 'resume_review_state.freezed.dart';

enum ResumeReviewStatus {
  initial,
  editing,
  syncing,
  success,
  failure,
}

@freezed
sealed class ResumeReviewState with _$ResumeReviewState {
  const factory ResumeReviewState({
    @Default(ResumeReviewStatus.initial) ResumeReviewStatus status,
    @Default({}) Map<String, dynamic> data,
    @Default(false) bool profileSynced,
    @Default(false) bool vaultSynced,
    String? errorMessage,
  }) = _ResumeReviewState;
}

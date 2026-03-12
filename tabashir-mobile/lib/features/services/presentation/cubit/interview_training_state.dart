part of 'interview_training_cubit.dart';

@freezed
class InterviewTrainingState with _$InterviewTrainingState {
  const factory InterviewTrainingState.initial() = InterviewTrainingInitial;
  const factory InterviewTrainingState.loading() = InterviewTrainingLoading;
  const factory InterviewTrainingState.waitlistSuccess() =
      InterviewTrainingWaitlistSuccess;
  const factory InterviewTrainingState.error(String message) =
      InterviewTrainingError;
}

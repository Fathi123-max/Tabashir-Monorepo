import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'interview_training_state.dart';
part 'interview_training_cubit.freezed.dart';

class InterviewTrainingCubit extends Cubit<InterviewTrainingState> {
  InterviewTrainingCubit() : super(const InterviewTrainingState.initial());

  Future<void> submitWaitlist(String email) async {
    if (state is! InterviewTrainingInitial) return;

    emit(const InterviewTrainingState.loading());

    try {
      // Simulate API call to add user to waitlist
      await Future.delayed(const Duration(seconds: 1));
      // In a real implementation, you would make an actual API call here
      // For now, we'll simulate success
      emit(const InterviewTrainingState.waitlistSuccess());
    } catch (e) {
      emit(InterviewTrainingState.error(e.toString()));
    }
  }

  Future<void> resetForm() async {
    emit(const InterviewTrainingState.initial());
  }
}

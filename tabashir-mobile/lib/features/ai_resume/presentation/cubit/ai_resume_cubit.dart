import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/network/models/ai_resume/create_ai_resume_request.dart';
import 'package:tabashir/core/network/models/ai_resume/create_ai_resume_response.dart';
import 'package:tabashir/features/ai_resume/domain/repositories/ai_resume_repository.dart';

part 'ai_resume_state.dart';
part 'ai_resume_cubit.freezed.dart';
part 'ai_resume_cubit.g.dart';

@Injectable(as: Cubit<AiResumeState>)
class AiResumeCubit extends Cubit<AiResumeState> {
  AiResumeCubit(this._repository) : super(const AiResumeState());

  final AiResumeRepository _repository;

  /// Create AI resume
  Future<void> createAiResume({
    required CreateAiResumeRequest request,
  }) async {
    emit(
      state.copyWith(
        status: AiResumeStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final response = await _repository.createAiResume(request: request);

      emit(
        state.copyWith(
          status: AiResumeStatus.success,
          resume: response,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AiResumeStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Clear error
  void clearError() {
    emit(
      state.copyWith(
        errorMessage: '',
        status: AiResumeStatus.initial,
      ),
    );
  }

  /// Reset to initial state
  void reset() {
    emit(const AiResumeState());
  }
}

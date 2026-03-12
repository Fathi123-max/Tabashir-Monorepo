import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/network/models/upload/upload_response.dart';
import 'package:tabashir/features/upload/domain/repositories/upload_repository.dart';

part 'upload_state.dart';
part 'upload_cubit.freezed.dart';
part 'upload_cubit.g.dart';

@Injectable(as: Cubit<UploadState>)
class UploadCubit extends Cubit<UploadState> {
  UploadCubit(this._repository) : super(const UploadState());

  final UploadRepository _repository;

  /// Upload file to the server
  Future<void> uploadFile({
    required File file,
    String? fileName,
  }) async {
    emit(
      state.copyWith(
        status: UploadStatus.loading,
        progress: 0,
        errorMessage: '',
      ),
    );

    try {
      final response = await _repository.uploadFile(
        file: file,
        fileName: fileName,
      );

      final updatedFiles = List<UploadResponse>.from(state.uploadedFiles)
        ..add(response);

      emit(
        state.copyWith(
          status: UploadStatus.success,
          progress: 100,
          uploadResponse: response,
          uploadedFiles: updatedFiles,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: UploadStatus.error,
          progress: 0,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Update upload progress
  void updateProgress(int progress) {
    emit(
      state.copyWith(progress: progress),
    );
  }

  /// Clear error
  void clearError() {
    emit(
      state.copyWith(
        errorMessage: '',
        status: UploadStatus.initial,
      ),
    );
  }

  /// Reset to initial state
  void reset() {
    emit(const UploadState());
  }

  /// Clear uploaded files
  void clearUploadedFiles() {
    emit(
      state.copyWith(uploadedFiles: []),
    );
  }
}

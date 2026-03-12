part of 'upload_cubit.dart';

@freezed
sealed class UploadState with _$UploadState {
  const factory UploadState({
    @Default(UploadStatus.initial) UploadStatus status,
    @Default(0) int progress,
    @Default('') String errorMessage,
    UploadResponse? uploadResponse,
    @Default([]) List<UploadResponse> uploadedFiles,
  }) = _UploadState;

  factory UploadState.fromJson(Map<String, dynamic> json) =>
      _$UploadStateFromJson(json);
}

enum UploadStatus {
  initial,
  loading,
  success,
  error,
}

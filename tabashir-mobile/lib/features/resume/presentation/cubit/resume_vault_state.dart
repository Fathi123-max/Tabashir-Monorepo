part of 'resume_vault_cubit.dart';

@freezed
sealed class ResumeVaultState with _$ResumeVaultState {
  const factory ResumeVaultState({
    @Default(ResumeVaultStatus.initial) ResumeVaultStatus status,
    @Default(<ResumeItem>[]) List<ResumeItem> resumes,
    String? errorMessage,
  }) = _ResumeVaultState;

  const ResumeVaultState._();

  bool get isLoading => status == ResumeVaultStatus.loading;
  bool get hasError => status == ResumeVaultStatus.failure;
  bool get isEmpty => resumes.isEmpty && status == ResumeVaultStatus.success;
  bool get isUploading => status == ResumeVaultStatus.uploading;
}

enum ResumeVaultStatus {
  initial,
  loading,
  success,
  failure,
  deleting,
  uploading,
}

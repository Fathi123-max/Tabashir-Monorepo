part of 'resume_import_cubit.dart';

@freezed
sealed class ResumeImportState with _$ResumeImportState {
  const factory ResumeImportState.initial() = _Initial;
  const factory ResumeImportState.loading() = _Loading;
  const factory ResumeImportState.success({
    ResumeItem? resume,
    Map<String, dynamic>? parsedData,
  }) = _Success;
  const factory ResumeImportState.error(String message) = _Error;
  const factory ResumeImportState.skipped() = _Skipped;
}

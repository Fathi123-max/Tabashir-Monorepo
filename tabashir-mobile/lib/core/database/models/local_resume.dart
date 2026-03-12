import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_resume.freezed.dart';
part 'local_resume.g.dart';

/// Model for storing resume files locally on device
@freezed
sealed class LocalResume with _$LocalResume {
  /// Constructor
  const factory LocalResume({
    required String id,
    required String name,
    required String title,
    required String filePath,
    required String fileType,
    required int fileSize,
    required DateTime createdAt,
    @Default(false) bool isDefault,
  }) = _LocalResume;

  factory LocalResume.fromJson(Map<String, dynamic> json) =>
      _$LocalResumeFromJson(json);
}

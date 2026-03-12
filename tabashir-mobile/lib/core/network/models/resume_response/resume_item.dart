import 'package:freezed_annotation/freezed_annotation.dart';

part 'resume_item.freezed.dart';
part 'resume_item.g.dart';

@freezed
sealed class ResumeItem with _$ResumeItem {
  const factory ResumeItem({
    required String id,
    required String filename,
    required String? originalUrl,
    required String? formatedUrl,
    required bool isAiResume,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? formatedContent, // Added for translation
    // UI-specific properties
    @Default('') String name, // Display name (defaults to filename)
    @Default('') String filePath, // Local or remote file path
    @Default('') String fileType, // File extension (PDF, DOC, etc.)
    @Default(0) int fileSize, // File size in bytes
    @Default('') String lastModified, // Formatted last modified date
    @Default(false) bool isDefault, // Whether this is the default resume
    @Default('') String title, // Resume title for display
  }) = _ResumeItem;

  factory ResumeItem.fromJson(Map<String, dynamic> json) =>
      _$ResumeItemFromJson(json);
}

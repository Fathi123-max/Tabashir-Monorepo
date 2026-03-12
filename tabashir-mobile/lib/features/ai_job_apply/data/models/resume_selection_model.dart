import 'package:freezed_annotation/freezed_annotation.dart';

part 'resume_selection_model.freezed.dart';
part 'resume_selection_model.g.dart';

/// Model representing a resume available for AI job application
@freezed
sealed class ResumeSelectionModel with _$ResumeSelectionModel {
  /// Creates a resume selection model
  const factory ResumeSelectionModel({
    /// Unique identifier for the resume
    required String id,

    /// Resume title/name
    required String title,

    /// Last updated timestamp
    required DateTime lastUpdated,

    /// Match percentage for AI recommendation (0-100)
    /// -1 indicates score not calculated yet
    @Default(-1) int matchPercentage,

    /// Whether this resume is recommended by AI
    @Default(false) bool isRecommended,

    /// Additional metadata
    /// Empty string means no description provided
    @Default('No description available') String description,
  }) = _ResumeSelectionModel;

  /// Creates a ResumeSelectionModel from JSON
  factory ResumeSelectionModel.fromJson(Map<String, dynamic> json) =>
      _$ResumeSelectionModelFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_preference_model.freezed.dart';
part 'location_preference_model.g.dart';

/// Sealed class representing a location preference for AI job application
@freezed
sealed class LocationPreferenceModel with _$LocationPreferenceModel {
  /// Creates a location preference model
  const factory LocationPreferenceModel({
    /// Unique identifier for the location
    required String id,

    /// Location name/title
    required String name,

    /// Whether this is a custom location added by user
    @Default(false) bool isCustom,

    /// Location type (e.g., city, remote, country)
    /// Empty string means type not specified
    @Default('unspecified') String type,

    /// Match score or relevance (0-100)
    /// -1 indicates score not calculated yet
    @Default(-1) int matchScore,

    /// Growth percentage for this location
    /// 0 means no data available
    @Default(0) int growthPercentage,

    /// Additional metadata
    /// Empty string means no description provided
    @Default('No description available') String description,
  }) = _LocationPreferenceModel;

  /// Creates a LocationPreferenceModel from JSON
  factory LocationPreferenceModel.fromJson(Map<String, dynamic> json) =>
      _$LocationPreferenceModelFromJson(json);
}

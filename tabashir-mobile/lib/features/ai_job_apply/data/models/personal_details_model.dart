import 'package:freezed_annotation/freezed_annotation.dart';

part 'personal_details_model.freezed.dart';
part 'personal_details_model.g.dart';

/// Gender enumeration
enum Gender {
  /// Male
  @JsonValue('male')
  male,

  /// Female
  @JsonValue('female')
  female,

  /// Prefer not to say
  @JsonValue('prefer_not_to_say')
  preferNotToSay,
}

/// Sealed class representing personal details for AI job application
@freezed
sealed class PersonalDetailsModel with _$PersonalDetailsModel {
  /// Creates a personal details model
  const factory PersonalDetailsModel({
    /// Nationality country code
    /// Can be null for users who haven't set it yet
    /// When null, it should be initialized from user profile or config
    String? nationality,

    /// Selected gender
    Gender? gender,

    /// Whether visa sponsorship is required
    @Default(false) bool requiresVisaSponsorship,
  }) = _PersonalDetailsModel;

  /// Creates a PersonalDetailsModel from JSON
  factory PersonalDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$PersonalDetailsModelFromJson(json);
}

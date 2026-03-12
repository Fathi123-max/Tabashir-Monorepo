import 'dart:convert';
import 'personal_details_model.dart';
import 'target_role_model.dart';
import 'location_preference_model.dart';

/// Class representing review data for AI job application
class ReviewModel {
  /// Creates a review model
  const ReviewModel({
    /// Number of resumes selected
    /// Default: 1 (at least one resume should be selected)
    this.selectedResumesCount = 1,

    /// Selected target roles
    /// Default: empty list (no roles selected yet)
    this.selectedRoles = const [],

    /// Selected locations
    /// Default: empty list (no locations selected yet)
    this.selectedLocations = const [],

    /// Personal details
    /// Default: null (not set yet)
    this.personalDetails,

    /// Number of matching jobs found
    /// Default: 0 (no matches yet, will be updated after submission)
    this.matchingJobsCount = 0,

    /// AI confidence percentage (0-100)
    /// Default: -1 (not calculated yet)
    this.aiConfidence = -1,
  });

  /// Creates a ReviewModel from JSON
  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    selectedResumesCount: json['selectedResumesCount'] as int? ?? 1,
    selectedRoles:
        (json['selectedRoles'] as List<dynamic>?)
            ?.map((e) => TargetRoleModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        const [],
    selectedLocations:
        (json['selectedLocations'] as List<dynamic>?)
            ?.map(
              (e) =>
                  LocationPreferenceModel.fromJson(e as Map<String, dynamic>),
            )
            .toList() ??
        const [],
    personalDetails: json['personalDetails'] == null
        ? null
        : PersonalDetailsModel.fromJson(
            json['personalDetails'] as Map<String, dynamic>,
          ),
    matchingJobsCount: json['matchingJobsCount'] as int? ?? 0,
    aiConfidence: json['aiConfidence'] as int? ?? -1,
  );

  /// Number of resumes selected
  final int selectedResumesCount;

  /// Selected target roles
  final List<TargetRoleModel> selectedRoles;

  /// Selected locations
  final List<LocationPreferenceModel> selectedLocations;

  /// Personal details
  final PersonalDetailsModel? personalDetails;

  /// Number of matching jobs found
  final int matchingJobsCount;

  /// AI confidence percentage
  final int aiConfidence;

  /// Creates a copy of this review model
  ReviewModel copyWith({
    int? selectedResumesCount,
    List<TargetRoleModel>? selectedRoles,
    List<LocationPreferenceModel>? selectedLocations,
    PersonalDetailsModel? personalDetails,
    int? matchingJobsCount,
    int? aiConfidence,
  }) => ReviewModel(
    selectedResumesCount: selectedResumesCount ?? this.selectedResumesCount,
    selectedRoles: selectedRoles ?? this.selectedRoles,
    selectedLocations: selectedLocations ?? this.selectedLocations,
    personalDetails: personalDetails ?? this.personalDetails,
    matchingJobsCount: matchingJobsCount ?? this.matchingJobsCount,
    aiConfidence: aiConfidence ?? this.aiConfidence,
  );

  /// Serializes this ReviewModel to a JSON map
  Map<String, dynamic> toJson() => {
    'selectedResumesCount': selectedResumesCount,
    'selectedRoles': selectedRoles.map((e) => e.toJson()).toList(),
    'selectedLocations': selectedLocations.map((e) => e.toJson()).toList(),
    'personalDetails': personalDetails?.toJson(),
    'matchingJobsCount': matchingJobsCount,
    'aiConfidence': aiConfidence,
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ReviewModel &&
        other.selectedResumesCount == selectedResumesCount &&
        other.selectedRoles == selectedRoles &&
        other.selectedLocations == selectedLocations &&
        other.personalDetails == personalDetails &&
        other.matchingJobsCount == matchingJobsCount &&
        other.aiConfidence == aiConfidence;
  }

  @override
  int get hashCode => Object.hash(
    selectedResumesCount,
    selectedRoles,
    selectedLocations,
    personalDetails,
    matchingJobsCount,
    aiConfidence,
  );

  @override
  String toString() =>
      'ReviewModel(selectedResumesCount: $selectedResumesCount, selectedRoles: ${selectedRoles.length} items, selectedLocations: ${selectedLocations.length} items, personalDetails: $personalDetails, matchingJobsCount: $matchingJobsCount, aiConfidence: $aiConfidence)';
}

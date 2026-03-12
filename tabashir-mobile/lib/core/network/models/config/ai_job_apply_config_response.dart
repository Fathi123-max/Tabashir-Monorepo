import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_job_apply_config_response.freezed.dart';
part 'ai_job_apply_config_response.g.dart';

/// Response model for AI Job Apply configuration
@freezed
sealed class AiJobApplyConfigResponse with _$AiJobApplyConfigResponse {
  const factory AiJobApplyConfigResponse({
    /// List of popular job roles
    required List<String> popularRoles,

    /// List of popular job locations
    required List<String> popularLocations,

    /// List of available nationalities
    required List<String> nationalities,

    /// Maximum number of roles to display in UI
    required int maxRolesToShow,

    /// Maximum number of locations to display in UI
    required int maxLocationsToShow,

    /// Default AI confidence score (0-100)
    required int defaultAiConfidence,

    /// Configuration version for cache invalidation
    required String version,

    /// When this configuration expires (ISO 8601 string)
    required String expiresAt,
  }) = _AiJobApplyConfigResponse;

  factory AiJobApplyConfigResponse.fromJson(Map<String, dynamic> json) =>
      _$AiJobApplyConfigResponseFromJson(json);
}

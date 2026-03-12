import 'package:freezed_annotation/freezed_annotation.dart';

part 'target_role_model.freezed.dart';
part 'target_role_model.g.dart';

/// Model representing a target role for AI job application
@freezed
sealed class TargetRoleModel with _$TargetRoleModel {
  /// Creates a target role model
  const factory TargetRoleModel({
    /// Unique identifier for the role
    required String id,

    /// Role title/name
    required String title,

    /// Whether this is a custom role added by user
    @Default(false) bool isCustom,

    /// Additional metadata
    /// Empty string means no description provided
    @Default('No description available') String description,

    /// Match score or relevance (0-100)
    /// -1 indicates score not calculated yet
    @Default(-1) int matchScore,

    /// Potential opportunities unlock by adding this role
    /// 0 means no data available
    @Default(0) int potentialRoles,
  }) = _TargetRoleModel;

  /// Creates a TargetRoleModel from JSON
  factory TargetRoleModel.fromJson(Map<String, dynamic> json) =>
      _$TargetRoleModelFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_update_response.freezed.dart';
part 'profile_update_response.g.dart';

/// Profile update response model
@freezed
sealed class ProfileUpdateResponse with _$ProfileUpdateResponse {
  const factory ProfileUpdateResponse({
    required bool success,
    required String message,
  }) = _ProfileUpdateResponse;

  factory ProfileUpdateResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileUpdateResponseFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_update_request.freezed.dart';
part 'profile_update_request.g.dart';

/// Profile update request model
@freezed
sealed class ProfileUpdateRequest with _$ProfileUpdateRequest {
  const factory ProfileUpdateRequest({
    required String name,
    required String email,
    required String phone,
    required String nationality,
    required String gender,
    required String jobTitle,
    String? location,
    required String company,
    required String education,
    String? linkedin,
  }) = _ProfileUpdateRequest;

  factory ProfileUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$ProfileUpdateRequestFromJson(json);
}

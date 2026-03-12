import 'package:freezed_annotation/freezed_annotation.dart';

part 'personal_info_request.freezed.dart';
part 'personal_info_request.g.dart';

/// Personal info update request model
@freezed
sealed class PersonalInfoRequest with _$PersonalInfoRequest {
  const factory PersonalInfoRequest({
    required String fullName,
    required String email,
    required String phone,
    required String country,
    required String city,
    String? dateOfBirth,
    String? nationality,
    String? gender,
    String? profilePicture,
    List<String>? languages,
    int? age,
    List<String>? skills,
  }) = _PersonalInfoRequest;

  factory PersonalInfoRequest.fromJson(Map<String, dynamic> json) =>
      _$PersonalInfoRequestFromJson(json);
}

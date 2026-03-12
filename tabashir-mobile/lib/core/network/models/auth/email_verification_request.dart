import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_verification_request.freezed.dart';
part 'email_verification_request.g.dart';

/// Email verification request model
@freezed
sealed class EmailVerificationRequest with _$EmailVerificationRequest {
  const factory EmailVerificationRequest({
    required String email,
    String? token,
  }) = _EmailVerificationRequest;

  factory EmailVerificationRequest.fromJson(Map<String, dynamic> json) =>
      _$EmailVerificationRequestFromJson(json);
}

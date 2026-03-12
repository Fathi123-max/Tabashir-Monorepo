import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_verification_response.freezed.dart';
part 'email_verification_response.g.dart';

/// Email verification response model
@freezed
sealed class EmailVerificationResponse with _$EmailVerificationResponse {
  const factory EmailVerificationResponse({
    required bool success,
    String? message,
    EmailVerificationData? data,
  }) = _EmailVerificationResponse;

  factory EmailVerificationResponse.fromJson(Map<String, dynamic> json) =>
      _$EmailVerificationResponseFromJson(json);
}

/// Email verification data
@freezed
sealed class EmailVerificationData with _$EmailVerificationData {
  const factory EmailVerificationData({
    String? userId,
    String? email,
    bool? verified,
    String? createdAt,
  }) = _EmailVerificationData;

  factory EmailVerificationData.fromJson(Map<String, dynamic> json) =>
      _$EmailVerificationDataFromJson(json);
}

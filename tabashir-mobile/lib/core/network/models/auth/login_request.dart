import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request.freezed.dart';
part 'login_request.g.dart';

/// Login request model
@freezed
sealed class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    /// User email
    required String email,

    /// User password
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}

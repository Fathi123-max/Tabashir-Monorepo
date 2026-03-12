import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request.freezed.dart';
part 'register_request.g.dart';

/// Register request model
@freezed
sealed class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    /// User full name
    required String name,

    /// User email
    required String email,

    /// User password
    required String password,

    /// User type (e.g., CANDIDATE, EMPLOYER)
    required String userType,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}

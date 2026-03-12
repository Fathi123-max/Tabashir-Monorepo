import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response.freezed.dart';
part 'auth_response.g.dart';

/// Authentication response model
@freezed
sealed class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    /// Success status
    bool? success,

    /// Response message
    String? message,

    /// User data (API uses 'user' field, map to 'data')
    UserData? data,

    /// Authentication token (API uses 'accessToken' field, map to 'token')
    String? token,

    /// Direct access to accessToken from API
    String? accessToken,

    /// Direct access to refreshToken from API
    String? refreshToken,

    /// Direct access to user object from API
    UserData? user,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

/// User data model
@freezed
sealed class UserData with _$UserData {
  const factory UserData({
    /// User ID
    String? id,

    /// User name
    String? name,

    /// User email
    String? email,

    /// User type
    String? userType,

    /// Profile image URL
    String? profileImage,

    /// Phone number
    String? phone,

    /// Date of birth
    String? dateOfBirth,

    /// Created at timestamp
    String? createdAt,

    /// Updated at timestamp
    String? updatedAt,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}

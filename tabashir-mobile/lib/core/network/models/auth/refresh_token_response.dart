import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_token_response.freezed.dart';
part 'refresh_token_response.g.dart';

/// Refresh token response model
@freezed
sealed class RefreshTokenResponse with _$RefreshTokenResponse {
  const factory RefreshTokenResponse({
    /// The new access token
    required String accessToken,
  }) = _RefreshTokenResponse;

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResponseFromJson(json);
}

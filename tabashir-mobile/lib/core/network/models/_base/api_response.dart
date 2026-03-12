import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

/// Base API response model
/// All API responses should follow this pattern
@freezed
sealed class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    required bool success,
    String? message,
    @JsonKey(includeToJson: false, includeFromJson: false) T? data,
  }) = _ApiResponse<T>;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$ApiResponseFromJson(json);
}

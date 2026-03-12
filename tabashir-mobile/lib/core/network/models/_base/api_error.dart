import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error.freezed.dart';
part 'api_error.g.dart';

/// API error model
/// Standardized error response from APIs
@freezed
sealed class ApiError with _$ApiError {
  const factory ApiError({
    required String message,
    int? statusCode,
    String? code,
  }) = _ApiError;

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'cv_format_response.freezed.dart';
part 'cv_format_response.g.dart';

/// Response model for CV format operation
@freezed
sealed class CVFormatResponse with _$CVFormatResponse {
  const factory CVFormatResponse({
    /// Success status
    required bool success,

    /// Formatted CV URL or data
    String? formattedCv,

    /// Message
    String? message,
  }) = _CVFormatResponse;

  factory CVFormatResponse.fromJson(Map<String, dynamic> json) =>
      _$CVFormatResponseFromJson(json);
}

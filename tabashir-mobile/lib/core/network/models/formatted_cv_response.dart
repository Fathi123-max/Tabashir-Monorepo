import 'package:freezed_annotation/freezed_annotation.dart';

part 'formatted_cv_response.freezed.dart';
part 'formatted_cv_response.g.dart';

/// Response model for format-cv-object API
@freezed
sealed class FormattedCVResponse with _$FormattedCVResponse {
  const factory FormattedCVResponse({
    @JsonKey(name: 'formatted_resume')
    required Map<String, dynamic> formattedResume,
  }) = _FormattedCVResponse;

  factory FormattedCVResponse.fromJson(Map<String, dynamic> json) =>
      _$FormattedCVResponseFromJson(json);
}

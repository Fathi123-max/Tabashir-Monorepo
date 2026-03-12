import 'package:freezed_annotation/freezed_annotation.dart';

part 'cv_format_from_raw_request.freezed.dart';
part 'cv_format_from_raw_request.g.dart';

/// Request model for formatting CV from raw text
@freezed
sealed class CVFormatFromRawRequest with _$CVFormatFromRawRequest {
  const factory CVFormatFromRawRequest({
    /// Raw CV text data
    @JsonKey(name: 'raw_data') required String rawData,

    /// Output language: 'regular' or 'arabic'
    @Default('regular') String? outputLanguage,
  }) = _CVFormatFromRawRequest;

  factory CVFormatFromRawRequest.fromJson(Map<String, dynamic> json) =>
      _$CVFormatFromRawRequestFromJson(json);
}

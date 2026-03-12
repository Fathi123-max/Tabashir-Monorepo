import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'raw_cv_input.freezed.dart';
part 'raw_cv_input.g.dart';

/// Request model for formatting CV from raw text
@freezed
sealed class RawCVInput with _$RawCVInput {
  const factory RawCVInput({
    /// User ID for the request
    @JsonKey(name: 'user_id') required String userId,

    /// Raw text extracted from CV
    @JsonKey(name: 'raw_data') required String rawData,

    /// Output language: 'regular' or 'arabic'
    @Default('regular') String? outputLanguage,
  }) = _RawCVInput;

  factory RawCVInput.fromJson(Map<String, dynamic> json) =>
      _$RawCVInputFromJson(json);
}

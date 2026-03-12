import 'package:freezed_annotation/freezed_annotation.dart';

part 'formatted_cv_input.freezed.dart';
part 'formatted_cv_input.g.dart';

/// Request model for formatting CV file
@freezed
sealed class FormattedCVInput with _$FormattedCVInput {
  const factory FormattedCVInput({
    /// Output CV language type
    String? outputLanguage,
  }) = _FormattedCVInput;

  factory FormattedCVInput.fromJson(Map<String, dynamic> json) =>
      _$FormattedCVInputFromJson(json);
}

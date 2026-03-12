import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_model.freezed.dart';
part 'email_model.g.dart';

/// Request model for email-based operations
@freezed
sealed class EmailModel with _$EmailModel {
  const factory EmailModel({
    /// Applicant's email
    required String email,
  }) = _EmailModel;

  factory EmailModel.fromJson(Map<String, dynamic> json) =>
      _$EmailModelFromJson(json);
}

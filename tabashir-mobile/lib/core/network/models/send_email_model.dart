import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_email_model.freezed.dart';
part 'send_email_model.g.dart';

/// Model for sending emails
@freezed
sealed class SendEmailModel with _$SendEmailModel {
  const factory SendEmailModel({
    /// Recipient email
    required String email,

    /// Email subject
    String? subject,

    /// Email body
    String? body,
  }) = _SendEmailModel;

  factory SendEmailModel.fromJson(Map<String, dynamic> json) =>
      _$SendEmailModelFromJson(json);
}

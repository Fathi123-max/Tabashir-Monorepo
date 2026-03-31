import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_linkedin_email_request.freezed.dart';
part 'send_linkedin_email_request.g.dart';

/// Request model for sending LinkedIn email
@freezed
sealed class SendLinkedInEmailRequest with _$SendLinkedInEmailRequest {
  const factory SendLinkedInEmailRequest({
    /// Recipient email
    @JsonKey(name: 'recipient_email') required String recipientEmail,

    /// Recipient name
    @JsonKey(name: 'recipient_name') required String recipientName,
    @JsonKey(name: 'payment_intent_id') required String paymentIntentId,
  }) = _SendLinkedInEmailRequest;

  factory SendLinkedInEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$SendLinkedInEmailRequestFromJson(json);
}

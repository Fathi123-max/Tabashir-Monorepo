import 'package:freezed_annotation/freezed_annotation.dart';
import 'job_create_model.dart';

part 'job_create_payload.freezed.dart';
part 'job_create_payload.g.dart';

/// Payload wrapper for job creation
@freezed
sealed class JobCreatePayload with _$JobCreatePayload {
  const factory JobCreatePayload({
    /// Job creation data
    required JobCreate payload,
  }) = _JobCreatePayload;

  factory JobCreatePayload.fromJson(Map<String, dynamic> json) =>
      _$JobCreatePayloadFromJson(json);
}

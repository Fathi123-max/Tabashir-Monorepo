import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_update_response.freezed.dart';
part 'job_update_response.g.dart';

/// Response model for job update
@freezed
sealed class JobUpdateResponse with _$JobUpdateResponse {
  const factory JobUpdateResponse({
    /// Success status
    required bool success,

    /// Response message
    required String message,
  }) = _JobUpdateResponse;

  factory JobUpdateResponse.fromJson(Map<String, dynamic> json) =>
      _$JobUpdateResponseFromJson(json);
}

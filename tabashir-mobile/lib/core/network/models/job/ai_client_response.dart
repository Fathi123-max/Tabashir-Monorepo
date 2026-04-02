import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_client_response.freezed.dart';
part 'ai_client_response.g.dart';

@freezed
sealed class AiClientResponse with _$AiClientResponse {
  const factory AiClientResponse({
    @Default(false) bool success,
    String? message,
    AiClientData? data,
  }) = _AiClientResponse;

  factory AiClientResponse.fromJson(Map<String, dynamic> json) =>
      _$AiClientResponseFromJson(json);
}

@freezed
sealed class AiClientData with _$AiClientData {
  const factory AiClientData({
    String? nationality,
    String? gender,
    String? location,
    String? positions,
    String? filename,
    @JsonKey(name: 'jobs_to_apply_number') int? jobsToApplyNumber,
    @JsonKey(name: 'job_matching') int? jobMatching,
  }) = _AiClientData;

  factory AiClientData.fromJson(Map<String, dynamic> json) =>
      _$AiClientDataFromJson(json);
}

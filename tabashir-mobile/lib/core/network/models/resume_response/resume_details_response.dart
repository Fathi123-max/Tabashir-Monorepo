import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/core/network/models/resume_response/resume_item.dart';

part 'resume_details_response.freezed.dart';
part 'resume_details_response.g.dart';

@freezed
sealed class ResumeDetailsResponse with _$ResumeDetailsResponse {
  const factory ResumeDetailsResponse({
    required bool success,
    required ResumeItem resume,
  }) = _ResumeDetailsResponse;

  factory ResumeDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$ResumeDetailsResponseFromJson(json);
}

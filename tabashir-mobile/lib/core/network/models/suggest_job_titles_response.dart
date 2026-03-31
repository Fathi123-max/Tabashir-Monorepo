import 'package:freezed_annotation/freezed_annotation.dart';

part 'suggest_job_titles_response.freezed.dart';
part 'suggest_job_titles_response.g.dart';

@freezed
sealed class SuggestJobTitlesResponse with _$SuggestJobTitlesResponse {
  const factory SuggestJobTitlesResponse({
    required bool success,
    @JsonKey(name: 'suggested_job_titles')
    required List<String> suggestedJobTitles,
  }) = _SuggestJobTitlesResponse;

  factory SuggestJobTitlesResponse.fromJson(Map<String, dynamic> json) =>
      _$SuggestJobTitlesResponseFromJson(json);
}

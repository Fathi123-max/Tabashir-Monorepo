import 'package:freezed_annotation/freezed_annotation.dart';

part 'jobs_count_by_city_response.freezed.dart';
part 'jobs_count_by_city_response.g.dart';

/// Response model for jobs count by city
@freezed
sealed class JobsCountByCityResponse with _$JobsCountByCityResponse {
  const factory JobsCountByCityResponse({
    /// Success status
    required bool success,

    /// Data containing city counts
    required List<CityCount> data,
  }) = _JobsCountByCityResponse;

  factory JobsCountByCityResponse.fromJson(Map<String, dynamic> json) =>
      _$JobsCountByCityResponseFromJson(json);
}

/// Model for a city and its job count
@freezed
sealed class CityCount with _$CityCount {
  const factory CityCount({
    /// City name
    @JsonKey(name: 'vacancy_city') required String vacancyCity,

    /// Number of jobs in this city
    required int count,
  }) = _CityCount;

  factory CityCount.fromJson(Map<String, dynamic> json) =>
      _$CityCountFromJson(json);
}

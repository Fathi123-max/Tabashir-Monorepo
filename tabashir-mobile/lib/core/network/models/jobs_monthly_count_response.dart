import 'package:freezed_annotation/freezed_annotation.dart';

part 'jobs_monthly_count_response.freezed.dart';
part 'jobs_monthly_count_response.g.dart';

/// Response model for jobs monthly count
@freezed
sealed class JobsMonthlyCountResponse with _$JobsMonthlyCountResponse {
  const factory JobsMonthlyCountResponse({
    /// Success status
    required bool success,

    /// Data containing monthly counts
    required List<MonthlyCount> data,
  }) = _JobsMonthlyCountResponse;

  factory JobsMonthlyCountResponse.fromJson(Map<String, dynamic> json) =>
      _$JobsMonthlyCountResponseFromJson(json);
}

/// Model for a month and its job count
@freezed
sealed class MonthlyCount with _$MonthlyCount {
  const factory MonthlyCount({
    /// Month (YYYY-MM format)
    required String month,

    /// Number of jobs in this month
    required int count,
  }) = _MonthlyCount;

  factory MonthlyCount.fromJson(Map<String, dynamic> json) =>
      _$MonthlyCountFromJson(json);
}

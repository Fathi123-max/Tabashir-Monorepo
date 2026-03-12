// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_match_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobsMatchResponse _$JobsMatchResponseFromJson(Map<String, dynamic> json) =>
    _JobsMatchResponse(
      matchedJobs: (json['matchedJobs'] as List<dynamic>?)
          ?.map((e) => MatchedJob.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$JobsMatchResponseToJson(_JobsMatchResponse instance) =>
    <String, dynamic>{
      'matchedJobs': instance.matchedJobs,
      'total': instance.total,
    };

_MatchedJob _$MatchedJobFromJson(Map<String, dynamic> json) => _MatchedJob(
  jobId: json['jobId'] as String?,
  jobTitle: json['jobTitle'] as String?,
  companyName: json['companyName'] as String?,
  matchScore: (json['matchScore'] as num?)?.toDouble(),
  matchPercentage: json['matchPercentage'] as String?,
);

Map<String, dynamic> _$MatchedJobToJson(_MatchedJob instance) =>
    <String, dynamic>{
      'jobId': instance.jobId,
      'jobTitle': instance.jobTitle,
      'companyName': instance.companyName,
      'matchScore': instance.matchScore,
      'matchPercentage': instance.matchPercentage,
    };

_ApplyJobsResponse _$ApplyJobsResponseFromJson(Map<String, dynamic> json) =>
    _ApplyJobsResponse(
      message: json['message'] as String,
      success: json['success'] as bool,
      summary: ApplySummary.fromJson(json['summary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApplyJobsResponseToJson(_ApplyJobsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'success': instance.success,
      'summary': instance.summary,
    };

_ApplySummary _$ApplySummaryFromJson(Map<String, dynamic> json) =>
    _ApplySummary(
      applyResult: ApplyResult.fromJson(
        json['apply_result'] as Map<String, dynamic>,
      ),
      email: json['email'] as String,
      rankingResult: RankingResult.fromJson(
        json['ranking_result'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ApplySummaryToJson(_ApplySummary instance) =>
    <String, dynamic>{
      'apply_result': instance.applyResult,
      'email': instance.email,
      'ranking_result': instance.rankingResult,
    };

_ApplyResult _$ApplyResultFromJson(Map<String, dynamic> json) => _ApplyResult(
  date: json['date'] as String,
  email: json['email'] as String,
  matchesProcessed: (json['matches_processed'] as num).toInt(),
);

Map<String, dynamic> _$ApplyResultToJson(_ApplyResult instance) =>
    <String, dynamic>{
      'date': instance.date,
      'email': instance.email,
      'matches_processed': instance.matchesProcessed,
    };

_RankingResult _$RankingResultFromJson(Map<String, dynamic> json) =>
    _RankingResult(
      blockedPairsCount: (json['blocked_pairs_count'] as num).toInt(),
      clientEmail: json['client_email'] as String,
      clientsProcessed: (json['clients_processed'] as num).toInt(),
      executionTimeSeconds: (json['execution_time_seconds'] as num).toDouble(),
      existingMatchesSkipped: (json['existing_matches_skipped'] as num).toInt(),
      jobsProcessed: (json['jobs_processed'] as num).toInt(),
      matchesFound: (json['matches_found'] as num).toInt(),
      matchesInserted: (json['matches_inserted'] as num).toInt(),
      processingDate: json['processing_date'] as String,
    );

Map<String, dynamic> _$RankingResultToJson(_RankingResult instance) =>
    <String, dynamic>{
      'blocked_pairs_count': instance.blockedPairsCount,
      'client_email': instance.clientEmail,
      'clients_processed': instance.clientsProcessed,
      'execution_time_seconds': instance.executionTimeSeconds,
      'existing_matches_skipped': instance.existingMatchesSkipped,
      'jobs_processed': instance.jobsProcessed,
      'matches_found': instance.matchesFound,
      'matches_inserted': instance.matchesInserted,
      'processing_date': instance.processingDate,
    };

_ApplyToJobResponse _$ApplyToJobResponseFromJson(Map<String, dynamic> json) =>
    _ApplyToJobResponse(
      appliedJobId: (json['appliedJobId'] as num).toInt(),
      email: json['email'] as String,
      message: json['message'] as String,
      success: json['success'] as bool,
      user: ApplyToJobUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApplyToJobResponseToJson(_ApplyToJobResponse instance) =>
    <String, dynamic>{
      'appliedJobId': instance.appliedJobId,
      'email': instance.email,
      'message': instance.message,
      'success': instance.success,
      'user': instance.user,
    };

_ApplyToJobUser _$ApplyToJobUserFromJson(Map<String, dynamic> json) =>
    _ApplyToJobUser(
      date: json['date'] as String,
      email: json['email'] as String,
      jobApplied: (json['jobApplied'] as num).toInt(),
      rankingId: (json['rankingId'] as num).toInt(),
    );

Map<String, dynamic> _$ApplyToJobUserToJson(_ApplyToJobUser instance) =>
    <String, dynamic>{
      'date': instance.date,
      'email': instance.email,
      'jobApplied': instance.jobApplied,
      'rankingId': instance.rankingId,
    };

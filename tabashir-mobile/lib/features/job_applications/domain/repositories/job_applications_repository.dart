import 'package:tabashir/core/network/models/applied_jobs_response.dart';
import 'package:tabashir/core/network/models/jobs_count_response.dart';

/// Repository interface for job applications operations
/// Defines the contract for job application data operations
abstract class JobApplicationsRepository {
  /// Get user's applied jobs
  /// Returns [AppliedJobsResponse] with user's job application history
  Future<AppliedJobsResponse> getAppliedJobs({
    required String email,
  });

  /// Get count of user's applied jobs
  /// Returns [JobsCountResponse] with application count
  Future<JobsCountResponse> getAppliedJobsCount({
    required String email,
  });
}

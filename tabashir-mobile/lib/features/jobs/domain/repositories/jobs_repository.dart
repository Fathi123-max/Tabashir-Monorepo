import 'dart:io';

import 'package:tabashir/core/network/models/applied_jobs_response.dart';
import 'package:tabashir/core/network/models/job_details_response.dart';
import 'package:tabashir/core/network/models/jobs_match_response.dart';

/// Repository interface for job operations
/// Defines the contract for job-related data operations
abstract class JobsRepository {
  /// Get all available jobs with pagination, search, and optional filters
  /// Returns list of [JobDetailsResponse]
  /// [page] - Page number (0-indexed, default 0)
  /// [limit] - Number of items per page (default 20)
  /// [search] - Search query for job title, company, or skills
  /// [locations] - Filter by locations (Remote, On-site, Hybrid, or city names)
  /// [jobTypes] - Filter by job types (Full-time, Part-time, Contract, Internship)
  /// [experienceLevels] - Filter by experience levels (Entry-Level, Mid-Level, Senior, Lead)
  /// [minSalary] - Minimum salary filter
  /// [maxSalary] - Maximum salary filter
  /// [skills] - Filter by required skills
  /// [sort] - Sort order (Relevance, Newest, Salary)
  Future<List<JobDetailsResponse>> getJobs({
    int page = 0,
    int limit = 20,
    String? search,
    List<String>? locations,
    List<String>? jobTypes,
    List<String>? experienceLevels,
    int? minSalary,
    int? maxSalary,
    List<String>? skills,
    String? sort,
    String? email,
  });

  /// Get job details by job ID
  /// Returns [JobDetailsResponse] for the specified job
  Future<JobDetailsResponse> getJobById({
    required String jobId,
    String? email,
  });

  /// Get user's applied jobs
  /// Returns [AppliedJobsResponse] with user's job applications
  Future<AppliedJobsResponse> getAppliedJobs({
    required String email,
  });

  /// Apply to a specific job
  /// Returns [JobsMatchResponse] with application results
  Future<JobsMatchResponse> applyToJob({
    required String jobId,
    required File resumeFile,
    required String email,
    required String nationality,
    required String gender,
  });
}

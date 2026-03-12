import 'package:tabashir/features/recruiter/data/models/recruiter_model.dart';

/// Repository interface for recruiter operations
/// Defines the contract for recruiter data operations
abstract class RecruiterRepository {
  /// Get recruiter profile by ID
  /// Returns [RecruiterProfile]
  Future<RecruiterProfile> getRecruiterProfile({
    required String recruiterId,
  });

  /// Create a new recruiter profile
  /// Returns the created [RecruiterProfile]
  Future<RecruiterProfile> createRecruiterProfile({
    required RecruiterProfile profile,
  });

  /// Update recruiter profile
  /// Returns the updated [RecruiterProfile]
  Future<RecruiterProfile> updateRecruiterProfile({
    required String recruiterId,
    required RecruiterProfile profile,
  });

  /// Delete recruiter profile
  /// Returns void when operation is complete
  Future<void> deleteRecruiterProfile({
    required String recruiterId,
  });

  /// Create a new job posting
  /// Returns the created [JobPosting]
  Future<JobPosting> createJobPosting({
    required JobPosting jobPosting,
  });

  /// Update job posting
  /// Returns the updated [JobPosting]
  Future<JobPosting> updateJobPosting({
    required String jobId,
    required JobPosting jobPosting,
  });

  /// Delete job posting
  /// Returns void when operation is complete
  Future<void> deleteJobPosting({
    required String jobId,
  });

  /// Get all job postings by recruiter
  /// Returns list of [JobPosting]
  Future<List<JobPosting>> getJobPostings({
    required String recruiterId,
    JobStatus? status,
  });

  /// Get job posting by ID
  /// Returns [JobPosting]
  Future<JobPosting> getJobPosting({
    required String jobId,
  });

  /// Get applications for a job
  /// Returns list of [JobApplication]
  Future<List<JobApplication>> getJobApplications({
    required String jobId,
  });

  /// Update application status
  /// Returns void when operation is complete
  Future<void> updateApplicationStatus({
    required String applicationId,
    required ApplicationStatus status,
    String? notes,
  });

  /// Add note to application
  /// Returns void when operation is complete
  Future<void> addApplicationNote({
    required String applicationId,
    required String note,
  });

  /// Get all applications for recruiter
  /// Returns list of [JobApplication]
  Future<List<JobApplication>> getAllApplications({
    required String recruiterId,
    ApplicationStatus? status,
  });
}

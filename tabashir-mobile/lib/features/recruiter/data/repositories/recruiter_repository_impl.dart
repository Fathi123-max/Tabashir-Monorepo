import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:tabashir/core/services/isar_service.dart';
import 'package:tabashir/features/recruiter/data/models/recruiter_model.dart';
import 'package:tabashir/features/recruiter/domain/repositories/recruiter_repository.dart';

/// Implementation of RecruiterRepository
@Injectable(as: RecruiterRepository)
class RecruiterRepositoryImpl implements RecruiterRepository {
  RecruiterRepositoryImpl(this._isarService);

  final IsarService _isarService;
  static const String _recruitersKey = 'recruiters_data';
  static const String _jobsKey = 'jobs_data';
  static const String _applicationsKey = 'applications_data';

  @override
  Future<RecruiterProfile> getRecruiterProfile({
    required String recruiterId,
  }) async {
    try {
      final jsonString = _isarService.prefs.getString('recruiter_$recruiterId');
      if (jsonString == null) {
        throw Exception('Recruiter profile not found');
      }
      final json = jsonDecode(jsonString);
      return RecruiterProfile.fromJson(json as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to get recruiter profile: $e');
    }
  }

  @override
  Future<RecruiterProfile> createRecruiterProfile({
    required RecruiterProfile profile,
  }) async {
    try {
      final jsonString = jsonEncode(profile.toJson());
      await _isarService.prefs.setString('recruiter_${profile.id}', jsonString);
      return profile;
    } catch (e) {
      throw Exception('Failed to create recruiter profile: $e');
    }
  }

  @override
  Future<RecruiterProfile> updateRecruiterProfile({
    required String recruiterId,
    required RecruiterProfile profile,
  }) async {
    try {
      final jsonString = jsonEncode(profile.toJson());
      await _isarService.prefs.setString('recruiter_$recruiterId', jsonString);
      return profile;
    } catch (e) {
      throw Exception('Failed to update recruiter profile: $e');
    }
  }

  @override
  Future<void> deleteRecruiterProfile({
    required String recruiterId,
  }) async {
    try {
      await _isarService.prefs.remove('recruiter_$recruiterId');
    } catch (e) {
      throw Exception('Failed to delete recruiter profile: $e');
    }
  }

  @override
  Future<JobPosting> createJobPosting({
    required JobPosting jobPosting,
  }) async {
    try {
      final jsonString = jsonEncode(jobPosting.toJson());
      await _isarService.prefs.setString('job_${jobPosting.id}', jsonString);
      return jobPosting;
    } catch (e) {
      throw Exception('Failed to create job posting: $e');
    }
  }

  @override
  Future<JobPosting> updateJobPosting({
    required String jobId,
    required JobPosting jobPosting,
  }) async {
    try {
      final jsonString = jsonEncode(jobPosting.toJson());
      await _isarService.prefs.setString('job_$jobId', jsonString);
      return jobPosting;
    } catch (e) {
      throw Exception('Failed to update job posting: $e');
    }
  }

  @override
  Future<void> deleteJobPosting({
    required String jobId,
  }) async {
    try {
      await _isarService.prefs.remove('job_$jobId');
    } catch (e) {
      throw Exception('Failed to delete job posting: $e');
    }
  }

  @override
  Future<List<JobPosting>> getJobPostings({
    required String recruiterId,
    JobStatus? status,
  }) async {
    try {
      final jobs = <JobPosting>[];
      final prefs = _isarService.prefs;

      for (final key in prefs.getKeys()) {
        if (key.startsWith('job_')) {
          final jsonString = prefs.getString(key);
          if (jsonString != null) {
            final json = jsonDecode(jsonString);
            final job = JobPosting.fromJson(json as Map<String, dynamic>);
            if (job.recruiterId == recruiterId &&
                (status == null || job.status == status)) {
              jobs.add(job);
            }
          }
        }
      }

      return jobs;
    } catch (e) {
      throw Exception('Failed to get job postings: $e');
    }
  }

  @override
  Future<JobPosting> getJobPosting({
    required String jobId,
  }) async {
    try {
      final jsonString = _isarService.prefs.getString('job_$jobId');
      if (jsonString == null) {
        throw Exception('Job posting not found');
      }
      final json = jsonDecode(jsonString);
      return JobPosting.fromJson(json as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to get job posting: $e');
    }
  }

  @override
  Future<List<JobApplication>> getJobApplications({
    required String jobId,
  }) async {
    try {
      final applications = <JobApplication>[];
      final prefs = _isarService.prefs;

      for (final key in prefs.getKeys()) {
        if (key.startsWith('application_')) {
          final jsonString = prefs.getString(key);
          if (jsonString != null) {
            final json = jsonDecode(jsonString);
            final application = JobApplication.fromJson(
              json as Map<String, dynamic>,
            );
            if (application.jobId == jobId) {
              applications.add(application);
            }
          }
        }
      }

      return applications;
    } catch (e) {
      throw Exception('Failed to get job applications: $e');
    }
  }

  @override
  Future<void> updateApplicationStatus({
    required String applicationId,
    required ApplicationStatus status,
    String? notes,
  }) async {
    try {
      final jsonString = _isarService.prefs.getString(
        'application_$applicationId',
      );
      if (jsonString == null) {
        throw Exception('Application not found');
      }

      final json = jsonDecode(jsonString);
      final application = JobApplication.fromJson(json as Map<String, dynamic>);

      final updatedApplication = application.copyWith(
        status: status,
        notes: notes ?? application.notes,
      );

      final updatedJsonString = jsonEncode(updatedApplication.toJson());
      await _isarService.prefs.setString(
        'application_$applicationId',
        updatedJsonString,
      );
    } catch (e) {
      throw Exception('Failed to update application status: $e');
    }
  }

  @override
  Future<void> addApplicationNote({
    required String applicationId,
    required String note,
  }) async {
    try {
      final jsonString = _isarService.prefs.getString(
        'application_$applicationId',
      );
      if (jsonString == null) {
        throw Exception('Application not found');
      }

      final json = jsonDecode(jsonString);
      final application = JobApplication.fromJson(json as Map<String, dynamic>);

      final updatedNote =
          application.notes == null || application.notes!.isEmpty
          ? note
          : '${application.notes}\n$note';

      final updatedApplication = application.copyWith(notes: updatedNote);

      final updatedJsonString = jsonEncode(updatedApplication.toJson());
      await _isarService.prefs.setString(
        'application_$applicationId',
        updatedJsonString,
      );
    } catch (e) {
      throw Exception('Failed to add application note: $e');
    }
  }

  @override
  Future<List<JobApplication>> getAllApplications({
    required String recruiterId,
    ApplicationStatus? status,
  }) async {
    try {
      final applications = <JobApplication>[];
      final prefs = _isarService.prefs;

      for (final key in prefs.getKeys()) {
        if (key.startsWith('application_')) {
          final jsonString = prefs.getString(key);
          if (jsonString != null) {
            final json = jsonDecode(jsonString);
            final application = JobApplication.fromJson(
              json as Map<String, dynamic>,
            );

            final jobJsonString = prefs.getString('job_${application.jobId}');
            if (jobJsonString != null) {
              final jobJson = jsonDecode(jobJsonString);
              final job = JobPosting.fromJson(jobJson as Map<String, dynamic>);

              if (job.recruiterId == recruiterId &&
                  (status == null || application.status == status)) {
                applications.add(application);
              }
            }
          }
        }
      }

      return applications;
    } catch (e) {
      throw Exception('Failed to get all applications: $e');
    }
  }
}

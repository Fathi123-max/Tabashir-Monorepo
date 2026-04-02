import 'package:injectable/injectable.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/network/models/job_details_response.dart';
import 'package:tabashir/core/network/models/user/user_profile_response.dart';
import 'package:tabashir/core/services/job_match_service.dart';
import '../data/models/job_details.dart';
import '../domain/repositories/jobs_repository.dart';

/// Service class for managing job details operations.
/// Provides methods to fetch job details, apply to jobs, save jobs, and share job information.
@injectable
class JobDetailsService {
  JobDetailsService(this._jobsRepository);

  final JobsRepository _jobsRepository;
  final JobMatchService _jobMatchService = getIt<JobMatchService>();

  /// Fetches detailed information for the job with the given [jobId].
  /// Uses the API via JobsRepository to get real data.
  Future<JobDetails> getJobDetails(
    String jobId, {
    CandidateProfileData? userProfile,
    String? userEmail,
  }) async {
    print('[JOB_DETAILS_SERVICE] Fetching job details for jobId: $jobId');
    print(
      '[JOB_DETAILS_SERVICE] Correlation: userProfile = ${userProfile != null}, userEmail = $userEmail',
    );

    try {
      // Fetch job details from API, passing userEmail for backend matching
      final jobDetailsResponse = await _jobsRepository.getJobById(
        jobId: jobId,
        email: userEmail,
      );

      print('[JOB_DETAILS_SERVICE] Received API response: $jobDetailsResponse');

      // Map API response to UI model with user profile for match calculation
      return _mapApiResponseToJobDetails(jobDetailsResponse, userProfile);
    } catch (e) {
      print('[JOB_DETAILS_SERVICE] Error fetching job details: $e');
      rethrow;
    }
  }

  /// Maps API response to UI model - ONLY real backend data, NO mock data
  JobDetails _mapApiResponseToJobDetails(
    JobDetailsResponse response,
    CandidateProfileData? userProfile,
  ) {
    // Use match percentage from API response
    final matchPercentage = _jobMatchService.formatMatchPercentage(
      response.matchPercentage,
    );

    return JobDetails(
      id: response.jobId?.toString() ?? 'unknown',
      title: response.jobTitle ?? 'Untitled Position',
      description: response.jobDescription ?? 'No description available',
      company: response.companyName ?? 'Unknown Company',
      location: response.location ?? 'Not specified',
      salary: response.salary ?? 'Not specified',
      matchPercentage: matchPercentage,
      tags: _extractTags(response),
      requirements: _extractRequirements(response)
          .where((req) => req.trim().isNotEmpty)
          .toList(),
      skills: _extractSkills(response),
      // Real backend data
      employmentType: response.jobType,
      experienceLevel: response.experience,
      workingHours: response.workingHours,
      workingDays: response.workingDays,
      phone: response.phone,
      applyUrl: response.applyUrl,
      applicationEmail: response.applicationEmail,
      source: response.source,
      nationality: response.nationality,
      gender: response.gender,
      academicQualification: response.academicQualification,
      postedDate: response.jobDate,
      isSaved: response.isSaved ?? false,
    );
  }

  /// Extracts tags from the job response
  List<String> _extractTags(JobDetailsResponse response) {
    final tags = <String>[];

    if (response.jobType != null && response.jobType!.isNotEmpty) {
      tags.add(response.jobType!);
    }

    if (response.location != null) {
      // Add location as a tag
      final location = response.location!;
      if (location.toLowerCase().contains('remote')) {
        tags.add('Remote');
      } else if (location.toLowerCase().contains('hybrid')) {
        tags.add('Hybrid');
      } else {
        tags.add('On-site');
      }
    }

    if (response.workingHours != null && response.workingHours!.isNotEmpty) {
      tags.add(response.workingHours!);
    }

    if (response.workingDays != null && response.workingDays!.isNotEmpty) {
      tags.add(response.workingDays!);
    }

    if (response.source != null && response.source!.isNotEmpty) {
      tags.add(response.source!);
    }

    if (response.nationality != null && response.nationality!.isNotEmpty) {
      tags.add(response.nationality!);
    }

    if (response.gender != null && response.gender!.isNotEmpty) {
      tags.add(response.gender!);
    }

    return tags;
  }

  /// Extracts requirements from academic qualification and experience
  List<String> _extractRequirements(JobDetailsResponse response) {
    final requirements = <String>[];

    if (response.academicQualification != null &&
        response.academicQualification!.isNotEmpty) {
      requirements.add('Education: ${response.academicQualification!}');
    }

    if (response.experience != null && response.experience!.isNotEmpty) {
      requirements.add('Experience: ${response.experience!}');
    }

    return requirements;
  }

  /// Extracts skills from languages
  List<String> _extractSkills(JobDetailsResponse response) {
    final skills = <String>[];

    if (response.languages != null && response.languages!.isNotEmpty) {
      // Split languages by comma and add each as a skill
      final languageList = response.languages!
          .split(',')
          .map((lang) => lang.trim())
          .where((lang) => lang.isNotEmpty)
          .toList();
      skills.addAll(languageList);
    }

    return skills;
  }

  /// Submits an application for the job with the given [jobId].
  /// In a real implementation, this would send a request to the backend to apply to the job.
  Future<void> applyToJob(String jobId) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // In a real implementation, this would send a request to apply to the job
  }

  /// Prepares the job with the given [jobId] for sharing.
  /// In a real implementation, this would trigger the system's share functionality.
  Future<void> shareJob(String jobId) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // In a real implementation, this would trigger the system's share functionality
  }
}

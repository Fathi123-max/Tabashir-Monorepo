import 'package:injectable/injectable.dart';
import 'package:tabashir/core/network/models/user/user_profile_response.dart';
import 'package:tabashir/core/network/models/job_details_response.dart';

/// Service for calculating job match percentages based on user profile vs job requirements
@injectable
class JobMatchService {
  /// Calculate match percentage between user profile and job
  /// Returns a string like "85% Match"
  String calculateMatchPercentage({
    required CandidateProfileData? userProfile,
    required JobDetailsResponse job,
  }) {
    if (userProfile == null) {
      return '50% Match'; // Default if no profile data
    }

    // Calculate individual match scores (0-100)
    final skillsScore = _calculateSkillsMatch(userProfile, job);
    final experienceScore = _calculateExperienceMatch(userProfile, job);
    final locationScore = _calculateLocationMatch(userProfile, job);
    final jobTypeScore = _calculateJobTypeMatch(userProfile, job);

    // Weighted average (skills 40%, experience 30%, location 20%, job type 10%)
    final weightedScore = (skillsScore * 0.4) +
        (experienceScore * 0.3) +
        (locationScore * 0.2) +
        (jobTypeScore * 0.1);

    // Round to nearest integer and convert to percentage string
    final percentage = weightedScore.round();
    return '$percentage% Match';
  }

  /// Calculate skills match score (0-100)
  /// Weights: 40% of total score
  int _calculateSkillsMatch(
    CandidateProfileData userProfile,
    JobDetailsResponse job,
  ) {
    final userSkills = userProfile.skills ?? [];
    final jobSkills = _extractJobSkills(job);

    if (userSkills.isEmpty && jobSkills.isEmpty) {
      return 70; // Neutral score if both have no skills listed
    }

    if (userSkills.isEmpty) {
      return 40; // Low score if user has no skills but job requires some
    }

    if (jobSkills.isEmpty) {
      return 80; // High score if job doesn't specify skills
    }

    // Calculate overlap
    int matches = 0;
    for (final userSkill in userSkills) {
      for (final jobSkill in jobSkills) {
        if (_isSkillMatch(userSkill, jobSkill)) {
          matches++;
          break;
        }
      }
    }

    final matchRatio = matches / jobSkills.length;
    return (matchRatio * 100).round();
  }

  /// Calculate experience match score (0-100)
  /// Weights: 30% of total score
  int _calculateExperienceMatch(
    CandidateProfileData userProfile,
    JobDetailsResponse job,
  ) {
    final userExp = (userProfile.experience ?? '').toLowerCase();
    final jobExp = (job.experience ?? '').toLowerCase();

    if (userExp.isEmpty && jobExp.isEmpty) {
      return 70; // Neutral if both not specified
    }

    if (userExp.isEmpty) {
      return 50; // Lower score if user didn't specify experience
    }

    if (jobExp.isEmpty) {
      return 80; // High score if job doesn't require specific experience
    }

    // Parse experience levels
    final userExpLevel = _parseExperienceLevel(userExp);
    final jobExpLevel = _parseExperienceLevel(jobExp);

    if (userExpLevel == null || jobExpLevel == null) {
      return 60; // Default if can't parse
    }

    // Calculate match based on whether user meets job requirement
    if (userExpLevel >= jobExpLevel) {
      // User has equal or more experience than required
      return 100;
    } else {
      // User has less experience - calculate partial match
      final diff = jobExpLevel - userExpLevel;
      final score = 100 - (diff * 20); // Deduct 20 points per level
      return score.clamp(40, 90); // Minimum 40, maximum 90
    }
  }

  /// Calculate location match score (0-100)
  /// Weights: 20% of total score
  int _calculateLocationMatch(
    CandidateProfileData userProfile,
    JobDetailsResponse job,
  ) {
    final userLocation = (userProfile.location ?? '').toLowerCase();
    final jobLocation = (job.location ?? '').toLowerCase();

    if (userLocation.isEmpty && jobLocation.isEmpty) {
      return 70;
    }

    if (userLocation.isEmpty) {
      return 60;
    }

    if (jobLocation.isEmpty) {
      return 80;
    }

    // Check for exact match
    if (_isLocationMatch(userLocation, jobLocation)) {
      return 100;
    }

    // Check for partial match (same city or region)
    if (_isPartialLocationMatch(userLocation, jobLocation)) {
      return 85;
    }

    // Check if job is remote
    if (jobLocation.contains('remote')) {
      return 95; // Remote jobs are highly compatible
    }

    // Different locations
    return 45;
  }

  /// Calculate job type match score (0-100)
  /// Weights: 10% of total score
  int _calculateJobTypeMatch(
    CandidateProfileData userProfile,
    JobDetailsResponse job,
  ) {
    final userJobType = (userProfile.jobType ?? '').toLowerCase();
    final jobType = (job.jobType ?? '').toLowerCase();

    if (userJobType.isEmpty && jobType.isEmpty) {
      return 70;
    }

    if (userJobType.isEmpty) {
      return 70; // Neutral if user didn't specify preference
    }

    if (jobType.isEmpty) {
      return 80; // High score if job doesn't specify type
    }

    // Check for exact match
    if (_isJobTypeMatch(userJobType, jobType)) {
      return 100;
    }

    // Check for partial match
    if (_isPartialJobTypeMatch(userJobType, jobType)) {
      return 80;
    }

    return 60;
  }

  /// Extract skills from job (currently from languages field)
  List<String> _extractJobSkills(JobDetailsResponse job) {
    if (job.languages == null || job.languages!.isEmpty) {
      return [];
    }

    return job.languages!
        .split(',')
        .map((lang) => lang.trim())
        .where((lang) => lang.isNotEmpty)
        .toList();
  }

  /// Check if two skills match (case-insensitive, partial match allowed)
  bool _isSkillMatch(String userSkill, String jobSkill) {
    final user = userSkill.toLowerCase();
    final job = jobSkill.toLowerCase();

    // Exact match
    if (user == job) {
      return true;
    }

    // Partial match (user skill contains job skill or vice versa)
    if (user.contains(job) || job.contains(user)) {
      return true;
    }

    // Check for common skill variations
    final skillMap = <String, List<String>>{
      'javascript': ['js', 'javascript', 'javascript es6'],
      'typescript': ['ts', 'typescript'],
      'python': ['py', 'python', 'python3'],
      'react': ['react', 'reactjs', 'react.js'],
      'node': ['node', 'nodejs', 'node.js'],
      'flutter': ['flutter', 'flutter sdk'],
      'dart': ['dart', 'dartlang'],
    };

    for (final entry in skillMap.entries) {
      final variations = entry.value;
      if ((variations.contains(user) && variations.contains(job)) ||
          user == entry.key ||
          job == entry.key) {
        return true;
      }
    }

    return false;
  }

  /// Parse experience level string to numeric value
  /// Returns: 0-5 (0=none, 1=fresher, 2=junior, 3=mid, 4=senior, 5=expert)
  int? _parseExperienceLevel(String experience) {
    final exp = experience.toLowerCase();

    if (exp.contains('fresher') || exp.contains('entry') || exp.contains('0') || exp.contains('1 year')) {
      return 1;
    }
    if (exp.contains('junior') || exp.contains('2-3') || exp.contains('1-2')) {
      return 2;
    }
    if (exp.contains('mid') || exp.contains('3-5') || exp.contains('2-4')) {
      return 3;
    }
    if (exp.contains('senior') || exp.contains('5-8') || exp.contains('6-10')) {
      return 4;
    }
    if (exp.contains('lead') || exp.contains('expert') || exp.contains('8+') || exp.contains('10+')) {
      return 5;
    }

    // Try to extract numeric value
    final numericMatch = RegExp(r'(\d+)').firstMatch(exp);
    if (numericMatch != null) {
      final years = int.tryParse(numericMatch.group(1) ?? '0');
      if (years != null) {
        if (years == 0) return 1;
        if (years <= 2) return 2;
        if (years <= 4) return 3;
        if (years <= 7) return 4;
        return 5;
      }
    }

    return null;
  }

  /// Check if locations match exactly
  bool _isLocationMatch(String userLocation, String jobLocation) {
    return userLocation == jobLocation ||
           userLocation.contains(jobLocation) ||
           jobLocation.contains(userLocation);
  }

  /// Check if locations partially match (same city/region)
  bool _isPartialLocationMatch(String userLocation, String jobLocation) {
    // Split by common separators and check for common parts
    final userParts = userLocation.split(RegExp(r'[,/ -]'));
    final jobParts = jobLocation.split(RegExp(r'[,/ -]'));

    for (final userPart in userParts) {
      for (final jobPart in jobParts) {
        if (userPart.trim().isNotEmpty &&
            jobPart.trim().isNotEmpty &&
            userPart.toLowerCase() == jobPart.toLowerCase()) {
          return true;
        }
      }
    }

    return false;
  }

  /// Check if job types match exactly
  bool _isJobTypeMatch(String userJobType, String jobType) {
    return userJobType == jobType ||
           userJobType.contains(jobType) ||
           jobType.contains(userJobType);
  }

  /// Check if job types partially match
  bool _isPartialJobTypeMatch(String userJobType, String jobType) {
    final commonTypes = ['full-time', 'part-time', 'contract', 'freelance', 'remote'];

    for (final type in commonTypes) {
      if (userJobType.contains(type) && jobType.contains(type)) {
        return true;
      }
    }

    return false;
  }
}

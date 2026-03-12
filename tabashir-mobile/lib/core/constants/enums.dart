/// Enumerations used throughout the application
enum UserRole { candidate, recruiter, admin, superAdmin }

/// Status of job applications
enum ApplicationStatus {
  pending,
  reviewed,
  shortlisted,
  interview,
  rejected,
  accepted,
}

/// Job types
enum JobType { fullTime, partTime, contract, internship, remote, freelance }

/// Subscription plans
enum SubscriptionPlan { free, basic, premium, enterprise }

/// Payment status
enum PaymentStatus {
  pending,
  processing,
  succeeded,
  failed,
  refunded,
  cancelled,
}

/// Theme modes
enum ThemeMode { light, dark, system }

/// Notification types
enum NotificationType { application, interview, message, reminder, system }

/// Gender options
enum Gender { male, female, other, preferNotToSay }

/// Education levels
enum EducationLevel {
  highSchool,
  associate,
  bachelor,
  master,
  doctorate,
  certification,
}

/// Experience levels
enum ExperienceLevel { beginner, intermediate, advanced, expert }

/// Employment statuses
enum EmploymentStatus { employed, unemployed, student, freelancer, partTime }

/// Extensions for enum conversion
extension UserRoleExtension on UserRole {
  String get name {
    switch (this) {
      case UserRole.candidate:
        return 'candidate';
      case UserRole.recruiter:
        return 'recruiter';
      case UserRole.admin:
        return 'admin';
      case UserRole.superAdmin:
        return 'super_admin';
    }
  }

  String get displayName {
    switch (this) {
      case UserRole.candidate:
        return 'Candidate';
      case UserRole.recruiter:
        return 'Recruiter';
      case UserRole.admin:
        return 'Admin';
      case UserRole.superAdmin:
        return 'Super Admin';
    }
  }
}

extension ApplicationStatusExtension on ApplicationStatus {
  String get name {
    switch (this) {
      case ApplicationStatus.pending:
        return 'pending';
      case ApplicationStatus.reviewed:
        return 'reviewed';
      case ApplicationStatus.shortlisted:
        return 'shortlisted';
      case ApplicationStatus.interview:
        return 'interview';
      case ApplicationStatus.rejected:
        return 'rejected';
      case ApplicationStatus.accepted:
        return 'accepted';
    }
  }

  String get displayName {
    switch (this) {
      case ApplicationStatus.pending:
        return 'Pending';
      case ApplicationStatus.reviewed:
        return 'Reviewed';
      case ApplicationStatus.shortlisted:
        return 'Shortlisted';
      case ApplicationStatus.interview:
        return 'Interview';
      case ApplicationStatus.rejected:
        return 'Rejected';
      case ApplicationStatus.accepted:
        return 'Accepted';
    }
  }
}

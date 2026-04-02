import 'package:tabashir/core/network/models/user/user_profile_response.dart';
import 'package:tabashir/core/network/models/candidate/personal_info_request.dart';
import 'package:tabashir/core/network/models/candidate/professional_info_request.dart';
import 'package:tabashir/core/network/models/candidate/onboarding_response.dart';
import 'package:tabashir/core/network/models/profile/profile_update_request.dart';
import 'package:tabashir/core/network/models/job/ai_client_response.dart';

/// Repository interface for profile operations
/// Defines the contract for profile data operations
abstract class ProfileRepository {
  /// Get user profile data
  /// Returns [UserProfileResponse] with user profile information
  Future<UserProfileResponse> getUserProfile();

  /// Update user profile information (name, email, phone, etc.)
  /// This is a general profile update for all user types
  Future<void> updateProfile({
    required ProfileUpdateRequest profileUpdate,
  });

  /// Fetch client details from the AI DB
  Future<AiClientData?> getClient();

  /// Update client with specific details and trigger AI job matching
  Future<void> updateClient({
    required String email,
    required String nationality,
    required String gender,
    required List<String> locations,
    required List<String> positions,
    String? cvPath,
  });

  /// Update candidate personal information
  /// Returns [OnboardingResponse] with updated data
  Future<OnboardingResponse> updatePersonalInfo({
    required PersonalInfoRequest personalInfo,
  });

  /// Update candidate professional information
  /// Returns [OnboardingResponse] with updated data
  Future<OnboardingResponse> updateProfessionalInfo({
    required ProfessionalInfoRequest professionalInfo,
  });

  /// Delete user account
  Future<void> deleteAccount();
}

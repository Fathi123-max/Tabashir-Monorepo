import 'package:tabashir/core/network/models/auth/auth_response.dart';
import 'package:tabashir/core/network/models/auth/login_request.dart';
import 'package:tabashir/core/network/models/auth/register_request.dart';
import 'package:tabashir/core/network/models/auth/email_verification_request.dart';
import 'package:tabashir/core/network/models/auth/email_verification_response.dart';

/// Repository interface for authentication operations
/// Defines the contract for authentication data operations
abstract class AuthRepository {
  /// Login user with email and password
  /// Returns [AuthResponse] with user data and tokens
  Future<AuthResponse> login({
    required String email,
    required String password,
  });

  /// Register new user
  /// Returns [AuthResponse] with user data and tokens
  Future<AuthResponse> register({
    required String email,
    required String password,
    required String name,
    String userType = 'CANDIDATE',
  });

  /// Verify email with code
  /// Returns [EmailVerificationResponse]
  Future<EmailVerificationResponse> verifyEmail({
    required String email,
    required String code,
  });

  /// Send verification email
  /// Returns [EmailVerificationResponse]
  Future<EmailVerificationResponse> sendVerificationEmail({
    required String email,
  });

  /// Sign in with Apple ID
  /// Returns [AuthResponse] with user data and tokens
  Future<AuthResponse> appleSignIn({
    required String identityToken,
    String? email,
    String? givenName,
    String? familyName,
  });

  /// Sign in with Google ID
  /// Returns [AuthResponse] with user data and tokens
  Future<AuthResponse> googleSignIn({
    required String idToken,
    String? email,
    String? name,
  });
}

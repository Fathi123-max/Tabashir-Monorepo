import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:tabashir/core/services/auth_session_service.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/features/auth/domain/repositories/auth_repository.dart';

/// Service for Apple Sign-In authentication
/// Uses sign_in_with_apple package with custom backend API
///
/// To activate this service:
/// 1. Configure Apple Sign-In in Apple Developer Console (iOS)
/// 2. Create App ID and Services ID
/// 3. Create Private Key
/// 4. Set up backend API endpoint to verify Apple ID token
/// 5. Configure backend to accept Apple ID tokens
class AppleSignInService {
  AppleSignInService._();
  static AppleSignInService? _instance;
  static AppleSignInService get instance =>
      _instance ??= AppleSignInService._();

  final AuthRepository _repository = getIt<AuthRepository>();

  /// Initialize Apple Sign-In
  /// Call this once at app startup
  Future<void> initialize() async {
    // No initialization needed for direct Apple Sign-In
  }

  /// Sign in with Apple
  /// Returns the Apple ID token
  /// Throws exception on failure
  Future<String> signIn() async {
    try {
      // To use this service, you need to configure Apple Developer settings:
      // 1. Enable "Sign in with Apple" capability in Xcode
      // 2. Create an App ID and Service ID in Apple Developer Console
      // 3. Create and download Private Key (.p8 file)
      // 4. Configure your backend API to verify Apple ID tokens

      // Generate a cryptographic nonce
      final nonce = _generateNonce();

      // Request Apple Sign-In authorization
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: _sha256ofString(nonce),
      );

      // Get the identity token from Apple
      final identityToken = appleCredential.identityToken;

      if (identityToken == null) {
        throw Exception('No identity token received from Apple');
      }

      // Send token to backend for verification
      // Backend will verify the token with Apple and return JWT
      final response = await _repository.appleSignIn(
        identityToken: identityToken,
        email: appleCredential.email,
        givenName: appleCredential.givenName,
        familyName: appleCredential.familyName,
      );

      // Store the JWT token from backend in AuthSessionService
      final tokenToStore = response.token ?? response.accessToken;
      if (tokenToStore != null) {
        await AuthSessionService.instance.setLoggedIn(
          token: tokenToStore,
          refreshToken: response.refreshToken,
        );
      }

      return identityToken;
    } catch (e) {
      throw Exception('Apple sign-in failed: $e');
    }
  }

  /// Check if Apple Sign-In is available
  /// Returns true if running on iOS/macOS and device supports Apple Sign-In
  Future<bool> get isAvailable async => SignInWithApple.isAvailable();

  /// Sign out from Apple
  /// Note: This just clears the stored token, Apple doesn't have a sign-out API
  Future<void> signOut() async {
    try {
      await AuthSessionService.instance.setLoggedOut();
    } catch (e) {
      throw Exception('Apple sign-out failed: $e');
    }
  }

  /// Check if user is currently signed in with Apple
  /// Checks if there's a stored token in AuthSessionService
  Future<bool> get isSignedIn async =>
      AuthSessionService.instance.isAuthenticated;

  /// Generate a cryptographically secure random nonce
  String _generateNonce() {
    const chars =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final rand = Random.secure();
    return List.generate(
      64,
      (index) => chars[rand.nextInt(chars.length)],
    ).join();
  }

  /// SHA256 hash of the nonce
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}

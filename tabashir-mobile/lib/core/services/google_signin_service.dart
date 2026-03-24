import 'package:google_sign_in/google_sign_in.dart';
import 'package:tabashir/core/services/auth_session_service.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/features/auth/domain/repositories/auth_repository.dart';

/// Service for Google Sign-In authentication
/// Uses Firebase Auth (recommended approach)
class GoogleSignInService {
  GoogleSignInService._();
  static GoogleSignInService? _instance;
  static GoogleSignInService get instance =>
      _instance ??= GoogleSignInService._();

  late final GoogleSignIn _googleSignIn;
  final AuthRepository _repository = getIt<AuthRepository>();

  /// Initialize Google Sign-In
  /// Call this once at app startup
  Future<void> initialize(String serverClientId) async {
    _googleSignIn = GoogleSignIn(
      serverClientId: serverClientId,
      scopes: [
        'email',
        'profile',
      ],
    );
  }

  /// Sign in with Google
  /// Returns ID token on success
  /// Throws exception on failure
  Future<String> signIn() async {
    try {
      // Trigger the Google Sign-In flow
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in
        throw Exception('Google sign-in was cancelled');
      }

      // Obtain the auth details from the request
      final googleAuth = await googleUser.authentication;

      final idToken = googleAuth.idToken;
      if (idToken == null) {
        throw Exception('Google sign-in did not return an ID token');
      }

      // Exchange Google ID token for backend JWT
      final response = await _repository.googleSignIn(
        idToken: idToken,
        email: googleUser.email,
        name: googleUser.displayName,
      );

      // Store the JWT token from backend in AuthSessionService
      final tokenToStore = response.token ?? response.accessToken;
      if (tokenToStore != null) {
        await AuthSessionService.instance.setLoggedIn(
          token: tokenToStore,
          refreshToken: response.refreshToken,
        );
      }

      return idToken;
    } catch (e) {
      throw Exception('Google sign-in failed: $e');
    }
  }

  /// Sign out from Google
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await AuthSessionService.instance.setLoggedOut();
    } catch (e) {
      throw Exception('Google sign-out failed: $e');
    }
  }

  /// Check if user is currently signed in with Google
  bool get isSignedIn => _googleSignIn.currentUser != null;

  /// Get current Firebase user
  GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;
}

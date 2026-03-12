import 'package:google_sign_in/google_sign_in.dart';
import 'package:tabashir/core/services/auth_session_service.dart';

/// Service for Google Sign-In authentication
/// Uses Firebase Auth (recommended approach)
class GoogleSignInService {
  GoogleSignInService._();
  static GoogleSignInService? _instance;
  static GoogleSignInService get instance =>
      _instance ??= GoogleSignInService._();

  late final GoogleSignIn _googleSignIn;

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
  /// Returns UserCredential on success
  /// Throws exception on failure
  Future<String> signIn() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in
        throw Exception('Google sign-in was cancelled');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final idToken = googleAuth.idToken;
      if (idToken == null) {
        throw Exception('Google sign-in did not return an ID token');
      }

      await AuthSessionService.instance.setLoggedIn(token: idToken);
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
  bool get isSignedIn {
    return _googleSignIn.currentUser != null;
  }

  /// Get current Firebase user
  GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;
}

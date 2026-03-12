// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// import '../constants/storage_keys.dart';
// import 'local_storage_service.dart';

// /// Service to handle authentication operations
// class AuthService {
//   static AuthService? _instance;
//   static AuthService get instance => _instance ??= AuthService._();
//   AuthService._();

//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   /// Check if user is currently authenticated
//   bool get isAuthenticated {
//     return _firebaseAuth.currentUser != null;
//   }

//   /// Get current user
//   User? get currentUser => _firebaseAuth.currentUser;

//   /// Sign in with email and password
//   Future<bool> signInWithEmailAndPassword(String email, String password) async {
//     try {
//       await _firebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       await _saveUserCredentials();
//       return true;
//     } on FirebaseAuthException catch (e) {
//       // Handle specific auth errors
//       throw Exception(_mapAuthException(e));
//     }
//   }

//   /// Sign up with email and password
//   Future<bool> signUpWithEmailAndPassword(String email, String password, String name) async {
//     try {
//       await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       // Update display name
//       await _firebaseAuth.currentUser?.updateDisplayName(name);
//       await _saveUserCredentials();
//       return true;
//     } on FirebaseAuthException catch (e) {
//       throw Exception(_mapAuthException(e));
//     }
//   }

//   /// Sign in with Google
//   Future<bool> signInWithGoogle() async {
//     try {
//       // Trigger the authentication flow
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//       if (googleUser == null) {
//         // User cancelled the sign-in
//         return false;
//       }

//       // Obtain the auth details from the request
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//       // Create a new credential
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       // Sign in to Firebase with the Google credential
//       await _firebaseAuth.signInWithCredential(credential);
//       await _saveUserCredentials();
//       return true;
//     } catch (e) {
//       throw Exception('Google sign-in failed: $e');
//     }
//   }

//   /// Sign out the current user
//   Future<void> signOut() async {
//     await _firebaseAuth.signOut();
//     await _googleSignIn.signOut();
//     await LocalStorageService.instance.remove(StorageKeys.isLoggedIn);
//     await LocalStorageService.instance.clearSecureStorage();
//   }

//   /// Send password reset email
//   Future<void> sendPasswordResetEmail(String email) async {
//     await _firebaseAuth.sendPasswordResetEmail(email: email);
//   }

//   /// Save user credentials to local storage
//   Future<void> _saveUserCredentials() async {
//     final user = _firebaseAuth.currentUser;
//     if (user != null) {
//       await LocalStorageService.instance.setBool(StorageKeys.isLoggedIn, true);
//       // Save user details to local storage if needed
//     }
//   }

//   /// Get current ID token
//   Future<String?> getIdToken() async {
//     final user = _firebaseAuth.currentUser;
//     if (user != null) {
//       return await user.getIdToken();
//     }
//     return null;
//   }

//   /// Map Firebase auth exceptions to readable messages
//   String _mapAuthException(FirebaseAuthException e) {
//     switch (e.code) {
//       case 'user-not-found':
//         return 'No user found for that email.';
//       case 'wrong-password':
//         return 'Wrong password provided for that user.';
//       case 'email-already-in-use':
//         return 'The email address is already in use by another account.';
//       case 'weak-password':
//         return 'The password provided is too weak.';
//       case 'invalid-email':
//         return 'The email address is not valid.';
//       default:
//         return 'Authentication failed. Please try again.';
//     }
//   }
// }

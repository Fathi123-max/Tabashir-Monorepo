## Objective
- Implement Google Sign-In without Firebase, strictly following official `google_sign_in` guidance, and fix the `invalid_audience` error.

## Doc Cross‑Check
- Official package docs: `https://pub.dev/packages/google_sign_in` and iOS details: `https://pub.dev/packages/google_sign_in_ios`.
- Key requirements:
  - Initialize with correct `clientId` and `serverClientId` belonging to the same Google Cloud project.
  - iOS: Set `GIDClientID` (and optionally `GIDServerClientID`) in `Info.plist`, plus `CFBundleURLTypes` for reversed client ID.
  - Android: Ensure SHA‑1 fingerprints are registered and use the Web OAuth client ID as `serverClientId` when needed.

## Findings in Repo
- iOS URL scheme is correct (reversed client ID): `ios/Runner/Info.plist:70–83`.
- iOS `GIDClientID` is incorrect and points to another project: `ios/Runner/Info.plist:84–88` → `445510044278-...`.
- Firebase iOS plist shows the correct iOS client ID for this project: `ios/Runner/GoogleService-Info.plist:5–8` → `908457286237-beupf...`.
- Android Web client ID for the same project: `android/app/google-services.json:17–20,30–32` → `908457286237-sl5h3g85...`.
- App constant hardcodes a mismatched web client ID and misuses `String.fromEnvironment`: `lib/core/constants/app_constants.dart:61–66`.
- Current sign-in flow uses Firebase; must be refactored to pure Google:
  - `lib/core/services/google_signin_service.dart:33–71` (Firebase usage and token storage)
  - UI expects `UserCredential` (Firebase) in login/signup handlers.

## Plan: Pure Google Sign‑In
- Keep only `google_sign_in`; remove `FirebaseAuth` from the sign-in flow.
- Initialize `GoogleSignIn` with:
  - iOS/macOS: `clientId` = iOS client ID; `serverClientId` = Web client ID (if backend needs server auth code/idToken audience).
  - Android: pass `serverClientId` = Web client ID.
- Obtain tokens solely via `GoogleSignInAuthentication` and store `idToken` using `AuthSessionService`.
- Maintain current header injection (`Authorization: Bearer <idToken>`); ensure backend validates Google OIDC tokens.

## Todos
- Correct iOS `GIDClientID` in `ios/Runner/Info.plist` to match `GoogleService-Info.plist` `CLIENT_ID` (`908457286237-beupf...`).
- Optionally add `GIDServerClientID` to `Info.plist` with the Web client ID (`908457286237-sl5h3g85...`).
- Fix `lib/core/constants/app_constants.dart` to use `String.fromEnvironment('GOOGLE_SIGN_IN_SERVER_CLIENT_ID', defaultValue: '<placeholder>')` and remove the hardcoded mismatched ID.
- Refactor `lib/core/services/google_signin_service.dart`:
  - Remove `FirebaseAuth` usage (`signInWithCredential`), return a value (e.g., `GoogleSignInAccount` + tokens) instead of `UserCredential`.
  - Store `googleAuth.idToken` via `AuthSessionService.instance.setLoggedIn(token: ...)`.
  - Map cancellation and error codes to user‑friendly messages; include audience mismatch guidance.
- Update login/signup handlers to use the refactored service and store the Google ID token.
- Build with defines:
  - Android/iOS: `--dart-define=GOOGLE_SIGN_IN_SERVER_CLIENT_ID=908457286237-sl5h3g85uf350uje8k39f55t6ankopjc.apps.googleusercontent.com`.
- Confirm Android SHA‑1 fingerprints are registered in the Google Cloud/Firebase project; add release SHA‑1 for production.

## Error Handling & State
- Handle three paths in UI:
  - Success: token stored, navigate to `/`.
  - Cancel: detect `googleUser == null`, show non‑error banner.
  - Errors: surface `clientConfigurationError`, `invalid_audience`, network issues with concise instructions.
- Keep `AuthDioClient` unchanged for header injection; verify 401 handling doesn’t prematurely clear state on non‑auth endpoints.

## Security & Compliance
- Do not hardcode client IDs; rely on env (`--dart-define`).
- Ensure OIDC validation on the backend (issuer `accounts.google.com`); if backend expects Firebase tokens, coordinate server change.
- iOS App Store: Include Sign in with Apple if Google Sign‑In is present (per guidelines), already scaffolded in UI.

## Verification
- iOS: Confirm `GIDClientID` matches `GoogleService-Info.plist` and URL scheme resolves back to app.
- Android: Confirm `serverClientId` (Web ID) set and sign‑in returns non‑null `idToken`.
- End‑to‑end:
  - Login: `lib/features/auth/presentation/screens/login_screen.dart:130–147`.
  - Signup: `lib/features/auth/presentation/screens/signup_screen.dart:133–151`.
  - Token storage: `lib/core/services/google_signin_service.dart:58–66` (to be updated to use Google token).
  - API headers: `lib/core/network/_clients/auth_dio_client.dart:14–21`.
- Test cases:
  - Successful sign‑in, cancellation, audience mismatch, offline/network failure.

## Assumptions
- Backend accepts Google ID tokens (OIDC); if not, a coordinated server change is required for validation.
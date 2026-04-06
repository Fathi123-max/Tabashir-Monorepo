# Mobile StoreKit 2 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the Stripe-only payment flow with a platform-agnostic `PaymentPlatform` interface, implementing StoreKit 2 for iOS and keeping Stripe for Android.

**Architecture:** Abstract `PaymentPlatform` interface with two implementations (`StripePaymentPlatform` for Android, `ApplePaymentPlatform` for iOS). `PaymentCubit` depends on the interface, not a concrete implementation. DI injects the correct implementation based on `defaultTargetPlatform`.

**Tech Stack:** Flutter, Dart, `in_app_purchase` ^3.2.0, `flutter_stripe` (Android only), `flutter_bloc`, `freezed`, `get_it`/`injectable`

---

## File Structure

| Action | File | Responsibility |
|--------|------|----------------|
| Create | `lib/features/payments/domain/repositories/payment_platform.dart` | Abstract interface + sealed `PaymentResult` class |
| Create | `lib/core/services/apple_iap_service.dart` | Wraps `in_app_purchase` package for StoreKit 2 |
| Create | `lib/features/payments/data/repositories/stripe_payment_platform.dart` | Stripe implementation of PaymentPlatform (Android) |
| Create | `lib/features/payments/data/repositories/apple_payment_platform.dart` | StoreKit 2 implementation of PaymentPlatform (iOS) |
| Modify | `lib/features/payments/presentation/cubit/payment_cubit.dart` | Replace StripeService with PaymentPlatform; add `processPayment()` method |
| Modify | `lib/core/di/module.dart` | Add AppleIAPService + platform-based PaymentPlatform factory |
| Modify | `lib/features/services/presentation/screens/services_screen.dart` | Update payment call from `createPaymentIntent()` to `processPayment()` |
| Modify | `pubspec.yaml` | Add `in_app_purchase: ^3.2.0` |

---

### Task 1: Add `in_app_purchase` dependency

**Files:**
- Modify: `tabashir-mobile/pubspec.yaml`

- [ ] **Step 1: Add the dependency**

Run from the mobile directory:

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
flutter pub add in_app_purchase
```

- [ ] **Step 2: Verify it was added**

Check that `in_app_purchase: ^3.2.0` (or similar) appears in `pubspec.yaml` under `dependencies:`.

- [ ] **Step 3: Run code generation (in case pubspec changes trigger any)**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 4: Verify the project still compiles**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
flutter analyze --no-fatal-infos 2>&1 | head -20
```

Expected: No new errors beyond existing ones.

- [ ] **Step 5: Commit**

```bash
cd /Users/Apple/Documents/tabashir
git add tabashir-mobile/pubspec.yaml tabashir-mobile/pubspec.lock
git commit -m "chore: add in_app_purchase dependency for StoreKit 2"
```

---

### Task 2: Create `PaymentPlatform` interface and `PaymentResult` sealed class

**Files:**
- Create: `tabashir-mobile/lib/features/payments/domain/repositories/payment_platform.dart`

- [ ] **Step 1: Create the interface file**

Create `lib/features/payments/domain/repositories/payment_platform.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_platform.freezed.dart';

/// Abstract interface for payment processing.
/// Implementations: [StripePaymentPlatform] (Android), [ApplePaymentPlatform] (iOS).
abstract class PaymentPlatform {
  /// Process a payment for the given service.
  ///
  /// [serviceId] — e.g. 'ai-job-apply-basic'
  /// [amount] — price in AED
  /// [userId] — authenticated user ID
  /// [resumeId] — optional, required for ai-resume-optimization
  ///
  /// Returns a [PaymentResult] with success/cancelled/failed state.
  Future<PaymentResult> processPayment({
    required String serviceId,
    required double amount,
    required String userId,
    String? resumeId,
  });
}

/// Result of a payment attempt.
@freezed
class PaymentResult with _$PaymentResult {
  const factory PaymentResult.success({String? transactionId}) = _PaymentSuccess;
  const factory PaymentResult.cancelled() = _PaymentCancelled;
  const factory PaymentResult.failed(String message) = _PaymentFailed;
}
```

- [ ] **Step 2: Run code generation**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
dart run build_runner build --delete-conflicting-outputs
```

Expected: Generates `payment_platform.freezed.dart` with the sealed class implementation.

- [ ] **Step 3: Verify no analysis errors**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
flutter analyze lib/features/payments/domain/repositories/payment_platform.dart 2>&1
```

Expected: No errors.

- [ ] **Step 4: Commit**

```bash
cd /Users/Apple/Documents/tabashir
git add tabashir-mobile/lib/features/payments/domain/repositories/payment_platform.dart tabashir-mobile/lib/features/payments/domain/repositories/payment_platform.freezed.dart
git commit -m "feat: add PaymentPlatform interface and PaymentResult sealed class"
```

---

### Task 3: Create `AppleIAPService`

**Files:**
- Create: `tabashir-mobile/lib/core/services/apple_iap_service.dart`

- [ ] **Step 1: Create the service file**

Create `lib/core/services/apple_iap_service.dart`:

```dart
import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:dio/dio.dart';
import 'package:tabashir/core/utils/app_logger.dart';

class AppleIAPService {
  final InAppPurchase _iap = InAppPurchase.instance;
  final Dio _dio;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  final _purchaseController = StreamController<PurchaseDetails>.broadcast();

  Stream<PurchaseDetails> get purchaseStream => _purchaseController.stream;

  AppleIAPService(this._dio);

  /// Initialize IAP connection and start listening for purchase updates.
  Future<bool> init() async {
    final available = await _iap.isAvailable();
    if (!available) {
      AppLogger.error('[AppleIAP] Store not available', tag: 'Payments');
      return false;
    }

    _subscription = _iap.purchaseStream.listen(
      (purchaseDetailsList) {
        for (final purchase in purchaseDetailsList) {
          _purchaseController.add(purchase);
        }
      },
      onDone: () => _subscription?.cancel(),
      onError: (error) => AppLogger.error('[AppleIAP] Stream error: $error', tag: 'Payments'),
    );

    return true;
  }

  /// Fetch product details from App Store Connect.
  Future<Set<ProductDetails>> getProducts(Set<String> productIds) async {
    final response = await _iap.queryProductDetails(productIds);
    if (response.notFoundIDs.isNotEmpty) {
      AppLogger.warning('[AppleIAP] Products not found: ${response.notFoundIDs}', tag: 'Payments');
    }
    return response.productDetails;
  }

  /// Initiate a purchase. The actual payment flow is handled by the purchaseStream.
  Future<void> purchase(ProductDetails product) async {
    final param = PurchaseParam(productDetails: product);
    await _iap.buyConsumable(purchaseParam: param);
  }

  /// Verify the purchase receipt with the backend.
  /// POST /api/v1/payments/verify-apple-receipt
  Future<PaymentVerificationResult> verifyReceipt({
    required String transactionId,
    required String productId,
    required String userId,
    String? resumeId,
  }) async {
    try {
      final response = await _dio.post(
        '/api/v1/payments/verify-apple-receipt',
        data: {
          'transactionId': transactionId,
          'productId': productId,
          'userId': userId,
          if (resumeId != null) 'resumeId': resumeId,
        },
      );
      return PaymentVerificationResult(
        success: response.data['success'] == true,
        paymentId: response.data['data']?['paymentId'],
      );
    } catch (e) {
      AppLogger.error('[AppleIAP] Receipt verification failed: $e', tag: 'Payments');
      return const PaymentVerificationResult(success: false, error: 'Receipt verification failed');
    }
  }

  /// Mark a purchase as completed (consumes it so it can be purchased again).
  Future<void> completePurchase(PurchaseDetails purchase) async {
    await _iap.completePurchase(purchase);
  }

  /// Restore previous purchases (for user account recovery).
  Future<void> restorePurchases() async {
    await _iap.restorePurchases(applicationUserName: null);
  }

  void dispose() {
    _subscription?.cancel();
    _purchaseController.close();
  }
}

class PaymentVerificationResult {
  final bool success;
  final String? paymentId;
  final String? error;
  const PaymentVerificationResult({required this.success, this.paymentId, this.error});
}
```

- [ ] **Step 2: Verify no analysis errors**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
flutter analyze lib/core/services/apple_iap_service.dart 2>&1
```

Expected: No errors.

- [ ] **Step 3: Commit**

```bash
cd /Users/Apple/Documents/tabashir
git add tabashir-mobile/lib/core/services/apple_iap_service.dart
git commit -m "feat: add AppleIAPService for StoreKit 2 integration"
```

---

### Task 4: Create `StripePaymentPlatform`

**Files:**
- Create: `tabashir-mobile/lib/features/payments/data/repositories/stripe_payment_platform.dart`

- [ ] **Step 1: Create the implementation file**

Create `lib/features/payments/data/repositories/stripe_payment_platform.dart`:

```dart
import 'package:flutter/foundation.dart';
import 'package:tabashir/core/services/stripe_service.dart';
import 'package:tabashir/features/payments/domain/repositories/payment_platform.dart';
import 'package:tabashir/features/payments/domain/repositories/payment_repository.dart';
import 'package:tabashir/core/network/models/payment/payment_intent_request.dart';

class StripePaymentPlatform implements PaymentPlatform {
  final StripeService _stripeService;
  final PaymentRepository _repository;

  StripePaymentPlatform(this._stripeService, this._repository);

  @override
  Future<PaymentResult> processPayment({
    required String serviceId,
    required double amount,
    required String userId,
    String? resumeId,
  }) async {
    try {
      final request = PaymentIntentRequest(
        amount: amount,
        currency: 'AED',
        serviceId: serviceId,
        userId: userId,
        resumeId: resumeId,
      );

      final response = await _repository.createPaymentIntent(request: request);
      final data = response.data;

      if (data == null) {
        return const PaymentResult.failed('No payment data returned from server');
      }

      _stripeService.setPublishableKey(data.publishableKey ?? '');

      await _stripeService.initPaymentSheet(
        customerId: data.customer ?? '',
        customerEphemeralKeySecret: data.ephemeralKey ?? '',
        paymentIntentClientSecret: data.clientSecret ?? '',
        merchantDisplayName: 'Tabashir',
      );

      await Future.delayed(const Duration(milliseconds: 300));
      final result = await _stripeService.processPayment();

      if (result.success) {
        return PaymentResult.success(transactionId: data.paymentIntentId);
      } else if (result.canceled) {
        return const PaymentResult.cancelled();
      } else {
        return PaymentResult.failed(result.message);
      }
    } catch (e) {
      return PaymentResult.failed(e.toString());
    }
  }
}
```

- [ ] **Step 2: Verify no analysis errors**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
flutter analyze lib/features/payments/data/repositories/stripe_payment_platform.dart 2>&1
```

Expected: No errors.

- [ ] **Step 3: Commit**

```bash
cd /Users/Apple/Documents/tabashir
git add tabashir-mobile/lib/features/payments/data/repositories/stripe_payment_platform.dart
git commit -m "feat: add StripePaymentPlatform implementation for Android"
```

---

### Task 5: Create `ApplePaymentPlatform`

**Files:**
- Create: `tabashir-mobile/lib/features/payments/data/repositories/apple_payment_platform.dart`

- [ ] **Step 1: Create the implementation file**

Create `lib/features/payments/data/repositories/apple_payment_platform.dart`:

```dart
import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:tabashir/core/services/apple_iap_service.dart';
import 'package:tabashir/core/utils/app_logger.dart';
import 'package:tabashir/features/payments/domain/repositories/payment_platform.dart';

class ApplePaymentPlatform implements PaymentPlatform {
  final AppleIAPService _appleService;

  ApplePaymentPlatform(this._appleService);

  @override
  Future<PaymentResult> processPayment({
    required String serviceId,
    required double amount,
    required String userId,
    String? resumeId,
  }) async {
    // 1. Initialize IAP
    final available = await _appleService.init();
    if (!available) {
      return const PaymentResult.failed('App Store payments not available');
    }

    // 2. Fetch product details
    final products = await _appleService.getProducts({serviceId});
    if (products.isEmpty) {
      return PaymentResult.failed('Product $serviceId not found in App Store');
    }

    final product = products.first;

    // 3. Listen for purchase updates using Completer pattern
    final completer = Completer<PaymentResult>();
    late final StreamSubscription<PurchaseDetails> sub;

    sub = _appleService.purchaseStream.listen((purchase) async {
      if (purchase.productID != serviceId) return;

      switch (purchase.status) {
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          // 4. Verify with backend
          final verification = await _appleService.verifyReceipt(
            transactionId: purchase.purchaseID ?? purchase.transactionDate.toString(),
            productId: serviceId,
            userId: userId,
            resumeId: resumeId,
          );

          if (verification.success) {
            await _appleService.completePurchase(purchase);
            completer.complete(
              PaymentResult.success(transactionId: verification.paymentId),
            );
          } else {
            completer.complete(
              PaymentResult.failed('Receipt verification failed: ${verification.error}'),
            );
          }
          sub.cancel();
          break;

        case PurchaseStatus.error:
          completer.complete(
            PaymentResult.failed(purchase.error?.message ?? 'Purchase failed'),
          );
          sub.cancel();
          break;

        case PurchaseStatus.pending:
          // Still processing — don't complete yet
          break;

        case PurchaseStatus.canceled:
          completer.complete(const PaymentResult.cancelled());
          sub.cancel();
          break;
      }
    });

    // 5. Initiate purchase
    await _appleService.purchase(product);

    // 6. Wait for result (with timeout)
    try {
      return await completer.future.timeout(
        const Duration(minutes: 5),
        onTimeout: () {
          sub.cancel();
          return const PaymentResult.failed('Payment timed out');
        },
      );
    } catch (e) {
      sub.cancel();
      return PaymentResult.failed(e.toString());
    }
  }
}
```

- [ ] **Step 2: Verify no analysis errors**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
flutter analyze lib/features/payments/data/repositories/apple_payment_platform.dart 2>&1
```

Expected: No errors.

- [ ] **Step 3: Commit**

```bash
cd /Users/Apple/Documents/tabashir
git add tabashir-mobile/lib/features/payments/data/repositories/apple_payment_platform.dart
git commit -m "feat: add ApplePaymentPlatform implementation for iOS StoreKit 2"
```

---

### Task 6: Refactor `PaymentCubit` to use `PaymentPlatform`

**Files:**
- Modify: `tabashir-mobile/lib/features/payments/presentation/cubit/payment_cubit.dart`

- [ ] **Step 1: Read the current file**

Read `lib/features/payments/presentation/cubit/payment_cubit.dart` to understand its full structure. Note: it has `createPaymentIntent()`, `createCheckoutSession()`, `loadLatestPayment()`, `clearError()`, `reset()`, plus Stripe-specific methods (`initPaymentSheet`, `processPaymentSheet`, `isApplePayAvailable`, `processApplePay`, `isGooglePayAvailable`, `processGooglePay`).

- [ ] **Step 2: Replace the file content**

Replace the ENTIRE file with:

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/utils/app_logger.dart';
import 'package:tabashir/features/payments/domain/repositories/payment_platform.dart';
import 'package:tabashir/features/payments/domain/repositories/payment_repository.dart';
import 'package:tabashir/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:tabashir/features/home/presentation/cubit/home_cubit.dart';

part 'payment_state.dart';
part 'payment_cubit.freezed.dart';
part 'payment_cubit.g.dart';

@injectable
class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(
    this._platform,
    this._profileCubit,
  ) : super(const PaymentState());

  final PaymentPlatform _platform;
  final ProfileCubit _profileCubit;

  /// Callback fired after successful payment.
  /// Set this before calling processPayment to handle navigation.
  Future<void> Function(PaymentResult)? onPaymentSuccess;

  /// Process a payment — works for both Stripe (Android) and Apple IAP (iOS).
  Future<void> processPayment({
    required String serviceId,
    required double amount,
    String? resumeId,
  }) async {
    final userId = _currentUserId;

    emit(state.copyWith(status: PaymentStatus.loading, errorMessage: ''));

    try {
      final result = await _platform.processPayment(
        serviceId: serviceId,
        amount: amount,
        userId: userId,
        resumeId: resumeId,
      );

      switch (result) {
        case Success():
          await _refreshAfterPayment();
          emit(state.copyWith(
            status: PaymentStatus.success,
            paymentSuccessful: true,
          ));
          onPaymentSuccess?.call(result);
          onPaymentSuccess = null;

        case Cancelled():
          emit(state.copyWith(
            status: PaymentStatus.canceled,
            errorMessage: 'Payment was canceled',
          ));

        case Failed(:final message):
          emit(state.copyWith(
            status: PaymentStatus.failed,
            errorMessage: message,
          ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: PaymentStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Get the current user ID from profile cubit
  String get _currentUserId {
    final userId = _profileCubit.currentUserId;
    if (userId == null || userId.isEmpty) {
      throw Exception('User ID not available. Please ensure you are logged in.');
    }
    return userId;
  }

  Future<void> _refreshAfterPayment() async {
    try {
      await _profileCubit.loadProfileData(force: true);
      AppLogger.debug('[PaymentCubit] Profile refreshed after payment', tag: 'Payments');

      try {
        final homeCubit = getIt<HomeCubit>();
        final email = _profileCubit.state.profile?.email;
        if (email != null && email.isNotEmpty) {
          await homeCubit.loadAiEnhancedHomeData(email: email);
          AppLogger.debug('[PaymentCubit] HomeCubit refreshed with new credits', tag: 'Payments');
        }
      } catch (homeErr) {
        AppLogger.error('[PaymentCubit] Failed to refresh HomeCubit: $homeErr', tag: 'Payments', error: homeErr);
      }
    } catch (profileErr) {
      AppLogger.error('[PaymentCubit] Failed to refresh profile: $profileErr', tag: 'Payments', error: profileErr);
    }
  }

  /// Load latest payment (kept for backwards compatibility)
  Future<void> loadLatestPayment() async {
    emit(state.copyWith(status: PaymentStatus.loading, errorMessage: ''));
    try {
      final response = await getIt<PaymentRepository>().getLatestPayment();
      emit(state.copyWith(status: PaymentStatus.success, latestPayment: response));
    } catch (e) {
      emit(state.copyWith(status: PaymentStatus.failed, errorMessage: e.toString()));
    }
  }

  void clearError() {
    emit(state.copyWith(errorMessage: '', status: PaymentStatus.initial));
  }

  void reset() {
    emit(const PaymentState());
  }
}
```

- [ ] **Step 3: Check existing state file**

Read `lib/features/payments/presentation/cubit/payment_state.dart`. It likely has `PaymentStatus` enum and freezed state. If `PaymentStatus` enum doesn't have all needed values, verify it has: `initial`, `loading`, `success`, `failed`, `canceled`, `processing`, `requiresAction`.

If the state file needs no changes, proceed. If it references types that changed, update it accordingly.

- [ ] **Step 4: Run code generation**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 5: Run analysis to find errors**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
flutter analyze lib/features/payments/presentation/cubit/payment_cubit.dart 2>&1
```

Expected: May show errors from callers still using `createPaymentIntent()`. These will be fixed in Task 8.

- [ ] **Step 6: Commit**

```bash
cd /Users/Apple/Documents/tabashir
git add tabashir-mobile/lib/features/payments/presentation/cubit/payment_cubit.dart tabashir-mobile/lib/features/payments/presentation/cubit/payment_cubit.freezed.dart tabashir-mobile/lib/features/payments/presentation/cubit/payment_cubit.g.dart
git commit -m "refactor: replace StripeService with PaymentPlatform in PaymentCubit"
```

---

### Task 7: Update DI registration

**Files:**
- Modify: `tabashir-mobile/lib/core/di/module.dart`

- [ ] **Step 1: Read the current module.dart**

The file has `StripeService` registered as `@lazySingleton`. We need to add `AppleIAPService` and a platform-based `PaymentPlatform` factory.

- [ ] **Step 2: Add imports at the top**

After the existing imports, add:

```dart
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:tabashir/core/services/apple_iap_service.dart';
import 'package:tabashir/features/payments/domain/repositories/payment_platform.dart';
import 'package:tabashir/features/payments/data/repositories/stripe_payment_platform.dart';
import 'package:tabashir/features/payments/data/repositories/apple_payment_platform.dart';
import 'package:tabashir/features/payments/domain/repositories/payment_repository.dart';
```

- [ ] **Step 3: Add new registrations**

After the `StripeService` registration (around line 63), add:

```dart
  @lazySingleton
  AppleIAPService get appleIAPService => AppleIAPService(authDioClient.dio);

  @lazySingleton
  PaymentPlatform get paymentPlatform {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return ApplePaymentPlatform(getIt<AppleIAPService>());
    }
    return StripePaymentPlatform(
      getIt<StripeService>(),
      getIt<PaymentRepository>(),
    );
  }
```

- [ ] **Step 4: Run code generation**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 5: Verify analysis**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
flutter analyze lib/core/di/module.dart 2>&1
```

Expected: No errors.

- [ ] **Step 6: Commit**

```bash
cd /Users/Apple/Documents/tabashir
git add tabashir-mobile/lib/core/di/module.dart tabashir-mobile/lib/core/di/module.config.dart tabashir-mobile/lib/core/di/module.g.dart
git commit -m "feat: register AppleIAPService and platform-based PaymentPlatform factory in DI"
```

---

### Task 8: Update `ServicesScreen` to use `processPayment()`

**Files:**
- Modify: `tabashir-mobile/lib/features/services/presentation/screens/services_screen.dart`

- [ ] **Step 1: Read the current file**

Find the `_onJobApplyServicePressed` method and the `_onPaymentSuccess` callback. The current code calls `PaymentCubit.createPaymentIntent(request: PaymentIntentRequest(...))`.

- [ ] **Step 2: Update the payment call**

Find where `_onJobApplyServicePressed` calls the cubit. Replace:

```dart
context.read<PaymentCubit>().createPaymentIntent(
  request: PaymentIntentRequest(
    amount: _pendingAmount ?? 100,
    currency: 'AED',
    serviceId: serviceId,
    serviceTitle: serviceTitle,
  ),
);
```

With:

```dart
final userId = context.read<ProfileCubit>().currentUserId ?? '';
context.read<PaymentCubit>().processPayment(
  serviceId: serviceId,
  amount: _pendingAmount ?? 100,
  resumeId: null,
);
```

- [ ] **Step 3: Update the `onPaymentSuccess` callback**

The old callback signature was `Future<void> Function(PaymentIntentResponse?)`. The new one is `Future<void> Function(PaymentResult)`. Update the callback assignment:

Old:
```dart
context.read<PaymentCubit>().onPaymentSuccess = (paymentIntent) async {
  // navigate to success screen
};
```

New:
```dart
context.read<PaymentCubit>().onPaymentSuccess = (result) async {
  final transactionId = switch (result) {
    Success(:final transactionId) => transactionId,
    _ => null,
  };
  // navigate to success screen
};
```

- [ ] **Step 4: Remove unused imports**

Remove imports that are no longer needed:
- `package:tabashir/core/network/models/payment/payment_intent_request.dart` (if no longer used)
- `package:tabashir/core/network/models/payment/payment_intent_response.dart` (if no longer used)
- `package:tabashir/core/models/stripe/stripe_enums.dart` (if no longer used)

Keep imports that are still used.

- [ ] **Step 5: Run analysis**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
flutter analyze lib/features/services/presentation/screens/services_screen.dart 2>&1
```

Fix any remaining errors.

- [ ] **Step 6: Commit**

```bash
cd /Users/Apple/Documents/tabashir
git add tabashir-mobile/lib/features/services/presentation/screens/services_screen.dart
git commit -m "refactor: update ServicesScreen to use processPayment() instead of createPaymentIntent()"
```

---

### Task 9: Run full analysis and fix any remaining issues

- [ ] **Step 1: Run full project analysis**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
flutter analyze 2>&1 | grep -E "error|warning" | head -30
```

- [ ] **Step 2: Fix any errors**

If there are other files calling `PaymentCubit.createPaymentIntent()`, `PaymentCubit.initPaymentSheet()`, or `PaymentCubit.processPaymentSheet()`, update them to use `processPayment()`. Search for callers:

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
grep -r "createPaymentIntent\|initPaymentSheet\|processPaymentSheet" lib/ --include="*.dart" | grep -v "payment_cubit.dart" | grep -v ".freezed.dart" | grep -v ".g.dart"
```

- [ ] **Step 3: Run code generation one final time**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 4: Verify clean analysis**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-mobile
flutter analyze 2>&1 | grep -c "error"
```

Expected: 0 errors.

- [ ] **Step 5: Commit remaining fixes**

```bash
cd /Users/Apple/Documents/tabashir
git status
git add -A
git commit -m "fix: resolve remaining analysis errors from PaymentPlatform migration"
```

---

## Post-Implementation Setup (Manual, Not Coded)

These steps are required before the feature works on iOS:

1. **App Store Connect** — Create 6 Consumable products with IDs matching the product table in the spec
2. **App Store Connect API Key** — Download .p8 file, set `APPLE_*` env vars on backend server (already done for backend)
3. **Backend `.env`** — Ensure `EMAIL_PASSWORD` is set (already done)
4. **Test with Sandbox** — Create a Sandbox Apple ID in App Store Connect, sign in on iOS device, test purchase flow
5. **Android test** — Verify Stripe flow is unchanged on Android device/emulator

# Mobile StoreKit 2 Integration — Design Spec

**Date:** 2026-04-03
**Status:** Draft — Awaiting User Review

## Context

The Tabashir mobile app (`tabashir-mobile/`) currently uses `flutter_stripe` for all payments on both iOS and Android. Apple App Store Guideline 3.1.1 mandates StoreKit for digital goods. The backend (`tabashir-backend/`) already has the `/api/v1/payments/verify-apple-receipt` endpoint implemented.

This design covers the **mobile only**. The backend is already complete.

## Decisions Made

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Products in scope | All 6 services | Full parity with backend offerings |
| Architecture pattern | Abstract `PaymentPlatform` interface | Clean separation, scalable to Google Play later |
| IAP package | `in_app_purchase` (official) | No third-party dependency, maintained by Flutter team |
| Purchase type | Consumable | Matches one-time payment model |

## Architecture

```
ServicesScreen (unchanged UI)
    │
    ▼
PaymentCubit.processPayment(serviceId, amount, userId)
    │
    ▼
PaymentPlatform (injected based on platform)
    │
    ├── iOS → ApplePaymentPlatform
    │         ├── AppleIAPService (in_app_purchase)
    │         └── POST /api/v1/payments/verify-apple-receipt (backend)
    │
    └── Android → StripePaymentPlatform
                  ├── StripeService (flutter_stripe)
                  └── POST /api/v1/payments/create-intent (backend)
```

## New Files

| File | Purpose |
|------|---------|
| `lib/features/payments/domain/repositories/payment_platform.dart` | Abstract `PaymentPlatform` interface + `PaymentResult` sealed class |
| `lib/features/payments/data/repositories/stripe_payment_platform.dart` | Stripe implementation (Android) |
| `lib/features/payments/data/repositories/apple_payment_platform.dart` | StoreKit 2 implementation (iOS) |
| `lib/core/services/apple_iap_service.dart` | Wraps `in_app_purchase` package — connection, products, purchases, receipt verification |

## Modified Files

| File | Change |
|------|--------|
| `lib/features/payments/presentation/cubit/payment_cubit.dart` | Replace `StripeService` dependency with `PaymentPlatform`; replace `createPaymentIntent()` with `processPayment()` |
| `lib/core/di/module.dart` | Add `AppleIAPService` registration; add platform-based `PaymentPlatform` factory |
| `pubspec.yaml` | Add `in_app_purchase: ^3.2.0` |
| `lib/features/services/presentation/screens/services_screen.dart` | Update payment call from `createPaymentIntent(request:)` to `processPayment(serviceId:, amount:, userId:)` |

## API Contract: Mobile → Backend

### iOS: POST /api/v1/payments/verify-apple-receipt

Already implemented in backend. Request:
```json
{
  "transactionId": "29384756201938475",
  "productId": "ai-job-apply-basic",
  "userId": "cmni71rhn00008zsahasau1ok",
  "resumeId": "..." // only for ai-resume-optimization
}
```

### Android: POST /api/v1/payments/create-intent

Unchanged. Existing Stripe flow.

## Product ID Mapping

Same IDs used in both Stripe and App Store Connect:

| Product ID | Price (AED) | Type |
|------------|-------------|------|
| `ai-job-apply-basic` | 100 | Consumable |
| `ai-job-apply-premium` | 200 | Consumable |
| `ai-resume-optimization` | 29 | Consumable |
| `linkedin-optimization` | 60 | Consumable |
| `ai-linkedin-enhancement` | 19 | Consumable |
| `interview-training` | 150 | Consumable |

## Payment Flow (iOS)

```
User taps service card
    │
    ▼
PaymentCubit.processPayment(serviceId, amount, userId)
    │
    ▼
ApplePaymentPlatform.processPayment()
    │
    ├─ 1. AppleIAPService.init() — check StoreKit availability
    ├─ 2. AppleIAPService.getProducts({serviceId}) — fetch from App Store
    ├─ 3. Listen to purchaseStream (Completer pattern)
    ├─ 4. AppleIAPService.purchase(product) — triggers Apple payment sheet
    ├─ 5. On PurchaseStatus.purchased:
    │     ├─ AppleIAPService.verifyReceipt() → POST /verify-apple-receipt
    │     ├─ If success: completePurchase() → consume
    │     └─ Return PaymentSuccess(transactionId)
    ├─ 6. On PurchaseStatus.canceled: Return PaymentCancelled()
    ├─ 7. On PurchaseStatus.error: Return PaymentFailed(message)
    └─ 8. Timeout after 5 minutes → Return PaymentFailed("timed out")
```

## Payment Flow (Android)

Unchanged. Stripe PaymentSheet flow via `StripePaymentPlatform`.

## Error Handling

| Scenario | iOS Behavior | Android Behavior |
|----------|-------------|-----------------|
| Store not available | PaymentFailed("App Store payments not available") | N/A |
| Product not found in App Store | PaymentFailed("Product X not found in App Store") | N/A |
| User cancels Apple sheet | PaymentCancelled() | PaymentCancelled() |
| Apple API timeout | PaymentFailed("Payment timed out") | N/A |
| Backend receipt verification fails | PaymentFailed("Receipt verification failed") | N/A |
| Stripe PaymentSheet cancel | N/A | PaymentCancelled() |
| Stripe network error | N/A | PaymentFailed(error message) |

## Testing

### Unit Tests
- `ApplePaymentPlatform` — mock `InAppPurchase`, test happy path, cancel, error, timeout
- `StripePaymentPlatform` — mock `StripeService`, test happy path, cancel, error
- `PaymentCubit` — mock `PaymentPlatform`, test state transitions for success/cancel/fail

### Manual Testing
1. Configure App Store Connect sandbox account
2. Create 6 consumable products in App Store Connect
3. Build and run on iOS simulator or device
4. Purchase `ai-job-apply-basic` — verify credits appear in HomeCubit
5. Cancel a purchase mid-flow — verify PaymentCancelled state
6. Test on Android — verify Stripe flow unchanged

## Risks & Mitigations

| Risk | Mitigation |
|------|------------|
| App Store products not created before testing | Create during development phase, use Sandbox for testing |
| `in_app_purchase` package behavior differs from docs | Test early with a minimal prototype |
| Completer pattern causes memory leak if stream never emits | 5-minute timeout + `sub.cancel()` in all exit paths |
| Breaking change to `PaymentCubit` API for existing callers | Update `ServicesScreen` in the same commit; no other callers exist |

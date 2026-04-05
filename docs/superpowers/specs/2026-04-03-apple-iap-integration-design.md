# Apple StoreKit 2 IAP Integration — Backend Design

**Date:** 2026-04-03
**Status:** Draft — Awaiting User Review

## Context

The Tabashir mobile app currently uses Stripe (`flutter_stripe`) for all in-app payments on both iOS and Android. Apple App Store Guideline 3.1.1 mandates StoreKit for digital goods sold within iOS apps. Stripe cannot be used as the payment method for digital purchases inside the iOS app.

This design covers the **backend only** (Python Flask in `tabashir-backend/`). The mobile implementation is a separate effort.

## Decisions Made

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Products in scope | All 6 existing services | Full parity with Stripe offerings |
| Verification method | Server-to-Server (App Store Server API) | Most secure, matches Stripe webhook pattern |
| Environment handling | Auto-detect from receipt `environment` field | Simplest API contract, eliminates mobile-side errors |
| Fulfillment logic | Extracted into shared `PaymentFulfillmentService` | Prevents drift between Stripe and Apple fulfillment paths |

## Architecture

### New Components

| Component | File | Purpose |
|-----------|------|---------|
| `AppleIAPService` | `app/services/apple_iap_service.py` | Generate App Store API JWT, verify StoreKit 2 transactions |
| `PaymentFulfillmentService` | `app/services/payment_fulfillment_service.py` | Shared fulfillment logic (job credits, resume updates, emails, subscriptions) |
| Verify Receipt Endpoint | `app/routes/payments_namespace.py` (new route) | `POST /api/v1/payments/verify-apple-receipt` |

### Payment Flow

```
Mobile (StoreKit 2)
    │  POST /api/v1/payments/verify-apple-receipt
    │  { transactionId, productId, userId }
    ▼
Flask Backend
    │
    ├─ 1. Validate required fields
    ├─ 2. Idempotency check: SELECT from Payment WHERE transactionId = ?
    ├─ 3. AppleIAPService.verify_transaction(transactionId)
    │     ├─ Generate ES256 JWT (App Store Connect key)
    │     ├─ GET /inApps/v1/transactions/{transactionId}
    │     └─ Return decoded receipt
    ├─ 4. Validate productId matches receipt
    ├─ 5. INSERT INTO Payment (paymentMethod='apple', status='COMPLETED', ...)
    └─ 6. PaymentFulfillmentService.fulfill(productId, userId, amount)
```

### Existing Components — Changes

| Component | Action |
|-----------|--------|
| `StripeService` | **Unchanged** — Android and web continue using Stripe |
| `StripeWebhook._handle_payment_success` | **Refactored** — inline fulfillment logic moved to `PaymentFulfillmentService` |
| `StripeWebhook._activate_job_apply` | **Moved** → `PaymentFulfillmentService._activate_job_apply` |

## API Contract

### POST /api/v1/payments/verify-apple-receipt

**Request:**
```json
{
  "transactionId": "29384756201938475",
  "productId": "ai-resume-optimization",
  "userId": "usr_abc123",
  "resumeId": "resume_xyz789"
}
```

For products other than `ai-resume-optimization`, omit `resumeId`:
```json
{
  "transactionId": "29384756201938475",
  "productId": "ai-job-apply-basic",
  "userId": "usr_abc123"
}
```

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `transactionId` | string | Yes | StoreKit 2 transaction ID |
| `productId` | string | Yes | Must match App Store Connect product ID |
| `userId` | string | Yes | User who made the purchase |
| `resumeId` | string | Conditional | Required only for `ai-resume-optimization` product |

**Success (200):**
```json
{
  "success": true,
  "data": {
    "transactionId": "29384756201938475",
    "productId": "ai-job-apply-basic",
    "paymentId": "pay_a1b2c3d4e5f6",
    "environment": "Sandbox"
  }
}
```

**Errors:**
- `400` — Missing fields, invalid product, product mismatch, receipt invalid
- `409` — Transaction already processed (idempotency)
- `500` — Server error

### Product ID Mapping

All 6 services use the same product IDs in Stripe and Apple:

| Product ID | Price (AED) | Fulfillment |
|------------|-------------|-------------|
| `ai-job-apply-basic` | 100 | +100 job credits |
| `ai-job-apply-premium` | 200 | +200 job credits |
| `ai-resume-optimization` | 29 | Update AiResume paymentStatus |
| `linkedin-optimization` | 60 | Create 30-day Subscription |
| `ai-linkedin-enhancement` | 19 | Send onboarding email |
| `interview-training` | 150 | Log purchase (future expansion) |

## Error Handling

| Scenario | Behavior |
|----------|----------|
| Missing Apple config | Warn in logs, return 500 "Apple IAP not configured" |
| Apple API timeout | Return 502 "Apple service unavailable, please retry" |
| Invalid JWT signature | Return 500 with error detail |
| Duplicate transaction | Return 200 with "already processed" message (idempotent) |
| Product not found | Return 400 "Invalid product ID" |
| Receipt productId ≠ request productId | Return 400 "Product ID mismatch" |
| ai-resume-optimization without resumeId | Return 400 "resumeId is required for this product" |

## Testing

### Unit Tests
- `AppleIAPService.generate_app_store_token` — validates JWT structure
- `AppleIAPService.verify_transaction` — mocks Apple API response
- `PaymentFulfillmentService.fulfill` — mocks DB queries, verifies correct handler called
- `verify-apple-receipt` endpoint — mocks both Apple service and DB layer

### Integration Tests
- End-to-end flow with sandbox Apple transaction
- Idempotency: same transactionId called twice returns 200 second time
- Product mismatch detection

## Environment Variables

```env
# Apple In-App Purchase (App Store Server API)
APPLE_KEY_ID=
APPLE_ISSUER_ID=
APPLE_TEAM_ID=
APPLE_BUNDLE_ID=com.tabashir.app
APPLE_PRIVATE_KEY_PATH=
```

The `.p8` private key file is **not** committed to git. It is downloaded once from App Store Connect and placed on the server/deployment environment.

## Dependencies

- `PyJWT[crypto]>=2.8.0` — already in requirements (`PyJWT==2.11.0`), need `cryptography` extra
- `requests` — already installed
- No new external services beyond Apple's App Store Server API

## Risks & Mitigations

| Risk | Mitigation |
|------|------------|
| Apple API key expires or is revoked | Rotate key via App Store Connect, update `.p8` file |
| App Store product IDs not created before launch | Create in App Store Connect during development, test with Sandbox |
| Fulfillment logic drifts between Stripe and Apple paths | Single `PaymentFulfillmentService` is the source of truth for both |
| Sandbox receipts sent to production endpoint | Auto-detect from receipt, separate Apple API URLs |

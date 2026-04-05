# Apple IAP Backend Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add Apple StoreKit 2 receipt verification and payment fulfillment to the Python Flask backend, while extracting shared fulfillment logic from the existing Stripe webhook.

**Architecture:** Three new components: `AppleIAPService` (Apple API calls), `PaymentFulfillmentService` (shared business logic), and a new `/verify-apple-receipt` endpoint. The Stripe webhook is refactored to use the shared fulfillment service.

**Tech Stack:** Python Flask, PyJWT (ES256), requests, psycopg2, pytest

---

## File Structure

| Action | File | Responsibility |
|--------|------|----------------|
| Create | `app/services/apple_iap_service.py` | JWT generation for Apple API + transaction verification |
| Create | `app/services/payment_fulfillment_service.py` | Shared fulfillment logic for all payment providers |
| Create | `tests/test_apple_iap_service.py` | Unit tests for AppleIAPService |
| Create | `tests/test_payment_fulfillment_service.py` | Unit tests for PaymentFulfillmentService |
| Create | `tests/test_payments_namespace.py` | Tests for the verify-apple-receipt endpoint |
| Modify | `app/routes/payments_namespace.py` | Add `/verify-apple-receipt` route, refactor StripeWebhook to use PaymentFulfillmentService |
| Modify | `app/config.py` | Add 5 Apple IAP config vars |
| Modify | `.env.example` | Add Apple IAP env var placeholders |
| Modify | `requirements.txt` | Add `cryptography` package (PyJWT crypto extra) |

---

### Task 1: Add Dependencies and Config

**Files:**
- Modify: `tabashir-backend/requirements.txt`
- Modify: `tabashir-backend/app/config.py`
- Modify: `tabashir-backend/.env.example`

- [ ] **Step 1: Add `cryptography` to requirements.txt**

The `PyJWT` package is already installed at `2.11.0`, but the ES256 algorithm requires the `cryptography` extra. Add it explicitly:

```
cryptography>=41.0.0
```

Add this line after the existing `PyJWT==2.11.0` line in `requirements.txt`.

- [ ] **Step 2: Install the new dependency**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-backend
source venv/bin/activate
pip install cryptography
```

- [ ] **Step 3: Add Apple IAP config to `app/config.py`**

Add these 5 lines after the Stripe settings (after line 62):

```python
    # Apple IAP (App Store Server API)
    APPLE_KEY_ID = os.getenv('APPLE_KEY_ID')
    APPLE_ISSUER_ID = os.getenv('APPLE_ISSUER_ID')
    APPLE_TEAM_ID = os.getenv('APPLE_TEAM_ID')
    APPLE_BUNDLE_ID = os.getenv('APPLE_BUNDLE_ID')
    APPLE_PRIVATE_KEY_PATH = os.getenv('APPLE_PRIVATE_KEY_PATH')
```

- [ ] **Step 4: Add Apple IAP env vars to `.env.example`**

Append to the end of `.env.example`:

```env
# Apple In-App Purchase (App Store Server API)
APPLE_KEY_ID=
APPLE_ISSUER_ID=
APPLE_TEAM_ID=
APPLE_BUNDLE_ID=com.tabashir.app
APPLE_PRIVATE_KEY_PATH=
```

- [ ] **Step 5: Commit**

```bash
cd /Users/Apple/Documents/tabashir
git add tabashir-backend/requirements.txt tabashir-backend/app/config.py tabashir-backend/.env.example
git commit -m "feat: add Apple IAP config vars and cryptography dependency"
```

---

### Task 2: Create `AppleIAPService`

**Files:**
- Create: `tabashir-backend/app/services/apple_iap_service.py`
- Test: `tabashir-backend/tests/test_apple_iap_service.py`

- [ ] **Step 1: Write tests for `AppleIAPService`**

Create `tests/test_apple_iap_service.py`:

```python
import pytest
import unittest.mock as mock
from app.services.apple_iap_service import AppleIAPService


class TestAppleIAPService:
    def setup_method(self):
        self.service = AppleIAPService()

    @mock.patch('app.services.apple_iap_service.Config')
    @mock.patch('builtins.open', new_callable=mock.mock_open, read_data='-----BEGIN EC PRIVATE KEY-----\nMOCK_KEY\n-----END EC PRIVATE KEY-----')
    @mock.patch('jwt.encode')
    def test_generate_token_returns_jwt_string(self, mock_encode, mock_open_file, mock_config):
        mock_config.APPLE_KEY_ID = 'TEST_KEY_ID'
        mock_config.APPLE_ISSUER_ID = 'TEST_ISSUER_ID'
        mock_config.APPLE_TEAM_ID = 'TEST_TEAM_ID'
        mock_config.APPLE_BUNDLE_ID = 'com.test.app'
        mock_config.APPLE_PRIVATE_KEY_PATH = '/path/to/key.p8'
        mock_encode.return_value = 'mock.jwt.token'

        token = self.service.generate_app_store_token()

        assert token == 'mock.jwt.token'
        mock_encode.assert_called_once()

    @mock.patch('app.services.apple_iap_service.Config')
    def test_generate_token_returns_none_when_config_missing(self, mock_config):
        mock_config.APPLE_KEY_ID = None
        mock_config.APPLE_ISSUER_ID = 'TEST'
        mock_config.APPLE_TEAM_ID = 'TEST'
        mock_config.APPLE_BUNDLE_ID = 'TEST'
        mock_config.APPLE_PRIVATE_KEY_PATH = '/path/to/key.p8'

        token = self.service.generate_app_store_token()

        assert token is None

    @mock.patch.object(AppleIAPService, 'generate_app_store_token', return_value='test.jwt.token')
    @mock.patch('requests.get')
    def test_verify_transaction_returns_response(self, mock_get, mock_gen_token):
        mock_response = mock.Mock()
        mock_response.json.return_value = {
            'transactionId': '12345',
            'productId': 'ai-job-apply-basic',
            'environment': 'Sandbox'
        }
        mock_response.raise_for_status.return_value = None
        mock_get.return_value = mock_response

        result = self.service.verify_transaction('12345', 'Sandbox')

        assert result['productId'] == 'ai-job-apply-basic'
        assert result['environment'] == 'Sandbox'
        mock_get.assert_called_once()
        assert 'storekit-sandbox' in mock_get.call_args[1] or 'sandbox' in str(mock_get.call_args)

    @mock.patch.object(AppleIAPService, 'generate_app_store_token', return_value='test.jwt.token')
    @mock.patch('requests.get')
    def test_verify_transaction_returns_none_on_error(self, mock_get, mock_gen_token):
        import requests
        mock_get.side_effect = requests.exceptions.RequestException('timeout')

        result = self.service.verify_transaction('12345', 'Sandbox')

        assert result is None
```

- [ ] **Step 2: Run tests to verify they fail**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-backend
source venv/bin/activate
pytest tests/test_apple_iap_service.py -v
```

Expected: FAIL with `ModuleNotFoundError: No module named 'app.services.apple_iap_service'`

- [ ] **Step 3: Create `AppleIAPService`**

Create `app/services/apple_iap_service.py`:

```python
import jwt
import time
import requests
import logging
from app.config import Config

logger = logging.getLogger(__name__)


class AppleIAPService:
    """
    Handles Apple App Store Server API authentication
    and receipt verification for StoreKit 2 purchases.
    """

    APPLE_ROOT_URLS = {
        'Sandbox': 'https://api.storekit-sandbox.itunes.apple.com',
        'Production': 'https://api.storekit.itunes.apple.com',
    }

    def generate_app_store_token(self):
        """
        Generate ES256 JWT token for App Store Server API.
        Returns the JWT string or None if config is incomplete.
        """
        if not all([
            Config.APPLE_KEY_ID,
            Config.APPLE_ISSUER_ID,
            Config.APPLE_TEAM_ID,
            Config.APPLE_BUNDLE_ID,
            Config.APPLE_PRIVATE_KEY_PATH,
        ]):
            logger.warning('Apple IAP config is incomplete — cannot generate App Store token')
            return None

        now = int(time.time())
        payload = {
            'iss': Config.APPLE_ISSUER_ID,
            'iat': now,
            'exp': now + 3600,
            'aud': 'appstoreconnect-v1',
            'bid': Config.APPLE_BUNDLE_ID,
        }

        headers = {
            'kid': Config.APPLE_KEY_ID,
            'alg': 'ES256',
        }

        try:
            with open(Config.APPLE_PRIVATE_KEY_PATH, 'r') as f:
                private_key = f.read()

            token = jwt.encode(payload, private_key, algorithm='ES256', headers=headers)
            return token
        except Exception as e:
            logger.error(f'Error generating Apple App Store token: {str(e)}')
            return None

    def verify_transaction(self, transaction_id, environment='Sandbox'):
        """
        Verify a StoreKit 2 transaction via App Store Server API.

        Args:
            transaction_id: The transaction ID from StoreKit 2
            environment: 'Sandbox' or 'Production' — determines which Apple API URL to use

        Returns:
            dict with transaction details, or None on failure
        """
        token = self.generate_app_store_token()
        if not token:
            return None

        base_url = self.APPLE_ROOT_URLS.get(environment, self.APPLE_ROOT_URLS['Sandbox'])
        url = f'{base_url}/inApps/v1/transactions/{transaction_id}'

        headers = {
            'Authorization': f'Bearer {token}',
            'Content-Type': 'application/json',
        }

        try:
            response = requests.get(url, headers=headers, timeout=10)
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            logger.error(f'Apple receipt verification failed: {str(e)}')
            return None
```

- [ ] **Step 4: Run tests to verify they pass**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-backend
source venv/bin/activate
pytest tests/test_apple_iap_service.py -v
```

Expected: All 4 tests PASS

- [ ] **Step 5: Commit**

```bash
cd /Users/Apple/Documents/tabashir
git add tabashir-backend/app/services/apple_iap_service.py tabashir-backend/tests/test_apple_iap_service.py
git commit -m "feat: add AppleIAPService for StoreKit 2 receipt verification"
```

---

### Task 3: Create `PaymentFulfillmentService`

**Files:**
- Create: `tabashir-backend/app/services/payment_fulfillment_service.py`
- Test: `tabashir-backend/tests/test_payment_fulfillment_service.py`

- [ ] **Step 1: Write tests for `PaymentFulfillmentService`**

Create `tests/test_payment_fulfillment_service.py`:

```python
import pytest
import unittest.mock as mock
from app.services.payment_fulfillment_service import PaymentFulfillmentService


class TestPaymentFulfillmentService:
    def setup_method(self):
        self.service = PaymentFulfillmentService()

    @mock.patch('app.services.payment_fulfillment_service.execute_query')
    def test_fulfill_job_apply_basic_calls_activate(self, mock_execute):
        self.service.fulfill('ai-job-apply-basic', 'user123', 100)

        # Should call execute_query to update AI DB jobs_to_apply_number
        execute_calls = [call for call in mock_execute.call_args_list]
        assert len(execute_calls) > 0

    @mock.patch('app.services.payment_fulfillment_service.execute_query')
    def test_fulfill_job_apply_premium_calls_activate_with_more_jobs(self, mock_execute):
        self.service.fulfill('ai-job-apply-premium', 'user123', 200)

        execute_calls = [call for call in mock_execute.call_args_list]
        assert len(execute_calls) > 0

    @mock.patch('app.services.payment_fulfillment_service.execute_query')
    def test_fulfill_linkedin_optimization_creates_subscription(self, mock_execute):
        self.service.fulfill('linkedin-optimization', 'user123', 60)

        # Should call execute_query to create subscription
        execute_calls = [call for call in mock_execute.call_args_list]
        assert len(execute_calls) > 0

    @mock.patch('app.services.payment_fulfillment_service.execute_query')
    def test_fulfill_unknown_service_does_nothing(self, mock_execute):
        self.service.fulfill('unknown-product', 'user123', 50)

        # Should not call execute_query for unknown products
        mock_execute.assert_not_called()

    @mock.patch('app.services.payment_fulfillment_service.StripeService.get_service_price')
    def test_get_price_returns_correct_price(self, mock_price):
        from app.services.stripe_service import StripeService

        assert StripeService.get_service_price('ai-job-apply-basic') == 100
        assert StripeService.get_service_price('ai-job-apply-premium') == 200
        assert StripeService.get_service_price('ai-resume-optimization') == 29
        assert StripeService.get_service_price('linkedin-optimization') == 60
        assert StripeService.get_service_price('ai-linkedin-enhancement') == 19
        assert StripeService.get_service_price('interview-training') == 150
        assert StripeService.get_service_price('nonexistent') is None
```

- [ ] **Step 2: Run tests to verify they fail**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-backend
source venv/bin/activate
pytest tests/test_payment_fulfillment_service.py -v
```

Expected: FAIL with `ModuleNotFoundError: No module named 'app.services.payment_fulfillment_service'`

- [ ] **Step 3: Create `PaymentFulfillmentService`**

Create `app/services/payment_fulfillment_service.py`:

```python
import logging
import uuid
from datetime import datetime, timedelta
from app.database.db import execute_query
from app.services.stripe_service import StripeService
from app.services.send_linkedin_email import send_email

logger = logging.getLogger(__name__)


class PaymentFulfillmentService:
    """
    Shared fulfillment logic for all payment providers (Stripe, Apple, future Google).
    Replaces the inline logic previously in StripeWebhook._handle_payment_success.
    """

    def fulfill(self, service_id, user_id, amount, receipt_data=None):
        """
        Route to the correct service handler based on product/service ID.

        Args:
            service_id: Product identifier (e.g., 'ai-job-apply-basic')
            user_id: User who made the purchase
            amount: Payment amount in AED
            receipt_data: Optional receipt metadata from the payment provider
        """
        handler = self._get_handler(service_id, user_id, amount)
        if handler:
            try:
                handler()
                logger.info(f'Fulfillment completed for {service_id} — user {user_id}')
            except Exception as e:
                logger.error(f'Fulfillment failed for {service_id} — user {user_id}: {str(e)}')
                raise
        else:
            logger.warning(f'No fulfillment handler for service: {service_id}')

    def _get_handler(self, service_id, user_id, amount):
        """Return the handler function for the given service_id."""
        handlers = {
            'ai-job-apply-basic': lambda: self._activate_job_apply(user_id, 100),
            'ai-job-apply-premium': lambda: self._activate_job_apply(user_id, 200),
            'ai-resume-optimization': lambda: self._update_ai_resume(user_id, amount),
            'linkedin-optimization': lambda: self._create_linkedin_subscription(user_id),
            'ai-linkedin-enhancement': lambda: self._send_linkedin_email(user_id),
            'interview-training': lambda: self._log_interview_training(user_id),
        }
        return handlers.get(service_id)

    def _activate_job_apply(self, user_id, jobs_number):
        """Activate job apply for a user with specified number of jobs."""
        from app.routes.resumes_namespace import get_client_cv_filename, Config as ResumesConfig
        from app.routes.resumes_namespace import format_cv_from_path, convert_docx_to_pdf
        import shutil
        import os

        user_data = execute_query(
            'SELECT email FROM users WHERE id = %s',
            (user_id,),
            fetch_one=True
        )
        if not user_data or not user_data.get('email'):
            logger.warning(f'User {user_id} email not found')
            return

        email = user_data['email']
        logger.info(f'Activating job apply for {email} with {jobs_number} jobs')

        filename = get_client_cv_filename(email)

        # Update job count in AI DB
        from app.database.db import get_ai_db_connection
        ai_conn = get_ai_db_connection()
        ai_cursor = ai_conn.cursor()
        ai_cursor.execute(
            'UPDATE clients SET jobs_to_apply_number = jobs_to_apply_number + %s, job_matching = 1 WHERE email = %s',
            (jobs_number, email)
        )
        ai_conn.commit()
        ai_cursor.close()
        ai_conn.close()
        logger.info(f'Updated job count for {email}: +{jobs_number} jobs')

        if not filename:
            logger.warning(f'No CV filename found for {email}, but job credits added')
            return

        cv_dir = ResumesConfig.CV_STORAGE_PATH
        original_cv_path = cv_dir / filename

        if not original_cv_path.exists():
            logger.warning(f'CV file not found at {original_cv_path}, searching for match...')
            matching_files = [
                f for f in os.listdir(cv_dir)
                if filename.replace('.pdf', '') in f and f.endswith('.pdf')
            ]
            if matching_files:
                original_cv_path = cv_dir / matching_files[0]
                logger.info(f'Found matching CV file: {matching_files[0]}')
            else:
                logger.warning(f'No matching CV file found for {email}, but job credits already added')
                return

        if not original_cv_path.exists():
            logger.warning(f'CV file still not found at {original_cv_path}, but job credits already added')
            return

        try:
            formatted_docx = format_cv_from_path(original_cv_path)
            pdf_path = convert_docx_to_pdf(formatted_docx)
            final_filename = pdf_path.name
            final_path = cv_dir / final_filename
            shutil.move(pdf_path, final_path)

            if formatted_docx.exists():
                formatted_docx.unlink()

            execute_query(
                'UPDATE users SET "cvFilename" = %s, "jobCount" = "jobCount" + %s, "aiJobApplyCount" = "aiJobApplyCount" + 1 WHERE email = %s',
                (final_filename, jobs_number, email),
                commit=True
            )
            logger.info(f'Successfully activated job apply for {email} with {jobs_number} jobs')
        except Exception as cv_error:
            logger.error(f'CV formatting failed for {email}: {str(cv_error)}')
            logger.warning(f'Job credits already added, but CV formatting skipped')

    def _update_ai_resume(self, user_id, amount):
        """Mark AI resume as paid for a user. Called without resumeId — updates latest."""
        execute_query(
            'UPDATE "AiResume" SET "paymentStatus" = true, "paymentAmount" = %s, "paymentDate" = %s, status = %s WHERE "userId" = %s',
            (amount, datetime.now(), 'COMPLETED', user_id),
            commit=True
        )

    def _create_linkedin_subscription(self, user_id):
        """Create a 30-day LinkedIn Optimization subscription for a user."""
        sub_id = f"sub_{uuid.uuid4().hex[:12]}"
        execute_query(
            """INSERT INTO "Subscription" (id, "userId", plan, status, "startDate", "endDate", "autoRenew", "createdAt", "updatedAt")
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)""",
            (
                sub_id,
                user_id,
                'LINKEDIN_OPTIMIZATION',
                'ACTIVE',
                datetime.now(),
                datetime.now() + timedelta(days=30),
                False,
                datetime.now(),
                datetime.now()
            ),
            commit=True
        )

    def _send_linkedin_email(self, user_id):
        """Send LinkedIn enhancement onboarding email."""
        user = execute_query(
            'SELECT email, name FROM users WHERE id = %s',
            (user_id,),
            fetch_one=True
        )
        if user:
            try:
                send_email(user['email'], user['name'])
                logger.info(f'LinkedIn enhancement email sent to {user["email"]}')
            except Exception as email_err:
                logger.error(f'Failed to send LinkedIn enhancement email: {str(email_err)}')
        else:
            logger.warning(f'User {user_id} not found for LinkedIn email')

    def _log_interview_training(self, user_id):
        """Log interview training purchase (future expansion point)."""
        logger.info(f'Interview Training purchased for user {user_id}')
```

- [ ] **Step 4: Run tests to verify they pass**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-backend
source venv/bin/activate
pytest tests/test_payment_fulfillment_service.py -v
```

Expected: All 5 tests PASS

- [ ] **Step 5: Commit**

```bash
cd /Users/Apple/Documents/tabashir
git add tabashir-backend/app/services/payment_fulfillment_service.py tabashir-backend/tests/test_payment_fulfillment_service.py
git commit -m "feat: add PaymentFulfillmentService for shared payment fulfillment logic"
```

---

### Task 4: Refactor Stripe Webhook to Use `PaymentFulfillmentService`

**Files:**
- Modify: `tabashir-backend/app/routes/payments_namespace.py`

- [ ] **Step 1: Read the current `payments_namespace.py` carefully**

The file has `StripeWebhook` with `_handle_payment_success` containing inline fulfillment logic and `_activate_job_apply` at the bottom. We need to:
1. Import `PaymentFulfillmentService`
2. Replace the inline fulfillment in `_handle_payment_success` with a call to `PaymentFulfillmentService.fulfill()`
3. Remove `_activate_job_apply` (moved to PaymentFulfillmentService)
4. Keep `_update_payment_status` (it's Stripe-specific)

- [ ] **Step 2: Apply the refactor to `payments_namespace.py`**

Add the import at the top (after line 8):

```python
from app.services.payment_fulfillment_service import PaymentFulfillmentService
```

Add the service instantiation after `stripe_service = StripeService()` (around line 18):

```python
fulfillment_service = PaymentFulfillmentService()
```

Replace the entire `_handle_payment_success` method (lines 114-220) with:

```python
    def _handle_payment_success(self, payment_intent):
        try:
            metadata = payment_intent.metadata.to_dict() if payment_intent.metadata else {}
            service_id = metadata.get('serviceId')
            user_id = metadata.get('userId')

            amount = payment_intent.amount_received / 100.0
            currency = str(payment_intent.currency).upper()
            transaction_id = payment_intent.id

            logger.info(f'Processing successful payment — Service: {service_id}, User: {user_id}, Amount: {amount} {currency}')

            if not service_id or not user_id:
                logger.error(f'Missing service_id or user_id in metadata: {metadata}')
                return

            # Create Payment record
            execute_query(
                """
                INSERT INTO "Payment"
                (id, amount, currency, status, "paymentMethod", "transactionId", "paymentDate", "userId", "createdAt", "updatedAt")
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                ON CONFLICT ("transactionId") DO UPDATE SET status = 'COMPLETED', "paymentDate" = %s
                """,
                (
                    f"pay_{uuid.uuid4().hex[:12]}",
                    amount,
                    currency,
                    'COMPLETED',
                    'stripe',
                    transaction_id,
                    datetime.now(),
                    user_id,
                    datetime.now(),
                    datetime.now(),
                    datetime.now()
                ),
                commit=True
            )
            logger.info(f'Payment record created for transaction: {transaction_id}')

            # Delegate to shared fulfillment service
            fulfillment_service.fulfill(service_id, user_id, amount)

        except Exception as e:
            logger.error(f'Error updating database after payment: {str(e)}')
            raise e
```

Remove the entire `_activate_job_apply` method (lines 227-end of file). It has been moved to `PaymentFulfillmentService._activate_job_apply`.

- [ ] **Step 3: Verify the app still starts**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-backend
source venv/bin/activate
python -c "from app import create_app; app = create_app(); print('App created successfully')"
```

Expected: `App created successfully`

- [ ] **Step 4: Commit**

```bash
cd /Users/Apple/Documents/tabashir
git add tabashir-backend/app/routes/payments_namespace.py
git commit -m "refactor: extract Stripe webhook fulfillment to shared PaymentFulfillmentService"
```

---

### Task 5: Add `/verify-apple-receipt` Endpoint

**Files:**
- Modify: `tabashir-backend/app/routes/payments_namespace.py`
- Test: `tabashir-backend/tests/test_payments_namespace.py`

- [ ] **Step 1: Write tests for the endpoint**

Create `tests/test_payments_namespace.py`:

```python
import pytest
import unittest.mock as mock
import json


class TestVerifyAppleReceipt:
    """Tests for POST /api/v1/payments/verify-apple-receipt"""

    def _make_request(self, app, payload):
        """Helper to make test requests."""
        with app.test_client() as client:
            return client.post(
                '/api/v1/payments/verify-apple-receipt',
                data=json.dumps(payload),
                content_type='application/json'
            )

    def test_missing_fields_returns_400(self):
        from app import create_app
        app = create_app()

        response = self._make_request(app, {'transactionId': '123'})

        assert response.status_code == 400
        data = json.loads(response.data)
        assert 'error' in data

    @mock.patch('app.routes.payments_namespace.execute_query')
    def test_idempotent_transaction_returns_200(self, mock_execute):
        from app import create_app
        app = create_app()

        # Simulate existing transaction
        mock_execute.return_value = {'id': 'pay_existing'}

        response = self._make_request(app, {
            'transactionId': 'existing_txn',
            'productId': 'ai-job-apply-basic',
            'userId': 'user123'
        })

        assert response.status_code == 200
        data = json.loads(response.data)
        assert 'already processed' in data.get('message', '').lower() or data.get('success') is True

    @mock.patch('app.routes.payments_namespace.execute_query', return_value=None)
    @mock.patch('app.routes.payments_namespace.apple_iap_service')
    def test_invalid_receipt_returns_400(self, mock_apple_service, mock_execute):
        from app import create_app
        app = create_app()

        mock_apple_service.verify_transaction.return_value = None

        response = self._make_request(app, {
            'transactionId': 'bad_txn',
            'productId': 'ai-job-apply-basic',
            'userId': 'user123'
        })

        assert response.status_code == 400

    @mock.patch('app.routes.payments_namespace.execute_query', return_value=None)
    @mock.patch('app.routes.payments_namespace.apple_iap_service')
    def test_product_mismatch_returns_400(self, mock_apple_service, mock_execute):
        from app import create_app
        app = create_app()

        mock_apple_service.verify_transaction.return_value = {
            'productId': 'different-product',
            'environment': 'Sandbox'
        }

        response = self._make_request(app, {
            'transactionId': 'txn_123',
            'productId': 'ai-job-apply-basic',
            'userId': 'user123'
        })

        assert response.status_code == 400

    def test_resume_optimization_requires_resume_id(self):
        from app import create_app
        app = create_app()

        response = self._make_request(app, {
            'transactionId': 'txn_123',
            'productId': 'ai-resume-optimization',
            'userId': 'user123'
        })

        assert response.status_code == 400
        data = json.loads(response.data)
        assert 'resumeId' in data.get('error', '')
```

- [ ] **Step 2: Run tests to verify they fail**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-backend
source venv/bin/activate
pytest tests/test_payments_namespace.py -v
```

Expected: FAIL — endpoint doesn't exist yet

- [ ] **Step 3: Add the `/verify-apple-receipt` route**

Append to `app/routes/payments_namespace.py`, after the `StripeWebhook` class:

```python
@payments_ns.route('/verify-apple-receipt')
class VerifyAppleReceipt(Resource):
    @payments_ns.doc('verify_apple_receipt',
                     params={
                         'transactionId': 'StoreKit 2 transaction ID',
                         'productId': 'Product identifier (e.g., ai-job-apply-basic)',
                         'userId': 'User ID',
                         'resumeId': 'Resume ID (required for ai-resume-optimization)'
                     })
    def post(self):
        """Verify an Apple StoreKit 2 purchase receipt"""
        try:
            data = request.json
            transaction_id = data.get('transactionId')
            product_id = data.get('productId')
            user_id = data.get('userId')
            resume_id = data.get('resumeId')

            if not all([transaction_id, product_id, user_id]):
                return {'error': 'transactionId, productId, and userId are required'}, 400

            # resumeId required for ai-resume-optimization
            if product_id == 'ai-resume-optimization' and not resume_id:
                return {'error': 'resumeId is required for this product'}, 400

            # Check idempotency
            existing = execute_query(
                'SELECT id FROM "Payment" WHERE "transactionId" = %s AND status = %s',
                (transaction_id, 'COMPLETED'),
                fetch_one=True
            )
            if existing:
                return {
                    'success': True,
                    'message': 'Transaction already processed',
                    'data': {'transactionId': transaction_id}
                }, 200

            # Get price for this product
            price = StripeService.get_service_price(product_id)
            if not price:
                return {'error': 'Invalid product ID'}, 400

            # Verify receipt with Apple
            from app.services.apple_iap_service import AppleIAPService
            apple_service = AppleIAPService()
            receipt_data = apple_service.verify_transaction(transaction_id)

            if not receipt_data:
                return {'error': 'Receipt verification failed'}, 400

            # Validate product matches receipt
            receipt_product = receipt_data.get('productId')
            if receipt_product and receipt_product != product_id:
                logger.warning(f'Product mismatch: expected {product_id}, got {receipt_product}')
                return {'error': 'Product ID does not match receipt'}, 400

            # Extract environment from receipt
            environment = receipt_data.get('environment', 'Sandbox')

            # Create payment record
            payment_id = f"pay_{uuid.uuid4().hex[:12]}"
            execute_query(
                """
                INSERT INTO "Payment"
                (id, amount, currency, status, "paymentMethod", "transactionId", "paymentDate", "userId", "createdAt", "updatedAt")
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                """,
                (
                    payment_id,
                    price,
                    'AED',
                    'COMPLETED',
                    'apple',
                    transaction_id,
                    datetime.now(),
                    user_id,
                    datetime.now(),
                    datetime.now()
                ),
                commit=True
            )

            # Fulfill the purchase
            fulfillment_service.fulfill(product_id, user_id, price, receipt_data)

            return {
                'success': True,
                'data': {
                    'transactionId': transaction_id,
                    'productId': product_id,
                    'paymentId': payment_id,
                    'environment': environment
                }
            }, 200

        except Exception as e:
            logger.error(f'Error verifying Apple receipt: {str(e)}')
            return {'success': False, 'error': str(e)}, 500
```

- [ ] **Step 4: Run tests to verify they pass**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-backend
source venv/bin/activate
pytest tests/test_payments_namespace.py -v
```

Expected: All 5 tests PASS

- [ ] **Step 5: Commit**

```bash
cd /Users/Apple/Documents/tabashir
git add tabashir-backend/app/routes/payments_namespace.py tabashir-backend/tests/test_payments_namespace.py
git commit -m "feat: add /verify-apple-receipt endpoint for StoreKit 2 receipt verification"
```

---

### Task 6: Run Full Test Suite and Verify

- [ ] **Step 1: Run the full test suite**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-backend
source venv/bin/activate
pytest tests/ -v --ignore=tests/test_resume_generation.py
```

Expected: All tests PASS (excluding `test_resume_generation.py` which may have external dependencies)

- [ ] **Step 2: Verify the Flask app starts**

```bash
cd /Users/Apple/Documents/tabashir/tabashir-backend
source venv/bin/activate
python run.py &
sleep 3
curl -s http://localhost:5050/api/v1/payments/verify-apple-receipt -X POST -H "Content-Type: application/json" -d '{}' | python -m json.tool
```

Expected: Returns `{"error": "transactionId, productId, and userId are required"}` with status 400 — confirms the endpoint is registered.

- [ ] **Step 3: Stop the server**

```bash
kill %1
```

- [ ] **Step 4: Final commit**

```bash
cd /Users/Apple/Documents/tabashir
git status
git add -A
git commit -m "chore: verify Apple IAP integration — all tests passing"
```

---

## Post-Implementation Setup (Manual, Not Coded)

These steps are required before the feature works in production:

1. **App Store Connect** — Create 6 Consumable products matching the product IDs in the plan
2. **Download API Key** — Generate an App Store Connect API key (.p8 file), note the Key ID and Issuer ID
3. **Configure Environment** — Set the 5 `APPLE_*` env vars on the server
4. **Place .p8 Key** — Copy the .p8 file to the server at the path specified in `APPLE_PRIVATE_KEY_PATH`
5. **Test with Sandbox** — Use a Sandbox Apple ID in the mobile app to test the full flow

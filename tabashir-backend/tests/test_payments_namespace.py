import pytest
import unittest.mock as mock
import json
import sys
import os

# Add backend root to path so 'app' package is importable
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

# Mock stripe before it gets imported via app/__init__.py
sys.modules['stripe'] = mock.MagicMock()


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

    @mock.patch('app.routes.payments_namespace.execute_query')
    def test_missing_fields_returns_400(self, mock_execute):
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
    @mock.patch('app.services.apple_iap_service.AppleIAPService')
    def test_invalid_receipt_returns_400(self, mock_apple_service_class, mock_execute):
        from app import create_app
        app = create_app()

        mock_instance = mock.MagicMock()
        mock_instance.verify_transaction.return_value = None
        mock_apple_service_class.return_value = mock_instance

        response = self._make_request(app, {
            'transactionId': 'bad_txn',
            'productId': 'ai-job-apply-basic',
            'userId': 'user123'
        })

        assert response.status_code == 400

    @mock.patch('app.routes.payments_namespace.execute_query', return_value=None)
    @mock.patch('app.services.apple_iap_service.AppleIAPService')
    def test_product_mismatch_returns_400(self, mock_apple_service_class, mock_execute):
        from app import create_app
        app = create_app()

        mock_instance = mock.MagicMock()
        mock_instance.verify_transaction.return_value = {
            'productId': 'different-product',
            'environment': 'Sandbox'
        }
        mock_apple_service_class.return_value = mock_instance

        response = self._make_request(app, {
            'transactionId': 'txn_123',
            'productId': 'ai-job-apply-basic',
            'userId': 'user123'
        })

        assert response.status_code == 400

    @mock.patch('app.routes.payments_namespace.execute_query')
    def test_resume_optimization_requires_resume_id(self, mock_execute):
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

    @mock.patch('app.routes.payments_namespace.fulfillment_service')
    @mock.patch('app.routes.payments_namespace.execute_query')
    @mock.patch('app.services.apple_iap_service.AppleIAPService')
    def test_successful_receipt_verification(self, mock_apple_class, mock_execute, mock_fulfill):
        from app import create_app
        app = create_app()

        # First call: idempotency check returns None (not found)
        # Second call: INSERT Payment
        mock_execute.side_effect = [None, None]

        mock_apple_instance = mock.Mock()
        mock_apple_instance.verify_transaction.return_value = {
            'transactionId': 'txn_456',
            'productId': 'ai-job-apply-basic',
            'environment': 'Sandbox'
        }
        mock_apple_class.return_value = mock_apple_instance

        response = self._make_request(app, {
            'transactionId': 'txn_456',
            'productId': 'ai-job-apply-basic',
            'userId': 'user456'
        })

        assert response.status_code == 200
        data = json.loads(response.data)
        assert data['success'] is True
        assert data['data']['transactionId'] == 'txn_456'
        assert data['data']['productId'] == 'ai-job-apply-basic'
        assert 'paymentId' in data['data']
        assert data['data']['environment'] == 'Sandbox'

        # Verify fulfillment was called with correct args
        mock_fulfill.fulfill.assert_called_once()
        call_args = mock_fulfill.fulfill.call_args
        assert call_args[0][0] == 'ai-job-apply-basic'
        assert call_args[0][1] == 'user456'
        assert call_args[0][2] == 100

import pytest
import unittest.mock as mock
import sys
import os

# Add backend root to path so 'app' package is importable
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

# Mock stripe before it gets imported via app/__init__.py
sys.modules['stripe'] = mock.MagicMock()

from app.services.apple_iap_service import AppleIAPService


class TestAppleIAPService:
    def setup_method(self):
        self.service = AppleIAPService()

    @mock.patch.object(AppleIAPService, 'generate_app_store_token')
    def test_generate_token_returns_jwt_string(self, mock_gen_token):
        mock_gen_token.return_value = 'mock.jwt.token'

        token = self.service.generate_app_store_token()

        assert token == 'mock.jwt.token'
        mock_gen_token.assert_called_once()

    def test_generate_token_returns_none_when_config_missing(self):
        with mock.patch('app.services.apple_iap_service.Config') as mock_config:
            mock_config.APPLE_KEY_ID = None
            mock_config.APPLE_ISSUER_ID = 'TEST'
            mock_config.APPLE_TEAM_ID = 'TEST'
            mock_config.APPLE_BUNDLE_ID = 'TEST'
            mock_config.APPLE_PRIVATE_KEY_PATH = '/path/to/key.p8'

            service = AppleIAPService()
            token = service.generate_app_store_token()

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

    @mock.patch.object(AppleIAPService, 'generate_app_store_token', return_value='test.jwt.token')
    @mock.patch('requests.get')
    def test_verify_transaction_returns_none_on_error(self, mock_get, mock_gen_token):
        import requests
        mock_get.side_effect = requests.exceptions.RequestException('timeout')

        result = self.service.verify_transaction('12345', 'Sandbox')

        assert result is None

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

    @mock.patch('app.services.apple_iap_service.open', new_callable=mock.mock_open, read_data='-----BEGIN EC PRIVATE KEY-----\nMOCK_KEY\n-----END EC PRIVATE KEY-----')
    @mock.patch('jwt.encode', return_value='mock.jwt.token')
    @mock.patch('time.time', return_value=1000000)
    def test_generate_token_calls_jwt_encode(self, mock_time, mock_jwt_encode, mock_open_file):
        with mock.patch('app.services.apple_iap_service.Config') as mock_config:
            mock_config.APPLE_KEY_ID = 'KEY1'
            mock_config.APPLE_ISSUER_ID = 'ISSUER1'
            mock_config.APPLE_TEAM_ID = 'TEAM1'
            mock_config.APPLE_BUNDLE_ID = 'com.example.app'
            mock_config.APPLE_PRIVATE_KEY_PATH = '/path/to/key.p8'

            token = self.service.generate_app_store_token()

            assert token == 'mock.jwt.token'
            mock_jwt_encode.assert_called_once()
            # Verify correct payload was passed
            call_args = mock_jwt_encode.call_args
            assert call_args.kwargs['algorithm'] == 'ES256'
            payload = call_args[0][0]  # payload is first positional arg
            assert payload['iss'] == 'ISSUER1'
            assert payload['aud'] == 'appstoreconnect-v1'

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
    def test_verify_transaction_returns_none_on_error(self, mock_get, mock_gen_token, caplog):
        import logging
        import requests
        mock_get.side_effect = requests.exceptions.RequestException('timeout')

        with caplog.at_level(logging.ERROR):
            result = self.service.verify_transaction('12345', 'Sandbox')

        assert result is None
        assert 'Apple receipt verification failed' in caplog.text

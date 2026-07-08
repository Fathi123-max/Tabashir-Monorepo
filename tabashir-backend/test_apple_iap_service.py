import pytest
import jwt
from unittest.mock import patch, MagicMock
from app.services.apple_iap_service import AppleIAPService
from app.config import Config

class TestAppleIAPService:
    """Unit tests for AppleIAPService transactions verification and decoding"""

    @patch('app.services.apple_iap_service.requests.get')
    def test_verify_transaction_success(self, mock_requests_get):
        """Test verify_transaction successfully fetches and decodes JWS payload"""
        # Create a sample payload we expect Apple to sign in JWS format
        expected_payload = {
            "productId": "ai_resume_optimization",
            "transactionId": "mock_txn_12345",
            "originalTransactionId": "mock_txn_12345",
            "environment": "Sandbox",
            "purchaseDate": 1700000000
        }
        
        # Encode payload into a mock JWT/JWS token
        # (verify_signature=False is used in decoding so we don't need real keys for encoding in test)
        mock_jws_token = jwt.encode(expected_payload, "mock-key-not-used", algorithm="HS256")
        if isinstance(mock_jws_token, bytes):
            mock_jws_token = mock_jws_token.decode('utf-8')
            
        # Mock the requests.get response
        mock_response = MagicMock()
        mock_response.status_code = 200
        mock_response.json.return_value = {
            "signedTransactionInfo": mock_jws_token
        }
        mock_requests_get.return_value = mock_response

        # Instantiate AppleIAPService and call verify_transaction
        # Ensure minimum configuration is set so it generates a token (or patch generate_app_store_token)
        with patch.object(AppleIAPService, 'generate_app_store_token', return_value="mock-token"):
            service = AppleIAPService()
            result = service.verify_transaction("mock_txn_12345", environment="Sandbox")

        # Assertions
        assert result is not None
        assert result["productId"] == "ai_resume_optimization"
        assert result["transactionId"] == "mock_txn_12345"
        assert result["environment"] == "Sandbox"
        assert result["purchaseDate"] == 1700000000

    @patch('app.services.apple_iap_service.requests.get')
    def test_verify_transaction_no_signed_info(self, mock_requests_get):
        """Test verify_transaction returns None if signedTransactionInfo is missing"""
        # Mock the requests.get response with missing field
        mock_response = MagicMock()
        mock_response.status_code = 200
        mock_response.json.return_value = {}
        mock_requests_get.return_value = mock_response

        with patch.object(AppleIAPService, 'generate_app_store_token', return_value="mock-token"):
            service = AppleIAPService()
            result = service.verify_transaction("mock_txn_12345", environment="Sandbox")

        assert result is None

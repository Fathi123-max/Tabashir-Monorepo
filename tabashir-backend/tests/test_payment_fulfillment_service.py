import pytest
import unittest.mock as mock
import sys
import os

# Add backend root to path so 'app' package is importable
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

# Mock stripe before it gets imported via app/__init__.py
sys.modules['stripe'] = mock.MagicMock()

from app.services.payment_fulfillment_service import PaymentFulfillmentService


class TestPaymentFulfillmentService:
    def setup_method(self):
        self.service = PaymentFulfillmentService()

    @mock.patch('app.services.job_apply.process_cv.get_client_cv_filename', return_value=None)
    @mock.patch('app.database.db.get_ai_db_connection')
    @mock.patch('app.services.payment_fulfillment_service.execute_query')
    def test_fulfill_job_apply_basic_calls_activate(self, mock_execute, mock_ai_conn, mock_get_filename):
        # Configure execute_query to return a user email when called
        mock_execute.return_value = {'email': 'test@example.com'}

        self.service.fulfill('ai-job-apply-basic', 'user123', 100)

        # Should call execute_query to update AI DB jobs_to_apply_number
        execute_calls = [call for call in mock_execute.call_args_list]
        assert len(execute_calls) > 0

    @mock.patch('app.services.job_apply.process_cv.get_client_cv_filename', return_value=None)
    @mock.patch('app.database.db.get_ai_db_connection')
    @mock.patch('app.services.payment_fulfillment_service.execute_query')
    def test_fulfill_job_apply_premium_calls_activate_with_more_jobs(self, mock_execute, mock_ai_conn, mock_get_filename):
        # Configure execute_query to return a user email when called
        mock_execute.return_value = {'email': 'test@example.com'}

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

    def test_get_price_returns_correct_price(self):
        from app.services.stripe_service import StripeService

        assert StripeService.get_service_price('ai-job-apply-basic') == 100
        assert StripeService.get_service_price('ai-job-apply-premium') == 200
        assert StripeService.get_service_price('ai-resume-optimization') == 29
        assert StripeService.get_service_price('linkedin-optimization') == 60
        assert StripeService.get_service_price('ai-linkedin-enhancement') == 19
        assert StripeService.get_service_price('interview-training') == 150
        assert StripeService.get_service_price('nonexistent') is None

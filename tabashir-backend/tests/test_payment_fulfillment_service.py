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

    @mock.patch('app.services.payment_fulfillment_service.execute_query')
    @mock.patch('app.routes.resumes_namespace.get_client_cv_filename', return_value=None)
    @mock.patch('app.database.db.get_ai_db_connection')
    def test_fulfill_job_apply_basic_updates_with_100_jobs(self, mock_ai_db, mock_get_cv, mock_execute):
        # Mock AI DB connection
        mock_conn = mock.Mock()
        mock_cursor = mock.Mock()
        mock_ai_db.return_value = mock_conn
        mock_conn.cursor.return_value = mock_cursor

        mock_execute.return_value = {'email': 'test@test.com'}

        self.service.fulfill('ai-job-apply-basic', 'user123', 100)

        # Verify AI DB was called with 100 jobs
        ai_cursor_calls = mock_cursor.execute.call_args_list
        assert any('100' in str(call) or 'jobs_to_apply_number' in str(call) for call in ai_cursor_calls)

    @mock.patch('app.services.payment_fulfillment_service.execute_query')
    @mock.patch('app.routes.resumes_namespace.get_client_cv_filename', return_value=None)
    @mock.patch('app.database.db.get_ai_db_connection')
    def test_fulfill_job_apply_premium_updates_with_200_jobs(self, mock_ai_db, mock_get_cv, mock_execute):
        mock_conn = mock.Mock()
        mock_cursor = mock.Mock()
        mock_ai_db.return_value = mock_conn
        mock_conn.cursor.return_value = mock_cursor

        mock_execute.return_value = {'email': 'test@test.com'}

        self.service.fulfill('ai-job-apply-premium', 'user123', 200)

        ai_cursor_calls = mock_cursor.execute.call_args_list
        assert any('200' in str(call) or 'jobs_to_apply_number' in str(call) for call in ai_cursor_calls)

    @mock.patch('app.services.payment_fulfillment_service.execute_query')
    def test_fulfill_linkedin_optimization_creates_subscription(self, mock_execute):
        self.service.fulfill('linkedin-optimization', 'user123', 60)

        # Verify INSERT INTO Subscription was called
        execute_calls = [str(call) for call in mock_execute.call_args_list]
        assert any('INSERT INTO "Subscription"' in call for call in execute_calls)
        assert any('LINKEDIN_OPTIMIZATION' in call for call in execute_calls)

    @mock.patch('app.services.payment_fulfillment_service.execute_query')
    def test_fulfill_unknown_service_does_nothing(self, mock_execute):
        self.service.fulfill('unknown-product', 'user123', 50)

        # Should not call execute_query for unknown products
        mock_execute.assert_not_called()

    @mock.patch('app.services.payment_fulfillment_service.send_email')
    @mock.patch('app.services.payment_fulfillment_service.execute_query')
    def test_fulfill_linkedin_enhancement_sends_email(self, mock_execute, mock_send_email):
        mock_execute.return_value = {'email': 'test@test.com', 'name': 'Test User'}

        self.service.fulfill('ai-linkedin-enhancement', 'user123', 19)

        mock_send_email.assert_called_once_with('test@test.com', 'Test User')

    @mock.patch('app.services.payment_fulfillment_service.execute_query')
    def test_fulfill_ai_resume_optimization_updates_payment(self, mock_execute):
        self.service.fulfill('ai-resume-optimization', 'user123', 29)

        execute_calls = [str(call) for call in mock_execute.call_args_list]
        assert any('UPDATE "AiResume"' in call for call in execute_calls)
        assert any('paymentStatus' in call for call in execute_calls)
        assert any('COMPLETED' in call for call in execute_calls)

    def test_fulfill_interview_training_logs_purchase(self, caplog):
        import logging
        with caplog.at_level(logging.INFO):
            self.service.fulfill('interview-training', 'user123', 150)

        assert 'Interview Training purchased for user user123' in caplog.text

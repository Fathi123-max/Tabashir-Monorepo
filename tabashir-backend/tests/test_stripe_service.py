import pytest
from app.services.stripe_service import StripeService


class TestStripeService:
    def test_get_service_price_returns_correct_prices(self):
        assert StripeService.get_service_price('ai-job-apply-basic') == 100
        assert StripeService.get_service_price('ai-job-apply-premium') == 200
        assert StripeService.get_service_price('ai-resume-optimization') == 29
        assert StripeService.get_service_price('linkedin-optimization') == 60
        assert StripeService.get_service_price('ai-linkedin-enhancement') == 19
        assert StripeService.get_service_price('interview-training') == 150
        assert StripeService.get_service_price('nonexistent') is None

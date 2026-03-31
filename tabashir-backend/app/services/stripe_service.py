import stripe
from app.config import Config
from app.database.db import execute_query
import logging

logger = logging.getLogger(__name__)

class StripeService:
    def __init__(self):
        if Config.STRIPE_SECRET_KEY:
            stripe.api_key = Config.STRIPE_SECRET_KEY
        else:
            logger.warning("STRIPE_SECRET_KEY is not set in Config")

    def create_or_get_customer(self, email, name=None, user_id=None):
        """
        Retrieves a Stripe customer by email or creates a new one.
        """
        try:
            # Search for existing customer
            customers = stripe.Customer.list(email=email, limit=1).data
            if customers:
                return customers[0]

            # Create new customer
            customer = stripe.Customer.create(
                email=email,
                name=name,
                metadata={
                    "user_id": user_id
                }
            )
            return customer
        except Exception as e:
            logger.error(f"Error in create_or_get_customer: {str(e)}")
            raise e

    def create_ephemeral_key(self, customer_id):
        """
        Creates an ephemeral key for a customer (required for mobile PaymentSheet).
        """
        try:
            return stripe.EphemeralKey.create(
                customer=customer_id,
                stripe_version='2022-11-15', # Standard version for flutter_stripe
            )
        except Exception as e:
            logger.error(f"Error in create_ephemeral_key: {str(e)}")
            raise e

    def create_payment_intent(self, amount_aed, customer_id, metadata=None):
        """
        Creates a PaymentIntent for a specific amount.
        amount_aed: Amount in AED (not cents, we convert here)
        """
        try:
            # Stripe expects amount in cents
            amount_cents = int(float(amount_aed) * 100)
            
            intent = stripe.PaymentIntent.create(
                amount=amount_cents,
                currency='aed',
                customer=customer_id,
                automatic_payment_methods={
                    'enabled': True,
                },
                metadata=metadata or {}
            )
            return intent
        except Exception as e:
            logger.error(f"Error in create_payment_intent: {str(e)}")
            raise e

    @staticmethod
    def get_service_price(service_id):
        """
        Returns the price in AED for a given service ID.
        Matching the logic from tabashir-frontend/lib/payment-data.ts
        """
        prices = {
            "ai-job-apply": 200,
            "linkedin-optimization": 60,
            "ai-linkedin-enhancement": 19,
            "ai-resume-optimization": 29,
            "interview-training": 150
        }
        return prices.get(service_id)

    @staticmethod
    def get_service_title(service_id):
        """
        Returns a friendly title for the service.
        """
        titles = {
            "ai-job-apply": "AI Job Apply",
            "linkedin-optimization": "LinkedIn Optimization",
            "ai-linkedin-enhancement": "LinkedIn Profile Enhancement",
            "ai-resume-optimization": "ATS CV Optimization",
            "interview-training": "Interview Training"
        }
        return titles.get(service_id, service_id)

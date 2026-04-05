from flask import request
from flask_restx import Namespace, Resource
import stripe
import logging
import uuid
from app.config import Config
from app.services.stripe_service import StripeService
from app.services.payment_fulfillment_service import PaymentFulfillmentService
from app.database.db import execute_query
from datetime import datetime

logger = logging.getLogger(__name__)

payments_ns = Namespace('payments', description='Stripe Payment Operations')

stripe_service = StripeService()
fulfillment_service = PaymentFulfillmentService()

@payments_ns.route('/create-intent')
class CreatePaymentIntent(Resource):
    @payments_ns.doc('create_payment_intent',
                     params={
                         'serviceId': 'The ID of the service (e.g., ai-job-apply)',
                         'userId': 'The ID of the user',
                         'resumeId': 'Optional resume ID'
                     })
    def post(self):
        """Create a PaymentIntent for the mobile app"""
        try:
            data = request.json
            service_id = data.get('serviceId')
            user_id = data.get('userId')
            resume_id = data.get('resumeId')

            if not service_id or not user_id:
                return {'error': 'serviceId and userId are required'}, 400

            # Get user email
            user = execute_query("SELECT email, name FROM users WHERE id = %s", (user_id,), fetch_one=True)
            if not user:
                return {'error': 'User not found'}, 404

            email = user['email']
            name = user['name']

            # Get price
            price = stripe_service.get_service_price(service_id)
            if not price:
                return {'error': 'Invalid service ID'}, 400

            # 1. Create/Get Customer
            customer = stripe_service.create_or_get_customer(email, name, user_id)

            # 2. Create Ephemeral Key
            ephemeral_key = stripe_service.create_ephemeral_key(customer.id)

            # 3. Create PaymentIntent
            metadata = {
                "serviceId": service_id,
                "userId": user_id,
                "resumeId": resume_id or "",
                "serviceTitle": stripe_service.get_service_title(service_id)
            }
            
            payment_intent = stripe_service.create_payment_intent(price, customer.id, metadata)

            return {
                "success": True,
                "data": {
                    "clientSecret": payment_intent.client_secret,
                    "paymentIntentId": payment_intent.id,
                    "ephemeralKey": ephemeral_key.secret,
                    "customer": customer.id,
                    "publishableKey": Config.STRIPE_PUBLISHABLE_KEY,
                    "amount": float(price),
                    "currency": "AED",
                    "status": payment_intent.status
                }
            }, 200

        except Exception as e:
            logger.error(f"Error creating PaymentIntent: {str(e)}")
            return {'success': False, 'error': str(e)}, 500

@payments_ns.route('/webhook')
class StripeWebhook(Resource):
    def post(self):
        """Handle Stripe Webhooks"""
        payload = request.data
        sig_header = request.headers.get('Stripe-Signature')

        if not sig_header:
            return {'error': 'No signature header'}, 400

        try:
            event = stripe.Webhook.construct_event(
                payload, sig_header, Config.STRIPE_WEBHOOK_SECRET
            )
        except Exception as e:
            logger.error(f"Webhook signature verification failed: {str(e)}")
            return {'error': 'Invalid signature'}, 400

        # Handle the event
        if event['type'] == 'payment_intent.succeeded':
            payment_intent = event['data']['object']
            self._handle_payment_success(payment_intent)
        elif event['type'] == 'payment_intent.payment_failed':
            payment_intent = event['data']['object']
            logger.info(f"Payment failed: {payment_intent['id']}")
            self._update_payment_status(payment_intent['id'], 'FAILED')

        return {'status': 'success'}, 200

    def _handle_payment_success(self, payment_intent):
        try:
            metadata = payment_intent.metadata.to_dict() if payment_intent.metadata else {}
            service_id = metadata.get('serviceId')
            user_id = metadata.get('userId')

            amount = payment_intent.amount_received / 100.0
            currency = str(payment_intent.currency).upper()
            transaction_id = payment_intent.id

            logger.info(f'Processing successful payment -- Service: {service_id}, User: {user_id}, Amount: {amount} {currency}')

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

    def _update_payment_status(self, transaction_id, status):
        execute_query(
            'UPDATE "Payment" SET status = %s, "updatedAt" = %s WHERE "transactionId" = %s',
            (status, datetime.now(), transaction_id),
            commit=True
        )


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

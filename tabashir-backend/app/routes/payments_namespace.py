from flask import request
from flask_restx import Namespace, Resource
import stripe
import logging
import uuid
from flask import render_template
from app.config import Config
from app.services.stripe_service import StripeService
from app.database.db import execute_query
from app.services.send_linkedin_email import send_email
from datetime import datetime, timedelta

logger = logging.getLogger(__name__)

payments_ns = Namespace('payments', description='Stripe Payment Operations')

stripe_service = StripeService()

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
        metadata = payment_intent.get('metadata', {})
        service_id = metadata.get('serviceId')
        user_id = metadata.get('userId')
        resume_id = metadata.get('resumeId')
        
        amount = payment_intent['amount_received'] / 100.0
        currency = payment_intent['currency'].upper()
        transaction_id = payment_intent['id']

        logger.info(f"Processing successful payment for user {user_id}, service {service_id}")

        try:
            # 1. Create Payment record (Raw SQL)
            # We match the database structure from Prisma
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

            # 2. Service-Specific Logic
            if service_id == 'ai-job-apply':
                # Increment job count
                execute_query(
                    'UPDATE users SET "jobCount" = "jobCount" + 200, "aiJobApplyCount" = "aiJobApplyCount" + 1 WHERE id = %s',
                    (user_id,),
                    commit=True
                )
            elif service_id == 'ai-resume-optimization' and resume_id:
                # Update AI Resume status and record payment
                execute_query(
                    'UPDATE "AiResume" SET "paymentStatus" = true, "paymentAmount" = %s, "paymentDate" = %s, status = %s WHERE id = %s',
                    (amount, datetime.now(), 'COMPLETED', resume_id),
                    commit=True
                )
            elif service_id == 'linkedin-optimization':
                # Create Subscription
                sub_id = f"sub_{transaction_id[-12:]}"
                execute_query(
                    """
                    INSERT INTO "Subscription" (id, "userId", plan, status, "startDate", "endDate", "autoRenew", "createdAt", "updatedAt")
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
                    """,
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
                # Link payment to subscription
                execute_query(
                    'UPDATE "Payment" SET "subscriptionId" = %s WHERE "transactionId" = %s',
                    (sub_id, transaction_id),
                    commit=True
                )
            elif service_id == 'ai-linkedin-enhancement':
                # Fetch user details to send email
                user = execute_query('SELECT email, name FROM users WHERE id = %s', (user_id,), fetch_one=True)
                if user:
                    try:
                        send_email(user['email'], user['name'])
                        logger.info(f"LinkedIn enhancement email sent to {user['email']}")
                    except Exception as email_err:
                        logger.error(f"Failed to send LinkedIn enhancement email: {str(email_err)}")
                else:
                    logger.warning(f"User {user_id} not found for LinkedIn email")
            
            elif service_id == 'interview-training':
                # This could trigger another notification or specific record creation
                logger.info(f"Interview Training purchased for user {user_id}")
                # We can add specific logic here later if needed

        except Exception as e:
            logger.error(f"Error updating database after payment: {str(e)}")
            raise e

    def _update_payment_status(self, transaction_id, status):
        execute_query(
            'UPDATE "Payment" SET status = %s, "updatedAt" = %s WHERE "transactionId" = %s',
            (status, datetime.now(), transaction_id),
            commit=True
        )

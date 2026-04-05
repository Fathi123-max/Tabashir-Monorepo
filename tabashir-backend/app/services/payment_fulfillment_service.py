import logging
import uuid
from datetime import datetime, timedelta
from app.database.db import execute_query
from app.services.stripe_service import StripeService
from app.services.send_linkedin_email import send_email

logger = logging.getLogger(__name__)


class PaymentFulfillmentService:
    """
    Shared fulfillment logic for all payment providers (Stripe, Apple, future Google).
    Replaces the inline logic previously in StripeWebhook._handle_payment_success.
    """

    def fulfill(self, service_id, user_id, amount, receipt_data=None):
        """
        Route to the correct service handler based on product/service ID.

        Args:
            service_id: Product identifier (e.g., 'ai-job-apply-basic')
            user_id: User who made the purchase
            amount: Payment amount in AED
            receipt_data: Optional receipt metadata from the payment provider
        """
        handler = self._get_handler(service_id, user_id, amount)
        if handler:
            try:
                handler()
                logger.info(f'Fulfillment completed for {service_id} -- user {user_id}')
            except Exception as e:
                logger.error(f'Fulfillment failed for {service_id} -- user {user_id}: {str(e)}')
                raise
        else:
            logger.warning(f'No fulfillment handler for service: {service_id}')

    def _get_handler(self, service_id, user_id, amount):
        """Return the handler function for the given service_id."""
        handlers = {
            'ai-job-apply-basic': lambda: self._activate_job_apply(user_id, 100),
            'ai-job-apply-premium': lambda: self._activate_job_apply(user_id, 200),
            'ai-resume-optimization': lambda: self._update_ai_resume(user_id, amount),
            'linkedin-optimization': lambda: self._create_linkedin_subscription(user_id),
            'ai-linkedin-enhancement': lambda: self._send_linkedin_email(user_id),
            'interview-training': lambda: self._log_interview_training(user_id),
        }
        return handlers.get(service_id)

    def _activate_job_apply(self, user_id, jobs_number):
        """Activate job apply for a user with specified number of jobs."""
        from app.routes.resumes_namespace import get_client_cv_filename, Config as ResumesConfig
        from app.routes.resumes_namespace import format_cv_from_path, convert_docx_to_pdf
        import shutil
        import os

        user_data = execute_query(
            'SELECT email FROM users WHERE id = %s',
            (user_id,),
            fetch_one=True
        )
        if not user_data or not user_data.get('email'):
            logger.warning(f'User {user_id} email not found')
            return

        email = user_data['email']
        logger.info(f'Activating job apply for {email} with {jobs_number} jobs')

        filename = get_client_cv_filename(email)

        # Update job count in AI DB
        from app.database.db import get_ai_db_connection
        ai_conn = get_ai_db_connection()
        ai_cursor = ai_conn.cursor()
        ai_cursor.execute(
            'UPDATE clients SET jobs_to_apply_number = jobs_to_apply_number + %s, job_matching = 1 WHERE email = %s',
            (jobs_number, email)
        )
        ai_conn.commit()
        ai_cursor.close()
        ai_conn.close()
        logger.info(f'Updated job count for {email}: +{jobs_number} jobs')

        if not filename:
            logger.warning(f'No CV filename found for {email}, but job credits added')
            return

        cv_dir = ResumesConfig.CV_STORAGE_PATH
        original_cv_path = cv_dir / filename

        if not original_cv_path.exists():
            logger.warning(f'CV file not found at {original_cv_path}, searching for match...')
            matching_files = [
                f for f in os.listdir(cv_dir)
                if filename.replace('.pdf', '') in f and f.endswith('.pdf')
            ]
            if matching_files:
                original_cv_path = cv_dir / matching_files[0]
                logger.info(f'Found matching CV file: {matching_files[0]}')
            else:
                logger.warning(f'No matching CV file found for {email}, but job credits already added')
                return

        if not original_cv_path.exists():
            logger.warning(f'CV file still not found at {original_cv_path}, but job credits already added')
            return

        try:
            formatted_docx = format_cv_from_path(original_cv_path)
            pdf_path = convert_docx_to_pdf(formatted_docx)
            final_filename = pdf_path.name
            final_path = cv_dir / final_filename
            shutil.move(pdf_path, final_path)

            if formatted_docx.exists():
                formatted_docx.unlink()

            execute_query(
                'UPDATE users SET "cvFilename" = %s, "jobCount" = "jobCount" + %s, "aiJobApplyCount" = "aiJobApplyCount" + 1 WHERE email = %s',
                (final_filename, jobs_number, email),
                commit=True
            )
            logger.info(f'Successfully activated job apply for {email} with {jobs_number} jobs')
        except Exception as cv_error:
            logger.error(f'CV formatting failed for {email}: {str(cv_error)}')
            logger.warning(f'Job credits already added, but CV formatting skipped')

    def _update_ai_resume(self, user_id, amount):
        """Mark AI resume as paid for a user. Called without resumeId -- updates latest."""
        execute_query(
            'UPDATE "AiResume" SET "paymentStatus" = true, "paymentAmount" = %s, "paymentDate" = %s, status = %s WHERE "userId" = %s',
            (amount, datetime.now(), 'COMPLETED', user_id),
            commit=True
        )

    def _create_linkedin_subscription(self, user_id):
        """Create a 30-day LinkedIn Optimization subscription for a user."""
        sub_id = f"sub_{uuid.uuid4().hex[:12]}"
        execute_query(
            """INSERT INTO "Subscription" (id, "userId", plan, status, "startDate", "endDate", "autoRenew", "createdAt", "updatedAt")
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)""",
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

    def _send_linkedin_email(self, user_id):
        """Send LinkedIn enhancement onboarding email."""
        user = execute_query(
            'SELECT email, name FROM users WHERE id = %s',
            (user_id,),
            fetch_one=True
        )
        if user:
            try:
                send_email(user['email'], user['name'])
                logger.info(f'LinkedIn enhancement email sent to {user["email"]}')
            except Exception as email_err:
                logger.error(f'Failed to send LinkedIn enhancement email: {str(email_err)}')
        else:
            logger.warning(f'User {user_id} not found for LinkedIn email')

    def _log_interview_training(self, user_id):
        """Log interview training purchase (future expansion point)."""
        logger.info(f'Interview Training purchased for user {user_id}')

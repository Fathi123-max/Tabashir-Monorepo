// Re-export all models for easy importing
// Use this file to import multiple models at once

export '_base/api_error.dart';
// Base models
export '_base/api_response.dart';
// AI Resume models
export 'ai_resume/create_ai_resume_request.dart';
export 'ai_resume/create_ai_resume_response.dart';
export 'applied_jobs_response.dart';
export 'auth/auth_response.dart';
export 'auth/email_verification_request.dart';
export 'auth/email_verification_response.dart';
// Auth models
export 'auth/login_request.dart';
export 'auth/register_request.dart';
export 'candidate/onboarding_response.dart';
// Candidate models
export 'candidate/personal_info_request.dart';
export 'candidate/professional_info_request.dart';
export 'cv_format_response.dart';
export 'cv_parsed_response.dart';
// Job & Resume models
export 'email_model.dart';
export 'job_create_model.dart';
export 'job_details_response.dart';
export 'job_update_model.dart';
export 'jobs_count_response.dart';
export 'jobs_match_response.dart';
export 'payment/checkout_session_request.dart';
export 'payment/checkout_session_response.dart';
export 'payment/latest_payment_response.dart';
// Payment models
export 'payment/payment_intent_request.dart';
export 'payment/payment_intent_response.dart';
export 'raw_cv_input.dart';
export 'send_email_model.dart';
export 'subscription/subscription_debug_response.dart';
// Subscription models
export 'subscription/subscription_response.dart';
// Upload models
export 'upload/upload_request.dart';
export 'upload/upload_response.dart';

// User models
// export 'user/user_profile_response.dart';

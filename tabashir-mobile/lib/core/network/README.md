# Tabashir API Client

This directory contains the API client implementation for the Tabashir backend.

## Overview

The API client provides access to the Tabashir resume processing and job management API. It uses:
- `retrofit_generator` for API client generation
- `dio` for HTTP requests
- `freezed` for immutable data models
- `injectable` for dependency injection

## Structure

```
lib/core/network/
├── models/                 # Data models for API requests and responses
│   ├── auth/              # Authentication models
│   │   ├── login_request.dart
│   │   ├── register_request.dart
│   │   ├── auth_response.dart
│   │   ├── email_verification_request.dart
│   │   └── email_verification_response.dart
│   ├── user/              # User profile models
│   │   └── user_profile_response.dart
│   ├── candidate/         # Candidate onboarding models
│   │   ├── personal_info_request.dart
│   │   ├── professional_info_request.dart
│   │   └── onboarding_response.dart
│   ├── subscription/      # Subscription models
│   │   ├── subscription_response.dart
│   │   └── subscription_debug_response.dart
│   ├── payment/           # Payment models
│   │   ├── payment_intent_request.dart
│   │   ├── payment_intent_response.dart
│   │   ├── checkout_session_request.dart
│   │   ├── checkout_session_response.dart
│   │   └── latest_payment_response.dart
│   ├── upload/            # File upload models
│   │   ├── upload_request.dart
│   │   └── upload_response.dart
│   ├── ai_resume/         # AI resume models
│   │   ├── create_ai_resume_request.dart
│   │   └── create_ai_resume_response.dart
│   ├── email_model.dart
│   ├── raw_cv_input.dart
│   ├── job_create_model.dart
│   ├── job_update_model.dart
│   ├── applied_jobs_response.dart
│   ├── jobs_count_response.dart
│   ├── cv_format_response.dart
│   ├── cv_parsed_response.dart
│   ├── job_details_response.dart
│   ├── jobs_match_response.dart
│   └── send_email_model.dart
├── services/
│   ├── tabashir_api_service.dart  # Resume & job processing API
│   ├── auth_api_service.dart      # Authentication API
│   ├── user_api_service.dart      # User management API
│   ├── subscription_api_service.dart  # Subscription API
│   ├── payment_api_service.dart       # Payment API
│   ├── upload_api_service.dart        # File upload API
│   ├── ai_resume_api_service.dart     # AI resume API
│   └── email_api_service.dart         # Email API
├── api_client.dart         # Main API client wrapper
├── dio_client.dart         # Dio HTTP client configuration
├── auth_dio_client.dart    # Auth Dio client with JWT support
├── swagger_spec.json       # Local copy of API specification
└── examples/
    └── auth_usage_example.dart  # Usage examples
```

## Usage

### 1. Inject the API client

```dart
import 'package:get_it/get_it.dart';
import 'package:tabashir/core/network/api_client.dart';

final apiClient = GetIt.instance<ApiClient>();
```

### 2. Use the API service

#### Authentication

```dart
// Login user
final loginRequest = LoginRequest(
  email: 'user@example.com',
  password: 'password123',
);
final loginResponse = await apiClient.authApiService.login(
  loginRequest,
);

// Register new user
final registerRequest = RegisterRequest(
  name: 'John Doe',
  email: 'user@example.com',
  password: 'password123',
  userType: 'CANDIDATE',
);
final registerResponse = await apiClient.authApiService.register(
  registerRequest,
);
```

#### User Management

```dart
// Get user profile
final profileResponse = await apiClient.userApiService.getUserProfile();

// Update personal info
final personalInfo = PersonalInfoRequest(
  fullName: 'John Doe',
  email: 'john@example.com',
  phone: '+1234567890',
  country: 'USA',
  city: 'New York',
);
await apiClient.userApiService.updatePersonalInfo(personalInfo);

// Update professional info
final professionalInfo = ProfessionalInfoRequest(
  summary: 'Experienced developer...',
  jobType: 'Full-time',
  experience: '5 years',
);
await apiClient.userApiService.updateProfessionalInfo(professionalInfo);
```

#### Subscription Management

```dart
// Get latest subscription
final subscription = await apiClient.subscriptionApiService.getLatestSubscription();

// Debug subscription
final debugData = await apiClient.subscriptionApiService.debugSubscription();
```

#### Payment Processing

```dart
// Create payment intent
final paymentRequest = PaymentIntentRequest(
  amount: 99.99,
  currency: 'AED',
  plan: 'PRO_PLAYER',
);
final paymentResponse = await apiClient.paymentApiService.createPaymentIntent(
  paymentRequest,
);

// Create checkout session
final checkoutRequest = CheckoutSessionRequest(
  plan: 'PRO_PLAYER',
  amount: 99.99,
  successUrl: 'https://yourapp.com/success',
  cancelUrl: 'https://yourapp.com/cancel',
);
final checkoutResponse = await apiClient.paymentApiService.createCheckoutSession(
  checkoutRequest,
);
```

#### File Upload

```dart
// Upload file
final file = await MultipartFile.fromFile(
  '/path/to/resume.pdf',
  filename: 'resume.pdf',
);
final uploadResponse = await apiClient.uploadApiService.uploadFile(
  file: file,
  fileName: 'resume.pdf',
);
```

#### AI Resume

```dart
// Create AI resume
final aiResumeRequest = CreateAiResumeRequest(
  personalDetailsJson: jsonEncode(personalDetails),
  professionalDetailsJson: jsonEncode(professionalDetails),
  employmentHistoryJson: jsonEncode(employmentHistory),
  educationJson: jsonEncode(education),
  skillsJson: jsonEncode(skills),
  languagesJson: jsonEncode(languages),
);
final aiResumeResponse = await apiClient.aiResumeApiService.createAiResume(
  aiResumeRequest,
);
```

#### Resume & Job Processing

```dart
// Get applied jobs for a user
final response = await apiClient.tabashirApiService.getAppliedJobs(
  email: 'user@example.com',
);

// Get count of applied jobs
final emailModel = EmailModel(email: 'user@example.com');
final countResponse = await apiClient.tabashirApiService.getAppliedJobsCount(
  emailModel,
);

// Format a CV
final file = await MultipartFile.fromFile(
  '/path/to/resume.pdf',
  filename: 'resume.pdf',
);
final formatResponse = await apiClient.tabashirApiService.formatCV(
  file: file,
  outputLanguage: 'arabic', // optional
);

// Apply to jobs with resume
final applyResponse = await apiClient.tabashirApiService.applyJobs(
  email: 'user@example.com',
  file: file,
  nationality: 'American',
  gender: 'Male',
  locations: ['New York', 'California'],
  positions: ['Software Engineer', 'Developer'],
);
```

## API Endpoints

The service provides the following endpoints:

### Authentication Endpoints
- `POST /api/v1/auth/login` - Login user with email and password
- `POST /api/v1/auth/register` - Register new user
- `GET /api/v1/auth/verify-email` - Email verification

### User Management Endpoints
- `GET /api/v1/users/me` - Get user profile data
- `POST /api/v1/candidates/onboarding/personal-info` - Update personal info
- `POST /api/v1/candidates/onboarding/professional-info` - Update professional info

### Subscription Endpoints
- `GET /api/v1/subscriptions/latest` - Get latest subscription
- `GET /api/v1/subscriptions/debug` - Debug subscription data
- `GET /api/v1/subscriptions/test` - Test subscription endpoints

### Payment Endpoints
- `POST /api/v1/payments/payment-intent` - Create payment intent
- `POST /api/v1/payments/stripe/create-checkout-session` - Create Stripe checkout session
- `GET /api/v1/payments/latest` - Get latest payment

### File Upload Endpoints
- `POST /api/v1/uploads/uploadthing` - File upload handling

### AI Resume Endpoints
- `POST /api/v1/resumes/ai-resume/create` - Create AI resume

### Resume Processing Endpoints
- `GET /api/v1/resumes/applied-jobs` - Get applied jobs for a user
- `POST /api/v1/resumes/applied-jobs-count` - Get count of applied jobs
- `POST /api/v1/resumes/apply` - Process resume and find matching jobs
- `POST /api/v1/resumes/format` - Convert CV to ATS format
- `POST /api/v1/resumes/format-cv-object` - Parse raw CV text
- `POST /api/v1/resumes/translate` - Translate CV to Arabic
- `POST /api/v1/resumes/send-linkedin-email` - Send LinkedIn email
- `GET /api/v1/resumes/health` - Health check

### Job Endpoints
- `GET /api/v1/resumes/jobs` - Get all jobs
- `GET /api/v1/resumes/jobs/count-by-city` - Get job counts by city
- `GET /api/v1/resumes/jobs/monthly-count` - Get monthly job counts
- `GET /api/v1/resumes/jobs/{job_id}` - Get job details
- `GET /api/v1/resumes/jobs/{job_id}/applicants-count` - Get applicant count
- `POST /api/v1/resumes/jobs` - Create a new job
- `PUT /api/v1/resumes/jobs/{job_id}` - Update a job
- `POST /api/v1/resumes/{job_id}/apply` - Apply to a specific job

## Error Handling

All API errors are handled through the `DioErrorMapper` class in `lib/core/error/dio_error_mapper.dart`. The mapper converts Dio exceptions to user-friendly error messages.

Example error handling:

```dart
try {
  final response = await apiClient.tabashirApiService.getAppliedJobs(
    email: 'user@example.com',
  );
} on DioException catch (error) {
  final errorMessage = DioErrorMapper.mapDioError(error);
  // Show error message to user
  DioErrorMapper.reportError(error); // Log to Crashlytics
}
```

## Code Generation

After modifying API service methods or models, regenerate the code:

```bash
dart run build_runner build --delete-conflicting-outputs
```

To watch for changes during development:

```bash
dart run build_runner watch
```

## Dependencies

The API client uses the following packages:
- `dio` - HTTP client
- `retrofit` - API client generation
- `freezed` - Immutable classes
- `json_serializable` - JSON serialization
- `injectable` - Dependency injection

## API Client Services

The `ApiClient` class provides access to all API services:

```dart
final apiClient = GetIt.instance<ApiClient>();

// Access any API service
apiClient.authApiService;        // Authentication
apiClient.userApiService;         // User management
apiClient.subscriptionApiService; // Subscriptions
apiClient.paymentApiService;      // Payments
apiClient.uploadApiService;       // File uploads
apiClient.aiResumeApiService;     // AI resume
apiClient.emailApiService;        // Email
apiClient.tabashirApiService;     // Resume & jobs
```

## Notes

- The API client is registered as a singleton in the DI container
- All models use `freezed` for immutability and pattern matching
- Generated files (`.g.dart`, `.freezed.dart`) are committed to git
- The API service uses multipart form data for file uploads
- All services connect to the unified Python backend via the base URL configured in `.env`
- Authentication is handled exclusively via JWT Bearer tokens in the `Authorization` header

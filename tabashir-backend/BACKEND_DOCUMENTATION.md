# Tabashir Backend Documentation

## Overview

The Tabashir Backend is a Python Flask-based AI-powered backend service that provides:
- **Resume/CV Processing**: AI-driven CV transformation, formatting, and parsing
- **Job Matching**: Intelligent job-candidate matching with ranking algorithms
- **Payment Processing**: Stripe and Apple In-App Purchase (IAP) integration
- **Authentication**: JWT-based authentication with login/register/refresh
- **Notifications**: OneSignal push notifications and in-app notification system
- **Job Application Automation**: AI-generated cover letters and automated email applications

---

## Architecture

### System Flow

```
┌──────────────────┐
│  Mobile App      │
│  (Flutter)       │
└────────┬─────────┘
         │ HTTP/REST API
         │ JWT Authentication
         ▼
┌─────────────────────────────────────────┐
│  Tabashir Backend (Flask)               │
│  Port: 5050 (unified) or 5001 (mobile)  │
├─────────────────────────────────────────┤
│  Routes (Namespaces)                    │
│  ├── Auth (/api/v1/auth)                │
│  ├── Users (/api/v1/users)              │
│  ├── Resumes (/api/v1/resumes)          │
│  ├── Jobs (/api/v1/jobs)                │
│  ├── Home (/api/v1/home)                │
│  ├── Candidates (/api/v1/candidates)    │
│  ├── Payments (/api/v1/payments)        │
│  └── Notifications (/api/mobile/*)      │
├─────────────────────────────────────────┤
│  Services                               │
│  ├── CV Processor (AI/NLP)              │
│  ├── Stripe Service                     │
│  ├── Apple IAP Service                  │
│  ├── Payment Fulfillment Service        │
│  ├── Notification Service               │
│  ├── Email Service                      │
│  ├── Translation Service                │
│  └── Job Apply (AI Automation)          │
├─────────────────────────────────────────┤
│  Database Layer                         │
│  ├── Main DB (Prisma-managed)           │
│  └── AI DB (Legacy PostgreSQL)          │
└─────────────────────────────────────────┘
         │
         ▼
┌──────────────────┐      ┌──────────────────┐
│  Main PostgreSQL │      │  AI PostgreSQL   │
│  (Neon Cloud)    │      │  (Legacy)        │
└──────────────────┘      └──────────────────┘
```

### Dual Database Architecture

**Main Database** (Prisma-managed, Neon PostgreSQL):
- Managed by `tabashir-frontend` via Prisma ORM
- Contains: `users`, `Job`, `SavedJobPost`, `JobApplication`, `Payment`, `Notification`, `AiResume`, `Subscription`
- Backend accesses via raw SQL (read-only, no migrations)

**AI Database** (Legacy PostgreSQL):
- Managed by backend directly
- Contains: `clients`, `jobs`, `rankings`
- Used for AI job matching and resume processing

---

## Directory Structure

```
tabashir-backend/
├── app/
│   ├── __init__.py                 # Flask app factory (Unified API)
│   ├── config.py                   # Configuration management
│   ├── database/
│   │   ├── __init__.py
│   │   ├── db.py                   # Database connections & query helpers
│   │   └── prisma_db.py            # Prisma client wrapper (if used)
│   ├── models/
│   │   ├── __init__.py
│   │   └── cv_models.py            # CV/Resume data models (Pydantic/dataclasses)
│   ├── routes/
│   │   ├── __init__.py
│   │   ├── auth_namespace.py       # Authentication endpoints
│   │   ├── users_namespace.py      # User management
│   │   ├── resumes_namespace.py    # Resume processing
│   │   ├── jobs_namespace.py       # Job endpoints
│   │   ├── home_namespace.py       # Home screen data
│   │   ├── candidates_namespace.py # Candidate operations
│   │   ├── payments_namespace.py   # Payment processing (Stripe + Apple)
│   │   ├── notifications_namespace.py  # Mobile notifications
│   │   └── middleware.py           # JWT authentication middleware
│   ├── services/
│   │   ├── __init__.py
│   │   ├── cv_processor.py         # AI CV transformation & formatting
│   │   ├── stripe_service.py       # Stripe payment integration
│   │   ├── apple_iap_service.py    # Apple App Store IAP verification
│   │   ├── payment_fulfillment_service.py  # Shared fulfillment logic
│   │   ├── notification_service.py # OneSignal push notifications
│   │   ├── email_service.py        # Email sending utilities
│   │   ├── send_linkedin_email.py  # LinkedIn enhancement emails
│   │   ├── jwt_service.py          # JWT token creation/verification
│   │   ├── password_service.py     # Password hashing/verification
│   │   ├── translation_service.py  # Arabic translation
│   │   ├── arabic_translator.py    # Arabic-specific translation
│   │   ├── profile_sync_service.py # Profile sync between DBs
│   │   ├── text_extractor.py       # PDF/DOCX text extraction
│   │   ├── text_extract_PyMuPDF.py # PyMuPDF-based extraction
│   │   └── job_apply/
│   │       ├── __init__.py
│   │       ├── ai_job_apply.py     # AI-powered job application
│   │       ├── process_cv.py       # CV processing pipeline
│   │       ├── ai_matching.py      # AI job-candidate matching
│   │       └── ranking.py          # Job ranking algorithm
│   ├── utils/
│   │   ├── __init__.py
│   │   ├── job_sync_utils.py       # Sync jobs between DBs
│   │   ├── file_utils.py           # File handling utilities
│   │   └── db_utils.py             # Database utilities
│   └── apify_integration.py        # Apify web scraping integration
├── templates/                      # Word document templates for CV formatting
│   ├── Arabic Docxtpl Compatible CV Template.docx
│   └── Docxtpl Compatible CV Template.docx
├── uploads/                        # Temporary upload directory
├── CVs/                            # Permanent CV storage
├── scripts/                        # Utility scripts
├── tests/                          # Test suite
├── run.py                          # Unified API entry point (Port 5050)
├── run_root.py                     # Mobile API entry point (Port 5001)
├── run_new.py                      # Alternative entry point (if needed)
├── requirements.txt                # Python dependencies
├── requirements-root.txt           # Root-specific dependencies
├── .env.example                    # Environment variables template
├── setup.sh                        # Setup script
├── init_local_db.py                # Local DB initialization
├── run_apify_sync.sh               # Apify sync cron script
└── pytest.ini                      # Pytest configuration
```

---

## Entry Points

### 1. Unified API (`run.py`)
- **Port**: 5050
- **Purpose**: Main API with Swagger docs at `/docs`
- **Namespaces Registered**:
  - `/api/v1/auth` - Authentication
  - `/api/v1/users` - User management
  - `/api/v1/resumes` - Resume processing
  - `/api/v1/jobs` - Job operations
  - `/api/v1/home` - Home screen data
  - `/api/v1/candidates` - Candidate operations
  - `/api/v1/payments` - Payment processing
  - `/api/mobile/notifications` - Mobile notifications

### 2. Mobile API (`run_root.py`)
- **Port**: 5001 (configurable via `FLASK_PORT`)
- **Purpose**: Mobile-specific endpoints with blueprints
- **Blueprints Registered**:
  - `auth_bp` - Authentication
  - `profile_bp` - Profile management
  - `mobile_profile_bp` - Mobile profile
  - `job_bp` - Job operations
  - `home_bp` - Home screen
  - `resume_bp` - Resume processing
  - `home_mobile_bp` - Mobile home
  - `mobile_bp` - Mobile general
  - `candidate_bp` - Candidate operations
  - `ai_job_apply_bp` - AI job application
  - `resume_mobile_bp` - Mobile resume

---

## API Endpoints

### Authentication (`/api/v1/auth`)

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/login` | User login with email/password | No |
| POST | `/register` | User registration | No |
| POST | `/refresh` | Refresh access token | No |
| DELETE | `/account` | Delete user account | Yes (JWT) |
| POST | `/apple-signin` | Sign in with Apple | No |
| POST | `/google-signin` | Sign in with Google | No |

**Request/Response Examples**:

#### Login
```bash
POST /api/v1/auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "securepassword"
}

Response:
{
  "user": {
    "id": "uuid",
    "name": "John Doe",
    "email": "user@example.com",
    "userType": "CANDIDATE"
  },
  "accessToken": "eyJ...",
  "refreshToken": "eyJ..."
}
```

#### Register
```bash
POST /api/v1/auth/register
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "securepassword",
  "name": "John Doe",
  "userType": "CANDIDATE"  // Optional, defaults to CANDIDATE
}
```

### Jobs (`/api/v1/jobs`)

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/recommended` | Get recommended jobs | Yes (JWT) |
| GET | `/saved-jobs` | Get user's saved jobs | Yes (JWT) |
| POST | `/saved-jobs` | Save a job | Yes (JWT) |
| DELETE | `/saved-jobs/<job_id>` | Remove saved job | Yes (JWT) |
| POST | `/sync-jobs` | Sync jobs from device | Yes (JWT) |

### Payments (`/api/v1/payments`)

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/create-intent` | Create Stripe PaymentIntent | No (requires userId) |
| POST | `/webhook` | Stripe webhook handler | No (verified via signature) |
| POST | `/verify-apple-receipt` | Verify Apple IAP receipt | No |

**Supported Products**:

| Product ID | Price (AED) | Description |
|------------|-------------|-------------|
| `ai_job_apply_basic` | 100 | AI Job Apply - Basic (100 jobs) |
| `ai_job_apply_premium` | 200 | AI Job Apply - Premium (200 jobs) |
| `ai_resume_optimization` | 29 | ATS CV Optimization |
| `linkedin_optimization` | 60 | LinkedIn Optimization (30 days) |
| `ai_linkedin_enhancement` | 19 | LinkedIn Profile Enhancement |
| `interview_training` | 150 | Interview Training |

**Create PaymentIntent**:
```bash
POST /api/v1/payments/create-intent
Content-Type: application/json

{
  "serviceId": "ai_job_apply_basic",
  "userId": "user-uuid",
  "resumeId": "resume-uuid"  // Optional
}

Response:
{
  "success": true,
  "data": {
    "clientSecret": "pi_xxx_secret_xxx",
    "paymentIntentId": "pi_xxx",
    "ephemeralKey": "ek_xxx",
    "customer": "cus_xxx",
    "publishableKey": "pk_xxx",
    "amount": 100.0,
    "currency": "AED",
    "status": "requires_payment_method"
  }
}
```

**Verify Apple Receipt**:
```bash
POST /api/v1/payments/verify-apple-receipt
Content-Type: application/json

{
  "transactionId": "1234567890",
  "productId": "ai_job_apply_basic",
  "userId": "user-uuid",
  "resumeId": "resume-uuid"  // Required for ai-resume-optimization
}
```

### Notifications (`/api/mobile/notifications`)

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/` | Fetch notifications (paginated) | Yes (JWT) |
| PATCH | `/` | Mark notification(s) as read | Yes (JWT) |
| GET | `/count` | Get unread count | Yes (JWT) |

**Fetch Notifications**:
```bash
GET /api/mobile/notifications?limit=50&offset=0
Authorization: Bearer <token>

Response:
{
  "notifications": [
    {
      "id": "notif-uuid",
      "title": "New Job Match",
      "message": "You have a new job match!",
      "type": "job_match",
      "createdAt": "2024-01-01T12:00:00",
      "isRead": false,
      "senderId": "sender-uuid",
      "senderName": "Tabashir",
      "data": { "jobId": "job-uuid" }
    }
  ]
}
```

---

## Core Services

### 1. CV Processor (`cv_processor.py`)

**Purpose**: AI-powered CV transformation and formatting using LLMs.

**Key Functions**:

- `get_openai_client()`: Returns configured LLM client (supports InceptionLabs AI, OpenAI, DeepSeek)
- `chat_with_model(messages)`: Sends messages to LLM and returns response
- `safe_parse_ai_response(response_str)`: Parses AI responses (handles JSON/Python literals)
- `cv_transformer(cv_txt)`: Transforms raw CV text using AI (enhances content, adds bullet points)
- `cv_formatter(cv_txt, translate_to_english=False)`: Formats CV into structured `Resume` object

**LLM Configuration**:
```python
# Environment variables
LLM_API_KEY=your_api_key_here
LLM_BASE_URL=https://api.inceptionlabs.ai/v1
LLM_MODEL=mercury-2

# Fallback to OpenAI/DeepSeek
OPENAI_API_KEY=...
DEEPSEEK_API_KEY=...
LLM_PROVIDER=openai  # or deepseek
```

**CV Transformation Pipeline**:
1. **Transform**: Enhance raw CV text (add bullet points, improve wording, extract leadership/projects)
2. **Format**: Parse into structured sections (header, objective, education, work, projects, leadership, skills, languages, keywords)
3. **Translate** (optional): Translate non-English CVs to English

### 2. Stripe Service (`stripe_service.py`)

**Purpose**: Stripe payment integration for mobile app.

**Key Methods**:

- `create_or_get_customer(email, name, user_id)`: Create/retrieve Stripe customer
- `create_ephemeral_key(customer_id)`: Create ephemeral key for mobile PaymentSheet
- `create_payment_intent(amount_aed, customer_id, metadata)`: Create PaymentIntent
- `get_service_price(service_id)`: Get price for product ID
- `get_service_title(service_id)`: Get friendly title for product ID

**Webhook Handling**:
- Verifies webhook signature
- Creates `Payment` record with `COMPLETED` status
- Calls `PaymentFulfillmentService.fulfill()` for service-specific fulfillment
- Handles failures with `PENDING→COMPLETED/FAILED` status flow

### 3. Apple IAP Service (`apple_iap_service.py`)

**Purpose**: Apple App Store Server API authentication and receipt verification.

**Key Methods**:

- `generate_app_store_token()`: Generate ES256 JWT token for App Store API
- `verify_transaction(transaction_id, environment='Sandbox')`: Verify StoreKit 2 transaction

**Apple IAP Configuration**:
```bash
APPLE_KEY_ID=...
APPLE_ISSUER_ID=...
APPLE_TEAM_ID=...
APPLE_BUNDLE_ID=ae.tabashir
APPLE_PRIVATE_KEY_PATH=/path/to/private_key.p8
```

**Receipt Verification Flow**:
1. Generate JWT token for App Store API
2. Call Apple's `/inApps/v1/transactions/{transaction_id}` endpoint
3. Validate product ID matches receipt
4. Create `Payment` record with `PENDING` status
5. Fulfill purchase via `PaymentFulfillmentService`
6. Update status to `COMPLETED` (or `FAILED` on error)

**Retry Logic**: Exponential backoff (1s, 2s, 4s) for 5xx errors, no retry for 4xx (except 429)

### 4. Payment Fulfillment Service (`payment_fulfillment_service.py`)

**Purpose**: Shared fulfillment logic for all payment providers.

**Service Handlers**:

| Service ID | Handler | Description |
|------------|---------|-------------|
| `ai_job_apply_basic` | `_activate_job_apply(user_id, 100)` | Add 100 job credits |
| `ai_job_apply_premium` | `_activate_job_apply(user_id, 200)` | Add 200 job credits |
| `ai_resume_optimization` | `_update_ai_resume(user_id, amount, resume_id)` | Mark resume as paid |
| `linkedin_optimization` | `_create_linkedin_subscription(user_id)` | Create 30-day subscription |
| `ai_linkedin_enhancement` | `_send_linkedin_email(user_id)` | Send onboarding email |
| `interview_training` | `_log_interview_training(user_id)` | Log purchase (future) |

**Job Activation Flow** (`_activate_job_apply`):
1. Fetch user email from `users` table
2. Update `clients.jobs_to_apply_number` in AI DB (+N jobs)
3. Set `clients.job_matching = 1`
4. Format user's CV (find file, transform, convert to PDF)
5. Update `users.cvFilename`, `users.jobCount`, `users.aiJobApplyCount`

### 5. Notification Service (`notification_service.py`)

**Purpose**: Create in-app notifications and send push notifications via OneSignal.

**Key Method**: `create_notification(user_id, title, message, notification_type, data)`

**Flow**:
1. Insert notification into `Notification` table (main DB)
2. Send push notification via OneSignal REST API

**OneSignal Configuration**:
```bash
ONESIGNAL_APP_ID=bf2fbe39-0ab0-41e1-a9cb-1ecefe72474c
ONESIGNAL_API_KEY=...
```

### 6. AI Job Apply (`job_apply/ai_job_apply.py`)

**Purpose**: Automated job application with AI-generated cover letters.

**Key Functions**:

- `generate_cover_letter(client_details, job_description)`: Generate cover letter using LLM
- `send_email(to_email, cc_email, subject, cover_letter, pdf_path)`: Send application email with CV attachment
- `apply(email, file_path)`: Apply to all pending jobs for user
- `apply_single_job(email, file_path, job_id)`: Apply to specific job

**Application Flow**:
1. Fetch pending jobs from `rankings` table (AI DB)
2. Generate cover letter using LLM
3. Send email with CV attachment to job application email
4. Update `rankings.status = 'applied'`
5. Decrement `clients.jobs_to_apply_number`

### 7. JWT Service (`jwt_service.py`)

**Purpose**: JWT token creation and verification.

**Configuration**:
```bash
JWT_SECRET_KEY=...  # Falls back to SECRET_KEY
JWT_ACCESS_EXPIRE=900       # 15 minutes
JWT_REFRESH_EXPIRE=604800   # 7 days
```

**Key Functions**:
- `create_access_token(payload)`: Create short-lived access token
- `create_refresh_token(payload)`: Create long-lived refresh token
- `verify_refresh_token(token)`: Verify and decode refresh token

### 8. Password Service (`password_service.py`)

**Purpose**: Password hashing and verification using bcrypt.

**Key Functions**:
- `hash_password(password)`: Hash password with bcrypt
- `verify_password(password, hashed)`: Verify password against hash

---

## Database Schema

### Main Database Tables (Prisma-managed)

**users**:
- `id` (UUID, PK)
- `email` (String, Unique)
- `password` (String, hashed)
- `name` (String)
- `userType` (String: CANDIDATE, RECRUITER, OWNER)
- `cvFilename` (String)
- `jobCount` (Int)
- `aiJobApplyCount` (Int)
- `createdAt`, `updatedAt` (Timestamp)

**Job**:
- `id` (UUID, PK)
- `title`, `company`, `companyLogo`
- `jobType`, `location`, `salaryMin`, `salaryMax`
- `description`, `requirements`, `benefits`
- `views`, `applicationsCount`
- `status` (String: ACTIVE, CLOSED)
- `isActive` (Boolean)
- `createdAt`, `updatedAt` (Timestamp)

**SavedJobPost**:
- `id` (UUID, PK)
- `jobId` (UUID, FK → Job)
- `userId` (UUID, FK → users)
- `createdAt`, `updatedAt` (Timestamp)

**Payment**:
- `id` (String, PK)
- `amount` (Float)
- `currency` (String)
- `status` (String: PENDING, COMPLETED, FAILED)
- `paymentMethod` (String: stripe, apple)
- `transactionId` (String, Unique)
- `paymentDate` (Timestamp)
- `userId` (UUID, FK → users)
- `createdAt`, `updatedAt` (Timestamp)

**Notification**:
- `id` (UUID, PK)
- `userId` (UUID, FK → users)
- `title`, `message` (String)
- `type` (String: job_match, application_update, etc.)
- `isRead` (Boolean)
- `data` (JSON)
- `senderId`, `senderName` (String, optional)
- `createdAt`, `updatedAt` (Timestamp)

**AiResume**:
- `id` (UUID, PK)
- `userId` (UUID, FK → users)
- `paymentStatus` (Boolean)
- `paymentAmount` (Float)
- `paymentDate` (Timestamp)
- `status` (String: PENDING, COMPLETED, FAILED)
- `createdAt`, `updatedAt` (Timestamp)

**Subscription**:
- `id` (String, PK)
- `userId` (UUID, FK → users)
- `plan` (String: LINKEDIN_OPTIMIZATION)
- `status` (String: ACTIVE, CANCELLED, EXPIRED)
- `startDate`, `endDate` (Timestamp)
- `autoRenew` (Boolean)
- `createdAt`, `updatedAt` (Timestamp)

### AI Database Tables (Legacy)

**clients**:
- `id` (Serial, PK)
- `name`, `email` (String)
- `major`, `location`, `skills`, `keywords`
- `filename` (String: CV filename)
- `jobs_to_apply_number` (Int)
- `job_matching` (Int: 0=disabled, 1=enabled)
- `date_in` (Timestamp)

**jobs**:
- `id` (Serial, PK)
- `job_title`, `job_description`
- `vacancy_city`, `gender`, `nationality`
- `application_email` (String)

**rankings**:
- `id` (Serial, PK)
- `client_id`, `job_id` (FKs)
- `name`, `email`, `major`, `location`, `skills`, `keywords`
- `job_title`, `job_description`, `job_application_email`
- `filename`, `status` (String: pending, applied)
- `date`, `score` (Float)
- `degree`

---

## Environment Variables

Copy `.env.example` to `.env` and fill in the values:

```bash
# Application
SECRET_KEY=your-secret-key-for-flask
DEBUG=True
EMAIL_PASSWORD=your-email-password

# File Upload
UPLOAD_FOLDER=uploads
TEMP_FOLDER=uploads/temp
FORMATTED_FOLDER=uploads/processed/formatted
TRANSLATED_FOLDER=uploads/processed/translated
MAX_CONTENT_LENGTH=16777216  # 16MB
ALLOWED_EXTENSIONS=doc,docx,pdf

# Main Database (Prisma-managed, Neon PostgreSQL)
POSTGRES_HOST=ep-xxx.neon.tech
POSTGRES_PORT=5432
POSTGRES_DB=tabashir
POSTGRES_USER=tabashir_user
POSTGRES_PASSWORD=your-password
POSTGRES_SSLMODE=prefer

# AI Database (Legacy PostgreSQL)
AI_POSTGRES_HOST=localhost
AI_POSTGRES_PORT=5432
AI_POSTGRES_DB=tabashir_ai
AI_POSTGRES_USER=tabashir_ai_user
AI_POSTGRES_PASSWORD=your-password

# LLM Configuration (InceptionLabs AI or OpenAI)
LLM_API_KEY=your-api-key
LLM_BASE_URL=https://api.inceptionlabs.ai/v1
LLM_MODEL=mercury-2

# Legacy LLM Keys (fallback)
OPENAI_API_KEY=sk-xxx
DEEPSEEK_API_KEY=sk-xxx
LLM_PROVIDER=openai  # or deepseek

# Stripe
STRIPE_SECRET_KEY=sk_test_xxx
STRIPE_PUBLISHABLE_KEY=pk_test_xxx
STRIPE_WEBHOOK_SECRET=whsec_xxx

# Apple IAP (App Store Server API)
APPLE_KEY_ID=xxx
APPLE_ISSUER_ID=xxx
APPLE_TEAM_ID=xxx
APPLE_BUNDLE_ID=ae.tabashir
APPLE_PRIVATE_KEY_PATH=/path/to/private_key.p8

# OneSignal
ONESIGNAL_APP_ID=bf2fbe39-0ab0-41e1-a9cb-1ecefe72474c
ONESIGNAL_API_KEY=your-api-key
```

---

## Installation & Setup

### Prerequisites

- **Python**: 3.11+
- **PostgreSQL**: Main DB (Neon) + AI DB (local or remote)
- **SpaCy Model**: `en_core_web_sm`

### Step-by-Step Setup

1. **Navigate to backend directory**:
```bash
cd tabashir-backend
```

2. **Create virtual environment**:
```bash
python -m venv venv
source venv/bin/activate  # macOS/Linux
# or: venv\Scripts\activate  # Windows
```

3. **Install dependencies**:
```bash
pip install -r requirements.txt
python -m spacy download en_core_web_sm
```

4. **Configure environment**:
```bash
cp .env.example .env
# Edit .env with your credentials
```

5. **Initialize local AI database** (if running locally):
```bash
python init_local_db.py
```

6. **Run the server**:

For unified API (Port 5050):
```bash
python run.py
```

For mobile API (Port 5001):
```bash
python run_root.py
```

7. **Access Swagger docs**:
- Unified API: http://localhost:5050/docs
- Mobile API: http://localhost:5001/docs

### Production Deployment

**Using Gunicorn**:
```bash
gunicorn --bind 0.0.0.0:5050 --workers 4 run:app
```

**Using the setup script**:
```bash
sh setup.sh
```

---

## Security Considerations

### Critical Security Fixes Applied

1. **Email Password Removed from Hardcoded Values**:
   - `EMAIL_PASSWORD` moved to environment variable
   - Files affected: `send_linkedin_email.py`, `ai_job_apply.py`

2. **Apple IAP Receipt Verification**:
   - ES256 JWT token authentication for App Store API
   - Exponential backoff retry logic for reliability
   - Product ID validation against receipt

3. **Payment Fulfillment Idempotency**:
   - `ON CONFLICT ("transactionId") DO UPDATE` for race condition safety
   - `PENDING→COMPLETED/FAILED` status flow prevents double-fulfillment

4. **User Validation**:
   - Validate `userId` exists before processing payments
   - JWT middleware protects authenticated endpoints

5. **Account Deletion**:
   - Cascading deletion across all tables
   - Sync deletion to AI DB (`clients`, `rankings`)

### Best Practices

- Never commit `.env` files
- Use strong `SECRET_KEY` (not default dev key)
- Enable `POSTGRES_SSLMODE=prefer` for encrypted DB connections
- Rotate Apple private keys periodically
- Monitor Stripe webhook logs for failed payments

---

## Testing

### Run Tests

```bash
cd tabashir-backend
pytest
```

### Run Specific Test File

```bash
pytest tests/test_payment_fulfillment.py
```

### Test Coverage

```bash
pytest --cov=app
```

### Test Configuration (`pytest.ini`)

```ini
[pytest]
testpaths = tests
python_files = test_*.py
python_functions = test_*
```

---

## Troubleshooting

### Common Issues

**1. Database Connection Fails**:
- Check `.env` database credentials
- Verify SSL mode (`POSTGRES_SSLMODE=prefer`)
- Test connection: `python app/database/db.py`

**2. LLM API Key Missing**:
- Ensure `LLM_API_KEY` or `OPENAI_API_KEY` is set
- Check `LLM_BASE_URL` is correct for your provider

**3. Apple IAP Token Generation Fails**:
- Verify all `APPLE_*` env vars are set
- Check private key file exists at `APPLE_PRIVATE_KEY_PATH`
- Ensure key format is valid ES256

**4. Stripe Webhook Not Triggering**:
- Verify `STRIPE_WEBHOOK_SECRET` matches Stripe dashboard
- Check webhook endpoint is publicly accessible (use ngrok for local testing)
- Monitor logs: `Stripe-Signature` header must be present

**5. CV Transformation Returns Empty**:
- Check SpaCy model installed: `python -m spacy download en_core_web_sm`
- Verify LLM API key has sufficient credits
- Check input CV text is not empty

### Debug Mode

Enable debug logging:
```bash
DEBUG=True
```

This enables:
- Flask debug mode (auto-reload on code changes)
- Detailed error messages in responses
- Verbose database connection logs

---

## Monitoring & Maintenance

### Logs to Monitor

- Payment fulfillment failures (`Fulfillment failed for...`)
- Database connection errors (`Failed to connect to...`)
- LLM API errors (rate limits, invalid responses)
- OneSignal push notification failures
- Stripe webhook signature verification failures

### Scheduled Tasks

**Apify Sync** (job data synchronization):
```bash
sh run_apify_sync.sh
```

Add to cron for automated sync:
```cron
0 */6 * * * cd /path/to/tabashir-backend && sh run_apify_sync.sh
```

### Database Maintenance

**Main Database**: Managed by Prisma migrations from `tabashir-frontend`
- Never run migrations from backend
- Read-only access recommended

**AI Database**: Managed by backend directly
- Monitor `rankings` table for stale `pending` records
- Archive old `clients` records periodically

---

## Integration with Other Apps

### Frontend (Next.js)

- **Database Sharing**: Frontend owns Prisma schema, backend reads via raw SQL
- **API Communication**: Backend can call frontend API routes if needed
- **Deployment**: Backend deploys independently, frontend deploys separately

### Mobile (Flutter)

- **Authentication**: JWT Bearer tokens via `Authorization` header
- **Payment Flow**:
  1. Mobile calls `/api/v1/payments/create-intent` to get PaymentIntent
  2. Mobile processes payment via Stripe SDK
  3. Stripe sends webhook to `/api/v1/payments/webhook`
  4. Backend fulfills purchase
- **Apple IAP Flow**:
  1. Mobile completes purchase via StoreKit 2
  2. Mobile sends transaction ID to `/api/v1/payments/verify-apple-receipt`
  3. Backend verifies with Apple and fulfills purchase
- **Notifications**: OneSignal push notifications via `NotificationService`

---

## Future Enhancements

1. **Google IAP Integration**: Add Google Play Billing support
2. **Subscription Management**: Expand beyond one-time purchases
3. **Interview Training Fulfillment**: Implement `_log_interview_training` handler
4. **Transaction Support**: Wrap account deletion in DB transaction
5. **Improved Error Handling**: Return structured error codes for mobile
6. **Rate Limiting**: Add rate limiting to prevent abuse
7. **API Versioning**: Version endpoints for backward compatibility
8. **GraphQL Support**: Consider GraphQL for flexible mobile queries

---

## Contributors & History

### Major Changes (Chronological)

1. **Initial Setup**: Flask app with basic auth and CV processing
2. **Dual Database Architecture**: Added AI DB for job matching
3. **Stripe Integration**: Mobile payment processing
4. **Apple IAP**: App Store receipt verification
5. **Payment Fulfillment Service**: Shared fulfillment logic
6. **Security Fixes**: Removed hardcoded passwords, added validation
7. **Notification System**: OneSignal integration
8. **AI Job Apply**: Automated cover letter generation and email applications
9. **Idempotency & Race Condition Safety**: `ON CONFLICT` clauses, PENDING status flow

---

## Support & Resources

- **Swagger Docs**: http://localhost:5050/docs
- **Flask Documentation**: https://flask.palletsprojects.com/
- **Stripe Documentation**: https://stripe.com/docs
- **Apple App Store Server API**: https://developer.apple.com/documentation/appstoreserverapi
- **OneSignal Documentation**: https://onesignal.com/docs

---

## License

Internal use only - Tabashir HR Consulting Platform

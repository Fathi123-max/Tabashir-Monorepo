# Tabashir Backend - QWEN Context

## Project Overview

**Tabashir Backend** is a Python Flask API providing AI-powered resume processing, NLP-driven job matching, and dedicated mobile API endpoints. It serves as the AI engine for the Tabashir HR platform.

### Tech Stack

| Category | Technology |
|----------|------------|
| **Framework** | Flask 2.3.x + Flask-RestX 1.1.x |
| **Language** | Python 3.11+ |
| **AI/LLM** | OpenAI GPT-4o, DeepSeek, InceptionLabs (Mercury-2) |
| **NLP** | SpaCy (`en_core_web_sm`), scikit-learn, scipy |
| **Document Processing** | PyMuPDF, PyPDF2, python-docx, docxtpl, docx2pdf |
| **Database** | PostgreSQL (via psycopg2 with RealDictCursor) |
| **Authentication** | JWT (PyJWT, bcrypt) |
| **API Documentation** | Flask-RestX (Swagger UI at `/docs`) |
| **CORS** | Flask-CORS |
| **HTTP Client** | requests, httpx |
| **Data Processing** | pandas, numpy, joblib |
| **Testing** | pytest |
| **WSGI Server** | gunicorn |

### Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    Flask Application                         │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  API Namespaces (Flask-RestX)                         │  │
│  │  ├── auth_ns      - Authentication endpoints          │  │
│  │  ├── profile_ns   - User profile endpoints            │  │
│  │  ├── jobs_ns      - Job management endpoints          │  │
│  │  ├── home_ns      - Dashboard/home endpoints          │  │
│  │  └── resume_ns    - Resume processing endpoints       │  │
│  └───────────────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  Blueprints (Route Handlers)                          │  │
│  │  ├── auth_bp       - Auth route handlers              │  │
│  │  ├── profile_bp    - Profile handlers                 │  │
│  │  ├── mobile_bp     - Mobile-specific handlers         │  │
│  │  ├── job_bp        - Job handlers                     │  │
│  │  ├── resume_bp     - Resume handlers                  │  │
│  │  └── candidate_bp  - Candidate handlers               │  │
│  └───────────────────────────────────────────────────────┘  │
├─────────────────────────────────────────────────────────────┤
│  Services Layer (Business Logic)                            │
│  ├── cv_processor.py     - AI CV transformation            │
│  ├── cv_formatter.py     - CV JSON extraction              │
│  ├── job_apply/          - Job matching logic              │
│  ├── text_extractor.py   - PDF/DOCX parsing                │
│  ├── jwt_service.py      - Token generation/validation     │
│  └── password_service.py - Password hashing/verification   │
├─────────────────────────────────────────────────────────────┤
│  Database Layer (psycopg2)                                  │
│  └── PostgreSQL (shared schema with Next.js/Prisma)        │
└─────────────────────────────────────────────────────────────┘
```

### Server Ports

| Server | File | Port | Purpose |
|--------|------|------|---------|
| **Unified API** | `run.py` | 5050 | All NLP tasks, user management, jobs |
| **Mobile API** | `run_root.py` | 5001 | Dedicated mobile endpoints |

---

## Quick Start

### Prerequisites
- Python 3.11+
- PostgreSQL database
- pip or poetry

### Installation

```bash
cd tabashir-backend

# Create virtual environment
python -m venv venv

# Activate virtual environment
source venv/bin/activate  # macOS/Linux
# or: venv\Scripts\activate  # Windows

# Install dependencies
pip install -r requirements.txt

# Download SpaCy model
python -m spacy download en_core_web_sm

# Setup environment variables
cp .env.example .env
# Edit .env with your API keys and database credentials
```

### Running the Server

```bash
# Run unified API (Port 5050)
python run.py

# Run mobile API (Port 5001)
python run_root.py

# Run with Flask development server
flask run --port 5050

# Run with gunicorn (production)
gunicorn -w 4 -b 0.0.0.0:5050 run:app
```

### Background Tasks

```bash
# Run Apify job synchronization
sh run_apify_sync.sh

# Run Python script directly
python check_tokens.py
```

### Testing

```bash
# Run pytest
pytest

# Run with coverage
pytest --cov=app

# Run specific test file
pytest tests/test_auth.py
```

---

## Project Structure

```
tabashir-backend/
├── app/
│   ├── __init__.py
│   ├── routes/                   # API Routes (Flask-RestX Namespaces + Blueprints)
│   │   ├── __init__.py
│   │   ├── auth_namespace.py     # Auth namespace (Swagger docs)
│   │   ├── auth_routes.py        # Auth blueprint (actual handlers)
│   │   ├── profile_namespace.py
│   │   ├── profile_routes.py
│   │   ├── mobile_profile_routes.py
│   │   ├── jobs_namespace.py
│   │   ├── job_routes.py
│   │   ├── home_namespace.py
│   │   ├── home_routes.py
│   │   ├── resume_routes.py      # Resume namespace + blueprint
│   │   ├── mobile_routes.py      # Mobile-specific routes
│   │   ├── resume_mobile_routes.py
│   │   └── middleware.py         # JWT middleware
│   │
│   ├── services/                 # Business Logic
│   │   ├── __init__.py
│   │   ├── cv_processor.py       # AI CV transformation (GPT-4o)
│   │   ├── cv_formatter.py       # CV JSON extraction
│   │   ├── text_extractor.py     # PDF/DOCX text extraction
│   │   ├── job_apply/
│   │   │   ├── __init__.py
│   │   │   ├── job_matcher.py    # Semantic job matching
│   │   │   └── ranking.py        # Candidate ranking
│   │   ├── jwt_service.py        # JWT token generation/validation
│   │   └── password_service.py   # Password hashing (bcrypt)
│   │
│   ├── models/                   # Data Structures
│   │   ├── __init__.py
│   │   ├── cv_models.py          # Resume/CV models
│   │   ├── user_models.py        # User models
│   │   └── job_models.py         # Job models
│   │
│   └── database/                 # Database Layer
│       ├── __init__.py
│       └── db.py                 # Database connection utilities
│
├── templates/                    # Word templates for resume generation
│   ├── arabic_template.docx
│   └── regular_template.docx
│
├── uploads/                      # Uploaded files (CVs, resumes)
├── CVs/                          # Processed CV files
├── formatted/                    # Formatted resume output
├── translated/                   # Translated resumes
├── temp/                         # Temporary processing files
│
├── migrations/                   # Database migration scripts (if any)
├── tests/                        # Test files
│   ├── __init__.py
│   ├── test_auth.py
│   ├── test_resume.py
│   └── test_jobs.py
│
├── config.py                     # Configuration class
├── run.py                        # Main entry point (Port 5050)
├── run_root.py                   # Mobile API entry point (Port 5001)
├── run_new.py                    # Alternative entry point
├── run.py                        # Original entry point
├── requirements.txt              # Python dependencies
├── requirements-root.txt         # Additional dependencies
├── .env.example                  # Environment template
├── .gitignore
├── pytest.ini                    # Pytest configuration
├── setup.sh                      # Setup script
├── test_config.py                # Test configuration
├── check_tokens.py               # Token validation script
├── init_local_db.py              # Local DB initialization
├── run_apify_sync.sh             # Apify sync script
└── swagger_spec.json             # Swagger specification
```

---

## Configuration

### Environment Variables

```env
# Database (Prisma schema - read-only access)
PRISMA_DB_HOST=localhost
PRISMA_DB_PORT=5432
PRISMA_DB_NAME=tabashir_hr
PRISMA_DB_USER=Apple
PRISMA_DB_PASSWORD=

# AI Job Matching Database (optional, separate)
AI_DB_HOST=localhost
AI_DB_PORT=5432
AI_DB_NAME=ai_job_matching
AI_DB_USER=postgres
AI_DB_PASSWORD=

# JWT Settings (MUST match Next.js for token compatibility)
JWT_SECRET_KEY=b0db5450cbb5cb89b04f02f649a26431f13c10eff61bb17704eb6c838ae8decf9b025b7e7a2d2a19813eab31f0c112d7dc732416fd6180963b8c1969b7d4315e
JWT_ACCESS_EXPIRE=900          # 15 minutes
JWT_REFRESH_EXPIRE=604800      # 7 days

# AI/LLM Configuration
OPENAI_API_KEY=sk-...
DEEPSEEK_API_KEY=...
LLM_PROVIDER=openai            # or 'deepseek' or 'inceptionlabs'
LLM_API_KEY=                   # Optional: override for custom provider
LLM_BASE_URL=                  # Optional: custom API base URL
LLM_MODEL=                     # Optional: custom model name

# Flask Configuration
FLASK_PORT=5001
FLASK_ENV=development
SECRET_KEY=your-secret-key-here

# Apify (Job scraping - optional)
APIFY_API_TOKEN=...
```

### Config Class

```python
# config.py
import os
from pathlib import Path

class Config:
    # Database
    PRISMA_DB_HOST = os.getenv("PRISMA_DB_HOST", "localhost")
    PRISMA_DB_PORT = os.getenv("PRISMA_DB_PORT", "5432")
    PRISMA_DB_NAME = os.getenv("PRISMA_DB_NAME", "tabashir_hr")
    PRISMA_DB_USER = os.getenv("PRISMA_DB_USER", "Apple")
    PRISMA_DB_PASSWORD = os.getenv("PRISMA_DB_PASSWORD", "")

    # JWT
    JWT_SECRET_KEY = os.getenv(
        "JWT_SECRET_KEY",
        "b0db5450cbb5cb89b04f02f649a26431f13c10eff61bb17704eb6c838ae8decf9b025b7e7a2d2a19813eab31f0c112d7dc732416fd6180963b8c1969b7d4315e"
    )
    JWT_ACCESS_EXPIRE = 15 * 60  # 15 minutes
    JWT_REFRESH_EXPIRE = 7 * 24 * 60 * 60  # 7 days

    # Paths
    BASE_DIR = Path(__file__).parent
    TEMP_FOLDER = BASE_DIR / "temp"
    FORMATTED_FOLDER = BASE_DIR / "formatted"
    TRANSLATED_FOLDER = BASE_DIR / "translated"
    ARABIC_TEMPLATE_PATH = BASE_DIR / "templates" / "arabic_template.docx"
    REGULAR_TEMPLATE_PATH = BASE_DIR / "templates" / "regular_template.docx"
```

---

## API Architecture

### Flask-RestX Namespaces (Swagger Documentation)

```python
# app/routes/auth_namespace.py
from flask_restx import Namespace, Resource
from http import HTTPStatus
from app.services.jwt_service import create_access_token, verify_refresh_token
from app.routes.middleware import jwt_required
from flask import request

auth_ns = Namespace('auth', description='Authentication Endpoints')

login_parser = auth_ns.parser()
login_parser.add_argument('email', required=True, help='User email')
login_parser.add_argument('password', required=True, help='User password')

@auth_ns.route('/login')
class Login(Resource):
    @auth_ns.expect(login_parser)
    def post(self):
        """User login endpoint"""
        data = login_parser.parse_args()
        email = data.get('email', '').strip()
        password = data.get('password', '')

        if not email or not password:
            return {"error": "Email and password required"}, HTTPStatus.BAD_REQUEST

        # Query database
        user = execute_query(
            """SELECT id, email, name, password, "userType" 
               FROM users WHERE email = %s""",
            (email,),
            fetch_one=True
        )

        if not user or not user.get('password'):
            return {"error": "Invalid credentials"}, HTTPStatus.UNAUTHORIZED

        # Verify password and create tokens
        access_token = create_access_token({
            "id": user['id'],
            "email": user['email'],
            "userType": user.get('userType', 'CANDIDATE')
        })

        return {
            "user": {
                "id": user['id'],
                "email": user['email'],
                "name": user['name'],
            },
            "accessToken": access_token,
        }, HTTPStatus.OK
```

### Blueprints (Actual Route Handlers)

```python
# app/routes/auth_routes.py
from flask import Blueprint, request, jsonify
from http import HTTPStatus
from app.database.db import execute_query
from app.services.jwt_service import create_access_token
from app.services.password_service import verify_password, hash_password

auth_bp = Blueprint('auth', __name__)

@auth_bp.route('/api/mobile/auth/register', methods=['POST'])
def register():
    """User registration endpoint"""
    data = request.get_json()
    email = data.get('email', '').strip()
    password = data.get('password', '')
    name = data.get('name', '')
    user_type = data.get('userType', 'CANDIDATE')

    # Validate input
    if not email or not password:
        return jsonify({"error": "Email and password required"}), HTTPStatus.BAD_REQUEST

    # Check if user exists
    existing = execute_query(
        "SELECT id FROM users WHERE email = %s",
        (email,),
        fetch_one=True
    )

    if existing:
        return jsonify({"error": "User already exists"}), HTTPStatus.CONFLICT

    # Hash password and insert
    hashed_password = hash_password(password)
    
    user = execute_query(
        """INSERT INTO users (email, password, name, "userType", "createdAt")
           VALUES (%s, %s, %s, %s, NOW())
           RETURNING id, email, name, "userType" """,
        (email, hashed_password, name, user_type),
        fetch_one=True
    )

    access_token = create_access_token({
        "id": user['id'],
        "email": user['email'],
        "userType": user_type
    })

    return jsonify({
        "user": user,
        "accessToken": access_token,
    }), HTTPStatus.CREATED
```

### Database Layer

```python
# app/database/db.py
import psycopg2
from psycopg2.extras import RealDictCursor
import os

def get_connection():
    """Get database connection from environment variables"""
    return psycopg2.connect(
        host=os.getenv("PRISMA_DB_HOST", "localhost"),
        port=os.getenv("PRISMA_DB_PORT", "5432"),
        database=os.getenv("PRISMA_DB_NAME", "tabashir_hr"),
        user=os.getenv("PRISMA_DB_USER", "Apple"),
        password=os.getenv("PRISMA_DB_PASSWORD", ""),
    )

def execute_query(query, params=None, fetch_one=False, fetch_all=False):
    """Execute a database query with parameters"""
    conn = get_connection()
    try:
        with conn.cursor(cursor_factory=RealDictCursor) as cursor:
            cursor.execute(query, params or ())
            
            if fetch_one:
                result = cursor.fetchone()
            elif fetch_all:
                result = cursor.fetchall()
            else:
                result = cursor.rowcount
            
            conn.commit()
            return result
    finally:
        conn.close()
```

---

## AI Resume Processing

### CV Transformer (AI-Powered)

```python
# app/services/cv_processor.py
from openai import OpenAI
from flask import current_app
import ast
import json

def get_openai_client():
    """Get OpenAI-compatible client with provider flexibility"""
    config = current_app.config
    provider = config.get('LLM_PROVIDER', 'openai').lower()

    if provider == 'deepseek':
        return OpenAI(
            api_key=config['DEEPSEEK_API_KEY'],
            base_url="https://api.deepseek.com"
        ), "deepseek-chat"
    else:
        return OpenAI(api_key=config['OPENAI_API_KEY']), "gpt-4o"

def cv_transformer(cv_txt: str) -> str:
    """
    Transform and enhance CV content using AI.
    
    Enhancements:
    - Reformulate content while maintaining integrity
    - Expand bullet points to 3-5 per experience
    - Add relevant skills implicitly mentioned
    - Fix grammar, spelling, formatting
    - Professional tone enhancement
    """
    
    system_prompt = """
    Your job is to rewrite and transform CVs. Reformulate CVs to maintain 
    integrity while making strategic enhancements:
    
    1. Each experience should have 3-5 bullet points
    2. Explicitly state relevant implicit skills
    3. Maintain sections: Career Objective, Education, Work Experience, 
       Leadership Experience, Projects, Skills, Additional Training, Languages
    4. Fix all grammar, spelling, spacing, capitalization errors
    5. Professional formatting (e.g., "ALAIN" → "Al Ain, Abu Dhabi")
    
    Look for leadership keywords: "president", "head", "lead", "captain", 
    "manager", "director", "chief", "coordinator", "supervisor", "organizer", 
    "founder", "chair", "representative".
    
    Look for project keywords: "developed", "created", "built", "designed", 
    "implemented", "launched", "initiated", "established", "organized", 
    "managed".
    """

    conversation = [
        {"role": "system", "content": system_prompt},
        {"role": "assistant", "content": "Please provide the CV you'd like me to transform."},
        {"role": "user", "content": cv_txt},
    ]

    client, model = get_openai_client()
    
    response = client.chat.completions.create(
        model=model,
        messages=conversation
    )

    return response.choices[0].message.content

def cv_formatter(cv_txt: str) -> dict:
    """
    Extract structured JSON from CV text.
    Returns standardized Resume model format.
    """
    # Similar AI-powered extraction logic
    pass

def safe_parse_ai_response(response_str):
    """Safely parse AI response (handles both Python dict and JSON)"""
    try:
        return ast.literal_eval(response_str)
    except Exception:
        try:
            return json.loads(response_str)
        except Exception as e:
            print(f"Failed to parse AI response: {e}")
            return None
```

### Text Extraction

```python
# app/services/text_extractor.py
import PyMuPDF  # fitz
import docx
from docx2pdf import convert

def extract_text_from_pdf(pdf_path):
    """Extract text from PDF using PyMuPDF"""
    doc = fitz.open(pdf_path)
    text = ""
    for page in doc:
        text += page.get_text()
    doc.close()
    return text

def extract_text_from_docx(docx_path):
    """Extract text from DOCX"""
    doc = docx.Document(docx_path)
    return "\n".join([para.text for para in doc.paragraphs if para.text.strip()])

def extract_text(file_path):
    """Extract text based on file extension"""
    if file_path.endswith('.pdf'):
        return extract_text_from_pdf(file_path)
    elif file_path.endswith('.docx'):
        return extract_text_from_docx(file_path)
    else:
        raise ValueError(f"Unsupported file format: {file_path}")
```

### Resume Generation with Templates

```python
# Using docxtpl for Word template rendering
from docxtpl import DocxTemplate

def generate_resume(resume_data: dict, template_path: str, output_path: str):
    """Generate formatted resume from template"""
    tpl = DocxTemplate(template_path)
    
    context = {
        'name': resume_data.get('name', ''),
        'email': resume_data.get('email', ''),
        'phone': resume_data.get('phone', ''),
        'objective': resume_data.get('objective', ''),
        'education': resume_data.get('education', []),
        'work_experience': resume_data.get('work_experience', []),
        'leadership_experience': resume_data.get('leadership_experience', []),
        'projects': resume_data.get('projects', []),
        'skills': resume_data.get('skills', []),
        'languages': resume_data.get('languages', []),
    }
    
    tpl.render(context)
    tpl.save(output_path)
```

---

## JWT Authentication

### Token Service

```python
# app/services/jwt_service.py
import jwt
import datetime
from functools import wraps
from flask import request, jsonify, current_app

def create_access_token(payload, expires_in=None):
    """Create JWT access token"""
    if expires_in is None:
        expires_in = current_app.config.get('JWT_ACCESS_EXPIRE', 900)
    
    payload['exp'] = datetime.datetime.utcnow() + datetime.timedelta(seconds=expires_in)
    payload['type'] = 'access'
    
    return jwt.encode(
        payload,
        current_app.config['JWT_SECRET_KEY'],
        algorithm='HS256'
    )

def create_refresh_token(payload, expires_in=None):
    """Create JWT refresh token"""
    if expires_in is None:
        expires_in = current_app.config.get('JWT_REFRESH_EXPIRE', 604800)
    
    payload['exp'] = datetime.datetime.utcnow() + datetime.timedelta(seconds=expires_in)
    payload['type'] = 'refresh'
    
    return jwt.encode(
        payload,
        current_app.config['JWT_SECRET_KEY'],
        algorithm='HS256'
    )

def verify_token(token):
    """Verify and decode JWT token"""
    try:
        payload = jwt.decode(
            token,
            current_app.config['JWT_SECRET_KEY'],
            algorithms=['HS256']
        )
        return payload
    except jwt.ExpiredSignatureError:
        return None
    except jwt.InvalidTokenError:
        return None

def jwt_required(f):
    """Decorator to protect routes with JWT authentication"""
    @wraps(f)
    def decorated_function(*args, **kwargs):
        auth_header = request.headers.get('Authorization')
        
        if not auth_header or not auth_header.startswith('Bearer '):
            return jsonify({"error": "Missing or invalid authorization header"}), 401
        
        token = auth_header.split(' ')[1]
        payload = verify_token(token)
        
        if not payload:
            return jsonify({"error": "Invalid or expired token"}), 401
        
        # Add user info to request context
        request.current_user = payload
        return f(*args, **kwargs)
    
    return decorated_function
```

### Password Service

```python
# app/services/password_service.py
import bcrypt

def hash_password(password):
    """Hash password using bcrypt"""
    return bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

def verify_password(password, hashed):
    """Verify password against hash"""
    return bcrypt.checkpw(password.encode('utf-8'), hashed.encode('utf-8'))
```

---

## API Endpoints

### Authentication (`/api/mobile/auth`)

```
POST   /api/mobile/auth/login      - User login
POST   /api/mobile/auth/register   - User registration
POST   /api/mobile/auth/refresh    - Refresh access token
POST   /api/mobile/auth/logout     - User logout (invalidate token)
```

### Profile (`/api/user`)

```
GET    /api/user/profile          - Get user profile
PUT    /api/user/profile          - Update user profile
POST   /api/user/change-password  - Change password
GET    /api/user/settings         - Get user settings
PUT    /api/user/settings         - Update user settings
```

### Jobs (`/api`)

```
GET    /api/jobs                  - List all jobs
GET    /api/jobs/:id              - Get job details
POST   /api/jobs                  - Create job (recruiter)
PUT    /api/jobs/:id              - Update job
DELETE /api/jobs/:id              - Delete job
POST   /api/apply                 - Apply to job
GET    /api/applications          - Get user applications
GET    /api/jobs/saved            - Get saved jobs
POST   /api/jobs/save             - Save job
DELETE /api/jobs/unsave/:id       - Unsave job
```

### Resume (`/api/v1/resume`)

```
POST   /api/v1/resume/upload      - Upload CV for processing
POST   /api/v1/resume/transform   - Transform CV with AI
POST   /api/v1/resume/format      - Format CV to JSON
GET    /api/v1/resume/:id         - Get resume by ID
GET    /api/v1/resumes            - Get all user resumes
DELETE /api/v1/resume/:id         - Delete resume
POST   /api/v1/resume/generate    - Generate resume from JSON
```

### Mobile-Specific (`/api/mobile/*`)

```
GET    /api/mobile/home           - Home dashboard data
GET    /api/mobile/candidate      - Candidate profile
POST   /api/mobile/candidate      - Create/update candidate
POST   /api/mobile/ai-job-apply   - AI-powered job application
GET    /api/mobile/notifications  - Get notifications
POST   /api/mobile/resume/parse   - Parse resume (mobile-optimized)
```

---

## Development Conventions

### API Documentation

Always use `flask-restx` namespaces for auto-generated Swagger docs:

```python
# Define namespace
api_ns = Namespace('items', description='Item operations')

# Define model
item_model = api_ns.model('Item', {
    'id': fields.String(required=True),
    'name': fields.String(required=True),
    'description': fields.String(),
})

# Use in route
@api_ns.route('/items')
class Items(Resource):
    @api_ns.marshal_list_with(item_model)
    def get(self):
        """List all items"""
        return get_all_items()
```

### Database Queries

**CRITICAL**: This backend uses raw SQL via `psycopg2`. NEVER attempt schema migrations here—all schema changes belong to `tabashir-frontend/prisma/schema.prisma`.

```python
# ✅ GOOD: Read-only query
user = execute_query(
    "SELECT * FROM users WHERE id = %s",
    (user_id,),
    fetch_one=True
)

# ✅ GOOD: Insert with RETURNING
new_job = execute_query(
    """INSERT INTO jobs (title, company, description, "recruiterId")
       VALUES (%s, %s, %s, %s)
       RETURNING *""",
    (title, company, description, recruiter_id),
    fetch_one=True
)

# ✅ GOOD: Update
execute_query(
    """UPDATE users SET name = %s, email = %s 
       WHERE id = %s""",
    (name, email, user_id)
)
```

### Error Handling

```python
from http import HTTPStatus

@api_ns.route('/items/<id>')
class ItemResource(Resource):
    def get(self, id):
        try:
            item = get_item_by_id(id)
            if not item:
                return {"error": "Item not found"}, HTTPStatus.NOT_FOUND
            return item, HTTPStatus.OK
        except Exception as e:
            current_app.logger.error(f"Error fetching item: {e}")
            return {"error": "Internal server error"}, HTTPStatus.INTERNAL_SERVER_ERROR
```

### Logging

```python
import logging

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

# Usage in routes
current_app.logger.info(f"User {user_id} logged in")
current_app.logger.error(f"Database error: {str(e)}")
```

---

## Testing

### Pytest Setup

```python
# tests/conftest.py
import pytest
from app import create_app

@pytest.fixture
def app():
    app = create_app()
    app.config['TESTING'] = True
    return app

@pytest.fixture
def client(app):
    return app.test_client()
```

### Test Example

```python
# tests/test_auth.py
import pytest
from http import HTTPStatus

def test_login_success(client):
    response = client.post('/api/mobile/auth/login', json={
        'email': 'test@example.com',
        'password': 'password123'
    })
    
    assert response.status_code == HTTPStatus.OK
    data = response.get_json()
    assert 'accessToken' in data
    assert 'user' in data

def test_login_invalid_credentials(client):
    response = client.post('/api/mobile/auth/login', json={
        'email': 'test@example.com',
        'password': 'wrongpassword'
    })
    
    assert response.status_code == HTTPStatus.UNAUTHORIZED
    data = response.get_json()
    assert 'error' in data
```

---

## Common Tasks

### Adding a New Endpoint

1. Create namespace (for Swagger docs):
```python
# app/routes/new_namespace.py
from flask_restx import Namespace, Resource

new_ns = Namespace('new', description='New feature endpoints')

@new_ns.route('/endpoint')
class NewEndpoint(Resource):
    def get(self):
        """Endpoint description"""
        return {"data": "result"}
```

2. Create blueprint (actual handler):
```python
# app/routes/new_routes.py
from flask import Blueprint, request, jsonify

new_bp = Blueprint('new', __name__)

@new_bp.route('/api/new/endpoint', methods=['GET'])
def new_endpoint():
    return jsonify({"data": "result"})
```

3. Register in `create_app()`:
```python
# run.py or run_root.py
from app.routes.new_namespace import new_ns
from app.routes.new_routes import new_bp

api.add_namespace(new_ns, path='/api/new')
app.register_blueprint(new_bp)
```

### Adding AI Processing

```python
# app/services/new_ai_service.py
from openai import OpenAI

def process_with_ai(input_data):
    client = OpenAI(api_key=current_app.config['OPENAI_API_KEY'])
    
    response = client.chat.completions.create(
        model="gpt-4o",
        messages=[
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": input_data},
        ]
    )
    
    return response.choices[0].message.content
```

---

## Troubleshooting

### Database Connection Issues

```python
# Test database connection
from app.database.db import get_connection

try:
    conn = get_connection()
    print("Database connection successful!")
    conn.close()
except Exception as e:
    print(f"Database connection failed: {e}")
```

### AI API Issues

```python
# Test OpenAI connection
from openai import OpenAI

client = OpenAI(api_key="your-api-key")
response = client.chat.completions.create(
    model="gpt-4o",
    messages=[{"role": "user", "content": "Hello"}]
)
print(response.choices[0].message.content)
```

### JWT Token Issues

- Ensure `JWT_SECRET_KEY` matches between Flask and Next.js
- Check token expiration times
- Verify `Authorization` header format: `Bearer <token>`

### Import Errors

```bash
# Reinstall dependencies
pip install -r requirements.txt --force-reinstall

# Ensure virtual environment is activated
source venv/bin/activate
```

---

## Key Files

| File | Purpose |
|------|---------|
| `run.py` | Main entry point (Port 5050) |
| `run_root.py` | Mobile API entry point (Port 5001) |
| `config.py` | Configuration class |
| `app/routes/*` | API routes (namespaces + blueprints) |
| `app/services/cv_processor.py` | AI CV processing |
| `app/services/jwt_service.py` | JWT authentication |
| `app/database/db.py` | Database utilities |
| `templates/` | Word templates for resume generation |
| `requirements.txt` | Python dependencies |

---

## External Integrations

### OpenAI (LLM)

```python
from openai import OpenAI

client = OpenAI(api_key=current_app.config['OPENAI_API_KEY'])

response = client.chat.completions.create(
    model="gpt-4o",
    messages=[
        {"role": "system", "content": "You are a resume expert."},
        {"role": "user", "content": cv_text},
    ],
    temperature=0.7,
    max_tokens=2000,
)

enhanced_cv = response.choices[0].message.content
```

### DeepSeek (Alternative LLM)

```python
from openai import OpenAI

client = OpenAI(
    api_key=current_app.config['DEEPSEEK_API_KEY'],
    base_url="https://api.deepseek.com"
)

response = client.chat.completions.create(
    model="deepseek-chat",
    messages=[...],
)
```

### Apify (Job Scraping)

```bash
# Run job synchronization
sh run_apify_sync.sh
```

---

## Security Considerations

1. **JWT Tokens**: Use strong secret keys, rotate periodically
2. **Password Hashing**: Always use bcrypt for password storage
3. **Input Validation**: Validate all user inputs
4. **SQL Injection**: Use parameterized queries (never string concatenation)
5. **CORS**: Configure allowed origins appropriately
6. **Rate Limiting**: Implement rate limiting for sensitive endpoints
7. **API Keys**: Never commit API keys to version control

---

## Performance Optimization

### Database Query Optimization

```python
# Use indexes for frequently queried columns
# SELECT * FROM users WHERE email = ?  → Index on email

# Use LIMIT for large result sets
execute_query("SELECT * FROM jobs LIMIT %s", (limit,))

# Use connection pooling for high-traffic apps
```

### Caching

```python
from functools import lru_cache

@lru_cache(maxsize=128)
def get_expensive_data(key):
    return execute_query("SELECT * FROM expensive_table WHERE key = %s", (key,))
```

### Async Processing

For long-running AI tasks, consider Celery or RQ for background processing:

```python
from celery import Celery

celery = Celery('tasks', broker='redis://localhost:6379/0')

@celery.task
def process_resume_async(cv_data):
    return cv_transformer(cv_data)
```

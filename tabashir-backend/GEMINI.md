# Tabashir Backend - Project Context & Instructions

The `tabashir-backend` is an AI-powered Python backend application designed to process, format, and enhance ATS-friendly resumes using Natural Language Processing (NLP) and Large Language Models (LLMs). It handles CV transformation, translation, structuring, and AI-driven job matching, as well as serving dedicated mobile API endpoints.

## Project Overview

- **Core Technologies:**
  - **Frameworks:** Flask, Flask-RestX (for Swagger documentation), Flask-CORS.
  - **AI/LLM:** OpenAI API (GPT-4o), DeepSeek API.
  - **NLP & Documents:** PyMuPDF, PyPDF2, SpaCy (`en_core_web_sm`), `docxtpl` (Word template rendering).
  - **Database:** PostgreSQL (Neon) accessed via `psycopg2` (RealDictCursor).
- **Authentication:**
  - User-facing endpoints (e.g. `/api/v1/*`) require a Bearer JWT.

## Architecture

The backend operates a unified entry point, utilizing Flask Blueprints and Namespaces:

1. **Unified API (`run.py` - Port 5050):** Handles all NLP tasks, user management, jobs, and candidate onboarding.

### Key Directories
- `app/routes/`: API endpoint definitions (Flask-RestX Namespaces).
- `app/services/`: Core business logic.
  - `cv_processor.py`: AI-driven CV rewriting (`cv_transformer`) and structured JSON extraction (`cv_formatter`).
  - `job_apply/`: Logic for candidate-job semantic matching and ranking.
  - `text_extractor.py`: PDF/DOCX parsing.
- `app/models/`: Domain data structures (e.g., `Resume` object schema).
- `app/database/`: Database connectivity.
- `templates/`: Microsoft Word `.docx` templates used to generate user-ready resumes.

## AI Resume Workflow

1. **Extraction:** Raw text is pulled from uploaded PDF/DOCX files.
2. **Transformation:** AI refines the text (expanding bullet points, fixing grammar, matching tone).
3. **Structuring:** The refined text is parsed into a strict JSON object mapped to the `Resume` model.
4. **Generation:** The JSON data is injected into `docxtpl` templates to produce a formatted `.docx` file (which can be converted to PDF).

## Building and Running

### Prerequisites
- Python 3.11+
- PostgreSQL database (schema defined by Prisma in `tabashir-frontend`)

### Setup Environment
```bash
cd tabashir-backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python -m spacy download en_core_web_sm
```

*(Note: Provide your API keys and DB credentials in `.env` based on `.env.example`)*

### Run the Servers
```bash
# Run the unified API (Port 5050)
python run.py
```

### Background Tasks
```bash
# Run Apify job synchronization
sh run_apify_sync.sh
```

## Development Conventions

- **API Documentation:** Always use `flask-restx` namespaces to ensure Swagger documentation is automatically generated (`/docs`).
- **Database Modularity:** This service uses raw SQL queries via `psycopg2`. **Do not** attempt to run schema migrations from here; all schema definitions belong to `tabashir-frontend/prisma/schema.prisma`.
- **AI Pipelines:** Any changes to the LLM interaction should be centralized in `app/services/cv_processor.py`.

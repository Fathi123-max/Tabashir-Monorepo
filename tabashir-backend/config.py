import os
from pathlib import Path

class Config:
    # Prisma Database (Tabashir users, jobs)
    PRISMA_DB_HOST = os.getenv("PRISMA_DB_HOST", "localhost")
    PRISMA_DB_PORT = os.getenv("PRISMA_DB_PORT", "5432")
    PRISMA_DB_NAME = os.getenv("PRISMA_DB_NAME", "tabashir_hr")
    PRISMA_DB_USER = os.getenv("PRISMA_DB_USER", "Apple")
    PRISMA_DB_PASSWORD = os.getenv("PRISMA_DB_PASSWORD", "")

    # AI Job Matching Database (existing)
    AI_DB_HOST = os.getenv("AI_DB_HOST", "localhost")
    AI_DB_PORT = os.getenv("AI_DB_PORT", "5432")
    AI_DB_NAME = os.getenv("AI_DB_NAME", "ai_job_matching")
    AI_DB_USER = os.getenv("AI_DB_USER", "postgres")
    AI_DB_PASSWORD = os.getenv("AI_DB_PASSWORD", "")

    # JWT Settings - Use same secret as Next.js for token compatibility
    JWT_SECRET_KEY = os.getenv("JWT_SECRET_KEY", "b0db5450cbb5cb89b04f02f649a26431f13c10eff61bb17704eb6c838ae8decf9b025b7e7a2d2a19813eab31f0c112d7dc732416fd6180963b8c1969b7d4315e")
    JWT_ACCESS_EXPIRE = 15 * 60  # 15 minutes
    JWT_REFRESH_EXPIRE = 7 * 24 * 60 * 60  # 7 days

    # Folder paths for CV processing
    BASE_DIR = Path(__file__).parent
    TEMP_FOLDER = BASE_DIR / "temp"
    FORMATTED_FOLDER = BASE_DIR / "formatted"
    TRANSLATED_FOLDER = BASE_DIR / "translated"
    ARABIC_TEMPLATE_PATH = BASE_DIR / "templates" / "arabic_template.docx"
    REGULAR_TEMPLATE_PATH = BASE_DIR / "templates" / "regular_template.docx"

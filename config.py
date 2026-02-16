import os

class Config:
    # Prisma Database (Tabashir users, jobs)
    PRISMA_DB_HOST = os.getenv("PRISMA_DB_HOST", "localhost")
    PRISMA_DB_PORT = os.getenv("PRISMA_DB_PORT", "5432")
    PRISMA_DB_NAME = os.getenv("PRISMA_DB_NAME", "tabashir")
    PRISMA_DB_USER = os.getenv("PRISMA_DB_USER", "postgres")
    PRISMA_DB_PASSWORD = os.getenv("PRISMA_DB_PASSWORD", "")

    # AI Job Matching Database (existing)
    AI_DB_HOST = os.getenv("AI_DB_HOST", "localhost")
    AI_DB_PORT = os.getenv("AI_DB_PORT", "5432")
    AI_DB_NAME = os.getenv("AI_DB_NAME", "ai_job_matching")
    AI_DB_USER = os.getenv("AI_DB_USER", "postgres")
    AI_DB_PASSWORD = os.getenv("AI_DB_PASSWORD", "")

    # JWT Settings
    JWT_SECRET_KEY = os.getenv("JWT_SECRET_KEY", "your-secret-key")
    JWT_ACCESS_EXPIRE = 15 * 60  # 15 minutes
    JWT_REFRESH_EXPIRE = 7 * 24 * 60 * 60  # 7 days

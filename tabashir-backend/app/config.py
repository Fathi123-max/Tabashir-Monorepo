from pathlib import Path
from dotenv import load_dotenv
import os

load_dotenv()

class Config:
    BASE_DIR = Path(__file__).resolve().parent.parent

    UPLOAD_FOLDER = BASE_DIR / os.getenv('UPLOAD_FOLDER', 'uploads')
    TEMP_FOLDER = BASE_DIR / os.getenv('TEMP_FOLDER', 'uploads/temp')
    FORMATTED_FOLDER = BASE_DIR / os.getenv('FORMATTED_FOLDER', 'uploads/processed/formatted')
    TRANSLATED_FOLDER = BASE_DIR / os.getenv('TRANSLATED_FOLDER', 'uploads/processed/translated')

    MAX_CONTENT_LENGTH = int(os.getenv('MAX_CONTENT_LENGTH', 16 * 1024 * 1024)) # 16MB
    ALLOWED_EXTENSIONS = set(os.getenv('ALLOWED_EXTENSIONS', 'doc,docx,pdf').split(','))

    POSTGRES_HOST = os.getenv("POSTGRES_HOST")
    POSTGRES_PORT = os.getenv("POSTGRES_PORT")
    POSTGRES_DB = os.getenv("POSTGRES_DB")
    POSTGRES_USER = os.getenv("POSTGRES_USER")
    POSTGRES_PASSWORD = os.getenv("POSTGRES_PASSWORD")
    POSTGRES_SSLMODE = os.getenv("POSTGRES_SSLMODE", "prefer")

    AI_POSTGRES_HOST = os.getenv("AI_POSTGRES_HOST")
    AI_POSTGRES_PORT = os.getenv("AI_POSTGRES_PORT")
    AI_POSTGRES_DB = os.getenv("AI_POSTGRES_DB")
    AI_POSTGRES_USER = os.getenv("AI_POSTGRES_USER")
    AI_POSTGRES_PASSWORD = os.getenv("AI_POSTGRES_PASSWORD")


    SECRET_KEY = os.getenv('SECRET_KEY', 'default-dev-key')
    JWT_SECRET_KEY = os.getenv('JWT_SECRET_KEY', os.getenv('SECRET_KEY', 'default-dev-key'))
    JWT_ACCESS_EXPIRE = int(os.getenv('JWT_ACCESS_EXPIRE', 900))       # 15 min
    JWT_REFRESH_EXPIRE = int(os.getenv('JWT_REFRESH_EXPIRE', 604800))  # 7 days
    DEBUG = os.getenv('DEBUG', 'False').lower() in ['true', '1', 'yes']
    OPENAI_API_KEY = os.getenv('OPENAI_API_KEY')
    DEEPSEEK_API_KEY = os.getenv('DEEPSEEK_API_KEY')
    LLM_PROVIDER = os.getenv('LLM_PROVIDER')

    # Email settings
    EMAIL_HOST = 'mail.tabashir.ae'
    EMAIL_PORT = 465
    EMAIL_USERNAME = 'support@tabashir.ae'
    EMAIL_PASSWORD = 'm=%.]]d@tcrZ'

    # Templates path
    ARABIC_TEMPLATE_PATH = BASE_DIR / os.getenv('TEMPLATE_FOLDER', 'templates') / "Arabic Docxtpl Compatible CV Template.docx"
    REGULAR_TEMPLATE_PATH = BASE_DIR / os.getenv('TEMPLATE_FOLDER', 'templates') / "Docxtpl Compatible CV Template.docx"
    
    BASE_DIR = Path(
        os.getenv(
            "D:\R2oya\Backups\AI_Job_Matching_Last_Version",
            Path(__file__).resolve().parent.parent
        )
    )  # adjust if needed
    CV_STORAGE_PATH = BASE_DIR / "CVs"
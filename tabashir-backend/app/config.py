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

    AI_POSTGRES_HOST = os.getenv("AI_POSTGRES_HOST", "localhost")
    AI_POSTGRES_PORT = os.getenv("AI_POSTGRES_PORT", "5432")
    AI_POSTGRES_DB = os.getenv("AI_POSTGRES_DB", "tabashir_ai")
    AI_POSTGRES_USER = os.getenv("AI_POSTGRES_USER", "Apple")
    AI_POSTGRES_PASSWORD = os.getenv("AI_POSTGRES_PASSWORD", "")


    SECRET_KEY = os.getenv('SECRET_KEY', 'default-dev-key')
    JWT_SECRET_KEY = os.getenv('JWT_SECRET_KEY', os.getenv('JWT_ACCESS_SECRET', os.getenv('SECRET_KEY', 'default-dev-key')))
    JWT_REFRESH_SECRET = os.getenv('JWT_REFRESH_SECRET', JWT_SECRET_KEY)
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
    
    # OneSignal settings
    ONESIGNAL_APP_ID = os.getenv('ONESIGNAL_APP_ID', 'bf2fbe39-0ab0-41e1-a9cb-1ecefe72474c')
    ONESIGNAL_API_KEY = os.getenv('ONESIGNAL_API_KEY')
    
    # Path for storing uploaded resumes permanently
    CV_STORAGE_PATH = BASE_DIR / "CVs"

    # Stripe settings
    STRIPE_SECRET_KEY = os.getenv('STRIPE_SECRET_KEY')
    STRIPE_PUBLISHABLE_KEY = os.getenv('STRIPE_PUBLISHABLE_KEY')
    STRIPE_WEBHOOK_SECRET = os.getenv('STRIPE_WEBHOOK_SECRET')

    # Apple IAP (App Store Server API)
    APPLE_KEY_ID = os.getenv('APPLE_KEY_ID')
    APPLE_ISSUER_ID = os.getenv('APPLE_ISSUER_ID')
    APPLE_TEAM_ID = os.getenv('APPLE_TEAM_ID')
    APPLE_BUNDLE_ID = os.getenv('APPLE_BUNDLE_ID')
    APPLE_PRIVATE_KEY_PATH = os.getenv('APPLE_PRIVATE_KEY_PATH')
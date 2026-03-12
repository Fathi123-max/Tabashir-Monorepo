from flask import Flask, request, jsonify, make_response
from flask_restx import Api
from flask_cors import CORS
from app.config import Config
from app.routes.resume_routes import resume_ns
from app.routes.auth_namespace import auth_ns
from app.routes.profile_namespace import profile_ns
from app.routes.jobs_namespace import jobs_ns
from app.routes.home_namespace import home_ns
from app.routes.mobile_namespace import mobile_ns
from app.routes.resume_mobile_namespace import resume_mobile_ns
from app.database.db import get_db_connection


def create_app(config_class=Config):
    app = Flask(__name__)
    app.config.from_object(config_class)

    CORS(
        app,
        resources={r"/api/*": {"origins": "*"}},
        supports_credentials=False,
        allow_headers=["Content-Type", "Authorization", "X-API-TOKEN"],
        methods=["GET", "POST", "PUT", "DELETE", "OPTIONS"]
    )

    authorizations = {
        'apiKey': {
            'type': 'apiKey',
            'in': 'header',
            'name': 'X-API-TOKEN',
            'description': 'Custom API Token header'
        },
        'Bearer': {
            'type': 'apiKey',
            'in': 'header',
            'name': 'Authorization',
            'description': 'JWT Bearer token (format: Bearer <token>)'
        }
    }

    api = Api(
        app,
        version='1.0',
        title='Tabashir - Resume Processing API',
        description='This is the AI powered backend for Tabashir that processes, formats, and enhances ATS-friendly resumes using natural language processing. It also supports resume translation, file management, and provides job-related information.',
        authorizations=authorizations,
        security='apiKey'
    )

    api.add_namespace(resume_ns, path='/api/v1/resume')
    api.add_namespace(auth_ns, path='/api/v1/auth')
    api.add_namespace(profile_ns, path='/api/v1/user')
    api.add_namespace(jobs_ns, path='/api/v1/jobs')
    api.add_namespace(home_ns, path='/api/v1/home')
    api.add_namespace(mobile_ns, path='/api/v1/mobile')
    api.add_namespace(resume_mobile_ns, path='/api/v1/mobile/resumes')

    return app

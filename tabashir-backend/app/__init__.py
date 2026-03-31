from flask import Flask, request, jsonify, make_response
from flask_restx import Api
from flask_cors import CORS
from app.config import Config
from app.routes.resumes_namespace import resumes_ns
from app.routes.auth_namespace import auth_ns
from app.routes.users_namespace import users_ns
from app.routes.jobs_namespace import jobs_ns
from app.routes.home_namespace import home_ns
from app.routes.candidates_namespace import candidates_ns
from app.routes.payments_namespace import payments_ns
from app.database.db import get_db_connection


def create_app(config_class=Config):
    app = Flask(__name__)
    app.config.from_object(config_class)

    CORS(
        app,
        resources={r"/api/*": {"origins": "*"}},
        supports_credentials=False,
        allow_headers=["Content-Type", "Authorization"],
        methods=["GET", "POST", "PUT", "DELETE", "OPTIONS"]
    )

    authorizations = {
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
        title='Tabashir - Unified API',
        description='The unified backend for Tabashir that processes resumes using natural language processing, handles user authentication, jobs matching, and candidate onboarding.',
        authorizations=authorizations
    )

    api.add_namespace(auth_ns, path='/api/v1/auth')
    api.add_namespace(users_ns, path='/api/v1/users')
    api.add_namespace(resumes_ns, path='/api/v1/resumes')
    api.add_namespace(jobs_ns, path='/api/v1/jobs')
    api.add_namespace(home_ns, path='/api/v1/home')
    api.add_namespace(candidates_ns, path='/api/v1/candidates')
    api.add_namespace(payments_ns, path='/api/v1/payments')

    return app

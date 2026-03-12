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

    @app.before_request
    def validate_api_token():
        # Allow OPTIONS requests without auth (for CORS preflight)
        if request.method == 'OPTIONS':
            return '', 200

        if not request.path.startswith('/api/'):
            return

        # Skip API token check for JWT-protected routes
        jwt_prefixes = ('/api/v1/auth', '/api/v1/user', '/api/v1/jobs', '/api/v1/home', '/api/v1/mobile')
        if any(request.path.startswith(p) for p in jwt_prefixes):
            return  # JWT middleware handles auth via @jwt_required decorator

        # Existing X-API-TOKEN validation for /api/v1/resume
        token = request.headers.get('X-API-TOKEN')
        if not token:
            return make_response(jsonify({
                'success': False,
                'message': 'Unauthorized: Missing API token'
            }), 401)

        try:
            conn = get_db_connection()
            cursor = conn.cursor()
            cursor.execute("SELECT token FROM api_tokens WHERE active = TRUE")
            rows = cursor.fetchall()
            valid_tokens = [row['token'] for row in rows]

            cursor.close()
            conn.close()
        except Exception as e:
            return make_response(jsonify({
                'success': False,
                'message': 'Token validation DB error',
                'error': str(e)
            }), 500)

        if token not in valid_tokens:
            return make_response(jsonify({
                'success': False,
                'message': 'Unauthorized: Invalid API token'
            }), 401)

    return app

import os
from functools import wraps
from flask import request
from http import HTTPStatus
from app.services.jwt_service import verify_access_token


def jwt_required(f):
    """Decorator to require valid JWT token or X-API-TOKEN"""
    @wraps(f)
    def decorated(*args, **kwargs):
        # 1. Check for X-API-TOKEN first (internal/trusted services)
        api_token = request.headers.get('X-API-TOKEN')
        if api_token and api_token == os.getenv('API_TOKEN'):
            # Set default admin/system user info
            request.user_id = 'system'
            request.user_email = 'system@tabashir.ae'
            request.user_type = 'ADMIN'
            return f(*args, **kwargs)

        # 2. Check for Bearer token
        auth_header = request.headers.get('Authorization', '')

        if not auth_header:
            return {"error": "Authorization header required"}, HTTPStatus.UNAUTHORIZED

        if not auth_header.startswith('Bearer '):
            return {"error": "Authorization header must be Bearer token"}, HTTPStatus.UNAUTHORIZED

        token = auth_header.replace('Bearer ', '')

        try:
            payload = verify_access_token(token)
            # Store user info in request
            request.user_id = payload.get('id')
            request.user_email = payload.get('email')
            request.user_type = payload.get('userType')
        except Exception as e:
            return {"error": str(e)}, HTTPStatus.UNAUTHORIZED

        return f(*args, **kwargs)
    return decorated

from functools import wraps
from flask import request, jsonify
from http import HTTPStatus
from app.services.jwt_service import verify_access_token


def jwt_required(f):
    """Decorator to require valid JWT token"""
    @wraps(f)
    def decorated(*args, **kwargs):
        auth_header = request.headers.get('Authorization', '')

        if not auth_header:
            return jsonify({"error": "Authorization header required"}), HTTPStatus.UNAUTHORIZED

        if not auth_header.startswith('Bearer '):
            return jsonify({"error": "Authorization header must be Bearer token"}), HTTPStatus.UNAUTHORIZED

        token = auth_header.replace('Bearer ', '')

        try:
            payload = verify_access_token(token)
            # Store user info in request
            request.user_id = payload.get('id')
            request.user_email = payload.get('email')
            request.user_type = payload.get('userType')
        except Exception as e:
            return jsonify({"error": str(e)}), HTTPStatus.UNAUTHORIZED

        return f(*args, **kwargs)
    return decorated

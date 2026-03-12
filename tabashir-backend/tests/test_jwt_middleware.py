import pytest
import json
import sys
sys.path.insert(0, '/Users/Apple/Documents/tabashir')

from app import create_app
from app.services.jwt_service import create_access_token
from app.routes.middleware import jwt_required
from flask import Blueprint, request, jsonify

# Create test route
test_bp = Blueprint('test', __name__)


@test_bp.route('/protected', methods=['GET'])
@jwt_required
def protected_route():
    return jsonify({
        "user_id": request.user_id,
        "user_email": request.user_email
    })


# Register in app
app = create_app()
app.register_blueprint(test_bp)


def test_protected_route_with_valid_token():
    """Test that a valid JWT token allows access to protected route"""
    client = app.test_client()
    token = create_access_token({"id": "user123", "email": "test@example.com", "userType": "CANDIDATE"})

    response = client.get('/protected', headers={'Authorization': f'Bearer {token}'})
    assert response.status_code == 200
    data = response.get_json()
    assert data['user_id'] == 'user123'
    assert data['user_email'] == 'test@example.com'


def test_protected_route_without_token():
    """Test that missing token returns 401"""
    client = app.test_client()
    response = client.get('/protected')
    assert response.status_code == 401
    data = response.get_json()
    assert "error" in data


def test_protected_route_with_invalid_token():
    """Test that invalid token returns 401"""
    client = app.test_client()
    response = client.get('/protected', headers={'Authorization': 'Bearer invalid'})
    assert response.status_code == 401
    data = response.get_json()
    assert "error" in data


def test_protected_route_with_wrong_prefix():
    """Test that non-Bearer token returns 401"""
    client = app.test_client()
    token = create_access_token({"id": "user123", "email": "test@example.com", "userType": "CANDIDATE"})
    response = client.get('/protected', headers={'Authorization': f'Basic {token}'})
    assert response.status_code == 401


def test_protected_route_with_expired_token():
    """Test that expired token returns 401"""
    import time
    client = app.test_client()

    # Create a token that's already expired
    from app.services.jwt_service import create_access_token
    import jwt
    from datetime import datetime, timedelta
    from app.config import Config

    # Create expired token manually
    expired_payload = {
        "id": "user123",
        "email": "test@example.com",
        "userType": "CANDIDATE",
        "type": "access",
        "exp": datetime.utcnow() - timedelta(seconds=60),  # Expired 60 seconds ago
        "iat": datetime.utcnow() - timedelta(seconds=120)
    }
    expired_token = jwt.encode(expired_payload, Config.JWT_SECRET_KEY, algorithm="HS256")

    response = client.get('/protected', headers={'Authorization': f'Bearer {expired_token}'})
    assert response.status_code == 401
    data = response.get_json()
    assert "error" in data

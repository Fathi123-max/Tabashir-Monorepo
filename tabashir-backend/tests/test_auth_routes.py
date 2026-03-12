import pytest
import json
import sys
sys.path.insert(0, '/Users/Apple/Documents/tabashir')

from app import create_app

@pytest.fixture
def client():
    app = create_app()
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client


def test_login_missing_fields(client):
    """Test that login returns 400 when email or password is missing"""
    response = client.post('/api/auth/login',
        data=json.dumps({"email": "test@example.com"}),
        content_type='application/json'
    )

    assert response.status_code == 400


def test_login_empty_body(client):
    """Test that login returns 400 when request body is empty"""
    response = client.post('/api/auth/login',
        data=json.dumps({}),
        content_type='application/json'
    )

    assert response.status_code == 400


@pytest.mark.database
def test_login_success(client):
    """Test successful login - requires database"""
    # First create a test user in DB
    from app.database.prisma_db import execute_prisma_query
    from app.services.password_service import hash_password

    # Create test user
    execute_prisma_query(
        """INSERT INTO users (id, email, password, name, "userType", "createdAt", "updatedAt")
           VALUES (%s, %s, %s, %s, %s, NOW(), NOW())
           ON CONFLICT (email) DO NOTHING""",
        ("test-user-123", "test@example.com", hash_password("password123"), "Test User", "CANDIDATE"),
        commit=True
    )

    response = client.post('/api/auth/login',
        data=json.dumps({"email": "test@example.com", "password": "password123"}),
        content_type='application/json'
    )

    assert response.status_code == 200
    data = response.get_json()
    assert 'accessToken' in data
    assert 'refreshToken' in data


@pytest.mark.database
def test_login_invalid_credentials(client):
    """Test login with invalid credentials - requires database"""
    response = client.post('/api/auth/login',
        data=json.dumps({"email": "wrong@example.com", "password": "wrong"}),
        content_type='application/json'
    )

    assert response.status_code == 401

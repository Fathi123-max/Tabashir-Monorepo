import pytest
import json
import sys
sys.path.insert(0, '/Users/Apple/Documents/tabashir')

from unittest.mock import patch, MagicMock
from app import create_app
from app.services.jwt_service import create_access_token


@pytest.fixture
def client():
    app = create_app()
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client


@pytest.fixture
def auth_headers():
    """Create valid auth headers with JWT token"""
    token = create_access_token({
        "id": "test-user-123",
        "email": "test@example.com",
        "userType": "CANDIDATE"
    })
    return {"Authorization": f"Bearer {token}"}


def test_get_profile_without_auth(client):
    """Test that GET profile returns 401 without authorization"""
    response = client.get('/api/profile')

    assert response.status_code == 401


def test_get_profile_with_invalid_token(client):
    """Test that GET profile returns 401 with invalid token"""
    response = client.get('/api/profile', headers={"Authorization": "Bearer invalid-token"})

    assert response.status_code == 401


@patch('app.routes.profile_routes.execute_prisma_query')
def test_get_profile_success(mock_query, client, auth_headers):
    """Test GET profile returns user data"""
    # Mock database response
    mock_query.return_value = {
        'id': 'test-user-123',
        'email': 'test@example.com',
        'name': 'Test User',
        'userType': 'CANDIDATE',
        'phone': None,
        'nationality': None,
        'gender': None,
        'languages': None,
        'age': None,
        'profilePicture': None,
        'jobType': None,
        'skills': None,
        'experience': None,
        'education': None,
        'degree': None,
        'location': None,
        'linkedin': None,
        'onboardingCompleted': False
    }

    response = client.get('/api/profile', headers=auth_headers)

    assert response.status_code == 200
    data = response.get_json()
    assert 'user' in data
    assert 'profile' in data


@patch('app.routes.profile_routes.execute_prisma_query')
def test_get_profile_returns_user_info(mock_query, client, auth_headers):
    """Test GET profile returns correct user info"""
    mock_query.return_value = {
        'id': 'test-user-123',
        'email': 'test@example.com',
        'name': 'Test User',
        'userType': 'CANDIDATE',
        'phone': None,
        'nationality': None,
        'gender': None,
        'languages': None,
        'age': None,
        'profilePicture': None,
        'jobType': None,
        'skills': None,
        'experience': None,
        'education': None,
        'degree': None,
        'location': None,
        'linkedin': None,
        'onboardingCompleted': False
    }

    response = client.get('/api/profile', headers=auth_headers)

    assert response.status_code == 200
    data = response.get_json()
    assert data['user']['id'] == "test-user-123"
    assert data['user']['email'] == "test@example.com"


def test_put_profile_without_auth(client):
    """Test that PUT profile returns 401 without authorization"""
    response = client.put('/api/profile',
        data=json.dumps({"name": "Test User"}),
        content_type='application/json'
    )

    assert response.status_code == 401


def test_put_profile_with_invalid_token(client):
    """Test that PUT profile returns 401 with invalid token"""
    response = client.put('/api/profile',
        data=json.dumps({"name": "Test User"}),
        content_type='application/json',
        headers={"Authorization": "Bearer invalid-token"}
    )

    assert response.status_code == 401


def test_put_profile_empty_body(client, auth_headers):
    """Test that PUT profile returns 400 with empty body"""
    response = client.put('/api/profile',
        data=json.dumps({}),
        content_type='application/json',
        headers=auth_headers
    )

    assert response.status_code == 400


@patch('app.routes.profile_routes.execute_prisma_query')
def test_put_profile_success(mock_query, client, auth_headers):
    """Test PUT profile returns success"""
    mock_query.return_value = {'id': 'candidate-123'}

    response = client.put('/api/profile',
        data=json.dumps({"name": "Updated Name"}),
        content_type='application/json',
        headers=auth_headers
    )

    assert response.status_code == 200
    data = response.get_json()
    assert data['success'] is True
    assert 'Profile updated successfully' in data['message']


@patch('app.routes.profile_routes.execute_prisma_query')
def test_put_profile_with_profile_fields(mock_query, client, auth_headers):
    """Test PUT profile with profile fields"""
    # Use return_value to return the same value for all calls
    mock_query.return_value = None

    response = client.put('/api/profile',
        data=json.dumps({
            "name": "Test User",
            "phone": "+1234567890",
            "location": "New York",
            "skills": ["Python", "JavaScript"]
        }),
        content_type='application/json',
        headers=auth_headers
    )

    assert response.status_code == 200
    data = response.get_json()
    assert data['success'] is True


@patch('app.routes.profile_routes.execute_prisma_query')
def test_get_profile_user_not_found(mock_query, client, auth_headers):
    """Test GET profile returns 404 when user not found"""
    mock_query.return_value = None

    response = client.get('/api/profile', headers=auth_headers)

    assert response.status_code == 404
    data = response.get_json()
    assert 'error' in data


@patch('app.routes.profile_routes.execute_prisma_query')
def test_put_profile_update_existing(mock_query, client, auth_headers):
    """Test PUT profile updates existing profile"""
    mock_query.side_effect = [
        {'id': 'candidate-123'},  # Get candidate
        {'id': 'profile-123'},    # Check existing profile (UPDATE)
        None,  # UPDATE query
    ]

    response = client.put('/api/profile',
        data=json.dumps({
            "location": "Updated Location"
        }),
        content_type='application/json',
        headers=auth_headers
    )

    assert response.status_code == 200
    data = response.get_json()
    assert data['success'] is True

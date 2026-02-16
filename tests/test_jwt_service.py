import pytest
import time
import sys
sys.path.insert(0, '/Users/Apple/Documents/tabashir')

from app.services.jwt_service import (
    create_access_token,
    create_refresh_token,
    verify_access_token,
    verify_refresh_token,
    decode_token
)

def test_create_and_verify_access_token():
    payload = {"id": "user123", "email": "test@example.com", "userType": "CANDIDATE"}
    token = create_access_token(payload)
    assert token is not None
    assert isinstance(token, str)

    decoded = verify_access_token(token)
    assert decoded["id"] == "user123"
    assert decoded["email"] == "test@example.com"

def test_create_and_verify_refresh_token():
    payload = {"id": "user123"}
    token = create_refresh_token(payload)
    decoded = verify_refresh_token(token)
    assert decoded["id"] == "user123"

def test_invalid_token_raises():
    with pytest.raises(Exception):
        verify_access_token("invalid.token.here")

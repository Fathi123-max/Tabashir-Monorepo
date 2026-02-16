import pytest
import sys
sys.path.insert(0, '/Users/Apple/Documents/tabashir')

from app.services.password_service import hash_password, verify_password

def test_hash_password_returns_string():
    password = "testpassword123"
    hashed = hash_password(password)
    assert isinstance(hashed, str)
    assert hashed != password

def test_verify_correct_password():
    password = "testpassword123"
    hashed = hash_password(password)
    assert verify_password(password, hashed) is True

def test_verify_incorrect_password():
    password = "testpassword123"
    wrong = "wrongpassword"
    hashed = hash_password(password)
    assert verify_password(wrong, hashed) is False

def test_different_hashes_for_same_password():
    password = "testpassword123"
    hash1 = hash_password(password)
    hash2 = hash_password(password)
    # bcrypt generates different salts
    assert hash1 != hash2
    assert verify_password(password, hash1)
    assert verify_password(password, hash2)

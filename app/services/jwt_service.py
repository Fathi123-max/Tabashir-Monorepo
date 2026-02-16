import jwt
from datetime import datetime, timedelta
from typing import Dict, Any
from app.config import Config

ALGORITHM = "HS256"

def create_access_token(payload: Dict[str, Any]) -> str:
    """Create JWT access token with 15 minute expiry"""
    to_encode = payload.copy()
    expire = datetime.utcnow() + timedelta(seconds=Config.JWT_ACCESS_EXPIRE)
    to_encode.update({
        "type": "access",
        "exp": expire,
        "iat": datetime.utcnow()
    })
    return jwt.encode(to_encode, Config.JWT_SECRET_KEY, algorithm=ALGORITHM)

def create_refresh_token(payload: Dict[str, Any]) -> str:
    """Create JWT refresh token with 7 day expiry"""
    to_encode = {"id": payload.get("id")}.copy()
    expire = datetime.utcnow() + timedelta(seconds=Config.JWT_REFRESH_EXPIRE)
    to_encode.update({
        "type": "refresh",
        "exp": expire,
        "iat": datetime.utcnow()
    })
    return jwt.encode(to_encode, Config.JWT_SECRET_KEY, algorithm=ALGORITHM)

def verify_access_token(token: str) -> Dict[str, Any]:
    """Verify and decode access token"""
    try:
        payload = jwt.decode(token, Config.JWT_SECRET_KEY, algorithms=[ALGORITHM])
        if payload.get("type") != "access":
            raise jwt.InvalidTokenError("Invalid token type")
        return payload
    except jwt.ExpiredSignatureError:
        raise Exception("Token has expired")
    except jwt.InvalidTokenError as e:
        raise Exception(f"Invalid token: {str(e)}")

def verify_refresh_token(token: str) -> Dict[str, Any]:
    """Verify and decode refresh token"""
    try:
        payload = jwt.decode(token, Config.JWT_SECRET_KEY, algorithms=[ALGORITHM])
        if payload.get("type") != "refresh":
            raise jwt.InvalidTokenError("Invalid token type")
        return payload
    except jwt.ExpiredSignatureError:
        raise Exception("Token has expired")
    except jwt.InvalidTokenError as e:
        raise Exception(f"Invalid token: {str(e)}")

def decode_token(token: str) -> Dict[str, Any]:
    """Decode token without verification (for debugging)"""
    return jwt.decode(token, options={"verify_signature": False})

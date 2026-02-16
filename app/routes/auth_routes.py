from flask import Blueprint, request, jsonify
from http import HTTPStatus
from app.database.prisma_db import execute_prisma_query
from app.services.jwt_service import create_access_token, create_refresh_token
from app.services.password_service import verify_password, hash_password

auth_bp = Blueprint('auth', __name__, url_prefix='/api/auth')

@auth_bp.route('/login', methods=['POST'])
def login():
    """User login endpoint"""
    data = request.get_json()

    if not data:
        return jsonify({"error": "Request body required"}), HTTPStatus.BAD_REQUEST

    email = data.get('email', '').strip()
    password = data.get('password', '')

    if not email or not password:
        return jsonify({"error": "Email and password required"}), HTTPStatus.BAD_REQUEST

    # Query user from prisma database
    user = execute_prisma_query(
        """SELECT id, email, name, password, "userType" FROM users WHERE email = %s""",
        (email,),
        fetch_one=True
    )

    if not user or not user.get('password'):
        return jsonify({"error": "Invalid credentials"}), HTTPStatus.UNAUTHORIZED

    if not verify_password(password, user['password']):
        return jsonify({"error": "Invalid credentials"}), HTTPStatus.UNAUTHORIZED

    # Create tokens
    payload = {
        "id": user['id'],
        "email": user['email'],
        "userType": user.get('userType', 'CANDIDATE') or 'CANDIDATE'
    }

    access_token = create_access_token(payload)
    refresh_token = create_refresh_token({"id": user['id']})

    return jsonify({
        "user": {
            "id": user['id'],
            "name": user['name'],
            "email": user['email'],
            "userType": user.get('userType', 'CANDIDATE')
        },
        "accessToken": access_token,
        "refreshToken": refresh_token
    }), HTTPStatus.OK


@auth_bp.route('/register', methods=['POST'])
def register():
    """User registration endpoint"""
    data = request.get_json()

    if not data:
        return jsonify({"error": "Request body required"}), HTTPStatus.BAD_REQUEST

    email = data.get('email', '').strip().lower()
    password = data.get('password', '')
    name = data.get('name', '').strip()
    user_type = data.get('userType', 'CANDIDATE').upper()

    if not email or not password:
        return jsonify({"error": "Email and password required"}), HTTPStatus.BAD_REQUEST

    if len(password) < 6:
        return jsonify({"error": "Password must be at least 6 characters"}), HTTPStatus.BAD_REQUEST

    # Check if user exists
    existing = execute_prisma_query(
        "SELECT id FROM users WHERE email = %s",
        (email,),
        fetch_one=True
    )

    if existing:
        return jsonify({"error": "Email already registered"}), HTTPStatus.CONFLICT

    # Create user
    import uuid
    user_id = str(uuid.uuid4())
    hashed_password = hash_password(password)

    # Validate user type
    if user_type not in ['CANDIDATE', 'RECRUITER', 'ADMIN']:
        user_type = 'CANDIDATE'

    execute_prisma_query(
        """INSERT INTO users (id, email, name, password, "userType", "createdAt", "updatedAt")
           VALUES (%s, %s, %s, %s, %s, NOW(), NOW())""",
        (user_id, email, name, hashed_password, user_type),
        commit=True
    )

    # Create tokens
    payload = {
        "id": user_id,
        "email": email,
        "userType": user_type
    }

    access_token = create_access_token(payload)
    refresh_token = create_refresh_token({"id": user_id})

    return jsonify({
        "user": {
            "id": user_id,
            "name": name,
            "email": email,
            "userType": user_type
        },
        "accessToken": access_token,
        "refreshToken": refresh_token
    }), HTTPStatus.CREATED


@auth_bp.route('/refresh', methods=['POST'])
def refresh():
    """Refresh access token"""
    data = request.get_json()

    if not data or not data.get('refreshToken'):
        return jsonify({"error": "Refresh token required"}), HTTPStatus.BAD_REQUEST

    try:
        from app.services.jwt_service import verify_refresh_token
        payload = verify_refresh_token(data['refreshToken'])

        # Get user info
        user = execute_prisma_query(
            """SELECT id, email, name, "userType" FROM users WHERE id = %s""",
            (payload['id'],),
            fetch_one=True
        )

        if not user:
            return jsonify({"error": "User not found"}), HTTPStatus.NOT_FOUND

        # Create new access token
        token_payload = {
            "id": user['id'],
            "email": user['email'],
            "userType": user.get('userType', 'CANDIDATE') or 'CANDIDATE'
        }

        access_token = create_access_token(token_payload)

        return jsonify({
            "accessToken": access_token
        }), HTTPStatus.OK

    except Exception as e:
        return jsonify({"error": "Invalid refresh token"}), HTTPStatus.UNAUTHORIZED

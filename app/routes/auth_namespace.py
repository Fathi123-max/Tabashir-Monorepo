from flask_restx import Namespace, Resource, reqparse
from flask import request, jsonify
from http import HTTPStatus
from app.database.prisma_db import execute_prisma_query
from app.services.jwt_service import create_access_token, create_refresh_token
from app.services.password_service import verify_password, hash_password

auth_ns = Namespace('auth', description='Authentication Endpoints')

login_parser = auth_ns.parser()
login_parser.add_argument('email', required=True, help='User email')
login_parser.add_argument('password', required=True, help='User password')

register_parser = auth_ns.parser()
register_parser.add_argument('email', required=True, help='User email')
register_parser.add_argument('password', required=True, help='User password')
register_parser.add_argument('name', required=True, help='User name')
register_parser.add_argument('userType', required=False, help='User type')


@auth_ns.route('/login')
class Login(Resource):
    @auth_ns.expect(login_parser)
    def post(self):
        """User login endpoint"""
        data = login_parser.parse_args()
        email = data.get('email', '').strip()
        password = data.get('password', '')

        if not email or not password:
            return {"error": "Email and password required"}, HTTPStatus.BAD_REQUEST

        user = execute_prisma_query(
            """SELECT id, email, name, password, "userType" FROM users WHERE email = %s""",
            (email,),
            fetch_one=True
        )

        if not user or not user.get('password'):
            return {"error": "Invalid credentials"}, HTTPStatus.UNAUTHORIZED

        if not verify_password(password, user['password']):
            return {"error": "Invalid credentials"}, HTTPStatus.UNAUTHORIZED

        payload = {
            "id": user['id'],
            "email": user['email'],
            "userType": user.get('userType', 'CANDIDATE') or 'CANDIDATE'
        }

        access_token = create_access_token(payload)
        refresh_token = create_refresh_token({"id": user['id']})

        return {
            "user": {
                "id": user['id'],
                "name": user['name'],
                "email": user['email'],
                "userType": user.get('userType', 'CANDIDATE')
            },
            "accessToken": access_token,
            "refreshToken": refresh_token
        }, HTTPStatus.OK


@auth_ns.route('/register')
class Register(Resource):
    @auth_ns.expect(register_parser)
    def post(self):
        """User registration endpoint"""
        data = register_parser.parse_args()
        email = data.get('email', '').strip()
        password = data.get('password', '')
        name = data.get('name', '')
        user_type = data.get('userType', 'CANDIDATE')

        if not email or not password or not name:
            return {"error": "Email, password, and name are required"}, HTTPStatus.BAD_REQUEST

        existing = execute_prisma_query(
            """SELECT id FROM users WHERE email = %s""",
            (email,),
            fetch_one=True
        )

        if existing:
            return {"error": "User already exists"}, HTTPStatus.CONFLICT

        import uuid
        user_id = str(uuid.uuid4())
        hashed = hash_password(password)

        try:
            execute_prisma_query(
                """INSERT INTO users (id, email, password, name, "userType", "createdAt", "updatedAt")
                   VALUES (%s, %s, %s, %s, %s, NOW(), NOW())""",
                (user_id, email, hashed, name, user_type),
                commit=True
            )
        except Exception as e:
            return {"error": str(e)}, HTTPStatus.INTERNAL_SERVER_ERROR

        payload = {"id": user_id, "email": email, "userType": user_type}
        access_token = create_access_token(payload)
        refresh_token = create_refresh_token({"id": user_id})

        return {
            "user": {"id": user_id, "name": name, "email": email, "userType": user_type},
            "accessToken": access_token,
            "refreshToken": refresh_token
        }, HTTPStatus.CREATED


refresh_parser = auth_ns.parser()
refresh_parser.add_argument('refreshToken', required=True, help='Refresh token')


@auth_ns.route('/refresh')
class Refresh(Resource):
    @auth_ns.expect(refresh_parser)
    def post(self):
        """Refresh access token"""
        data = refresh_parser.parse_args()
        refresh_token = data.get('refreshToken')

        if not refresh_token:
            return {"error": "Refresh token required"}, HTTPStatus.BAD_REQUEST

        from app.services.jwt_service import verify_refresh_token
        payload = verify_refresh_token(refresh_token)

        if not payload:
            return {"error": "Invalid refresh token"}, HTTPStatus.UNAUTHORIZED

        user = execute_prisma_query(
            """SELECT id, email, name, "userType" FROM users WHERE id = %s""",
            (payload.get('id'),),
            fetch_one=True
        )

        if not user:
            return {"error": "User not found"}, HTTPStatus.NOT_FOUND

        new_payload = {
            "id": user['id'],
            "email": user['email'],
            "userType": user.get('userType', 'CANDIDATE') or 'CANDIDATE'
        }
        access_token = create_access_token(new_payload)

        return {"accessToken": access_token}, HTTPStatus.OK

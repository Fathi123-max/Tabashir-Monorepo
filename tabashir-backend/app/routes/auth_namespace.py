import uuid
from flask_restx import Namespace, Resource
from http import HTTPStatus
from app.database.db import execute_query
from app.services.jwt_service import create_access_token, create_refresh_token, verify_refresh_token
from app.services.password_service import verify_password, hash_password
from app.routes.middleware import jwt_required
from flask import request

auth_ns = Namespace('auth', description='Authentication Endpoints')

login_parser = auth_ns.parser()
login_parser.add_argument('email', required=True, help='User email')
login_parser.add_argument('password', required=True, help='User password')

register_parser = auth_ns.parser()
register_parser.add_argument('email', required=True, help='User email')
register_parser.add_argument('password', required=True, help='User password')
register_parser.add_argument('name', required=True, help='User name')
register_parser.add_argument('userType', required=False, help='User type')

refresh_parser = auth_ns.parser()
refresh_parser.add_argument('refreshToken', required=True, help='Refresh token')


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

        user = execute_query(
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

        existing = execute_query(
            """SELECT id FROM users WHERE email = %s""",
            (email,),
            fetch_one=True
        )

        if existing:
            return {"error": "User already exists"}, HTTPStatus.CONFLICT

        user_id = str(uuid.uuid4())
        hashed = hash_password(password)

        try:
            execute_query(
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


@auth_ns.route('/refresh')
class Refresh(Resource):
    @auth_ns.expect(refresh_parser)
    def post(self):
        """Refresh access token"""
        data = refresh_parser.parse_args()
        refresh_token = data.get('refreshToken')

        if not refresh_token:
            return {"error": "Refresh token required"}, HTTPStatus.BAD_REQUEST

        try:
            payload = verify_refresh_token(refresh_token)
        except Exception as e:
            return {"error": str(e)}, HTTPStatus.UNAUTHORIZED

        if not payload:
            return {"error": "Invalid refresh token"}, HTTPStatus.UNAUTHORIZED

        user = execute_query(
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


@auth_ns.route('/account')
class Account(Resource):
    @jwt_required
    @auth_ns.doc(security='Bearer')
    def delete(self):
        """Delete the authenticated user's account and all associated data"""
        user_id = getattr(request, 'user_id', None)
        
        if not user_id:
            return {"error": "Unauthorized"}, HTTPStatus.UNAUTHORIZED

        try:
            # 1. Get user email to delete from legacy 'clients' table
            user = execute_query(
                "SELECT email FROM users WHERE id = %s",
                (user_id,),
                fetch_one=True
            )
            
            if not user:
                return {"error": "User not found"}, HTTPStatus.NOT_FOUND
                
            email = user['email']

            # Execute deletion across tables.
            # Using execute_query sequentially but it ideally should be a single transaction
            # db.py's execute_query connects and disconnects per call, so we'll do them one by one.
            # A failure midway might leave orphaned data, but we'll try to delete dependents first.

            # 2. Delete Saved Jobs & Job Applications
            execute_query('DELETE FROM "SavedJobPost" WHERE "userId" = %s', (user_id,), commit=True)
            execute_query('DELETE FROM "JobApplication" WHERE "userId" = %s', (user_id,), commit=True)

            # 3. Delete Candidate Profiles (requires finding the Candidate ID first)
            candidate = execute_query('SELECT id FROM "Candidate" WHERE "userId" = %s', (user_id,), fetch_one=True)
            if candidate:
                candidate_id = candidate['id']
                execute_query('DELETE FROM "CandidateProfile" WHERE "candidateId" = %s', (candidate_id,), commit=True)
                execute_query('DELETE FROM "Candidate" WHERE id = %s', (candidate_id,), commit=True)

            # 4. Delete legacy clients and rankings entry based on email
            if email:
                execute_query("DELETE FROM clients WHERE email = %s", (email,), commit=True)
                execute_query("DELETE FROM rankings WHERE email = %s", (email,), commit=True)

            # 5. Finally, delete the user
            execute_query("DELETE FROM users WHERE id = %s", (user_id,), commit=True)

            return {"message": "Account deleted successfully"}, HTTPStatus.OK

        except Exception as e:
            return {"error": f"Failed to delete account: {str(e)}"}, HTTPStatus.INTERNAL_SERVER_ERROR

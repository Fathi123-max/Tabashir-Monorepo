from flask_restx import Namespace, Resource
from flask import request, jsonify
from http import HTTPStatus
from app.database.prisma_db import execute_prisma_query
from app.routes.middleware import jwt_required

profile_ns = Namespace('user', description='User Profile Endpoints')


@profile_ns.route('/profile')
class Profile(Resource):
    @profile_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get user profile"""
        user_id = request.user_id

        user = execute_prisma_query(
            """SELECT u.id, u.email, u.name, u."userType", u."createdAt",
                      cp.phone, cp.nationality, cp.gender, cp.languages, cp.age,
                      cp."profilePicture", cp."jobType", cp.skills, cp.experience,
                      cp.education, cp.degree, cp.location, cp.linkedin,
                      cp."onboardingCompleted"
               FROM users u
               LEFT JOIN "Candidate" c ON c."userId" = u.id
               LEFT JOIN "CandidateProfile" cp ON cp."candidateId" = c.id
               WHERE u.id = %s""",
            (user_id,),
            fetch_one=True
        )

        if not user:
            return {"error": "User not found"}, HTTPStatus.NOT_FOUND

        return {"user": user}, HTTPStatus.OK

    @profile_ns.doc(security='Bearer')
    @jwt_required
    def put(self):
        """Update user profile"""
        user_id = request.user_id
        data = request.get_json()

        if not data:
            return {"error": "Request body required"}, HTTPStatus.BAD_REQUEST

        name = data.get('name')
        if name:
            execute_prisma_query(
                """UPDATE users SET name = %s, "updatedAt" = NOW() WHERE id = %s""",
                (name, user_id),
                commit=True
            )

        return {"message": "Profile updated", "userId": user_id}, HTTPStatus.OK

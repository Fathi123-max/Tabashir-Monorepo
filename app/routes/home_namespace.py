from flask_restx import Namespace, Resource
from flask import request, jsonify
from http import HTTPStatus
from app.database.prisma_db import execute_prisma_query
from app.routes.middleware import jwt_required

home_ns = Namespace('home', description='Home Dashboard Endpoints')


@home_ns.route('/dashboard')
class Dashboard(Resource):
    @home_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get user dashboard data"""
        user_id = request.user_id

        user = execute_prisma_query(
            """SELECT u.name, u."jobCount", u."aiJobApplyCount"
               FROM users u
               WHERE u.id = %s""",
            (user_id,),
            fetch_one=True
        )

        # Get application stats
        applications = execute_prisma_query(
            """SELECT status, COUNT(*) as count FROM "JobApplication" WHERE "userId" = %s GROUP BY status""",
            (user_id,),
            fetch_all=True
        )

        stats = {
            "totalApplications": sum(a['count'] for a in applications) if applications else 0,
            "inReview": next((a['count'] for a in applications if a['status'] == 'IN_REVIEW'), 0),
            "interview": next((a['count'] for a in applications if a['status'] == 'INTERVIEW'), 0),
            "offer": next((a['count'] for a in applications if a['status'] == 'OFFER'), 0),
            "rejected": next((a['count'] for a in applications if a['status'] == 'REJECTED'), 0),
            "savedJobs": 0
        }

        return {
            "user": user,
            "stats": stats,
            "metrics": {
                "profileCompletionPercentage": 75,
                "applicationSuccessRate": 20
            },
            "featuredJobs": []
        }, HTTPStatus.OK


@home_ns.route('/trending')
class Trending(Resource):
    @home_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get trending data"""
        return {"trending": []}, HTTPStatus.OK


@home_ns.route('/recommendations')
class Recommendations(Resource):
    @home_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get job recommendations"""
        return {"recommendations": []}, HTTPStatus.OK


@home_ns.route('/analytics')
class Analytics(Resource):
    @home_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get analytics data"""
        return {"analytics": {}}, HTTPStatus.OK

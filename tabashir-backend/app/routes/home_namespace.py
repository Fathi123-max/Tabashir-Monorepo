from flask_restx import Namespace, Resource
from flask import request
from http import HTTPStatus
from app.database.db import execute_query
from app.routes.middleware import jwt_required

home_ns = Namespace('home', description='Home Dashboard Endpoints')

@home_ns.route('/dashboard')
class Dashboard(Resource):
    @home_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get user dashboard data"""
        user_id = request.user_id

        try:
            user = execute_query(
                'SELECT name, "jobCount", "aiJobApplyCount" FROM users WHERE id = %s',
                (user_id,), fetch_one=True
            )
        except Exception:
            user = None

        try:
            saved = execute_query(
                'SELECT COUNT(*) as count FROM "SavedJobPost" WHERE "userId" = %s',
                (user_id,), fetch_one=True
            )
        except Exception:
            saved = None

        try:
            apps = execute_query(
                'SELECT status, COUNT(*) as count FROM "JobApplication" WHERE "userId" = %s GROUP BY status',
                (user_id,), fetch_all=True
            )
        except Exception:
            apps = None

        def _count(status_list):
            if not apps:
                return 0
            return sum(r['count'] for r in apps if r['status'] in status_list)

        total = sum(r['count'] for r in apps) if apps else 0

        try:
            recent_jobs = execute_query(
                """SELECT id, title, company, "companyLogo", "jobType", location
                   FROM "Job" WHERE status = 'ACTIVE'
                   ORDER BY "createdAt" DESC LIMIT 5""",
                fetch_all=True
            )
        except Exception:
            try:
                recent_jobs = execute_query(
                    """SELECT id, job_title as title, company_name as company, NULL as "companyLogo", job_type as "jobType", vacancy_city as location
                       FROM jobs
                       ORDER BY job_date DESC LIMIT 5""",
                    fetch_all=True
                )
            except Exception:
                recent_jobs = []

        return {
            "user": {
                "name": user.get('name', 'User') if user else 'User',
                "jobCount": user.get('jobCount', 0) if user else 0,
                "aiJobApplyCount": user.get('aiJobApplyCount', 0) if user else 0,
                "jobType": None
            },
            "stats": {
                "savedJobs": saved.get('count', 0) if saved else 0,
                "totalApplications": total,
                "inReview": _count(['pending', 'IN_REVIEW']),
                "interview": _count(['interview', 'INTERVIEW']),
                "offer": _count(['offer', 'OFFER']),
                "rejected": _count(['rejected', 'REJECTED'])
            },
            "recentJobs": recent_jobs or []
        }, HTTPStatus.OK


@home_ns.route('/trending')
class Trending(Resource):
    @home_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get trending data"""
        try:
            jobs = execute_query(
                """SELECT id, title, company, "companyLogo", "jobType",
                          "salaryMin", "salaryMax", location, "views"
                   FROM "Job"
                   WHERE status = 'ACTIVE'
                   ORDER BY "views" DESC, "createdAt" DESC
                   LIMIT 10""",
                fetch_all=True
            )
            return {"trending": jobs or []}, HTTPStatus.OK
        except Exception:
            return {"trending": []}, HTTPStatus.OK


@home_ns.route('/recommendations')
class Recommendations(Resource):
    @home_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get job recommendations"""
        try:
            jobs = execute_query(
                """SELECT id, title, company, "companyLogo", "jobType",
                          "salaryMin", "salaryMax", location, description
                   FROM "Job"
                   WHERE status = 'ACTIVE'
                   ORDER BY "createdAt" DESC LIMIT 15""",
                fetch_all=True
            )
            return {"recommendations": jobs or []}, HTTPStatus.OK
        except Exception:
            return {"recommendations": []}, HTTPStatus.OK


@home_ns.route('/analytics')
class Analytics(Resource):
    @home_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get analytics data"""
        user_id = request.user_id

        try:
            apps = execute_query(
                'SELECT status, COUNT(*) as count FROM "JobApplication" WHERE "userId" = %s GROUP BY status',
                (user_id,), fetch_all=True
            )
        except Exception:
            apps = None

        def _count(status_list):
            if not apps:
                return 0
            return sum(r['count'] for r in apps if r['status'] in status_list)

        return {
            "applicationStatusChart": [
                {"name": "In Review", "value": _count(['pending', 'IN_REVIEW']), "color": "#FFA500"},
                {"name": "Interview", "value": _count(['interview', 'INTERVIEW']), "color": "#0D56E1"},
                {"name": "Offer", "value": _count(['offer', 'OFFER']), "color": "#34D399"},
                {"name": "Rejected", "value": _count(['rejected', 'REJECTED']), "color": "#EF4444"},
            ],
            "matchScoreDistribution": [
                {"range": "90-100%", "count": 3},
                {"range": "80-89%", "count": 8},
                {"range": "70-79%", "count": 11},
            ],
            "monthlyApplications": [
                {"month": "Jan", "count": 2},
                {"month": "Feb", "count": 4},
                {"month": "Mar", "count": 3},
            ],
            "skillsDemand": [
                {"skill": "JavaScript", "demand": 245},
                {"skill": "Python", "demand": 198},
                {"skill": "React", "demand": 176},
                {"skill": "Node.js", "demand": 143},
                {"skill": "AI/ML", "demand": 127},
            ]
        }, HTTPStatus.OK

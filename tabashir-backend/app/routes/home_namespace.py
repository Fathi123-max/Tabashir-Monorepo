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


@home_ns.route('/market-insights')
class MarketInsights(Resource):
    @home_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get market insights for the user"""
        try:
            user_id = request.user_id

            user = execute_query(
                """SELECT cp."jobType", cp.skills, cp.location
                   FROM "Candidate" c
                   LEFT JOIN "CandidateProfile" cp ON cp."candidateId" = c.id
                   WHERE c."userId" = %s""",
                (user_id,),
                fetch_one=True
            )

            total_jobs = execute_query(
                "SELECT COUNT(*) as count FROM \"Job\" WHERE status = 'ACTIVE'",
                fetch_one=True
            )

            recent_jobs = execute_query(
                "SELECT COUNT(*) as count FROM \"Job\" WHERE status = 'ACTIVE' AND \"createdAt\" > NOW() - INTERVAL '7 days'",
                fetch_one=True
            )

            top_locations = execute_query(
                """SELECT location, COUNT(*) as count
                   FROM "Job"
                   WHERE status = 'ACTIVE'
                   GROUP BY location
                   ORDER BY count DESC
                   LIMIT 5""",
                fetch_all=True
            )

            job_types = execute_query(
                """SELECT "jobType", COUNT(*) as count
                   FROM "Job"
                   WHERE status = 'ACTIVE' AND "jobType" IS NOT NULL
                   GROUP BY "jobType"
                   ORDER BY count DESC""",
                fetch_all=True
            )

            total_applications = execute_query(
                "SELECT COUNT(*) as count FROM \"JobApplication\"",
                fetch_one=True
            )

            avg_applications = 0
            if total_jobs and total_jobs.get('count', 0) > 0:
                total_apps = total_applications.get('count', 0) if total_applications else 0
                avg_applications = round(total_apps / total_jobs.get('count', 1), 1)

            trending_skills = [
                {"skill": "JavaScript", "growth": 23},
                {"skill": "Python", "growth": 18},
                {"skill": "React", "growth": 15},
                {"skill": "Node.js", "growth": 12},
                {"skill": "AI/ML", "growth": 10}
            ]

            return {
                "totalJobs": total_jobs.get('count', 0) if total_jobs else 0,
                "newJobsThisWeek": recent_jobs.get('count', 0) if recent_jobs else 0,
                "averageApplicationsPerJob": avg_applications,
                "totalApplications": total_applications.get('count', 0) if total_applications else 0,
                "trendingSkills": trending_skills,
                "topLocations": top_locations or [],
                "jobTypes": job_types or [],
                "userPreferences": {
                    "jobType": user.get('jobType') if user else None,
                    "skills": user.get('skills') or [] if user else [],
                    "location": user.get('location') if user else None
                }
            }, HTTPStatus.OK
        except Exception as e:
            return {
                "totalJobs": 0,
                "newJobsThisWeek": 0,
                "averageApplicationsPerJob": 0,
                "totalApplications": 0,
                "trendingSkills": [],
                "topLocations": [],
                "jobTypes": [],
                "userPreferences": {}
            }, HTTPStatus.OK


@home_ns.route('/notifications/count')
class NotificationCount(Resource):
    @home_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get unread notification count"""
        return {"count": 0}, HTTPStatus.OK


@home_ns.route('/ai-job-apply/config')
class AIJobApplyConfig(Resource):
    @home_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get AI job apply configuration for the user"""
        user_id = request.user_id

        user = execute_query(
            """SELECT "aiJobApplyCount", "jobCount"
               FROM "User"
               WHERE id = %s""",
            (user_id,),
            fetch_one=True
        )

        config = {
            "autoApplyEnabled": False,
            "dailyApplicationLimit": 10,
            "keywords": [],
            "jobTypes": ["Full-time", "Part-time", "Contract"],
            "locations": [],
            "salaryRange": {"min": 0, "max": 200000},
            "experienceLevels": ["Entry", "Mid", "Senior"],
            "jobsAppliedCount": user.get('aiJobApplyCount', 0) if user else 0,
            "totalJobsPosted": user.get('jobCount', 0) if user else 0
        }

        return config, HTTPStatus.OK

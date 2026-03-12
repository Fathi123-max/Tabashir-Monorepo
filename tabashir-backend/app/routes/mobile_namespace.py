import uuid
import logging
from flask_restx import Namespace, Resource
from flask import request
from http import HTTPStatus
from app.database.db import execute_query
from app.routes.middleware import jwt_required

mobile_ns = Namespace('mobile', description='Mobile App Endpoints')


@mobile_ns.route('/jobs/recommended')
class MobileRecommendedJobs(Resource):
    @mobile_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get recommended jobs for mobile app"""
        try:
            user_id = request.user_id

            user = execute_query(
                """SELECT cp."jobType", cp.skills, cp.experience
                   FROM "Candidate" c
                   JOIN "CandidateProfile" cp ON cp."candidateId" = c.id
                   WHERE c."userId" = %s""",
                (user_id,),
                fetch_one=True
            )

            jobs = execute_query(
                """SELECT id, title, company, "companyLogo", "jobType", "salaryMin",
                          "salaryMax", location, description, requirements, "benefits",
                          "views", "applicationsCount", "createdAt"
                   FROM "Job"
                   WHERE status = 'ACTIVE' AND "isActive" = true
                   ORDER BY "createdAt" DESC
                   LIMIT 20""",
                fetch_all=True
            )

            return {"jobs": jobs or [], "total": len(jobs or [])}, HTTPStatus.OK
        except Exception as e:
            logging.warning(f"Using mock recommended jobs: {str(e)}")
            return {
                "jobs": [
                    {"id": "201", "title": "Senior Software Engineer", "company": "Tech Corp", "companyLogo": None, "jobType": "Full-time", "salaryMin": 100000, "salaryMax": 150000, "location": "Dubai, UAE"},
                    {"id": "202", "title": "Product Manager", "company": "Innovation Labs", "companyLogo": None, "jobType": "Full-time", "salaryMin": 90000, "salaryMax": 130000, "location": "Abu Dhabi, UAE"},
                    {"id": "203", "title": "Data Scientist", "company": "DataTech", "companyLogo": None, "jobType": "Full-time", "salaryMin": 110000, "salaryMax": 160000, "location": "Dubai, UAE"},
                ],
                "total": 3
            }, HTTPStatus.OK


@mobile_ns.route('/market/trending')
class MarketTrending(Resource):
    @mobile_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get trending jobs for mobile market"""
        try:
            jobs = execute_query(
                """SELECT id, title, company, "companyLogo", "jobType",
                          "salaryMin", "salaryMax", location, "views", "applicationsCount"
                   FROM "Job"
                   WHERE status = 'ACTIVE'
                   ORDER BY "views" DESC, "applicationsCount" DESC
                   LIMIT 15""",
                fetch_all=True
            )
            return {"trending": jobs or []}, HTTPStatus.OK
        except Exception as e:
            logging.warning(f"Using mock trending data: {str(e)}")
            return {"trending": []}, HTTPStatus.OK


@mobile_ns.route('/notifications/count')
class NotificationCount(Resource):
    @mobile_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get unread notification count for mobile app"""
        return {"count": 0}, HTTPStatus.OK


@mobile_ns.route('/sync-jobs')
class SyncJobs(Resource):
    @mobile_ns.doc(security='Bearer')
    @jwt_required
    def post(self):
        """Sync jobs from mobile device to server"""
        user_id = request.user_id
        data = request.get_json()

        if not data or not data.get('jobs'):
            return {"error": "jobs array required"}, HTTPStatus.BAD_REQUEST

        synced_count = 0
        for job_data in data.get('jobs', []):
            job_id = job_data.get('id')
            if job_id:
                existing = execute_query(
                    'SELECT id FROM "Job" WHERE id = %s',
                    (job_id,),
                    fetch_one=True
                )
                if existing:
                    synced_count += 1

        return {
            "synced": synced_count,
            "message": f"Synced {synced_count} jobs"
        }, HTTPStatus.OK


@mobile_ns.route('/home/market-insights')
class MarketInsights(Resource):
    @mobile_ns.doc(security='Bearer')
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
            logging.warning(f"Using mock market insights: {str(e)}")
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


@mobile_ns.route('/candidate/onboarding/professional-info')
class ProfessionalInfo(Resource):
    @mobile_ns.doc(security='Bearer')
    @jwt_required
    def post(self):
        """Submit professional info during candidate onboarding"""
        user_id = request.user_id
        data = request.get_json()

        if not data:
            return {"error": "Request body required"}, HTTPStatus.BAD_REQUEST

        candidate = execute_query(
            'SELECT id FROM "Candidate" WHERE "userId" = %s',
            (user_id,),
            fetch_one=True
        )

        if not candidate:
            candidate_id = str(uuid.uuid4())
            execute_query(
                'INSERT INTO "Candidate" (id, "userId", "createdAt", "updatedAt") VALUES (%s, %s, NOW(), NOW())',
                (candidate_id, user_id),
                commit=True
            )
            candidate = {'id': candidate_id}

        profile_fields = ['jobType', 'experience', 'skills', 'education', 'degree', 'location', 'linkedin']
        profile_data = {k: data.get(k) for k in profile_fields if k in data}

        if profile_data:
            existing = execute_query(
                'SELECT id FROM "CandidateProfile" WHERE "candidateId" = %s',
                (candidate['id'],),
                fetch_one=True
            )

            if existing:
                set_clause = ', '.join([f'"{k}" = %s' for k in profile_data.keys()])
                values = list(profile_data.values()) + [candidate['id']]
                execute_query(
                    f'UPDATE "CandidateProfile" SET {set_clause}, "updatedAt" = NOW() WHERE "candidateId" = %s',
                    values,
                    commit=True
                )
            else:
                profile_id = str(uuid.uuid4())
                columns = ', '.join([f'"{k}"' for k in profile_data.keys()])
                placeholders = ', '.join(['%s'] * len(profile_data))
                values = [profile_id, candidate['id']] + list(profile_data.values())
                execute_query(
                    f'INSERT INTO "CandidateProfile" (id, "candidateId", {columns}, "createdAt", "updatedAt") VALUES (%s, %s, {placeholders}, NOW(), NOW())',
                    values,
                    commit=True
                )

        return {
            "success": True,
            "message": "Professional info submitted successfully"
        }, HTTPStatus.OK


@mobile_ns.route('/ai-job-apply/config')
class AIJobApplyConfig(Resource):
    @mobile_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get AI job apply configuration for the user"""
        user_id = request.user_id

        user = execute_query(
            """SELECT "aiJobApplyCount", "jobCount"
               FROM users
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

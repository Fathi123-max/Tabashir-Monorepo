import uuid
from flask_restx import Namespace, Resource
from flask import request
from http import HTTPStatus
from app.database.db import execute_query
from app.routes.middleware import jwt_required

jobs_ns = Namespace('jobs', description='Job Endpoints')


@jobs_ns.route('/recommended')
class RecommendedJobs(Resource):
    @jobs_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get recommended jobs based on user profile"""
        try:
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
        except Exception:
            return {"jobs": [], "total": 0}, HTTPStatus.OK


@jobs_ns.route('/saved-jobs')
class SavedJobs(Resource):
    @jobs_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get all saved jobs for the current user"""
        user_id = request.user_id
        try:
            jobs = execute_query(
                """SELECT j.id, j.title, j.company, j."companyLogo", j."jobType",
                          j.location, j."salaryMin", j."salaryMax", s."createdAt" as "savedAt"
                   FROM "SavedJobPost" s
                   JOIN "Job" j ON j.id = s."jobId"
                   WHERE s."userId" = %s
                   ORDER BY s."createdAt" DESC""",
                (user_id,),
                fetch_all=True
            )
            # Ensure datetime serialization
            if jobs:
                for job in jobs:
                    if job.get('savedAt') and hasattr(job['savedAt'], 'isoformat'):
                        job['savedAt'] = job['savedAt'].isoformat()
            return {"savedJobs": jobs or []}, HTTPStatus.OK
        except Exception:
            return {"savedJobs": []}, HTTPStatus.OK

    @jobs_ns.doc(security='Bearer')
    @jwt_required
    def post(self):
        """Save a job"""
        user_id = request.user_id
        data = request.get_json()

        if not data:
            return {"error": "Request body required"}, HTTPStatus.BAD_REQUEST

        job_id = data.get('jobId')
        if not job_id:
            return {"error": "jobId required"}, HTTPStatus.BAD_REQUEST

        try:
            execute_query(
                """INSERT INTO "SavedJobPost" (id, "jobId", "userId", "createdAt", "updatedAt")
                   VALUES (%s, %s, %s, NOW(), NOW())
                   ON CONFLICT DO NOTHING""",
                (str(uuid.uuid4()), job_id, user_id),
                commit=True
            )
            return {"success": True, "message": "Job saved", "jobId": job_id}, HTTPStatus.CREATED
        except Exception as e:
            return {"error": str(e)}, HTTPStatus.INTERNAL_SERVER_ERROR


@jobs_ns.route('/saved-jobs/<string:job_id>')
class SavedJob(Resource):
    @jobs_ns.doc(security='Bearer')
    @jwt_required
    def delete(self, job_id):
        """Remove saved job"""
        user_id = request.user_id

        try:
            execute_query(
                'DELETE FROM "SavedJobPost" WHERE "jobId" = %s AND "userId" = %s',
                (job_id, user_id),
                commit=True
            )
            return {"success": True, "message": "Job removed from saved"}, HTTPStatus.OK
        except Exception as e:
            return {"error": str(e)}, HTTPStatus.INTERNAL_SERVER_ERROR

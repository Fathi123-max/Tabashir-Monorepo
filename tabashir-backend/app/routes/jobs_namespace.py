import uuid
from flask_restx import Namespace, Resource
from flask import request
from http import HTTPStatus
from app.database.db import execute_query
from app.routes.middleware import jwt_required
from app.utils.job_sync_utils import sync_job_from_legacy

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
            # Check/Sync from legacy database if needed to fulfill foreign key constraint
            success, msg = sync_job_from_legacy(job_id)
            if not success and msg != "Invalid Job ID format":
                print(f"[JOB_SYNC] Warning: {msg}")

            execute_query(
                """INSERT INTO "SavedJobPost" (id, "jobId", "userId", "createdAt", "updatedAt")
                   VALUES (%s, %s, %s, NOW(), NOW())
                   ON CONFLICT DO NOTHING""",
                (str(uuid.uuid4()), str(job_id), user_id),
                commit=True
            )
            return {"success": True, "message": "Job saved", "jobId": str(job_id)}, HTTPStatus.CREATED
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


@jobs_ns.route('/sync-jobs')
class SyncJobs(Resource):
    @jobs_ns.doc(security='Bearer')
    @jwt_required
    def post(self):
        """Sync jobs from client device to server"""
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

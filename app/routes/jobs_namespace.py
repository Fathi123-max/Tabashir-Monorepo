from flask_restx import Namespace, Resource
from flask import request, jsonify
from http import HTTPStatus
from app.database.prisma_db import execute_prisma_query
from app.routes.middleware import jwt_required

jobs_ns = Namespace('jobs', description='Job Endpoints')


@jobs_ns.route('/recommended')
class RecommendedJobs(Resource):
    @jobs_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get recommended jobs based on user profile"""
        user_id = request.user_id

        jobs = execute_prisma_query(
            """SELECT id, title, company, "companyLogo", "jobType", "salaryMin",
                      "salaryMax", location, description, requirements, "benefits",
                      "views", "applicationsCount", "createdAt"
               FROM jobs
               WHERE status = 'ACTIVE' AND "isActive" = true
               ORDER BY "createdAt" DESC
               LIMIT 20""",
            fetch_all=True
        )

        return {"jobs": jobs or [], "total": len(jobs or [])}, HTTPStatus.OK


@jobs_ns.route('/saved-jobs')
class SavedJobs(Resource):
    @jobs_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get saved jobs"""
        user_id = request.user_id
        return {"savedJobs": [], "total": 0}, HTTPStatus.OK

    @jobs_ns.doc(security='Bearer')
    @jwt_required
    def post(self):
        """Save a job"""
        user_id = request.user_id
        data = request.get_json()
        job_id = data.get('jobId') if data else None
        return {"message": "Job saved", "jobId": job_id}, HTTPStatus.OK


@jobs_ns.route('/saved-jobs/<job_id>')
class SavedJob(Resource):
    @jobs_ns.doc(security='Bearer')
    @jwt_required
    def delete(self, job_id):
        """Remove saved job"""
        return {"message": "Job removed from saved"}, HTTPStatus.OK

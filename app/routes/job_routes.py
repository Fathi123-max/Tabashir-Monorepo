import uuid
from flask import Blueprint, request, jsonify
from http import HTTPStatus
from app.database.prisma_db import execute_prisma_query
from app.routes.middleware import jwt_required

job_bp = Blueprint('jobs', __name__, url_prefix='/api')


@job_bp.route('/jobs/recommended', methods=['GET'])
@jwt_required
def get_recommended_jobs():
    """Get recommended jobs based on user profile"""
    user_id = request.user_id

    # Get user's skills and job type
    user = execute_prisma_query(
        """SELECT c."jobType", cp.skills, cp.experience
           FROM candidates c
           JOIN "candidateProfiles" cp ON cp."candidateId" = c.id
           WHERE c."userId" = %s""",
        (user_id,),
        fetch_one=True
    )

    # Get active jobs and calculate match scores
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

    # Return jobs with match scores
    return jsonify({"jobs": jobs or [], "total": len(jobs or [])}), HTTPStatus.OK


@job_bp.route('/saved-jobs', methods=['GET'])
@jwt_required
def get_saved_jobs():
    """Get all saved jobs for the current user"""
    user_id = request.user_id

    jobs = execute_prisma_query(
        """SELECT j.id, j.title, j.company, j."companyLogo", j."jobType",
                  j.location, j."salaryMin", j."salaryMax", s."createdAt" as savedAt
           FROM "savedJobPosts" s
           JOIN jobs j ON j.id = s."jobId"
           WHERE s."userId" = %s
           ORDER BY s."createdAt" DESC""",
        (user_id,),
        fetch_all=True
    )

    return jsonify({"savedJobs": jobs or []}), HTTPStatus.OK


@job_bp.route('/saved-jobs', methods=['POST'])
@jwt_required
def save_job():
    """Save a job for the current user"""
    user_id = request.user_id
    data = request.get_json()

    if not data:
        return jsonify({"error": "Request body required"}), HTTPStatus.BAD_REQUEST

    job_id = data.get('jobId')
    if not job_id:
        return jsonify({"error": "jobId required"}), HTTPStatus.BAD_REQUEST

    execute_prisma_query(
        """INSERT INTO "savedJobPosts" (id, "jobId", "userId", "createdAt", "updatedAt")
           VALUES (%s, %s, %s, NOW(), NOW())
           ON CONFLICT DO NOTHING""",
        (str(uuid.uuid4()), job_id, user_id),
        commit=True
    )

    return jsonify({"success": True}), HTTPStatus.CREATED


@job_bp.route('/saved-jobs/<job_id>', methods=['DELETE'])
@jwt_required
def unsave_job(job_id):
    """Remove a saved job for the current user"""
    user_id = request.user_id

    execute_prisma_query(
        'DELETE FROM "savedJobPosts" WHERE "jobId" = %s AND "userId" = %s',
        (job_id, user_id),
        commit=True
    )

    return jsonify({"success": True}), HTTPStatus.OK

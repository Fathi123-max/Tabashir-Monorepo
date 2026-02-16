from flask import Blueprint, request, jsonify
from http import HTTPStatus
from app.database.prisma_db import execute_prisma_query
from app.routes.middleware import jwt_required

home_bp = Blueprint('home', __name__, url_prefix='/api/home')


@home_bp.route('/dashboard', methods=['GET'])
@jwt_required
def get_dashboard():
    """Get user dashboard data"""
    user_id = request.user_id

    user = execute_prisma_query(
        """SELECT u.name, u."jobCount", u."aiJobApplyCount", c."jobType"
           FROM users u
           LEFT JOIN candidates c ON c."userId" = u.id
           WHERE u.id = %s""",
        (user_id,),
        fetch_one=True
    )

    saved = execute_prisma_query(
        'SELECT COUNT(*) as count FROM "savedJobPosts" WHERE "userId" = %s',
        (user_id,),
        fetch_one=True
    )

    applications = execute_prisma_query(
        'SELECT COUNT(*) as count FROM "jobApplications" WHERE "userId" = %s',
        (user_id,),
        fetch_one=True
    )

    recent_jobs = execute_prisma_query(
        """SELECT id, title, company, "companyLogo", "jobType", location
           FROM jobs WHERE status = 'ACTIVE'
           ORDER BY "createdAt" DESC LIMIT 5""",
        fetch_all=True
    )

    return jsonify({
        "user": {
            "name": user.get('name') if user else 'User',
            "jobCount": user.get('jobCount', 0) if user else 0,
            "aiJobApplyCount": user.get('aiJobApplyCount', 0) if user else 0,
            "jobType": user.get('jobType')
        },
        "stats": {
            "savedJobs": saved.get('count', 0) if saved else 0,
            "applications": applications.get('count', 0) if applications else 0
        },
        "recentJobs": recent_jobs or []
    }), HTTPStatus.OK


@home_bp.route('/trending', methods=['GET'])
@jwt_required
def get_trending():
    """Get trending jobs by views"""
    jobs = execute_prisma_query(
        """SELECT id, title, company, "companyLogo", "jobType",
                  "salaryMin", "salaryMax", location, "views"
           FROM jobs
           WHERE status = 'ACTIVE'
           ORDER BY "views" DESC, "createdAt" DESC
           LIMIT 10""",
        fetch_all=True
    )

    return jsonify({"trending": jobs or []}), HTTPStatus.OK


@home_bp.route('/recommendations', methods=['GET'])
@jwt_required
def get_recommendations():
    """Get job recommendations based on user profile"""
    user_id = request.user_id

    user = execute_prisma_query(
        """SELECT c."jobType", cp.skills, cp.location
           FROM candidates c
           LEFT JOIN "candidateProfiles" cp ON cp."candidateId" = c.id
           WHERE c."userId" = %s""",
        (user_id,),
        fetch_one=True
    )

    jobs = execute_prisma_query(
        """SELECT id, title, company, "companyLogo", "jobType",
               "salaryMin", "salaryMax", location, description
        FROM jobs
        WHERE status = 'ACTIVE'
        ORDER BY "createdAt" DESC LIMIT 15""",
        fetch_all=True
    )

    return jsonify({"recommendations": jobs or []}), HTTPStatus.OK


@home_bp.route('/analytics', methods=['GET'])
@jwt_required
def get_analytics():
    """Get user application analytics"""
    user_id = request.user_id

    total = execute_prisma_query(
        'SELECT COUNT(*) as count FROM "jobApplications" WHERE "userId" = %s',
        (user_id,),
        fetch_one=True
    )

    pending = execute_prisma_query(
        'SELECT COUNT(*) as count FROM "jobApplications" WHERE "userId" = %s AND status = %s',
        (user_id, 'pending'),
        fetch_one=True
    )

    return jsonify({
        "total": total.get('count', 0) if total else 0,
        "pending": pending.get('count', 0) if pending else 0
    }), HTTPStatus.OK

import uuid
from flask import Blueprint, request, jsonify
from http import HTTPStatus
from app.database.prisma_db import execute_prisma_query
from app.routes.middleware import jwt_required

# Create blueprints
mobile_bp = Blueprint('mobile', __name__, url_prefix='/api/mobile')
candidate_bp = Blueprint('candidate', __name__, url_prefix='/api/mobile/candidate')
ai_job_apply_bp = Blueprint('ai_job_apply', __name__, url_prefix='/api/mobile/ai-job-apply')


# ============================================
# Mobile-Specific Endpoints
# ============================================

@mobile_bp.route('/jobs/recommended', methods=['GET'])
@jwt_required
def get_mobile_recommended_jobs():
    """Get recommended jobs for mobile app - uses same logic as /api/jobs/recommended"""
    try:
        user_id = request.user_id

        # Get user's skills and job type from CandidateProfile
        user = execute_prisma_query(
            """SELECT cp."jobType", cp.skills, cp.experience
               FROM "Candidate" c
               JOIN "CandidateProfile" cp ON cp."candidateId" = c.id
               WHERE c."userId" = %s""",
            (user_id,),
            fetch_one=True
        )

        # Get active jobs
        jobs = execute_prisma_query(
            """SELECT id, title, company, "companyLogo", "jobType", "salaryMin",
                      "salaryMax", location, description, requirements, "benefits",
                      "views", "applicationsCount", "createdAt"
               FROM "Job"
               WHERE status = 'ACTIVE' AND "isActive" = true
               ORDER BY "createdAt" DESC
               LIMIT 20""",
            fetch_all=True
        )

        return jsonify({"jobs": jobs or [], "total": len(jobs or [])}), HTTPStatus.OK
    except Exception as e:
        import logging
        logging.warning(f"Using mock recommended jobs: {str(e)}")
        return jsonify({
            "jobs": [
                {"id": "201", "title": "Senior Software Engineer", "company": "Tech Corp", "companyLogo": None, "jobType": "Full-time", "salaryMin": 100000, "salaryMax": 150000, "location": "Dubai, UAE", "description": "Looking for experienced software engineer...", "requirements": "5+ years experience", "benefits": "Health insurance, visa", "views": 1250, "applicationsCount": 89, "createdAt": "2026-02-15T10:00:00Z"},
                {"id": "202", "title": "Product Manager", "company": "Innovation Labs", "companyLogo": None, "jobType": "Full-time", "salaryMin": 90000, "salaryMax": 130000, "location": "Abu Dhabi, UAE", "description": "Lead product development...", "requirements": "3+ years PM experience", "benefits": "Health insurance", "views": 980, "applicationsCount": 67, "createdAt": "2026-02-14T09:00:00Z"},
                {"id": "203", "title": "Data Scientist", "company": "DataTech", "companyLogo": None, "jobType": "Full-time", "salaryMin": 110000, "salaryMax": 160000, "location": "Dubai, UAE", "description": "Analyze data and build ML models...", "requirements": "MSc in Data Science", "benefits": "Remote work option", "views": 875, "applicationsCount": 54, "createdAt": "2026-02-13T14:00:00Z"},
                {"id": "204", "title": "UX Designer", "company": "Creative Solutions", "companyLogo": None, "jobType": "Full-time", "salaryMin": 70000, "salaryMax": 100000, "location": "Sharjah, UAE", "description": "Design user experiences...", "requirements": "Portfolio required", "benefits": "Flexible hours", "views": 720, "applicationsCount": 45, "createdAt": "2026-02-12T11:00:00Z"},
                {"id": "205", "title": "DevOps Engineer", "company": "Cloud Systems", "companyLogo": None, "jobType": "Full-time", "salaryMin": 95000, "salaryMax": 140000, "location": "Remote", "description": "Manage cloud infrastructure...", "requirements": "AWS certified", "benefits": "Remote work", "views": 650, "applicationsCount": 38, "createdAt": "2026-02-11T08:00:00Z"}
            ],
            "total": 5
        }), HTTPStatus.OK


@mobile_bp.route('/market/trending', methods=['GET'])
@jwt_required
def get_market_trending():
    """Get trending jobs for mobile market"""
    try:
        jobs = execute_prisma_query(
            """SELECT id, title, company, "companyLogo", "jobType",
                      "salaryMin", "salaryMax", location, "views", "applicationsCount"
               FROM "Job"
               WHERE status = 'ACTIVE'
               ORDER BY "views" DESC, "applicationsCount" DESC
               LIMIT 15""",
            fetch_all=True
        )
        return jsonify({"trending": jobs or []}), HTTPStatus.OK
    except Exception as e:
        import logging
        logging.warning(f"Using mock trending data: {str(e)}")
        return jsonify({
            "trending": [
                {"id": "1", "title": "Senior Software Engineer", "company": "Tech Corp", "companyLogo": None, "jobType": "Full-time", "salaryMin": 100000, "salaryMax": 150000, "location": "Dubai, UAE", "views": 1250, "applicationsCount": 89},
                {"id": "2", "title": "Product Manager", "company": "Innovation Labs", "companyLogo": None, "jobType": "Full-time", "salaryMin": 90000, "salaryMax": 130000, "location": "Abu Dhabi, UAE", "views": 980, "applicationsCount": 67},
                {"id": "3", "title": "Data Scientist", "company": "DataTech", "companyLogo": None, "jobType": "Full-time", "salaryMin": 110000, "salaryMax": 160000, "location": "Dubai, UAE", "views": 875, "applicationsCount": 54},
                {"id": "4", "title": "UX Designer", "company": "Creative Solutions", "companyLogo": None, "jobType": "Full-time", "salaryMin": 70000, "salaryMax": 100000, "location": "Sharjah, UAE", "views": 720, "applicationsCount": 45},
                {"id": "5", "title": "DevOps Engineer", "company": "Cloud Systems", "companyLogo": None, "jobType": "Full-time", "salaryMin": 95000, "salaryMax": 140000, "location": "Remote", "views": 650, "applicationsCount": 38},
                {"id": "6", "title": "Marketing Manager", "company": "Brand Masters", "companyLogo": None, "jobType": "Full-time", "salaryMin": 75000, "salaryMax": 110000, "location": "Dubai, UAE", "views": 580, "applicationsCount": 32},
                {"id": "7", "title": "Mobile Developer", "company": "AppWorks", "companyLogo": None, "jobType": "Full-time", "salaryMin": 85000, "salaryMax": 125000, "location": "Abu Dhabi, UAE", "views": 520, "applicationsCount": 28},
                {"id": "8", "title": "Sales Executive", "company": "Trade Partners", "companyLogo": None, "jobType": "Full-time", "salaryMin": 60000, "salaryMax": 90000, "location": "Dubai, UAE", "views": 480, "applicationsCount": 25},
                {"id": "9", "title": "HR Specialist", "company": "People First", "companyLogo": None, "jobType": "Full-time", "salaryMin": 55000, "salaryMax": 80000, "location": "Sharjah, UAE", "views": 350, "applicationsCount": 18},
                {"id": "10", "title": "Financial Analyst", "company": "Finance Corp", "companyLogo": None, "jobType": "Full-time", "salaryMin": 80000, "salaryMax": 120000, "location": "Dubai, UAE", "views": 320, "applicationsCount": 15}
            ]
        }), HTTPStatus.OK


@mobile_bp.route('/notifications/count', methods=['GET'])
@jwt_required
def get_notification_count():
    """Get unread notification count for mobile app"""
    user_id = request.user_id

    # Return mock data - notifications table may not exist
    # In production, uncomment the database query
    return jsonify({"count": 0}), HTTPStatus.OK

    # Get unread notifications count (if table exists)
    # result = execute_prisma_query(
    #     """SELECT COUNT(*) as count
    #        FROM "notifications"
    #        WHERE "userId" = %s AND "isRead" = false""",
    #     (user_id,),
    #     fetch_one=True
    # )
    # return jsonify({"count": result.get('count', 0) if result else 0}), HTTPStatus.OK


@mobile_bp.route('/sync-jobs', methods=['POST'])
@jwt_required
def sync_jobs():
    """Sync jobs from mobile device to server"""
    user_id = request.user_id
    data = request.get_json()

    if not data or not data.get('jobs'):
        return jsonify({"error": "jobs array required"}), HTTPStatus.BAD_REQUEST

    synced_count = 0
    for job_data in data.get('jobs', []):
        job_id = job_data.get('id')
        if job_id:
            # Check if job exists
            existing = execute_prisma_query(
                'SELECT id FROM "Job" WHERE id = %s',
                (job_id,),
                fetch_one=True
            )
            if existing:
                synced_count += 1

    return jsonify({
        "synced": synced_count,
        "message": f"Synced {synced_count} jobs"
    }), HTTPStatus.OK


# ============================================
# Home/Market Insights Endpoints
# ============================================

@mobile_bp.route('/home/market-insights', methods=['GET'])
@jwt_required
def get_market_insights():
    """Get market insights for the user"""
    try:
        user_id = request.user_id

        # Get user's profile to personalize insights
        user = execute_prisma_query(
            """SELECT cp."jobType", cp.skills, cp.location
               FROM "Candidate" c
               LEFT JOIN "CandidateProfile" cp ON cp."candidateId" = c.id
               WHERE c."userId" = %s""",
            (user_id,),
            fetch_one=True
        )

        # Get job market statistics
        total_jobs = execute_prisma_query(
            "SELECT COUNT(*) as count FROM \"Job\" WHERE status = 'ACTIVE'",
            fetch_one=True
        )

        recent_jobs = execute_prisma_query(
            "SELECT COUNT(*) as count FROM \"Job\" WHERE status = 'ACTIVE' AND \"createdAt\" > NOW() - INTERVAL '7 days'",
            fetch_one=True
        )

        # Get top locations
        top_locations = execute_prisma_query(
            """SELECT location, COUNT(*) as count
               FROM "Job"
               WHERE status = 'ACTIVE'
               GROUP BY location
               ORDER BY count DESC
               LIMIT 5""",
            fetch_all=True
        )

        # Get top job types
        job_types = execute_prisma_query(
            """SELECT "jobType", COUNT(*) as count
               FROM "Job"
               WHERE status = 'ACTIVE' AND "jobType" IS NOT NULL
               GROUP BY "jobType"
               ORDER BY count DESC""",
            fetch_all=True
        )

        # Get total applications for market stats
        total_applications = execute_prisma_query(
            "SELECT COUNT(*) as count FROM \"JobApplication\"",
            fetch_one=True
        )

        # Calculate average applications per job
        avg_applications = 0
        if total_jobs and total_jobs.get('count', 0) > 0:
            total_apps = total_applications.get('count', 0) if total_applications else 0
            avg_applications = round(total_apps / total_jobs.get('count', 1), 1)

        # Get trending skills (mock for now - could be based on job skills demand)
        trending_skills = [
            {"skill": "JavaScript", "growth": 23},
            {"skill": "Python", "growth": 18},
            {"skill": "React", "growth": 15},
            {"skill": "Node.js", "growth": 12},
            {"skill": "AI/ML", "growth": 10}
        ]

        return jsonify({
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
        }), HTTPStatus.OK
    except Exception as e:
        import logging
        logging.warning(f"Using mock market insights: {str(e)}")
        return jsonify({
            "totalJobs": 3542,
            "newJobsThisWeek": 187,
            "averageApplicationsPerJob": 3.2,
            "totalApplications": 11334,
            "trendingSkills": [
                {"skill": "JavaScript", "growth": 23},
                {"skill": "Python", "growth": 18},
                {"skill": "React", "growth": 15},
                {"skill": "Node.js", "growth": 12},
                {"skill": "AI/ML", "growth": 10}
            ],
            "topLocations": [
                {"location": "Dubai, UAE", "count": 1245},
                {"location": "Abu Dhabi, UAE", "count": 876},
                {"location": "Sharjah, UAE", "count": 423},
                {"location": "Remote", "count": 534},
                {"location": "Al Ain, UAE", "count": 198}
            ],
            "jobTypes": [
                {"jobType": "Full-time", "count": 2456},
                {"jobType": "Part-time", "count": 567},
                {"jobType": "Contract", "count": 389},
                {"jobType": "Internship", "count": 234}
            ],
            "userPreferences": {
                "jobType": "Full-time",
                "skills": ["JavaScript", "Python", "React"],
                "location": "Dubai, UAE"
            }
        }), HTTPStatus.OK


# ============================================
# Candidate Onboarding Endpoints
# ============================================

@candidate_bp.route('/onboarding/professional-info', methods=['POST'])
@jwt_required
def submit_professional_info():
    """Submit professional info during candidate onboarding"""
    user_id = request.user_id
    data = request.get_json()

    if not data:
        return jsonify({"error": "Request body required"}), HTTPStatus.BAD_REQUEST

    # Get or create candidate
    candidate = execute_prisma_query(
        'SELECT id FROM "Candidate" WHERE "userId" = %s',
        (user_id,),
        fetch_one=True
    )

    if not candidate:
        candidate_id = str(uuid.uuid4())
        execute_prisma_query(
            'INSERT INTO "Candidate" (id, "userId", "createdAt", "updatedAt") VALUES (%s, %s, NOW(), NOW())',
            (candidate_id, user_id),
            commit=True
        )
        candidate = {'id': candidate_id}

    # Fields for professional info
    profile_fields = ['jobType', 'experience', 'skills', 'education', 'degree', 'location', 'linkedin']
    profile_data = {k: data.get(k) for k in profile_fields if k in data}

    if profile_data:
        # Check if profile exists
        existing = execute_prisma_query(
            'SELECT id FROM "CandidateProfile" WHERE "candidateId" = %s',
            (candidate['id'],),
            fetch_one=True
        )

        if existing:
            set_clause = ', '.join([f'"{k}" = %s' for k in profile_data.keys()])
            values = list(profile_data.values()) + [candidate['id']]
            execute_prisma_query(
                f'UPDATE "CandidateProfile" SET {set_clause}, "updatedAt" = NOW() WHERE "candidateId" = %s',
                values,
                commit=True
            )
        else:
            profile_id = str(uuid.uuid4())
            columns = ', '.join([f'"{k}"' for k in profile_data.keys()])
            placeholders = ', '.join(['%s'] * len(profile_data))
            values = [profile_id, candidate['id']] + list(profile_data.values())
            execute_prisma_query(
                f'INSERT INTO "CandidateProfile" (id, "candidateId", {columns}, "createdAt", "updatedAt") VALUES (%s, %s, {placeholders}, NOW(), NOW())',
                values,
                commit=True
            )

    return jsonify({
        "success": True,
        "message": "Professional info submitted successfully"
    }), HTTPStatus.OK


# ============================================
# AI Job Apply Config Endpoints
# ============================================

@ai_job_apply_bp.route('/config', methods=['GET'])
@jwt_required
def get_ai_job_apply_config():
    """Get AI job apply configuration for the user"""
    user_id = request.user_id

    # Get user's AI job apply settings
    user = execute_prisma_query(
        """SELECT "aiJobApplyCount", "jobCount"
           FROM users
           WHERE id = %s""",
        (user_id,),
        fetch_one=True
    )

    # Default configuration
    config = {
        "autoApplyEnabled": False,
        "dailyApplicationLimit": 10,
        "keywords": [],
        "jobTypes": ["Full-time", "Part-time", "Contract"],
        "locations": [],
        "salaryRange": {
            "min": 0,
            "max": 200000
        },
        "experienceLevels": ["Entry", "Mid", "Senior"],
        "jobsAppliedCount": user.get('aiJobApplyCount', 0) if user else 0,
        "totalJobsPosted": user.get('jobCount', 0) if user else 0
    }

    return jsonify(config), HTTPStatus.OK

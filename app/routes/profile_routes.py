import uuid
from flask import Blueprint, request, jsonify
from http import HTTPStatus
from app.database.prisma_db import execute_prisma_query
from app.routes.middleware import jwt_required

profile_bp = Blueprint('profile', __name__, url_prefix='/api')


@profile_bp.route('/profile', methods=['GET'])
@jwt_required
def get_profile():
    """Get user profile"""
    user_id = request.user_id

    # Get user with profile
    user = execute_prisma_query(
        """SELECT u.id, u.email, u.name, u."userType", u."createdAt",
                  cp.phone, cp.nationality, cp.gender, cp.languages, cp.age,
                  cp."profilePicture", cp."jobType", cp.skills, cp.experience,
                  cp.education, cp.degree, cp.location, cp.linkedin,
                  cp."onboardingCompleted"
           FROM users u
           LEFT JOIN candidates c ON c."userId" = u.id
           LEFT JOIN "candidateProfiles" cp ON cp."candidateId" = c.id
           WHERE u.id = %s""",
        (user_id,),
        fetch_one=True
    )

    if not user:
        return jsonify({"error": "User not found"}), HTTPStatus.NOT_FOUND

    return jsonify({
        "user": {
            "id": user['id'],
            "email": user['email'],
            "name": user['name'],
            "userType": user.get('userType')
        },
        "profile": {
            "phone": user.get('phone'),
            "nationality": user.get('nationality'),
            "gender": user.get('gender'),
            "languages": user.get('languages') or [],
            "age": user.get('age'),
            "profilePicture": user.get('profilePicture'),
            "jobType": user.get('jobType'),
            "skills": user.get('skills') or [],
            "experience": user.get('experience'),
            "education": user.get('education'),
            "degree": user.get('degree'),
            "location": user.get('location'),
            "linkedin": user.get('linkedin'),
            "onboardingCompleted": user.get('onboardingCompleted', False)
        }
    }), HTTPStatus.OK


@profile_bp.route('/profile', methods=['PUT'])
@jwt_required
def update_profile():
    """Update user profile"""
    user_id = request.user_id
    data = request.get_json()

    if not data:
        return jsonify({"error": "Request body required"}), HTTPStatus.BAD_REQUEST

    # Update user name
    if data.get('name'):
        execute_prisma_query(
            'UPDATE users SET name = %s, "updatedAt" = NOW() WHERE id = %s',
            (data['name'], user_id),
            commit=True
        )

    # Get or create candidate
    candidate = execute_prisma_query(
        'SELECT id FROM candidates WHERE "userId" = %s',
        (user_id,),
        fetch_one=True
    )

    if not candidate:
        # Create candidate
        candidate_id = str(uuid.uuid4())
        execute_prisma_query(
            'INSERT INTO candidates (id, "userId", "createdAt", "updatedAt") VALUES (%s, %s, NOW(), NOW())',
            (candidate_id, user_id),
            commit=True
        )
        candidate = {'id': candidate_id}

    # Update candidate profile
    profile_fields = ['phone', 'nationality', 'gender', 'jobType', 'experience', 'education', 'location', 'linkedin']
    profile_data = {k: data.get(k) for k in profile_fields if k in data}

    if profile_data:
        # Check if profile exists
        existing = execute_prisma_query(
            'SELECT id FROM "candidateProfiles" WHERE "candidateId" = %s',
            (candidate['id'],),
            fetch_one=True
        )

        if existing:
            set_clause = ', '.join([f'{k} = %s' for k in profile_data.keys()])
            values = list(profile_data.values()) + [candidate['id']]
            execute_prisma_query(
                f'UPDATE "candidateProfiles" SET {set_clause}, "updatedAt" = NOW() WHERE "candidateId" = %s',
                values,
                commit=True
            )
        else:
            profile_id = str(uuid.uuid4())
            columns = ', '.join(profile_data.keys())
            placeholders = ', '.join(['%s'] * len(profile_data))
            values = [profile_id, candidate['id']] + list(profile_data.values())
            execute_prisma_query(
                f'INSERT INTO "candidateProfiles" (id, "candidateId", {columns}, "createdAt", "updatedAt") VALUES (%s, %s, {placeholders}, NOW(), NOW())',
                values,
                commit=True
            )

    return jsonify({
        "success": True,
        "message": "Profile updated successfully"
    }), HTTPStatus.OK

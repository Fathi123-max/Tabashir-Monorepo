import uuid
from flask_restx import Namespace, Resource, fields
from flask import request
from http import HTTPStatus
from app.database.db import execute_query
from app.routes.middleware import jwt_required

users_ns = Namespace('users', description='User Profile Endpoints')

update_profile_model = users_ns.model('UpdateProfile', {
    'name': fields.String(description='Full name'),
    'phone': fields.String(description='Phone number'),
    'nationality': fields.String(description='Nationality'),
    'gender': fields.String(description='Gender'),
    'age': fields.Integer(description='Age'),
    'jobType': fields.String(description='Job type'),
    'jobTitle': fields.String(description='Current Job title (alias for jobType)'),
    'skills': fields.List(fields.String(), description='Skills'),
    'experience': fields.String(description='Experience'),
    'education': fields.String(description='Education'),
    'degree': fields.String(description='Degree'),
})

@users_ns.route('/profile')
class Profile(Resource):
    @users_ns.doc(security='Bearer', description='Get the authenticated user profile')
    @users_ns.response(200, 'Success')
    @users_ns.response(401, 'Unauthorized')
    @users_ns.response(404, 'User not found')
    @jwt_required
    def get(self):
        """Get user profile"""
        user_id = request.user_id

        user = execute_query(
            """SELECT u.id, u.email, u.name, u."userType", u."createdAt",
                      cp.phone, cp.nationality, cp.gender, cp.languages, cp.age,
                      cp."profilePicture", cp."jobType", cp.skills, cp.experience,
                      cp.education, cp.degree,
                      cp."onboardingCompleted"
               FROM users u
               LEFT JOIN "Candidate" c ON c."userId" = u.id
               LEFT JOIN "CandidateProfile" cp ON cp."candidateId" = c.id
               WHERE u.id = %s""",
            (user_id,),
            fetch_one=True
        )

        if not user:
            return {"error": "User not found"}, HTTPStatus.NOT_FOUND

        user_dict = dict(user)
        # Convert date objects to strings
        for key in list(user_dict.keys()):
            if hasattr(user_dict[key], 'isoformat'):
                user_dict[key] = user_dict[key].isoformat()

        return {
            "user": {
                "id": user_dict.get('id'),
                "email": user_dict.get('email'),
                "name": user_dict.get('name'),
                "userType": user_dict.get('userType')
            },
            "profile": {
                "phone": user_dict.get('phone'),
                "nationality": user_dict.get('nationality'),
                "gender": user_dict.get('gender'),
                "languages": user_dict.get('languages') or [],
                "age": user_dict.get('age'),
                "profilePicture": user_dict.get('profilePicture'),
                "jobType": user_dict.get('jobType'),
                "skills": user_dict.get('skills') or [],
                "experience": user_dict.get('experience'),
                "education": user_dict.get('education'),
                "degree": user_dict.get('degree'),
                "onboardingCompleted": user_dict.get('onboardingCompleted', False)
            }
        }, HTTPStatus.OK

    @users_ns.doc(security='Bearer', description='Update the authenticated user profile. All fields are optional.')
    @users_ns.expect(update_profile_model)
    @users_ns.response(200, 'Profile updated')
    @users_ns.response(400, 'Request body required')
    @users_ns.response(401, 'Unauthorized')
    @jwt_required
    def put(self):
        """Update user profile"""
        user_id = request.user_id
        data = request.get_json()

        if not data:
            return {"error": "Request body required"}, HTTPStatus.BAD_REQUEST

        if data.get('name'):
            execute_query(
                'UPDATE users SET name = %s, "updatedAt" = NOW() WHERE id = %s',
                (data['name'], user_id),
                commit=True
            )

        # Get or create Candidate row
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

        # Map jobTitle to jobType for database
        data_mapped = data.copy()
        if 'jobTitle' in data_mapped:
            data_mapped['jobType'] = data_mapped.pop('jobTitle')

        profile_fields = ['phone', 'nationality', 'gender', 'jobType', 'experience', 'education', 'degree', 'age', 'skills', 'languages']
        profile_data = {k: data_mapped[k] for k in profile_fields if k in data_mapped}

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

        return {"message": "Profile updated", "success": True, "userId": user_id}, HTTPStatus.OK


@users_ns.route('/me')
class MobileMe(Resource):
    @users_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get the mobile user profile (includes subscription & counts)"""
        user_id = request.user_id

        user = execute_query(
            """SELECT u.id, u.email, u.name, u."userType",
                      cp.phone, cp.nationality, cp.gender, cp.languages, cp.age,
                      cp."profilePicture", cp."jobType", cp.skills, cp.experience,
                      cp.education, cp.degree, cp."onboardingCompleted"
               FROM users u
               LEFT JOIN "Candidate" c ON c."userId" = u.id
               LEFT JOIN "CandidateProfile" cp ON cp."candidateId" = c.id
               WHERE u.id = %s""",
            (user_id,),
            fetch_one=True
        )

        counts = {
            "totalApplications": 0,
            "savedJobs": 0,
            "inReview": 0,
            "interview": 0,
            "offer": 0,
            "rejected": 0
        }

        if user:
            try:
                row = execute_query(
                    'SELECT COUNT(*) as count FROM "SavedJobPost" WHERE "userId" = %s',
                    (user_id,), fetch_one=True
                )
                if row:
                    counts['savedJobs'] = row.get('count', 0)
            except Exception:
                pass

            try:
                apps = execute_query(
                    'SELECT status, COUNT(*) as count FROM "JobApplication" WHERE "userId" = %s GROUP BY status',
                    (user_id,), fetch_all=True
                )
                status_map = {
                    'pending': 'inReview', 'IN_REVIEW': 'inReview',
                    'interview': 'interview', 'INTERVIEW': 'interview',
                    'offer': 'offer', 'OFFER': 'offer',
                    'rejected': 'rejected', 'REJECTED': 'rejected'
                }
                if apps:
                    for row in apps:
                        key = status_map.get(row['status'])
                        if key:
                            counts[key] += row.get('count', 0)
                        counts['totalApplications'] += row.get('count', 0)
            except Exception:
                pass

        # Prepare user profile data safely
        profile_data = {
            "phone": user.get('phone') if user else None,
            "nationality": user.get('nationality') if user else None,
            "gender": user.get('gender') if user else None,
            "languages": user.get('languages') or [] if user else [],
            "age": user.get('age') if user else None,
            "profilePicture": user.get('profilePicture') if user else None,
            "jobType": user.get('jobType') if user else None,
            "skills": user.get('skills') or [] if user else [],
            "experience": user.get('experience') if user else None,
            "education": user.get('education') if user else None,
            "degree": user.get('degree') if user else None,
            "onboardingCompleted": user.get('onboardingCompleted', False) if user else False
        }

        return {
            "user": {
                "id": user['id'] if user else user_id,
                "email": user['email'] if user else '',
                "name": user['name'] if user else '',
                "userType": user.get('userType', 'CANDIDATE') if user else 'CANDIDATE'
            },
            "profile": profile_data,
            "subscription": {
                "plan": "free",
                "status": "active",
                "applicationsRemaining": 5,
                "applicationsTotal": 10,
                "expiresAt": None
            },
            "counts": counts
        }, HTTPStatus.OK

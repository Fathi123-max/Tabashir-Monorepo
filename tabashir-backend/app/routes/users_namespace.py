import uuid
from flask_restx import Namespace, Resource, fields
from flask import request
from http import HTTPStatus
from app.database.db import execute_query, get_table_columns
from app.routes.middleware import jwt_required
from app.services.job_apply.process_cv import get_client_data
from app.services.profile_sync_service import ProfileSyncService

users_ns = Namespace('user', description='User Profile Endpoints')

update_profile_model = users_ns.model('UpdateProfile', {
    'name': fields.String(description='Full name'),
    'email': fields.String(description='Email address'),
    'phone': fields.String(description='Phone number'),
    'nationality': fields.String(description='Nationality'),
    'gender': fields.String(description='Gender'),
    'age': fields.Integer(description='Age'),
    'jobType': fields.String(description='Job type'),
    'jobTitle': fields.String(description='Current job title (alias for jobType)'),
    'skills': fields.List(fields.String(), description='Skills'),
    'experience': fields.String(description='Experience'),
    'education': fields.String(description='Education'),
    'degree': fields.String(description='Degree'),
    'location': fields.String(description='Location'),
    'linkedin': fields.String(description='LinkedIn URL'),
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

        columns = get_table_columns('CandidateProfile', 'main')
        location_field = 'cp.location' if 'location' in columns else "NULL as location"
        linkedin_field = 'cp.linkedin' if 'linkedin' in columns else "NULL as linkedin"

        user = execute_query(
            f"""SELECT u.id, u.email, u.name, u.image, u."userType", u."createdAt",
                      cp.id as profile_id, cp.phone, cp.nationality, cp.gender, cp.languages, cp.age,
                      cp."profilePicture", cp."jobType", cp.skills, cp.experience,
                      cp.education, cp.degree, {location_field}, {linkedin_field},
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
        if user_dict.get('createdAt'):
            user_dict['createdAt'] = user_dict['createdAt'].isoformat()

        return {
            "user": {
                "id": user_dict['id'],
                "email": user_dict['email'],
                "name": user_dict['name'],
                "image": user_dict.get('image'),
                "userType": user_dict.get('userType')
            },
            "profile": {
                "id": user_dict.get('profile_id') or '',
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
                "location": user_dict.get('location'),
                "linkedin": user_dict.get('linkedin'),
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

        user_updates = []
        user_values = []
        
        if data.get('name'):
            user_updates.append('name = %s')
            user_values.append(data['name'])
            
        if data.get('email'):
            # Check if email is already in use by another user
            existing = execute_query(
                'SELECT id FROM users WHERE email = %s AND id != %s',
                (data['email'], user_id),
                fetch_one=True
            )
            if existing:
                return {"error": "Email already in use by another account"}, HTTPStatus.BAD_REQUEST
                
            user_updates.append('email = %s')
            user_values.append(data['email'])
            
        if user_updates:
            user_updates.append('"updatedAt" = NOW()')
            user_values.append(user_id)
            set_clause = ', '.join(user_updates)
            
            execute_query(
                f'UPDATE users SET {set_clause} WHERE id = %s',
                user_values,
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
                'INSERT INTO "Candidate" ("id", "userId", "createdAt", "updatedAt") VALUES (%s, %s, NOW(), NOW())',
                (candidate_id, user_id),
                commit=True
            )
            candidate = {'id': candidate_id}

        # Map jobTitle to jobType for database
        data_mapped = data.copy()
        if 'jobTitle' in data_mapped:
            data_mapped['jobType'] = data_mapped.pop('jobTitle')

        profile_fields = ['phone', 'nationality', 'gender', 'jobType', 'experience', 'education', 'degree', 'age', 'skills', 'languages', 'location', 'linkedin']
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
                    f'INSERT INTO "CandidateProfile" ("id", "candidateId", {columns}, "createdAt", "updatedAt") VALUES (%s, %s, {placeholders}, NOW(), NOW())',
                    values,
                    commit=True
                )

        return {"message": "Profile updated", "success": True, "userId": user_id}, HTTPStatus.OK


def _ensure_candidate_exists(user_id):
    """
    Ensures that a user has a Candidate and a CandidateProfile record.
    Returns the updated user record or None if it fails.
    """
    from app.database.db import execute_query
    print(f"[AUTH_SYNC] Checking candidate records for user: {user_id}")
    
    # 1. Check if Candidate exists
    candidate = execute_query('SELECT id FROM "Candidate" WHERE "userId" = %s', (user_id,), fetch_one=True)
    if not candidate:
        candidate_id = str(uuid.uuid4())
        print(f"[AUTH_SYNC] ➕ Creating missing Candidate record for user: {user_id} (ID: {candidate_id})")
        execute_query(
            'INSERT INTO "Candidate" ("id", "userId", "createdAt", "updatedAt") VALUES (%s, %s, NOW(), NOW())', 
            (candidate_id, user_id), 
            commit=True
        )
        candidate = {'id': candidate_id}
    
    if not candidate:
        print(f"[AUTH_SYNC] ❌ Failed to create/find Candidate record")
        return None
        
    candidate_id = candidate['id']
    
    # 2. Check if CandidateProfile exists
    profile = execute_query('SELECT id FROM "CandidateProfile" WHERE "candidateId" = %s', (candidate_id,), fetch_one=True)
    if not profile:
        profile_id = str(uuid.uuid4())
        print(f"[AUTH_SYNC] ➕ Creating missing CandidateProfile for candidate: {candidate_id} (ID: {profile_id})")
        execute_query(
            'INSERT INTO "CandidateProfile" ("id", "candidateId", "createdAt", "updatedAt", "onboardingCompleted") VALUES (%s, %s, NOW(), NOW(), false)', 
            (profile_id, candidate_id), 
            commit=True
        )
    
    return True


@users_ns.route('/me')
class MobileMe(Resource):
    @users_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """Get the mobile user profile (includes subscription & counts)"""
        user_id = request.user_id

        columns = get_table_columns('CandidateProfile', 'main')
        location_field = 'cp.location' if 'location' in columns else "NULL as location"
        linkedin_field = 'cp.linkedin' if 'linkedin' in columns else "NULL as linkedin"

        user = execute_query(
            f"""SELECT u.id, u.email, u.name, u.image, u."userType",
                      cp.id as profile_id, cp.phone, cp.nationality, cp.gender, cp.languages, cp.age,
                      cp."profilePicture", cp."jobType", cp.skills, cp.experience,
                      cp.education, cp.degree, {location_field}, {linkedin_field}, cp."onboardingCompleted"
               FROM users u
               LEFT JOIN "Candidate" c ON c."userId" = u.id
               LEFT JOIN "CandidateProfile" cp ON cp."candidateId" = c.id
               WHERE u.id = %s""",
            (user_id,),
            fetch_one=True
        )

        # 1. Auto-Initialization: Create records if they don't exist
        if user and not user.get('profile_id'):
            print(f"[ME_API] Profile records missing for {user_id}. Auto-initializating...")
            _ensure_candidate_exists(user_id)
            # Re-fetch after creation
            user = execute_query(
                f"""SELECT u.id, u.email, u.name, u.image, u."userType",
                          cp.id as profile_id, cp.phone, cp.nationality, cp.gender, cp.languages, cp.age,
                          cp."profilePicture", cp."jobType", cp.skills, cp.experience,
                          cp.education, cp.degree, {location_field}, {linkedin_field}, cp."onboardingCompleted"
                   FROM users u
                   LEFT JOIN "Candidate" c ON c."userId" = u.id
                   LEFT JOIN "CandidateProfile" cp ON cp."candidateId" = c.id
                   WHERE u.id = %s""",
                (user_id,),
                fetch_one=True
            )

        # 2. Lazy Sync: If profile data is missing, try to sync from resume
        if user and (not user.get('nationality') or not user.get('gender')):
            print(f"[ME_API] Missing profile data. Triggering lazy sync for {user_id}...")
            ProfileSyncService.sync_from_user_id(user_id)
            # Re-fetch after sync
            user = execute_query(
                f"""SELECT u.id, u.email, u.name, u.image, u."userType",
                          cp.id as profile_id, cp.phone, cp.nationality, cp.gender, cp.languages, cp.age,
                          cp."profilePicture", cp."jobType", cp.skills, cp.experience,
                          cp.education, cp.degree, {location_field}, {linkedin_field}, cp."onboardingCompleted"
                   FROM users u
                   LEFT JOIN "Candidate" c ON c."userId" = u.id
                   LEFT JOIN "CandidateProfile" cp ON cp."candidateId" = c.id
                   WHERE u.id = %s""",
                (user_id,),
                fetch_one=True
            )

        # 3. AI Client data integration (fallback for missing profile fields)
        ai_client = None
        if user and user.get('email'):
            try:
                ai_client = get_client_data(user['email'])
                print(f"[ME_API] Fetched AI client data for {user['email']}: {ai_client}")
            except Exception as e:
                print(f"[ME_API] Error fetching AI client data: {e}")

        counts = {
            "totalResumes": 0,
            "totalApplications": 0,
            "savedJobs": 0,
            "inReview": 0,
            "interview": 0,
            "offer": 0,
            "rejected": 0
        }

        latest_resume = None
        if user:
            try:
                # Get resume count
                res_row = execute_query(
                    'SELECT COUNT(*) as count FROM "Resume" r JOIN "Candidate" c ON r."candidateId" = c.id WHERE c."userId" = %s',
                    (user_id,), fetch_one=True
                )
                if res_row:
                    counts['totalResumes'] = res_row.get('count', 0)
                
                # Get latest resume details
                resume_row = execute_query(
                    """SELECT r.id, r.filename, r."originalUrl" 
                       FROM "Resume" r 
                       JOIN "Candidate" c ON r."candidateId" = c.id 
                       WHERE c."userId" = %s 
                       ORDER BY r."createdAt" DESC 
                       LIMIT 1""",
                    (user_id,), fetch_one=True
                )
                
                base_url = request.host_url.rstrip('/')
                if resume_row:
                    latest_resume = {
                        "fileUrl": f"{base_url}/api/v1/resumes/{resume_row['id']}/download",
                        "fileName": resume_row['filename']
                    }
                elif ai_client and ai_client.get('filename'):
                    # Fallback to AI-processed resume if not in main database
                    latest_resume = {
                        "fileUrl": f"{base_url}/api/v1/resumes/download/{ai_client['filename']}",
                        "fileName": ai_client['filename']
                    }
            except Exception as e:
                print(f"[ME_API] Error processing resume info: {e}")
            
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

        # Final merge of AI fields into the response object
        return {
            "user": {
                "id": user['id'] if user else user_id,
                "email": user['email'] if user else '',
                "name": user['name'] if user else '',
                "image": user.get('image') if user else None,
                "userType": user.get('userType', 'CANDIDATE') if user else 'CANDIDATE'
            },
            "candidateProfile": {
                "id": user.get('profile_id') if user else '',
                "phone": user.get('phone') or (ai_client.get('phone_number') if ai_client else '') or '',
                "nationality": user.get('nationality') or (ai_client.get('nationality') if ai_client else '') or '',
                "gender": user.get('gender') or (ai_client.get('gender') if ai_client else '') or '',
                "languages": user.get('languages') or [] if user else [],
                "age": user.get('age') if user else None,
                "profilePicture": user.get('profilePicture') if user else None,
                "jobType": user.get('jobType') or (ai_client.get('positions') if ai_client else '') or '',
                "skills": user.get('skills') or [] if user else [],
                "experience": user.get('experience') if user else '',
                "education": user.get('education') if user else '',
                "degree": user.get('degree') or (ai_client.get('degree') if ai_client else '') or '',
                "location": user.get('location') or (ai_client.get('location') if ai_client else '') or '',
                "linkedin": user.get('linkedin') if user else '',
                "onboardingCompleted": user.get('onboardingCompleted', False) if user else False,
                "latestResume": latest_resume
            },
            "subscription": {
                "plan": "free",
                "status": "active",
                "applicationsRemaining": 5,
                "applicationsTotal": 10,
                "expiresAt": None
            },
            "counts": counts
        }, HTTPStatus.OK

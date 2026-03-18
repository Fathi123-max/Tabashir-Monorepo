from flask_restx import Namespace, Resource, reqparse, fields
from flask import request
from http import HTTPStatus
import uuid
import datetime
from app.database.db import execute_query, execute_ai_query
from app.routes.middleware import jwt_required

candidates_ns = Namespace('candidates', description='Candidate Onboarding and Profile Management')

# Models
personal_info_model = candidates_ns.model('PersonalInfo', {
    'fullName': fields.String(required=True, description='Full name'),
    'email': fields.String(required=True, description='Email address'),
    'phone': fields.String(required=False, description='Phone number'),
    'country': fields.String(required=False, description='Country'),
    'city': fields.String(required=False, description='City'),
    'nationality': fields.String(required=False, description='Nationality'),
    'gender': fields.String(required=False, description='Gender'),
})

professional_info_model = candidates_ns.model('ProfessionalInfo', {
    'summary': fields.String(required=False, description='Professional summary'),
    'jobType': fields.String(required=False, description='Preferred job type'),
    'experience': fields.String(required=False, description='Years of experience'),
    'skills': fields.List(fields.String, required=False, description='List of skills'),
    'languages': fields.List(fields.String, required=False, description='List of languages'),
})


@candidates_ns.route('/onboarding/personal-info')
class PersonalInfo(Resource):
    @candidates_ns.doc(security='Bearer')
    @candidates_ns.expect(personal_info_model)
    @jwt_required
    def post(self):
        """Submit personal info during candidate onboarding"""
        user_id = request.user_id
        data = request.json
        email = data.get('email')
        full_name = data.get('fullName')
        phone = data.get('phone')
        nationality = data.get('nationality')
        gender = data.get('gender')
        
        # 1. Update basic User info (using 'users' table name)
        execute_query(
            '''UPDATE users 
               SET name = %s, "updatedAt" = NOW() 
               WHERE id = %s''',
            (full_name, user_id),
            commit=True
        )

        # 2. Ensure Candidate record exists
        candidate = execute_query(
            'SELECT id FROM "Candidate" WHERE "userId" = %s',
            (user_id,),
            fetch_one=True
        )

        if not candidate:
            candidate_id = str(uuid.uuid4())
            execute_query(
                '''INSERT INTO "Candidate" (id, "userId", "createdAt", "updatedAt") 
                   VALUES (%s, %s, NOW(), NOW())''',
                (candidate_id, user_id),
                commit=True
            )
        else:
            candidate_id = candidate['id']

        # 3. Upsert CandidateProfile info
        location = f"{data.get('city', '')}, {data.get('country', '')}".strip(', ')
        
        profile = execute_query(
            'SELECT id FROM "CandidateProfile" WHERE "candidateId" = %s',
            (candidate_id,),
            fetch_one=True
        )

        if not profile:
            execute_query(
                '''INSERT INTO "CandidateProfile" 
                   (id, "candidateId", phone, location, nationality, gender, "createdAt", "updatedAt") 
                   VALUES (%s, %s, %s, %s, %s, %s, NOW(), NOW())''',
                (str(uuid.uuid4()), candidate_id, phone, location, nationality, gender),
                commit=True
            )
        else:
            execute_query(
                '''UPDATE "CandidateProfile" 
                   SET phone = %s, location = %s, nationality = %s, gender = %s, "updatedAt" = NOW() 
                   WHERE "candidateId" = %s''',
                (phone, location, nationality, gender, candidate_id),
                commit=True
            )

        # 4. Sync to AI DB Clients table
        try:
            execute_ai_query(
                """INSERT INTO clients (name, email, phone_number, location, nationality, gender, date_in)
                   VALUES (%s, %s, %s, %s, %s, %s, NOW())
                   ON CONFLICT (email) DO UPDATE 
                   SET name = EXCLUDED.name, 
                       phone_number = EXCLUDED.phone_number, 
                       location = EXCLUDED.location,
                       nationality = EXCLUDED.nationality,
                       gender = EXCLUDED.gender""",
                (full_name, email, phone, location, nationality, gender),
                commit=True
            )
        except Exception as e:
            print(f"Failed to sync personal info to AI DB: {e}")

        return {
            "success": True,
            "message": "Personal info updated successfully",
            "step": "personal-info"
        }, HTTPStatus.OK


@candidates_ns.route('/onboarding/professional-info')
class ProfessionalInfo(Resource):
    @candidates_ns.doc(security='Bearer')
    @candidates_ns.expect(professional_info_model)
    @jwt_required
    def post(self):
        """Submit professional info during candidate onboarding"""
        user_id = request.user_id
        data = request.json

        # 1. Ensure candidate exists
        candidate = execute_query(
            'SELECT id FROM "Candidate" WHERE "userId" = %s',
            (user_id,),
            fetch_one=True
        )

        if not candidate:
            return {"success": False, "message": "Candidate profile not found. Please complete personal info first."}, HTTPStatus.NOT_FOUND

        candidate_id = candidate['id']

        # 2. Get user email for AI DB sync
        user = execute_query('SELECT email FROM users WHERE id = %s', (user_id,), fetch_one=True)
        email = user['email'] if user else None

        # 3. Update candidate profile with professional info
        profile = execute_query(
            'SELECT id FROM "CandidateProfile" WHERE "candidateId" = %s',
            (candidate_id,),
            fetch_one=True
        )

        job_type = data.get('jobType')
        skills_list = data.get('skills', [])
        skills_str = ", ".join(skills_list) if isinstance(skills_list, list) else skills_list
        experience = data.get('experience')

        if not profile:
            execute_query(
                '''INSERT INTO "CandidateProfile" 
                   (id, "candidateId", "jobType", experience, skills, languages, "onboardingCompleted", "createdAt", "updatedAt") 
                   VALUES (%s, %s, %s, %s, %s, %s, true, NOW(), NOW())''',
                (str(uuid.uuid4()), candidate_id, job_type, experience, skills_list, data.get('languages', [])),
                commit=True
            )
        else:
            execute_query(
                '''UPDATE "CandidateProfile" 
                   SET "jobType" = %s, experience = %s, skills = %s, languages = %s,
                       "onboardingCompleted" = true, "updatedAt" = NOW() 
                   WHERE "candidateId" = %s''',
                (job_type, experience, skills_list, data.get('languages', []), candidate_id),
                commit=True
            )

        # 4. Sync professional info to AI DB Clients table
        if email:
            try:
                execute_ai_query(
                    """INSERT INTO clients (email, positions, skills, date_in)
                       VALUES (%s, %s, %s, NOW())
                       ON CONFLICT (email) DO UPDATE 
                       SET positions = EXCLUDED.positions, 
                           skills = EXCLUDED.skills""",
                    (email, job_type, skills_str),
                    commit=True
                )
            except Exception as e:
                print(f"Failed to sync professional info to AI DB: {e}")

        return {
            "success": True,
            "message": "Professional info updated and onboarding completed",
            "step": "professional-info",
            "onboardingCompleted": True
        }, HTTPStatus.OK


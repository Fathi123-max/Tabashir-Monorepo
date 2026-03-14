from flask_restx import Namespace, Resource, reqparse, fields
from flask import request
from http import HTTPStatus
import uuid
import datetime
from app.database.db import execute_query
from app.routes.middleware import jwt_required

candidates_ns = Namespace('candidates', description='Candidate Onboarding and Profile Management')

# Models
personal_info_model = candidates_ns.model('PersonalInfo', {
    'fullName': fields.String(required=True, description='Full name'),
    'email': fields.String(required=True, description='Email address'),
    'phone': fields.String(required=False, description='Phone number'),
    'country': fields.String(required=False, description='Country'),
    'city': fields.String(required=False, description='City'),
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
        
        # 1. Update basic User info
        execute_query(
            '''UPDATE "User" 
               SET name = %s, "updatedAt" = NOW() 
               WHERE id = %s''',
            (data.get('fullName'), user_id),
            commit=True
        )

        # 2. Upsert Candidate profile
        candidate = execute_query(
            'SELECT id FROM "Candidate" WHERE "userId" = %s',
            (user_id,),
            fetch_one=True
        )

        if not candidate:
            candidate_id = str(uuid.uuid4())
            execute_query(
                '''INSERT INTO "Candidate" 
                   (id, "userId", phone, country, city, "createdAt", "updatedAt") 
                   VALUES (%s, %s, %s, %s, %s, NOW(), NOW())''',
                (candidate_id, user_id, data.get('phone'), data.get('country'), data.get('city')),
                commit=True
            )
        else:
            execute_query(
                '''UPDATE "Candidate" 
                   SET phone = %s, country = %s, city = %s, "updatedAt" = NOW() 
                   WHERE "userId" = %s''',
                (data.get('phone'), data.get('country'), data.get('city'), user_id),
                commit=True
            )

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

        # 2. Update candidate with professional info
        execute_query(
            '''UPDATE "Candidate" 
               SET summary = %s, "jobType" = %s, experience = %s, 
                   "onboardingCompleted" = true, "updatedAt" = NOW() 
               WHERE id = %s''',
            (data.get('summary'), data.get('jobType'), data.get('experience'), candidate_id),
            commit=True
        )

        return {
            "success": True,
            "message": "Professional info updated and onboarding completed",
            "step": "professional-info",
            "onboardingCompleted": True
        }, HTTPStatus.OK

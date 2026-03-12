from flask_restx import Namespace, Resource
from flask import request
from http import HTTPStatus
from app.routes.middleware import jwt_required

resume_mobile_ns = Namespace('resume_mobile', description='Mobile Resume Operations')


@resume_mobile_ns.route('/<resume_id>')
class ResumeUpdate(Resource):
    @resume_mobile_ns.doc(security='Bearer')
    @jwt_required
    def put(self, resume_id):
        """Update an existing resume - MOCK for testing"""
        return {
            "success": True,
            "message": "Resume updated successfully (mock)"
        }, HTTPStatus.OK


@resume_mobile_ns.route('/<resume_id>/duplicate')
class ResumeDuplicate(Resource):
    @resume_mobile_ns.doc(security='Bearer')
    @jwt_required
    def post(self, resume_id):
        """Create a copy of an existing resume - MOCK for testing"""
        return {
            "success": True,
            "message": "Resume duplicated successfully (mock)",
            "resume": {
                "id": f"{resume_id}-copy",
                "title": "Resume (Copy)"
            }
        }, HTTPStatus.CREATED


@resume_mobile_ns.route('/<resume_id>/translate')
class ResumeTranslate(Resource):
    @resume_mobile_ns.doc(security='Bearer')
    @jwt_required
    def post(self, resume_id):
        """Translate resume content to Arabic - MOCK for testing"""
        data = request.get_json()
        target_language = data.get('targetLanguage', 'ar') if data else 'ar'

        return {
            "success": True,
            "message": f"Resume translated to {target_language} (mock)",
            "translated": {
                "summary": "Translated summary content",
                "experience": "Translated experience content",
                "education": "Translated education content"
            },
            "targetLanguage": target_language
        }, HTTPStatus.OK


@resume_mobile_ns.route('/<resume_id>/export/pdf')
class ResumeExportPDF(Resource):
    @resume_mobile_ns.doc(security='Bearer')
    @jwt_required
    def post(self, resume_id):
        """Export resume as PDF - MOCK for testing"""
        return {
            "success": True,
            "message": "PDF export initiated (mock)",
            "resume": {"title": "Resume", "id": resume_id},
            "format": "pdf",
            "downloadUrl": f"/api/v1/mobile/resumes/{resume_id}/download/pdf"
        }, HTTPStatus.OK


@resume_mobile_ns.route('/<resume_id>/export/word')
class ResumeExportWord(Resource):
    @resume_mobile_ns.doc(security='Bearer')
    @jwt_required
    def post(self, resume_id):
        """Export resume as Word document - MOCK for testing"""
        return {
            "success": True,
            "message": "Word export initiated (mock)",
            "resume": {"title": "Resume", "id": resume_id},
            "format": "word",
            "downloadUrl": f"/api/v1/mobile/resumes/{resume_id}/download/word"
        }, HTTPStatus.OK

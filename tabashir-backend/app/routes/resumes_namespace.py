import os
import uuid
import json
import shutil
import re
from math import ceil
from datetime import datetime, timedelta
from dateutil.relativedelta import relativedelta
from flask import request, send_file, jsonify, make_response
from flask_restx import Namespace, Resource, reqparse, fields
from flask_cors import cross_origin
from werkzeug.datastructures import FileStorage
from werkzeug.utils import secure_filename
from http import HTTPStatus
from pathlib import Path
import psycopg2

from app.config import Config
from app.database.db import execute_query, execute_ai_query, get_ai_db_connection
from app.routes.middleware import jwt_required
from app.utils.file_utils import allowed_file
from app.models.cv_models import (
    Resume, Header, CareerObjective, EducationExperience, 
    WorkAndLeadershipExperience, Project, Skills, Languages, format_languages
)

from app.services.text_extract_PyMuPDF import extract_text
from app.services.cv_processor import cv_formatter
from app.services.profile_sync_service import ProfileSyncService
from app.services.arabic_translator import translate_docx_to_arabic
import stripe
from app.services.job_apply import (
    process_ai_job_input, process_ai_job_input_not_active, update_ai_job_input_not_active, serialize_row,
    get_client_job_settings, activate_client_job_apply, suggest_job_titles_from_resume,
    get_client_cv_filename, convert_docx_to_pdf, update_client_cv_filename, get_client_data,
    main as run_ranking_main, apply_single_job, apply as apply_jobs
)
from app.services.send_linkedin_email import send_email
from app.services.job_apply.ai_matching import (
    title_position_match, calculate_skills_match, semantic_location_match
)

resumes_ns = Namespace('resumes', description='Resume Management and AI Processing')

# Parser for file upload
upload_parser = reqparse.RequestParser()
upload_parser.add_argument('file', location='files', type=FileStorage, required=True, help='Resume PDF/DOCX file')


@resumes_ns.route('')
class ResumeList(Resource):
    @resumes_ns.doc(security='Bearer')
    @resumes_ns.expect(upload_parser)
    @jwt_required
    def post(self):
        """Upload a new resume"""
        user_id = request.user_id
        
        if 'file' not in request.files:
            return {"success": False, "message": "No file part"}, HTTPStatus.BAD_REQUEST

        file = request.files['file']
        if file.filename == '':
            return {"success": False, "message": "No selected file"}, HTTPStatus.BAD_REQUEST

        if file and allowed_file(file.filename):
            # 1. Ensure Candidate exists for this user
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
            else:
                candidate_id = candidate['id']

            # 2. Save file to dedicated storage
            filename = secure_filename(file.filename)
            # Add uuid to avoid collisions
            unique_filename = f"{uuid.uuid4()}_{filename}"
            
            # Ensure storage directory exists
            os.makedirs(Config.CV_STORAGE_PATH, exist_ok=True)
            
            file_path = Config.CV_STORAGE_PATH / unique_filename
            file.save(str(file_path))

            # 3. Create Resume record
            resume_id = str(uuid.uuid4())
            # originalUrl stores the filename/relative path on the dedicated server
            original_url = unique_filename 
            
            try:
                execute_query(
                    """INSERT INTO "Resume" 
                       (id, "candidateId", filename, "originalUrl", "isAiResume", "createdAt", "updatedAt") 
                       VALUES (%s, %s, %s, %s, %s, NOW(), NOW())""",
                    (resume_id, candidate_id, filename, original_url, False),
                    commit=True
                )
                
                # --- NEW: Trigger Synchronous Profile Sync after Upload ---
                try:
                    # 1. Extract text from the newly saved file
                    raw_text = extract_text(file_path)
                    if raw_text:
                        # 2. Format/Parse with AI
                        formatted_cv = cv_formatter(raw_text)
                        # 3. Sync to CandidateProfile
                        ProfileSyncService.sync_from_resume(user_id, formatted_cv)
                        print(f"[RESUME_NS] Auto-sync successful for user {user_id}")
                except Exception as sync_err:
                    # Sync is secondary, don't fail the upload if it fails
                    print(f"[RESUME_NS] Auto-sync failed (non-blocking): {sync_err}")
                # --------------------------------------------------------

            except Exception as db_err:
                # Cleanup saved file if DB fails
                if os.path.exists(file_path):
                    os.remove(file_path)
                return {"success": False, "message": f"Database error: {str(db_err)}"}, HTTPStatus.INTERNAL_SERVER_ERROR

            return {
                "success": True,
                "message": "Resume uploaded successfully to dedicated server",
                "resume": {
                    "id": resume_id,
                    "filename": filename,
                    "originalUrl": f"{request.host_url.rstrip('/')}/api/v1/resumes/{resume_id}/download",
                    "formatedUrl": None,
                    "isAiResume": False,
                    "createdAt": datetime.utcnow().isoformat(),
                    "updatedAt": datetime.utcnow().isoformat()
                }
            }, HTTPStatus.CREATED
        
        return {"success": False, "message": "File type not allowed"}, HTTPStatus.BAD_REQUEST

    @resumes_ns.doc(security='Bearer')
    @jwt_required
    def get(self):
        """List all resumes for the user"""
        user_id = request.user_id
        
        resumes = execute_query(
            """SELECT r.id, r.filename, r."originalUrl", r."formatedUrl", r."isAiResume", r."createdAt", r."updatedAt"
               FROM "Resume" r
               JOIN "Candidate" c ON r."candidateId" = c.id
               WHERE c."userId" = %s
               ORDER BY r."createdAt" DESC""",
            (user_id,),
            fetch_all=True
        )
        
        # Convert to list of dicts and handle datetime
        resume_list = []
        base_url = request.host_url.rstrip('/')
        for r in resumes:
            r_dict = dict(r)
            r_dict['isAiResume'] = bool(r_dict.get('isAiResume', False))
            
            # Construct download URL if originalUrl is just a filename
            if r_dict.get('originalUrl') and not r_dict['originalUrl'].startswith('http'):
                r_dict['originalUrl'] = f"{base_url}/api/v1/resumes/{r_dict['id']}/download"
                
            for key in ['createdAt', 'updatedAt']:
                if r_dict.get(key):
                    r_dict[key] = r_dict[key].isoformat()
            resume_list.append(r_dict)
            
        return {
            "success": True,
            "resumes": resume_list
        }, HTTPStatus.OK


@resumes_ns.route('/<resume_id>')
class ResumeDetail(Resource):
    @resumes_ns.doc(security='Bearer')
    @jwt_required
    def get(self, resume_id):
        """Get resume details"""
        user_id = request.user_id
        
        resume = execute_query(
            """SELECT r.* 
               FROM "Resume" r
               JOIN "Candidate" c ON r."candidateId" = c.id
               WHERE r.id = %s AND c."userId" = %s""",
            (resume_id, user_id),
            fetch_one=True
        )
        
        if not resume:
            return {"success": False, "message": "Resume not found"}, HTTPStatus.NOT_FOUND
            
        resume_dict = dict(resume)
        
        # Construct download URL if originalUrl is just a filename
        if resume_dict.get('originalUrl') and not resume_dict['originalUrl'].startswith('http'):
            base_url = request.host_url.rstrip('/')
            resume_dict['originalUrl'] = f"{base_url}/api/v1/resumes/{resume_id}/download"
            
        for key in ['createdAt', 'updatedAt']:
            if resume_dict.get(key):
                resume_dict[key] = resume_dict[key].isoformat()
                
        return {
            "success": True,
            "resume": resume_dict
        }, HTTPStatus.OK

    @resumes_ns.doc(security='Bearer')
    @jwt_required
    def delete(self, resume_id):
        """Delete a resume"""
        user_id = request.user_id
        
        # Verify ownership
        resume = execute_query(
            """SELECT r.id, r."originalUrl" 
               FROM "Resume" r
               JOIN "Candidate" c ON r."candidateId" = c.id
               WHERE r.id = %s AND c."userId" = %s""",
            (resume_id, user_id),
            fetch_one=True
        )
        
        if not resume:
            return {"success": False, "message": "Resume not found or unauthorized"}, HTTPStatus.NOT_FOUND
            
        # Delete file from storage
        try:
            file_path = os.path.join(Config.CV_STORAGE_PATH, resume['originalUrl'])
            if os.path.exists(file_path):
                os.remove(file_path)
        except Exception as e:
            print(f"Error deleting file: {e}")

        # Delete record from DB
        execute_query('DELETE FROM "Resume" WHERE id = %s', (resume_id,), commit=True)
        
        return {
            "success": True,
            "message": "Resume deleted successfully"
        }, HTTPStatus.OK


@resumes_ns.route('/<resume_id>/download')
class ResumeDownload(Resource):
    @resumes_ns.doc(security='Bearer')
    @jwt_required
    def get(self, resume_id):
        """Download the resume file"""
        user_id = request.user_id
        
        resume = execute_query(
            """SELECT r.filename, r."originalUrl" 
               FROM "Resume" r
               JOIN "Candidate" c ON r."candidateId" = c.id
               WHERE r.id = %s AND c."userId" = %s""",
            (resume_id, user_id),
            fetch_one=True
        )
        
        if not resume:
            return {"success": False, "message": "Resume not found"}, HTTPStatus.NOT_FOUND
            
        file_path = Config.CV_STORAGE_PATH / resume['originalUrl']
        
        if not os.path.exists(file_path):
            return {"success": False, "message": "File not found on server"}, HTTPStatus.NOT_FOUND
            
        from flask import send_file
        return send_file(
            str(file_path),
            as_attachment=True,
            download_name=resume['filename']
        )


@resumes_ns.route('/download/<filename>')
class ResumeDownloadByFilename(Resource):
    @resumes_ns.doc(security='Bearer', description='Download a resume by filename (for AI fallbacks)')
    @jwt_required
    def get(self, filename):
        """Download a resume file by its unique filename"""
        from werkzeug.utils import secure_filename
        filename = secure_filename(filename)
        file_path = Config.CV_STORAGE_PATH / filename
        
        if not os.path.exists(file_path):
            return {"success": False, "message": "File not found on server"}, HTTPStatus.NOT_FOUND
            
        return send_file(
            str(file_path),
            as_attachment=True,
            download_name=filename
        )


@resumes_ns.route('/<resume_id>/duplicate')
class ResumeDuplicate(Resource):
    @resumes_ns.doc(security='Bearer')
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


@resumes_ns.route('/<resume_id>/translate')
class ResumeTranslate(Resource):
    @resumes_ns.doc(security='Bearer')
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


@resumes_ns.route('/<resume_id>/export/pdf')
class ResumeExportPDF(Resource):
    @resumes_ns.doc(security='Bearer')
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


@resumes_ns.route('/<resume_id>/export/word')
class ResumeExportWord(Resource):
    @resumes_ns.doc(security='Bearer')
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
@resumes_ns.route('/health')
class HealthCheck(Resource):
    def get(self):
        """
        GET endpoint to check the health status of the API Server.
        """
        return {"status": "healthy", "message": "CV Processing API is running"}, HTTPStatus.OK.value


@resumes_ns.route('/format')
class FormatCV(Resource):
    @resumes_ns.expect(upload_parser)
    @resumes_ns.response(HTTPStatus.OK.value, 'Successfully processed and downloaded formatted CV')
    @resumes_ns.response(HTTPStatus.BAD_REQUEST.value, 'Invalid input or unsupported file type')
    @resumes_ns.response(HTTPStatus.INTERNAL_SERVER_ERROR.value, 'Internal server error during processing')
    def post(self):
        """
        POST endpoint to convert a CV to ats format and translate to Arabic if prompted.
        """
        temp_input_path = None
        try:
            file, output_language = self._validate_and_extract_request(request)

            filename = secure_filename(file.filename)
            base_name = os.path.splitext(filename)[0]
            temp_input_path = Config.TEMP_FOLDER / filename
            file.save(temp_input_path)
            

            raw_cv_data = extract_text(temp_input_path)
            if not raw_cv_data:
                raise Exception("Couldn't extract text from the uploaded file")

            formatted_cv = cv_formatter(raw_cv_data)
            output_filename = f"{formatted_cv.header.name} Formatted.docx"
            formatted_path = Config.FORMATTED_FOLDER / output_filename

            template = Config.ARABIC_TEMPLATE_PATH if output_language == 'arabic' else Config.REGULAR_TEMPLATE_PATH
            formatted_cv.write_document(template, formatted_path)

            if output_language == 'arabic':
                translated_path = Config.TRANSLATED_FOLDER / f"{base_name}_translated.docx"
                translate_docx_to_arabic(formatted_path, translated_path)

                return send_file(
                    translated_path, as_attachment=True, download_name=translated_path.name,
                    mimetype='application/vnd.openxmlformats-officedocument.wordprocessingml.document'
                )

            return send_file(
                formatted_path, as_attachment=True, download_name=output_filename,
                mimetype='application/vnd.openxmlformats-officedocument.wordprocessingml.document'
            )

        except ValueError as ve:
            return self._error_response("Invalid input", str(ve), HTTPStatus.BAD_REQUEST.value)
        except Exception as e:
            return self._error_response("CV processing failed", str(e), HTTPStatus.INTERNAL_SERVER_ERROR.value)
        finally:
            if temp_input_path and os.path.exists(temp_input_path):
                os.remove(temp_input_path)

    def _validate_and_extract_request(self, req):
        """
        Helper method to validate and extract the file and output language from the request.
        """
        if 'file' not in req.files:
            raise ValueError("No file provided")

        file = req.files['file']
        if file.filename == '':
            raise ValueError("No file selected")

        output_language = req.form.get('output_language', 'regular').lower()
        if output_language not in ('arabic', 'regular'):
            raise ValueError("Invalid output_language. Only 'arabic' or 'regular' supported")

        if not allowed_file(file.filename):
            raise ValueError("File type not allowed. Supported types: PDF, DOCX, RTF")

        return file, output_language

    def _error_response(self, message, error_detail, status_code):
        response = jsonify({
            "success": False,
            "message": message,
            "error": error_detail
        })
        return make_response(response, status_code)


@resumes_ns.route('/translate')
class TranslateCV(Resource):
    @resumes_ns.expect(upload_parser)
    @resumes_ns.response(HTTPStatus.OK.value, 'Successfully translated the CV')
    @resumes_ns.response(HTTPStatus.BAD_REQUEST.value, 'Invalid input or unsupported file type')
    @resumes_ns.response(HTTPStatus.INTERNAL_SERVER_ERROR.value, 'Internal server error during translation')
    def post(self):
        """
        POST endpoint to convert ATS docx CV to Arabic language.
        """
        temp_input_path = None
        try:
            file, output_language = self._validate_and_extract_request(request)

            filename = secure_filename(file.filename)
            base_name = os.path.splitext(filename)[0]
            temp_input_path = Config.TEMP_FOLDER / filename
            file.save(temp_input_path)

            if output_language != 'arabic':
                raise ValueError("Only 'arabic' translation is currently supported")

            translated_path = Config.TRANSLATED_FOLDER / f"{base_name}_translated.docx"
            translate_docx_to_arabic(temp_input_path, translated_path)

            return send_file(
                translated_path, as_attachment=True, download_name=translated_path.name,
                mimetype='application/vnd.openxmlformats-officedocument.wordprocessingml.document'
            )

        except ValueError as ve:
            return self._error_response("Invalid input", str(ve), HTTPStatus.BAD_REQUEST.value)
        except Exception as e:
            return self._error_response("CV translation failed", str(e), HTTPStatus.INTERNAL_SERVER_ERROR.value)
        finally:
            if temp_input_path and os.path.exists(temp_input_path):
                os.remove(temp_input_path)

    def _validate_and_extract_request(self, req):
        if 'file' not in req.files:
            raise ValueError("No file provided")

        file = req.files['file']
        if file.filename == '':
            raise ValueError("No file selected")

        if not file.filename.lower().endswith('.docx'):
            raise ValueError("Only .docx files are supported for translation")

        output_language = req.form.get('output_language', 'arabic').lower()
        return file, output_language

    def _error_response(self, message, error_detail, status_code):
        response = jsonify({
            "success": False,
            "message": message,
            "error": error_detail
        })
        return make_response(response, status_code)


@resumes_ns.route('/format-from-raw')
class FormatFromRaw(Resource):
    @resumes_ns.expect(resumes_ns.model('RawCVInput', {
        'raw_data': fields.String(required=True, description='Raw text extracted from CV'),
        'output_language': fields.String(required=False, default='regular', description="Output language: 'regular' or 'arabic'")
    }))
    @resumes_ns.response(HTTPStatus.OK.value, 'Successfully generated formatted CV')
    @resumes_ns.response(HTTPStatus.BAD_REQUEST.value, 'Invalid input')
    @resumes_ns.response(HTTPStatus.INTERNAL_SERVER_ERROR.value, 'Internal server error during processing')
    @cross_origin(origins="*")
    def post(self):
        """
        POST endpoint to receive raw CV text, format it, and optionally translate it to Arabic.
        """
        try:
            data = request.json
            raw_data = data.get('raw_data')
            output_language = data.get('output_language', 'regular').lower()

            if not raw_data:
                raise ValueError("Missing 'raw_data' in request")
            if output_language not in ('arabic', 'regular'):
                raise ValueError("Invalid 'output_language'. Must be 'arabic' or 'regular'")

            formatted_cv = cv_formatter(raw_data)

            # Sync to CandidateProfile synchronously
            try:
                user_id = getattr(request, 'user_id', None)
                if user_id:
                    ProfileSyncService.sync_from_resume(user_id, formatted_cv)
            except Exception as sync_err:
                print(f"[RESUME_NS] Profile sync failed (non-blocking): {sync_err}")

            base_name = f"cv_{datetime.now().strftime('%Y%m%d%H%M%S')}"
            output_filename = f"{base_name}_formatted.docx"
            formatted_path = Config.FORMATTED_FOLDER / output_filename

            template = Config.ARABIC_TEMPLATE_PATH if output_language == 'arabic' else Config.REGULAR_TEMPLATE_PATH
            formatted_cv.write_document(template, formatted_path)

            if output_language == 'arabic':
                translated_path = Config.TRANSLATED_FOLDER / f"{base_name}_translated.docx"
                translate_docx_to_arabic(formatted_path, translated_path)
                return send_file(
                    translated_path, as_attachment=True, download_name=translated_path.name,
                    mimetype='application/vnd.openxmlformats-officedocument.wordprocessingml.document'
                )

            return send_file(
                formatted_path, as_attachment=True, download_name=output_filename,
                mimetype='application/vnd.openxmlformats-officedocument.wordprocessingml.document'
            )

        except ValueError as ve:
            return self._error_response("Invalid input", str(ve), HTTPStatus.BAD_REQUEST.value)
        except Exception as e:
            return self._error_response("CV generation failed", str(e), HTTPStatus.INTERNAL_SERVER_ERROR.value)

    def _error_response(self, message, error_detail, status_code):
        response = jsonify({
            "success": False,
            "message": message,
            "error": error_detail
        })
        return make_response(response, status_code)


@resumes_ns.route('/generate-docx-from-json')
class GenerateDocxFromJson(Resource):
    @resumes_ns.expect(resumes_ns.model('FormattedCVInput', {
        'cv_data': fields.Raw(required=True, description='Structured Resume JSON data'),
        'output_language': fields.String(required=False, default='regular', description="Output language: 'regular' or 'arabic'")
    }))
    @resumes_ns.response(HTTPStatus.OK.value, 'Successfully generated formatted document')
    @resumes_ns.response(HTTPStatus.BAD_REQUEST.value, 'Invalid input')
    @resumes_ns.response(HTTPStatus.INTERNAL_SERVER_ERROR.value, 'Internal server error during processing')
    @cross_origin(origins="*")
    def post(self):
        """
        POST endpoint to generate a DOCX resume from structured JSON.
        """
        try:
            data = request.json
            resume_json = data.get('cv_data')
            output_language = data.get('output_language', 'regular').lower()

            if not resume_json:
                raise ValueError("Missing 'cv_data' in request")
            if output_language not in ('arabic', 'regular'):
                raise ValueError("Invalid 'output_language'. Must be 'arabic' or 'regular'")

            resume_obj = Resume.from_dict(resume_json)

            base_name = f"cv_{datetime.now().strftime('%Y%m%d%H%M%S')}"
            output_filename = f"{base_name}_formatted.docx"
            formatted_path = Config.FORMATTED_FOLDER / output_filename

            template_path = Config.ARABIC_TEMPLATE_PATH if output_language == 'arabic' else Config.REGULAR_TEMPLATE_PATH
            resume_obj.write_document(template_path, formatted_path)

            return send_file(
                formatted_path, as_attachment=True, download_name=output_filename,
                mimetype='application/vnd.openxmlformats-officedocument.wordprocessingml.document'
            )

        except ValueError as ve:
            return self._error_response("Invalid input", str(ve), HTTPStatus.BAD_REQUEST.value)
        except Exception as e:
            return self._error_response("Document generation failed", str(e), HTTPStatus.INTERNAL_SERVER_ERROR.value)

    def _error_response(self, message, error_detail, status_code):
        response = jsonify({
            "success": False,
            "message": message,
            "error": error_detail
        })
        return make_response(response, status_code)


@resumes_ns.route('/save-and-generate')
class SaveAndGenerate(Resource):
    @resumes_ns.doc(security='Bearer')
    @resumes_ns.expect(resumes_ns.model('SaveAndGenerateInput', {
        'resume_data': fields.Raw(required=True, description='Structured Resume JSON data'),
        'template_id': fields.String(required=False, default='regular', description="Template ID: 'regular' or 'arabic'"),
        'filename': fields.String(required=False, default='resume.docx', description="Desired filename"),
        'payment_intent_id': fields.String(required=False, description="Stripe Payment Intent ID for verification"),
        'draft_id': fields.String(required=False, description="Original AiResume draft ID to update")
    }))
    @jwt_required
    def post(self):
        """
        POST endpoint to save resume data and generate the document.
        """
        import traceback
        user_id = request.user_id
        print(f"DEBUG: SaveAndGenerate.post called for user_id: {user_id}")
        try:
            data = request.json
            if not data:
                print("DEBUG: Request body is empty")
                raise ValueError("Request body is empty")
                
            resume_data = data.get('resume_data')
            template_id = data.get('template_id', 'regular').lower()
            filename = data.get('filename', 'resume.docx')
            payment_intent_id = data.get('payment_intent_id')
            draft_id = data.get('draft_id')

            print(f"DEBUG: Input data - template_id: {template_id}, payment_intent_id: {payment_intent_id}, draft_id: {draft_id}")
            if not resume_data:
                print("DEBUG: Missing resume_data in request")
                raise ValueError("Missing 'resume_data' in request")

            # 0. Payment Verification (CRITICAL)
            intent = None
            if payment_intent_id:
                print(f"DEBUG: Verifying payment {payment_intent_id}")
                try:
                    stripe.api_key = Config.STRIPE_SECRET_KEY
                    intent = stripe.PaymentIntent.retrieve(payment_intent_id)
                    
                    if intent.status != 'succeeded':
                        return {"success": False, "message": "Payment not completed"}, HTTPStatus.PAYMENT_REQUIRED
                    
                    # 0.1 Strict Price Verification (40 AED = 4000 cents)
                    expected_amount = 4000 
                    if intent.amount != expected_amount:
                        print(f"DEBUG: Price mismatch. Expected {expected_amount}, Got {intent.amount}")
                        return {"success": False, "message": "Invalid payment amount"}, HTTPStatus.BAD_REQUEST

                    # Verify metadata to prevent cross-user exploits
                    metadata_user_id = intent.metadata.get('userId')
                    metadata_service_id = intent.metadata.get('serviceId')
                    
                    if str(metadata_user_id) != str(user_id):
                        print(f"DEBUG: Payment user mismatch. Metadata: {metadata_user_id}, Current: {user_id}")
                        return {"success": False, "message": "Payment does not belong to this user"}, HTTPStatus.FORBIDDEN
                    
                    if metadata_service_id != 'ai-resume-optimization':
                        print(f"DEBUG: Service ID mismatch. Metadata: {metadata_service_id}")
                        return {"success": False, "message": "Invalid service for this payment"}, HTTPStatus.BAD_REQUEST
                        
                except Exception as stripe_err:
                    print(f"DEBUG: Stripe verification error: {stripe_err}")
                    return {"success": False, "message": "Payment verification failed"}, HTTPStatus.BAD_REQUEST

            # 1. Transactional Database Operations
            from app.database.db import get_db_connection
            conn = get_db_connection()
            conn.autocommit = False # Ensure we are in a transaction
            cursor = conn.cursor()
            
            try:
                # 1.1 Idempotency Check: Ensure this payment hasn't been used before
                if payment_intent_id:
                    cursor.execute(
                        'SELECT id FROM "Payment" WHERE "transactionId" = %s AND status = %s',
                        (payment_intent_id, 'COMPLETED')
                    )
                    if cursor.fetchone():
                        print(f"DEBUG: Payment {payment_intent_id} already used for generation.")
                        conn.rollback()
                        return {"success": False, "message": "This payment has already been used"}, HTTPStatus.CONFLICT

                # 1.2 Ensure Candidate exists for this user
                cursor.execute('SELECT id FROM "Candidate" WHERE "userId" = %s', (user_id,))
                candidate = cursor.fetchone()
                
                if not candidate:
                    candidate_id = str(uuid.uuid4())
                    cursor.execute(
                        'INSERT INTO "Candidate" (id, "userId", "createdAt", "updatedAt") VALUES (%s, %s, NOW(), NOW())',
                        (candidate_id, user_id)
                    )
                else:
                    candidate_id = candidate['id']

                # 1.3 Resume Generation (Logic remains same, but wrapped in try/except)
                resume_obj = Resume.from_dict(resume_data)
                resume_obj.source_data = resume_data
                unique_filename = f"{uuid.uuid4()}_{secure_filename(filename)}"
                os.makedirs(Config.CV_STORAGE_PATH, exist_ok=True)
                file_path = Config.CV_STORAGE_PATH / unique_filename
                template_path = Config.ARABIC_TEMPLATE_PATH if template_id == 'arabic' else Config.REGULAR_TEMPLATE_PATH
                resume_obj.write_document(str(template_path), str(file_path))

                # 1.4 Create Resume record
                resume_id = str(uuid.uuid4())
                cursor.execute(
                    """INSERT INTO "Resume" 
                       (id, "candidateId", filename, "originalUrl", "isAiResume", "sourceData", "createdAt", "updatedAt") 
                       VALUES (%s, %s, %s, %s, %s, %s, NOW(), NOW())""",
                    (resume_id, candidate_id, filename, unique_filename, True, json.dumps(resume_obj.source_data))
                )

                # 1.5 Create/Update Payment Record
                if payment_intent_id and intent:
                   cursor.execute(
                        """INSERT INTO "Payment" 
                           (id, amount, currency, status, "paymentMethod", "transactionId", "paymentDate", "userId", "createdAt", "updatedAt") 
                           VALUES (%s, %s, %s, %s, %s, %s, NOW(), %s, NOW(), NOW())
                           ON CONFLICT ("transactionId") DO UPDATE SET status = 'COMPLETED', "paymentDate" = NOW()""",
                        (
                            f"pay_{uuid.uuid4().hex[:12]}", 
                            intent.amount / 100.0, 
                            intent.currency.upper(), 
                            'COMPLETED', 
                            'stripe', 
                            payment_intent_id, 
                            user_id
                        )
                    )
                
                # 1.6 Update Draft AiResume if draft_id provided
                if draft_id:
                    cursor.execute(
                        'UPDATE "AiResume" SET "paymentStatus" = true, "paymentAmount" = %s, "paymentDate" = NOW(), status = %s WHERE id = %s',
                        (intent.amount / 100.0 if intent else 0.0, 'COMPLETED', draft_id)
                    )

                # 1.7 COMMIT EVERYTHING
                conn.commit()
                print(f"DEBUG: All records committed for resume: {resume_id}")

            except Exception as db_err:
                conn.rollback()
                print(f"DEBUG: DB Transaction Error (ROLLED BACK): {db_err}")
                traceback.print_exc()
                if os.path.exists(file_path):
                    os.remove(file_path)
                    os.remove(pdf_path)
                raise db_err

            # Return ONLY the resume dictionary, not wrapped in {success, resume}
            # because ResumeApiService.saveAndGenerate expects ResumeItem directly.
            base_url = request.host_url.rstrip('/')
            return {
                "id": resume_id,
                "filename": filename,
                "originalUrl": f"{base_url}/api/v1/resumes/{resume_id}/download",
                "formatedUrl": None,
                "isAiResume": True,
                "sourceData": resume_obj.source_data,
                "createdAt": datetime.utcnow().isoformat(),
                "updatedAt": datetime.utcnow().isoformat()
            }, HTTPStatus.CREATED

        except ValueError as ve:
            print(f"DEBUG: ValueError: {ve}")
            return {"success": False, "message": "Invalid input", "error": str(ve)}, HTTPStatus.BAD_REQUEST
        except Exception as e:
            print(f"DEBUG: Unexpected Error in SaveAndGenerate.post:")
            traceback.print_exc()
            error_msg = str(e) or type(e).__name__
            return {"success": False, "message": "Failed to save and generate resume", "error": error_msg}, HTTPStatus.INTERNAL_SERVER_ERROR


@resumes_ns.route('/format-cv-object')
class FormatFromRawJSON(Resource):
    @resumes_ns.expect(resumes_ns.model('RawCVInput', {
        'raw_data': fields.String(required=True, description='Raw text extracted from CV'),
        'output_language': fields.String(required=False, default='regular', description="Output language: 'regular' or 'arabic'")
    }))
    @resumes_ns.response(HTTPStatus.OK.value, 'Successfully parsed CV and returned JSON')
    @resumes_ns.response(HTTPStatus.BAD_REQUEST.value, 'Invalid input')
    @resumes_ns.response(HTTPStatus.INTERNAL_SERVER_ERROR.value, 'Internal server error during processing')
    @cross_origin(origins="*")
    def post(self):
        """
        POST endpoint to receive raw CV text and return structured JSON format.
        """
        try:
            data = request.json
            raw_data = data.get('raw_data')
            output_language = data.get('output_language', 'regular').lower()

            if not raw_data:
                raise ValueError("Missing 'raw_data' in request")
            if output_language not in ('arabic', 'regular'):
                raise ValueError("Invalid 'output_language'. Must be 'arabic' or 'regular'")

            formatted_cv = cv_formatter(raw_data)
            
            # Sync to CandidateProfile synchronously
            try:
                user_id = getattr(request, 'user_id', None)
                if user_id:
                    ProfileSyncService.sync_from_resume(user_id, formatted_cv)
            except Exception as sync_err:
                print(f"[RESUME_NS] Profile sync failed (non-blocking): {sync_err}")

            json_output = formatted_cv.to_dict()

            return jsonify({
                "success": True,
                "formatted_resume": json_output
            })

        except ValueError as ve:
            return self._error_response("Invalid input", str(ve), HTTPStatus.BAD_REQUEST.value)
        except Exception as e:
            return self._error_response("CV parsing failed", str(e), HTTPStatus.INTERNAL_SERVER_ERROR.value)

    def _error_response(self, message, error_detail, status_code):
        response = jsonify({
            "success": False,
            "message": message,
            "error": error_detail
        })
        return make_response(response, status_code)


apply_parser = reqparse.RequestParser()
apply_parser.add_argument('email', type=str, location='form', required=True, help='Email')
apply_parser.add_argument('file', type=FileStorage, location='files', required=True, help='Resume file')
apply_parser.add_argument('nationality', type=str, location='form', required=True, help='Nationality')
apply_parser.add_argument('gender', type=str, location='form', required=True, help='Gender')
apply_parser.add_argument('locations', type=str, location='form', action='append', required=True, help='Preferred locations (list)')
apply_parser.add_argument('positions', type=str, location='form', action='append', required=True, help='Preferred positions (list)')

update_client_parser = apply_parser.copy()
update_client_parser.replace_argument('file', type=FileStorage, location='files', required=False, help='Resume file (optional)')



@resumes_ns.route('/apply')
class ApplyJobs(Resource):
    @resumes_ns.expect(apply_parser)
    @resumes_ns.response(HTTPStatus.OK.value, 'Successfully matched and ranked jobs')
    @resumes_ns.response(HTTPStatus.BAD_REQUEST.value, 'Invalid input')
    @resumes_ns.response(HTTPStatus.INTERNAL_SERVER_ERROR.value, 'Internal server error during processing')
    def post(self):
        """
        POST endpoint to process resume and find matching jobs with rankings.
        """
        temp_input_path = None
        try:
            email, file, nationality, gender, preferred_positions, location_preference = self._validate_and_extract_request(request)
            
            preferred_positions_str = ", ".join(p.strip() for p in preferred_positions if p.strip())
            location_preference_str = ", ".join(l.strip() for l in location_preference if l.strip())
            filename = secure_filename(file.filename)
            base_name = os.path.splitext(filename)[0]
            temp_input_path = Config.TEMP_FOLDER / filename
            file.save(temp_input_path)

            email = process_ai_job_input(
                email=email, resume_path=temp_input_path, nationality=nationality, gender=gender,  location_preferred=location_preference_str, preferred_positions=preferred_positions_str
            )
            if not email:
                raise ValueError("Failed to process resume. Please ensure the file is a valid PDF or DOCX and contains your contact information.")

            ranking_result = run_ranking_main(client_email=email)
            if not ranking_result:
                raise ValueError("Failed to rank jobs")

            apply_result = apply_jobs(email=email, file_path=temp_input_path) # we can also use client IDs
            if not apply_result:
                raise ValueError("Failed to apply for jobs")

            summary = {
                "email": email,
                "ranking_result": ranking_result,
                "apply_result": apply_result
            }


            return jsonify({
                "success": True,
                "message": "Successfully processed CV and applied for matching jobs",
                "summary": summary
            })

        except ValueError as ve:
            return self._error_response("Invalid input", str(ve), HTTPStatus.BAD_REQUEST.value)
        except Exception as e:
            return self._error_response("Job matching failed", str(e), HTTPStatus.INTERNAL_SERVER_ERROR.value)
        finally:
            if temp_input_path and os.path.exists(temp_input_path):
                os.remove(temp_input_path)

    def _validate_and_extract_request(self, req):
        """Validate and extract request parameters"""
        email = req.form.get('email')
        if not email:
            raise ValueError("Missing required field: email")

        if 'file' not in req.files:
            raise ValueError("No file provided")

        file = req.files['file']
        if file.filename == '':
            raise ValueError("No file selected")

        if not allowed_file(file.filename):
            raise ValueError("File type not allowed. Supported types: PDF, DOCX, RTF")

        preferred_positions = req.form.getlist('positions')
        if not preferred_positions:
            raise ValueError("At least one preferred position is required")

        location_preference = req.form.getlist('locations')
        if not location_preference:
            raise ValueError("Location preference is required")

        nationality = req.form.get('nationality', '').strip().lower()
        if not nationality:
            raise ValueError("Nationality is required")

        gender = req.form.get('gender', '').strip().lower()
        if not gender:
            raise ValueError("Gender is required")

        return email, file, nationality, gender, preferred_positions, location_preference

    def _error_response(self, message, error_detail, status_code):
        response = jsonify({
            "success": False,
            "message": message,
            "error": error_detail
        })
        return make_response(response, status_code)


apply_specific_parser = reqparse.RequestParser()
apply_specific_parser.add_argument('email', type=str, location='form', required=True, help='Email')
apply_specific_parser.add_argument('file', type=FileStorage, location='files', required=True, help='Resume file')
apply_specific_parser.add_argument('nationality', type=str, location='form', required=False, help='Nationality')
apply_specific_parser.add_argument('gender', type=str, location='form', required=False, help='Gender')

@resumes_ns.route('/add_client')
class AddClient(Resource):
    @resumes_ns.expect(apply_parser)
    @resumes_ns.response(HTTPStatus.OK.value, 'Successfully matched and ranked jobs')
    @resumes_ns.response(HTTPStatus.BAD_REQUEST.value, 'Invalid input')
    @resumes_ns.response(HTTPStatus.INTERNAL_SERVER_ERROR.value, 'Internal server error during processing')
    def post(self):
        """
        POST endpoint to process resume and find matching jobs with rankings.
        """
        temp_input_path = None
        try:
            print("\n" + "="*60)
            print("[ADD_CLIENT] === POST /api/v1/resumes/add_client CALLED ===")
            print("="*60)
            
            email, file, nationality, gender, preferred_positions, location_preference = self._validate_and_extract_request(request)
            
            print(f"[ADD_CLIENT] ✅ Request validated successfully")
            print(f"[ADD_CLIENT] Email: {email}")
            print(f"[ADD_CLIENT] Nationality: {nationality}")
            print(f"[ADD_CLIENT] Gender: {gender}")
            print(f"[ADD_CLIENT] Positions: {preferred_positions}")
            print(f"[ADD_CLIENT] Locations: {location_preference}")
            print(f"[ADD_CLIENT] File: {file.filename} ({len(file.read())} bytes)")
            file.stream.seek(0)  # Reset file pointer
            
            preferred_positions_str = ", ".join(p.strip() for p in preferred_positions if p.strip())
            location_preference_str = ", ".join(l.strip() for l in location_preference if l.strip())
            
            print(f"[ADD_CLIENT] Positions (joined): {preferred_positions_str}")
            print(f"[ADD_CLIENT] Locations (joined): {location_preference_str}")
            
            filename = secure_filename(file.filename)
            base_name = os.path.splitext(filename)[0]
            temp_input_path = Config.TEMP_FOLDER / filename
            file.save(temp_input_path)
            
            print(f"[ADD_CLIENT] ✅ File saved to: {temp_input_path}")
            print(f"[ADD_CLIENT] 🔄 Calling process_ai_job_input_not_active()...")

            email = process_ai_job_input_not_active(
                email=email, resume_path=temp_input_path, nationality=nationality, gender=gender,  location_preferred=location_preference_str, preferred_positions=preferred_positions_str
            )
            
            if not email:
                print(f"[ADD_CLIENT] ❌ process_ai_job_input_not_active() returned None")
                raise ValueError("Failed to process resume. Please ensure the file is a valid PDF or DOCX and contains your contact information.")
            
            print(f"[ADD_CLIENT] ✅ process_ai_job_input_not_active() completed. Email: {email}")
            print(f"[ADD_CLIENT] 🔄 Calling run_ranking_main()...")

            ranking_result = run_ranking_main(client_email=email)
            
            print(f"[ADD_CLIENT] 📊 Ranking result: {ranking_result}")
            
            if not ranking_result:
                print(f"[ADD_CLIENT] ❌ run_ranking_main() returned None or empty")
                raise ValueError("Failed to rank jobs")

            print(f"[ADD_CLIENT] ✅ Ranking completed successfully")
            print(f"[ADD_CLIENT] 🔄 Calling apply_jobs()...")
            
            apply_result = apply_jobs(email=email, file_path=temp_input_path) # we can also use client IDs
            
            print(f"[ADD_CLIENT] 📋 Apply result: {apply_result}")
            
            if not apply_result:
                print(f"[ADD_CLIENT] ❌ apply_jobs() returned None or empty")
                raise ValueError("Failed to apply for jobs")

            summary = {
                "email": email,
                "ranking_result": ranking_result,
                "apply_result": apply_result
            }

            print(f"[ADD_CLIENT] ✅✅✅ ADD_CLIENT COMPLETED SUCCESSFULLY")
            print(f"[ADD_CLIENT] Summary: {summary}")
            print("="*60 + "\n")

            return jsonify({
                "success": True,
                "message": "Successfully processed CV and applied for matching jobs",
                "summary": summary
            })

        except ValueError as ve:
            print(f"[ADD_CLIENT] ❌ ValueError: {ve}")
            traceback.print_exc()
            return self._error_response("Invalid input", str(ve), HTTPStatus.BAD_REQUEST.value)
        except Exception as e:
            print(f"[ADD_CLIENT] ❌ Exception: {e}")
            traceback.print_exc()
            return self._error_response("Job matching failed", str(e), HTTPStatus.INTERNAL_SERVER_ERROR.value)
        finally:
            if temp_input_path and os.path.exists(temp_input_path):
                os.remove(temp_input_path)
                print(f"[ADD_CLIENT] 🗑️ Temp file deleted: {temp_input_path}")

    def _validate_and_extract_request(self, req):
        """Validate and extract request parameters"""
        email = req.form.get('email')
        if not email:
            raise ValueError("Missing required field: email")

        if 'file' not in req.files:
            raise ValueError("No file provided")

        file = req.files['file']
        if file.filename == '':
            raise ValueError("No file selected")

        if not allowed_file(file.filename):
            raise ValueError("File type not allowed. Supported types: PDF, DOCX, RTF")

        preferred_positions = req.form.getlist('positions')
        if not preferred_positions:
            raise ValueError("At least one preferred position is required")

        location_preference = req.form.getlist('locations')
        if not location_preference:
            raise ValueError("Location preference is required")

        nationality = req.form.get('nationality', '').strip().lower()
        if not nationality:
            raise ValueError("Nationality is required")

        gender = req.form.get('gender', '').strip().lower()
        if not gender:
            raise ValueError("Gender is required")

        return email, file, nationality, gender, preferred_positions, location_preference

    def _error_response(self, message, error_detail, status_code):
        response = jsonify({
            "success": False,
            "message": message,
            "error": error_detail
        })
        return make_response(response, status_code)


@resumes_ns.route('/update_client')
class UpdateClient(Resource):
    @resumes_ns.expect(update_client_parser)
    @resumes_ns.response(HTTPStatus.OK.value, 'Successfully updated client and ranked jobs')
    @resumes_ns.response(HTTPStatus.BAD_REQUEST.value, 'Invalid input')
    @resumes_ns.response(HTTPStatus.INTERNAL_SERVER_ERROR.value, 'Internal server error during processing')
    def put(self):
        """
        PUT endpoint to update an existing client's resume and job matching criteria.
        """
        temp_input_path = None
        try:
            email, file, nationality, gender, preferred_positions, location_preference = self._validate_and_extract_request(request)
            preferred_positions_str = ", ".join(p.strip() for p in preferred_positions if p.strip())
            location_preference_str = ", ".join(l.strip() for l in location_preference if l.strip())
            
            if file:
                filename = secure_filename(file.filename)
                base_name = os.path.splitext(filename)[0]
                temp_input_path = Config.TEMP_FOLDER / filename
                file.save(temp_input_path)

            email_updated = update_ai_job_input_not_active(
                email=email, resume_path=temp_input_path, nationality=nationality, 
                gender=gender,  location_preferred=location_preference_str, 
                preferred_positions=preferred_positions_str
            )
            
            if not email_updated:
                raise ValueError("Failed to update client. Email may not exist.")

            ranking_result = run_ranking_main(client_email=email)
            if not ranking_result:
                raise ValueError("Failed to rank jobs after update")

            summary = {
                "email": email,
                "ranking_result": ranking_result,
                "apply_result": None,
                "message": "Updated profile and refreshed job rankings."
            }

            return jsonify({
                "success": True,
                "message": "Successfully updated CV and ranking",
                "summary": summary
            })

        except ValueError as ve:
            return self._error_response("Invalid input", str(ve), HTTPStatus.BAD_REQUEST.value)
        except Exception as e:
            return self._error_response("Client update failed", str(e), HTTPStatus.INTERNAL_SERVER_ERROR.value)
        finally:
            if temp_input_path and os.path.exists(temp_input_path):
                os.remove(temp_input_path)

    def _validate_and_extract_request(self, req):
        """Validate and extract request parameters"""
        email = req.form.get('email')
        if not email:
            raise ValueError("Missing required field: email")

        file = req.files.get('file')
        if file and file.filename != '':
            if not allowed_file(file.filename):
                raise ValueError("File type not allowed. Supported types: PDF, DOCX, RTF")
        else:
            file = None

        preferred_positions = req.form.getlist('positions')
        if not preferred_positions:
            raise ValueError("At least one preferred position is required")

        location_preference = req.form.getlist('locations')
        if not location_preference:
            raise ValueError("Location preference is required")

        nationality = req.form.get('nationality', '').strip().lower()
        if not nationality:
            raise ValueError("Nationality is required")

        gender = req.form.get('gender', '').strip().lower()
        if not gender:
            raise ValueError("Gender is required")

        return email, file, nationality, gender, preferred_positions, location_preference

    def _error_response(self, message, error_detail, status_code):
        response = jsonify({
            "success": False,
            "message": message,
            "error": error_detail
        })
        return make_response(response, status_code)


@resumes_ns.route('/client')
class ClientProfile(Resource):
    @jwt_required
    @resumes_ns.doc(security='Bearer Auth')
    @resumes_ns.response(HTTPStatus.OK.value, 'Successfully retrieved client profile')
    @resumes_ns.response(HTTPStatus.UNAUTHORIZED.value, 'Missing or invalid token')
    @resumes_ns.response(HTTPStatus.NOT_FOUND.value, 'Client profile not found')
    @resumes_ns.response(HTTPStatus.INTERNAL_SERVER_ERROR.value, 'Internal server error')
    def get(self):
        """
        GET endpoint to retrieve an existing client's profile from the AI database.
        """
        try:
            email = getattr(request, 'user_email', None)
            print(f"[CLIENT_PROFILE] GET /client called")
            print(f"[CLIENT_PROFILE] user_email from request: {email!r}")
            print(f"[CLIENT_PROFILE] user_id from request: {getattr(request, 'user_id', None)!r}")

            if not email:
                print("[CLIENT_PROFILE] ❌ No email found on request object")
                return {"success": False, "message": "User email not found in token"}, HTTPStatus.BAD_REQUEST.value

            print(f"[CLIENT_PROFILE] Looking up client data for: {email}")
            client_data = get_client_data(email)
            print(f"[CLIENT_PROFILE] client_data result: {client_data}")

            # Lazy Sync: If AI data is incomplete, try to sync from existing resume
            if client_data and (not client_data.get('nationality') or not client_data.get('gender')):
                user_id = getattr(request, 'user_id', None)
                if user_id:
                    print(f"[CLIENT_PROFILE] AI data incomplete. Triggering lazy sync for {user_id}...")
                    synced = ProfileSyncService.sync_from_user_id(user_id)
                    if synced:
                        print(f"[CLIENT_PROFILE] Lazy sync successful, re-fetching client data")
                        client_data = get_client_data(email)

            if not client_data:
                print(f"[CLIENT_PROFILE] ❌ Error fetching client data for email: {email}")
                return {"success": False, "message": "Failed to fetch client profile from AI database"}, HTTPStatus.INTERNAL_SERVER_ERROR.value

            print(f"[CLIENT_PROFILE] ✅ Successfully returned client data")
            return {
                "success": True,
                "data": client_data
            }, HTTPStatus.OK.value

        except Exception as e:
            import traceback
            print(f"[CLIENT_PROFILE] ❌ Unexpected error: {e}")
            traceback.print_exc()
            return {
                "success": False,
                "message": "Failed to retrieve client data",
                "error": str(e)
            }, HTTPStatus.INTERNAL_SERVER_ERROR.value


activate_job_apply_parser = reqparse.RequestParser()
activate_job_apply_parser.add_argument(
    'email',
    type=str,
    required=True,
    location='form',
    help='Client email address'
)
activate_job_apply_parser.add_argument(
    'jobs_number',
    type=int,
    required=True,
    location='form',
    help='Number of jobs to apply for'
)

def format_cv_from_path(input_path: Path, output_language: str = "regular"):
    """
    Formats a CV from a file path using the same logic as the /format endpoint.
    Returns the final output path (formatted or translated).
    """

    if not input_path.exists():
        raise FileNotFoundError(f"CV file not found: {input_path}")

    # 1. Extract text
    raw_cv_data = extract_text(input_path)
    if not raw_cv_data:
        raise Exception("Failed to extract CV text")

    # 2. Format CV
    formatted_cv = cv_formatter(raw_cv_data)

    # 3. Build output filename (same as endpoint)
    base_name = input_path.stem
    output_filename = f"{formatted_cv.header.name} .docx"
    formatted_path = Config.FORMATTED_FOLDER / output_filename

    # 4. Choose template
    template = (
        Config.ARABIC_TEMPLATE_PATH
        if output_language == "arabic"
        else Config.REGULAR_TEMPLATE_PATH
    )

    # 5. Write formatted document
    formatted_cv.write_document(template, formatted_path)

    # 6. Handle Arabic translation (same flow as endpoint)
    if output_language == "arabic":
        translated_path = Config.TRANSLATED_FOLDER / f"{base_name}_translated.docx"
        translate_docx_to_arabic(formatted_path, translated_path)
        return translated_path

    # 7. Regular output
    return formatted_path


@resumes_ns.route('/activate-job-apply')
class ActivateJobApply(Resource):

    @resumes_ns.expect(activate_job_apply_parser)
    def post(self):
        try:
            args = activate_job_apply_parser.parse_args()
            email = args['email']
            jobs_number = args['jobs_number']

            if jobs_number <= 0:
                raise ValueError("jobs_number must be greater than zero")

            filename = get_client_cv_filename(email)
            if not filename:
                return {"success": False, "message": "Client CV not found"}, 404
            temp_input_path = Config.TEMP_FOLDER / filename
            cv_dir = Config.CV_STORAGE_PATH / "temp_CVs"
            cv_dir_2 = Config.CV_STORAGE_PATH
            original_cv_path = cv_dir / filename
            print(f"original_cv_path: {original_cv_path}")
            if not original_cv_path.exists():
                return {"success": False, "message": "CV file missing on server"}, 404

            # 1 Format CV
            formatted_docx = format_cv_from_path(original_cv_path)

            # 2 Convert to PDF
            pdf_path = convert_docx_to_pdf(formatted_docx)

            final_filename = pdf_path.name
            final_path = cv_dir_2 / final_filename

            # 3 Replace original CV
            shutil.move(pdf_path, final_path)

            # 4 Cleanup temp DOCX
            if formatted_docx.exists():
                formatted_docx.unlink()

            # 5 Update DB
            update_client_cv_filename(email, final_filename)

            # 6 Activate job apply
            activate_client_job_apply(email=email, jobs_number=jobs_number)

            # 7 Return downloadable PDF
            return send_file(
                final_path,
                as_attachment=True,
                download_name=final_filename,
                mimetype="application/pdf"
            )

        except Exception as e:
            return {
                "success": False,
                "message": "Activation failed",
                "error": str(e)
            }, 500




@resumes_ns.route('/<int:job_id>/apply')
class ApplyToSpecificJob(Resource):
    @resumes_ns.expect(apply_specific_parser)
    @resumes_ns.response(HTTPStatus.OK.value, 'Successfully applied to specific job')
    def post(self, job_id):
        """
        POST endpoint to process resume and apply to a specific job.
        """
        temp_input_path = None
        try:
            email, file, nationality, gender, preferred_positions, location_preference = self._validate_and_extract_request(request)

            filename = secure_filename(file.filename)
            temp_input_path = Config.TEMP_FOLDER / filename
            file.save(temp_input_path)

            email = process_ai_job_input(
                email=email,
                resume_path=temp_input_path,
                nationality=nationality,
                gender=gender,
                location_preferred=location_preference,
                preferred_positions=preferred_positions
            )
            if not email:
                raise ValueError("Email not found in the resume. Please provide a valid resume with email address.")

            apply_result = apply_single_job(email=email, file_path=temp_input_path, job_id=job_id)
            if not apply_result:
                raise ValueError(f"Failed to apply for job {job_id}")

            return jsonify({
                "success": True,
                "message": f"Successfully applied to job {job_id}",
                "email": email,
                "applied_job_id": job_id,
                "summary": apply_result
            })

        except ValueError as ve:
            return self._error_response("Invalid input", str(ve), HTTPStatus.BAD_REQUEST.value)
        except Exception as e:
            return self._error_response("Job application failed", str(e), HTTPStatus.INTERNAL_SERVER_ERROR.value)
        finally:
            if temp_input_path and os.path.exists(temp_input_path):
                os.remove(temp_input_path)

    def _validate_and_extract_request(self, req):
        """Validate and extract request parameters"""
        email = req.form.get('email')
        if not email:
            raise ValueError("Missing required field: email")

        if 'file' not in req.files:
            raise ValueError("No file provided")

        file = req.files['file']
        if file.filename == '':
            raise ValueError("No file selected")

        if not allowed_file(file.filename):
            raise ValueError("File type not allowed. Supported types: PDF, DOCX, RTF")

        nationality = req.form.get('nationality', '').strip().lower()
        gender = req.form.get('gender', '').strip().lower()

        return email, file, nationality, gender, [], []

    def _error_response(self, message, error_detail, status_code):
        response = jsonify({
            "success": False,
            "message": message,
            "error": error_detail
        })
        return make_response(response, status_code)



applied_jobs = reqparse.RequestParser()
applied_jobs.add_argument('email', type=str, location='args', required=True, help='User Email')

@resumes_ns.route('/applied-jobs')
class AppliedJobs(Resource):
    @resumes_ns.expect(applied_jobs)
    @resumes_ns.response(HTTPStatus.OK.value, 'Successfully fetched jobs.')
    @resumes_ns.response(HTTPStatus.BAD_REQUEST.value, 'Invalid input')
    @resumes_ns.response(HTTPStatus.INTERNAL_SERVER_ERROR.value, 'Internal server error during processing')
    def get(self):
        """
        GET endpoint to fetch job application rankings for a given email.
        """

        conn = get_ai_db_connection()
        cursor = conn.cursor()
        try:
            args = applied_jobs.parse_args()
            email = args['email']

            query = """
                    SELECT
                        r.job_title, r.job_id, r.status, r.location, r.date, jd.experience, jd.entity AS company
                    FROM rankings r
                    LEFT JOIN jobs jd ON r.job_id::bigint = jd.id
                    WHERE r.email = %s AND r.status='applied'
                    """
            cursor.execute(query, (email,))
            rows = cursor.fetchall()
            if not rows:
                return {
                    "success": True,
                    "message": f"No applied jobs found for {email}",
                    "email": email,
                    "jobs": []
                }, HTTPStatus.OK

            jobs = []

            for row in rows:
                job_title, job_id, status, location, apply_date, experience, company = row

                jobs.append({
                    "job_title": job_title.strip().title() if job_title else "",
                    "job_id": str(job_id).strip() if job_id else "",
                    "status": str(status).strip().lower() if status else "",
                    "location": str(location).strip().title() if location else "",
                    "applied": str(apply_date).strip() if apply_date else "",
                    "experience": str(experience).strip().capitalize() if experience else "",
                    "company": str(company).strip().title() if company else ""
                })

            return {
                "success": True,
                "email": email,
                "message": f"Successfully fetched {len(jobs)} applied jobs",
                "jobs": jobs
            }, HTTPStatus.OK

        except Exception as e:
            return {
                "success": False,
                "message": "An error occurred while processing the request.",
                "error": str(e)
            }, HTTPStatus.INTERNAL_SERVER_ERROR

        finally:
            cursor.close()
            conn.close()


@resumes_ns.route('/jobs')
class Jobs(Resource):
    @resumes_ns.doc(params={
        'email': 'User email to exclude already applied jobs',
        'search': 'Search in job title or description',
        'location': 'Filter by city (e.g. Dubai)',
        'experience': 'Filter by experience (e.g. 2 years)',
        'attendance': 'Match keyword in description (remote, hybrid, onsite)',
        'sort': 'Sort options: job_date_desc | job_date_asc | salary_desc | salary_asc',
        'limit': 'Number of jobs per page (default 15)',
        'page': 'Page number (default 1)',
        'lang': 'Language: en (default) | ar',
    })
    def get(self):
        """
        Get Users Jobs With Searching Functionality.
        """
        conn = get_ai_db_connection()
        cursor = conn.cursor()
        try:
            args = request.args
            
            # DEBUG: Log all received parameters
            print(f"\n{'='*60}")
            print(f"[JOBS_NS] 🔍 RECEIVED REQUEST at {datetime.now().strftime('%H:%M:%S')}")
            print(f"[JOBS_NS] Full args: {dict(args)}")
            print(f"[JOBS_NS] Email param: '{args.get('email', 'NOT PROVIDED')}'")
            print(f"{'='*60}\n")

            # Filters
            email = args.get('email', '').strip()
            search = args.get('search', '').strip()
            location = args.get('location', '').strip()
            experience = args.get('experience', '').strip()
            attendance = args.get('attendance', '').strip().lower()
            
            # Advanced Filters (Lists/Ranges)
            locations = args.getlist('locations') or args.getlist('locations[]')
            job_types = args.getlist('jobTypes') or args.getlist('jobTypes[]')
            experience_levels = args.getlist('experienceLevels') or args.getlist('experienceLevels[]')
            skills = args.getlist('skills') or args.getlist('skills[]')
            
            min_salary = args.get('minSalary', '')
            max_salary = args.get('maxSalary', '')
            min_salary = int(min_salary) if min_salary.isdigit() else None
            max_salary = int(max_salary) if max_salary.isdigit() else None

            sort = args.get('sort', 'job_date_desc')
            language = args.get('lang', 'en').strip().lower()
            _limit = args.get('limit', '')
            _page = args.get('page', '')
            limit = int(_limit) if (_limit.isdigit() and int(_limit) > 0) else 15
            page = int(_page) if _page.isdigit() and int(_page) > 0 else 1
            offset = (page - 1) * limit
            
            # Validate language parameter
            if language not in ['en', 'ar']:
                language = 'en'

            # WHERE clauses
            where_clauses = []
            params = []
            where_clauses.append("NULLIF(job_date, 'Nan')::date >= (CURRENT_DATE - INTERVAL '2 months')")

            client_id = None
            if email:
                cursor.execute("SELECT id FROM clients WHERE email = %s", (email,))
                client_row = cursor.fetchone()
                if client_row:
                    client_id = str(client_row[0])
            
            # Emirates city filter (default) - works for both languages
            # Only apply if no explicit location filters are provided
            if not location and not locations:
                emirates = [
                    'abu dhabi', 'dubai', 'sharjah', 'ajman',
                    'umm al quwain', 'ras al khaimah', 'fujairah'
                ]
                if language == 'ar':
                    city_clauses = ["LOWER(COALESCE(vacancy_city_ar, vacancy_city)) ILIKE %s" for _ in emirates]
                else:
                    city_clauses = ["LOWER(vacancy_city) ILIKE %s" for _ in emirates]
                where_clauses.append("(" + " OR ".join(city_clauses) + ")")
                params.extend([f"%{city}%" for city in emirates])

            # Search functionality - language specific
            if search:
                if language == 'ar':
                    where_clauses.append("""
                        (LOWER(COALESCE(job_title_ar, job_title)) ILIKE %s 
                         OR LOWER(COALESCE(job_description_ar, job_description)) ILIKE %s)
                    """)
                else:
                    where_clauses.append("(LOWER(job_title) ILIKE %s OR LOWER(job_description) ILIKE %s)")
                params.extend([f"%{search.lower()}%"] * 2)

            # Location filter - single and list
            if location:
                if language == 'ar':
                    where_clauses.append("LOWER(COALESCE(vacancy_city_ar, vacancy_city)) = LOWER(%s)")
                else:
                    where_clauses.append("LOWER(vacancy_city) = LOWER(%s)")
                params.append(location)
            elif locations:
                placeholders = ', '.join(['LOWER(%s)'] * len(locations))
                if language == 'ar':
                    where_clauses.append(f"LOWER(COALESCE(vacancy_city_ar, vacancy_city)) IN ({placeholders})")
                else:
                    where_clauses.append(f"LOWER(vacancy_city) IN ({placeholders})")
                params.extend(locations)

            # Experience filter - single and list
            if experience:
                if language == 'ar':
                    where_clauses.append("LOWER(COALESCE(experience_ar, experience)) = LOWER(%s)")
                else:
                    where_clauses.append("LOWER(experience) = LOWER(%s)")
                params.append(experience)
            elif experience_levels:
                placeholders = ', '.join(['LOWER(%s)'] * len(experience_levels))
                if language == 'ar':
                    where_clauses.append(f"LOWER(COALESCE(experience_ar, experience)) IN ({placeholders})")
                else:
                    where_clauses.append(f"LOWER(experience) IN ({placeholders})")
                params.extend(experience_levels)

            # Job Type / Attendance filter
            if attendance:
                if language == 'ar':
                    where_clauses.append("LOWER(COALESCE(job_description_ar, job_description)) LIKE %s")
                else:
                    where_clauses.append("LOWER(job_description) LIKE %s")
                params.append(f"%{attendance}%")
            elif job_types:
                type_clauses = []
                for jtype in job_types:
                    if language == 'ar':
                        type_clauses.append("LOWER(COALESCE(job_description_ar, job_description)) LIKE %s")
                    else:
                        type_clauses.append("LOWER(job_description) LIKE %s")
                    params.append(f"%{jtype.lower()}%")
                where_clauses.append("(" + " OR ".join(type_clauses) + ")")

            # Skills filter
            if skills:
                skill_clauses = []
                for skill in skills:
                    if language == 'ar':
                        skill_clauses.append("LOWER(COALESCE(job_description_ar, job_description)) LIKE %s")
                    else:
                        skill_clauses.append("LOWER(job_description) LIKE %s")
                    params.append(f"%{skill.lower()}%")
                where_clauses.append("(" + " OR ".join(skill_clauses) + ")")

            # Salary range filter
            if min_salary is not None:
                if language == 'ar':
                    where_clauses.append("NULLIF(substring(COALESCE(salary_ar, salary) from '\\d+'), '')::bigint >= %s")
                else:
                    where_clauses.append("NULLIF(substring(salary from '\\d+'), '')::bigint >= %s")
                params.append(min_salary)
            
            if max_salary is not None:
                if language == 'ar':
                    where_clauses.append("NULLIF(substring(COALESCE(salary_ar, salary) from '\\d+'), '')::bigint <= %s")
                else:
                    where_clauses.append("NULLIF(substring(salary from '\\d+'), '')::bigint <= %s")
                params.append(max_salary)
            
            if where_clauses:
                where_sql = f"WHERE {' AND '.join(where_clauses)}"
                if client_id:
                    where_sql += f" AND jobs.id::text NOT IN (SELECT job_id FROM rankings WHERE client_id = %s)"
                    params.append(client_id)
            else:
                if client_id:
                    where_sql = f"WHERE jobs.id::text NOT IN (SELECT job_id FROM rankings WHERE client_id = %s)"
                    params.append(client_id)
                else:
                    where_sql = ""

            # Sorting logic - language specific
            if sort == 'job_date_asc':
                order_sql = "ORDER BY NULLIF(job_date, 'Nan')::date ASC"
            elif sort == 'salary_desc':
                if language == 'ar':
                    order_sql = "ORDER BY NULLIF(substring(COALESCE(salary_ar, salary) from '\\d+'), '')::bigint DESC"
                else:
                    order_sql = "ORDER BY NULLIF(substring(salary from '\\d+'), '')::bigint DESC"
            elif sort == 'salary_asc':
                if language == 'ar':
                    order_sql = "ORDER BY NULLIF(substring(COALESCE(salary_ar, salary) from '\\d+'), '')::bigint ASC"
                else:
                    order_sql = "ORDER BY NULLIF(substring(salary from '\\d+'), '')::bigint ASC"
            else:
                order_sql = "ORDER BY NULLIF(job_date, 'Nan')::date DESC"

            
            # Get total count
            count_query = f"SELECT COUNT(*) FROM jobs {where_sql}"
            cursor.execute(count_query, tuple(params))
            total_count = cursor.fetchone()[0]

            # Build SELECT query based on language
            if language == 'ar':
                select_fields = """
                    id, entity, nationality, gender,
                    COALESCE(job_title_ar, job_title) as job_title,
                    COALESCE(job_description_ar, job_description) as job_description,
                    COALESCE(academic_qualification_ar, academic_qualification) as academic_qualification,
                    COALESCE(experience_ar, experience) as experience,
                    COALESCE(languages_ar, languages) as languages,
                    COALESCE(salary_ar, salary) as salary,
                    COALESCE(vacancy_city_ar, vacancy_city) as vacancy_city,
                    COALESCE(working_hours_ar, working_hours) as working_hours,
                    COALESCE(working_days_ar, working_days) as working_days,
                    application_email, job_date, phone, source, apply_url,
                    COALESCE(company_name_ar, company_name) as entity,
                    COALESCE(company_name_ar, company_name) as company_name,
                    website_url, job_type, translation_status
                """
            else:
                select_fields = """
                    id, entity, nationality, gender,
                    job_title,
                    job_description,
                    academic_qualification,
                    experience,
                    languages,
                    salary,
                    vacancy_city,
                    working_hours,
                    working_days,
                    application_email, job_date, phone, source, apply_url,
                    company_name,
                    entity,
                    website_url, job_type, translation_status
                """

            query = f"""
                SELECT {select_fields}
                FROM jobs
                {where_sql}
                {order_sql}
                LIMIT %s OFFSET %s
            """

            cursor.execute(query, (*params, limit, offset))
            columns = [desc[0] for desc in cursor.description]
            rows = cursor.fetchall()
            jobs = [dict(zip(columns, row)) for row in rows]

            # On-demand translation for current page (Arabic only)
            if language == 'ar' and jobs:
                try:
                    ids_to_translate = [j['id'] for j in jobs if (j.get('translation_status') or '').lower() != 'completed']
                    if ids_to_translate:
                        from app.services.job_translation_worker import translate_job_now
                        for jid in ids_to_translate:
                            try:
                                translate_job_now(jid)
                            except Exception:
                                pass

                        # Re-fetch translated jobs and merge
                        placeholders = ','.join(['%s'] * len(ids_to_translate))
                        refetch_query = f"""
                            SELECT {select_fields}
                            FROM jobs
                            WHERE id IN ({placeholders})
                        """
                        cursor.execute(refetch_query, tuple(ids_to_translate))
                        refetch_columns = [desc[0] for desc in cursor.description]
                        refetched = [dict(zip(refetch_columns, r)) for r in cursor.fetchall()]
                        id_to_job = {j['id']: j for j in refetched}
                        for idx, job in enumerate(jobs):
                            updated = id_to_job.get(job['id'])
                            if updated:
                                jobs[idx] = updated
                except Exception:
                    # If anything fails, proceed with existing data
                    pass

            # Normalize IDs and convert datetime objects to strings
            for job in jobs:
                if 'id' in job:
                    job['id'] = str(job['id'])
                for key, value in job.items():
                    if hasattr(value, 'isoformat'):
                        job[key] = value.isoformat()
                        
            # --- SAVED JOBS & MATCHING LOGIC ---
            saved_job_ids = set()
            match_profile = None
            if email:
                try:
                    print(f"[JOBS_NS] ========== MATCHING DEBUG START ==========")
                    print(f"[JOBS_NS] Email: {email}")
                    
                    user_row = execute_query('SELECT id FROM users WHERE email = %s', (email,), fetch_one=True)
                    if user_row:
                        user_id = user_row['id'] if isinstance(user_row, dict) else user_row[0]
                        print(f"[JOBS_NS] User ID: {user_id}")

                        # 1. Fetch Saved Jobs
                        saved_entries = execute_query('SELECT "jobId" FROM "SavedJobPost" WHERE "userId" = %s', (user_id,), fetch_all=True)
                        if saved_entries:
                            saved_job_ids = {str(sj['jobId'] if isinstance(sj, dict) else sj[0]) for sj in saved_entries}
                            print(f"[JOBS_NS] Saved jobs count: {len(saved_job_ids)}")

                        # 2. Fetch Profile for Matching
                        profile = execute_query(
                            '''SELECT cp."jobType", cp.skills, cp.location
                               FROM "Candidate" c
                               JOIN "CandidateProfile" cp ON cp."candidateId" = c.id
                               WHERE c."userId" = %s''',
                            (user_id,), fetch_one=True
                        )
                        
                        print(f"[JOBS_NS] CandidateProfile query result: {profile}")
                        
                        # Fallback: If CandidateProfile is empty, try AI DB clients table
                        if not profile or (not profile.get('skills') and not profile.get('jobType')):
                            print(f"[JOBS_NS] CandidateProfile empty for user {user_id}, trying AI DB clients table...")
                            client_profile = execute_ai_query(
                                'SELECT positions, skills, location FROM clients WHERE email = %s',
                                (email,), fetch_one=True
                            )
                            print(f"[JOBS_NS] AI DB clients query result: {client_profile}")
                            if client_profile:
                                print(f"[JOBS_NS] ✅ Found profile in AI DB clients table")
                                profile = {
                                    "jobType": client_profile.get('positions') or "",
                                    "skills": client_profile.get('skills') or "",
                                    "location": client_profile.get('location') or ""
                                }
                        
                        if profile:
                            skills_list = profile.get('skills') or []
                            skills_str = ", ".join(skills_list) if isinstance(skills_list, list) else str(skills_list)
                            match_profile = {
                                "positions": profile.get('jobType') or "",
                                "skills": skills_str,
                                "location": profile.get('location') or ""
                            }
                            print(f"[JOBS_NS] Match profile loaded:")
                            print(f"[JOBS_NS]   - positions: '{match_profile['positions']}'")
                            print(f"[JOBS_NS]   - skills_count: {len(skills_list) if isinstance(skills_list, list) else 0}")
                            print(f"[JOBS_NS]   - skills: '{skills_str[:100]}...'")
                            print(f"[JOBS_NS]   - location: '{match_profile['location']}'")
                        else:
                            print(f"[JOBS_NS] ⚠️ NO PROFILE FOUND for user {user_id} in either database")
                            print(f"[JOBS_NS] This means the user hasn't uploaded a CV or synced their profile yet")
                    else:
                        print(f"[JOBS_NS] ⚠️ User not found for email: {email}")
                    
                    print(f"[JOBS_NS] ========== MATCHING DEBUG END ==========")
                except Exception as e:
                    print(f"[JOBS_NS] ❌ Error fetching user context for jobs list: {e}")
                    import traceback
                    traceback.print_exc()

            for job in jobs:
                job['is_saved'] = str(job['id']) in saved_job_ids

                # AI Matching Calculation
                if match_profile:
                    try:
                        title_score = title_position_match(job.get('job_title', ''), match_profile['positions'])
                        # Use job_description for skills matching (don't delete it yet!)
                        job_desc = job.get('job_description') or ''
                        print(f"[JOBS_NS] Job {job.get('id')}: title='{job.get('job_title')}', desc_len={len(job_desc)}, city='{job.get('vacancy_city')}'")
                        print(f"[JOBS_NS]   Profile: positions='{match_profile['positions']}', skills='{match_profile['skills']}', location='{match_profile['location']}'")
                        
                        skill_score = calculate_skills_match(job_desc if job_desc else job.get('job_title', ''), match_profile['skills'])
                        location_score = semantic_location_match(job.get('vacancy_city', ''), match_profile['location'])

                        final_score = round((0.4 * title_score + 0.4 * skill_score + 0.2 * location_score), 3)
                        job['match_percentage'] = str(int(round(final_score * 100, 0)))
                        print(f"[JOBS_NS]   Scores: T={title_score:.3f}, S={skill_score:.3f}, L={location_score:.3f} => {job['match_percentage']}%")
                    except Exception as e:
                        print(f"[JOBS_NS] Match calc error for job {job.get('id')}: {e}")
                        job['match_percentage'] = None  # Return null instead of '0' when matching fails
                else:
                    # Don't include match_percentage field when no profile is available
                    # This allows frontend to use default "50% Match" or show "N/A"
                    job['match_percentage'] = None

                # Clean up description to keep response slim
                # Frontend only needs description in details view
                if 'job_description' in job:
                    del job['job_description']

            return {
                "success": True,
                "jobs": jobs,
                "pagination": {
                    "total": total_count,
                    "page": page,
                    "limit": limit,
                    "pages": ceil(total_count / limit)
                }   
            }, HTTPStatus.OK

        except Exception as e:
            return {
                "success": False,
                "message": "Error retrieving jobs",
                "error": str(e)
            }, HTTPStatus.INTERNAL_SERVER_ERROR
        finally:
            cursor.close()
            conn.close()

    @resumes_ns.expect(resumes_ns.model('JobCreate', {
        'entity': fields.String(description='Entity'),
        'nationality': fields.String(description='Nationality'),
        'gender': fields.String(description='Gender'),
        'job_title': fields.String(required=True, description='Job title'),
        'academic_qualification': fields.String(description='Academic qualification'),
        'experience': fields.String(description='Experience'),
        'languages': fields.String(description='Languages'),
        'salary': fields.String(description='Salary'),
        'vacancy_city': fields.String(description='Vacancy city'),
        'working_hours': fields.String(description='Working hours'),
        'working_days': fields.String(description='Working days'),
        'application_email': fields.String(description='Application email'),
        'job_description': fields.String(description='Job description'),
        'job_date': fields.String(required=True, description='Job posting date YYYY-MM-DD'),
        'phone': fields.String(description='Phone'),
        'apply_url': fields.String(description='apply_url (previously link)'),
        'company_name': fields.String(description='Company Name'),
        'website_url': fields.String(description='Webste Url'),
        'job_type': fields.String(description='Job Type'),
    }))
    def post(self):
        """
        Create a JOb with Source Admin.:
        """
        conn = get_ai_db_connection()
        cursor = conn.cursor()
        try:
            data = request.get_json(force=True)

            required_fields = ['job_title', 'job_date', 'entity', 'gender', 'job_description']
            for field in required_fields:
                if field not in data or not data[field]:
                    return {"success": False, "message": f"Missing required field: {field}"}, HTTPStatus.BAD_REQUEST

            date_pattern = re.compile(r'^\d{4}-\d{2}-\d{2}$')
            job_date = data.get('job_date')
            if not date_pattern.match(job_date):
                return {
                    "success": False,
                    "message": "Invalid job_date format. Expected format is YYYY-MM-DD."
                }, HTTPStatus.BAD_REQUEST

            query = """
                INSERT INTO jobs
                (entity, nationality, gender, job_title, academic_qualification, experience, languages,
                salary, vacancy_city, working_hours, working_days, application_email, job_description,
                job_date, phone, source, apply_url, company_name, website_url, job_type, translation_status)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                RETURNING id
            """
            cursor.execute(query, (
                data.get('entity'),
                data.get('nationality'),
                data.get('gender'),
                data.get('job_title'),
                data.get('academic_qualification'),
                data.get('experience'),
                data.get('languages'),
                data.get('salary'),
                data.get('vacancy_city'),
                data.get('working_hours'),
                data.get('working_days'),
                data.get('application_email'),
                data.get('job_description'),
                data.get('job_date'),
                data.get('phone'),
                data.get('source'),
                data.get('apply_url'),
                data.get('company_name'),
                data.get('website_url'),
                data.get('job_type'),
                'pending',  # translation_status
            ))

            new_id = cursor.fetchone()[0]
            conn.commit()

            # Trigger translation for the new job (async)
            try:
                from app.services.job_translation_worker import translate_job_now
                # Run translation in background thread
                import threading
                threading.Thread(
                    target=translate_job_now, 
                    args=(new_id,), 
                    daemon=True
                ).start()
            except Exception as e:
                # Log error but don't fail the job creation
                print(f"Failed to trigger translation for job {new_id}: {e}")

            return {
                "success": True,
                "message": "Job created successfully",
                "job_id": new_id
            }, HTTPStatus.CREATED

        except Exception as e:
            conn.rollback()
            return {
                "success": False,
                "message": "Failed to create job",
                "error": str(e)
            }, HTTPStatus.INTERNAL_SERVER_ERROR

        finally:
            cursor.close()
            conn.close()


job_update_model = resumes_ns.model('JobUpdate', {
    'entity': fields.String(required=False),
    'nationality': fields.String(required=False),
    'gender': fields.String(required=False),
    'job_title': fields.String(required=False),
    'academic_qualification': fields.String(required=False),
    'experience': fields.String(required=False),
    'languages': fields.String(required=False),
    'salary': fields.String(required=False),
    'vacancy_city': fields.String(required=False),
    'working_hours': fields.String(required=False),
    'working_days': fields.String(required=False),
    'application_email': fields.String(required=False),
    'job_description': fields.String(required=False),
    'job_date': fields.String(required=False, description="Format: YYYY-MM-DD"),
    'apply_url': fields.String(required=False),
    'phone': fields.String(required=False),
    'source': fields.String(required=False),
    'company_name': fields.String(required=False),
    'website_url': fields.String(required=False),
    'job_type': fields.String(required=False),
})

@resumes_ns.route('/jobs/<int:job_id>')
class JobById(Resource):
    @resumes_ns.doc(params={
        'job_id': 'ID of the job to retrieve',
        'lang': 'Language: en (default) | ar'
    })
    def get(self, job_id):
        """
        Get a specific Job by JobId. (for Liked Section handling)
        """
        conn = get_ai_db_connection()
        cursor = conn.cursor()
        try:
            # Get language parameter
            language = request.args.get('lang', 'en').strip().lower()
            if language not in ['en', 'ar']:
                language = 'en'
            
            # Build query based on language
            if language == 'ar':
                select_query_ar = """
                    SELECT id, entity, nationality, gender,
                           COALESCE(job_title_ar, job_title) as job_title,
                           COALESCE(job_description_ar, job_description) as job_description,
                           COALESCE(academic_qualification_ar, academic_qualification) as academic_qualification,
                           COALESCE(experience_ar, experience) as experience,
                           COALESCE(languages_ar, languages) as languages,
                           COALESCE(salary_ar, salary) as salary,
                           COALESCE(vacancy_city_ar, vacancy_city) as vacancy_city,
                           COALESCE(working_hours_ar, working_hours) as working_hours,
                           COALESCE(working_days_ar, working_days) as working_days,
                           application_email, job_date, phone, source, apply_url,
                           COALESCE(company_name_ar, company_name) as company_name,
                           website_url, job_type, translation_status
                    FROM jobs WHERE id = %s
                """
                cursor.execute(select_query_ar, (job_id,))
                row = cursor.fetchone()
                if not row:
                    return {
                        "success": False,
                        "message": f"No job found with id {job_id}"
                    }, HTTPStatus.NOT_FOUND
                columns = [desc[0] for desc in cursor.description]
                job = dict(zip(columns, row))

                # If Arabic is requested and translation not completed, translate immediately then refetch
                if (job.get('translation_status') or '').lower() != 'completed':
                    try:
                        from app.services.job_translation_worker import translate_job_now
                        did_translate = translate_job_now(job_id)
                        if did_translate:
                            cursor.execute(select_query_ar, (job_id,))
                            row = cursor.fetchone()
                            columns = [desc[0] for desc in cursor.description]
                            job = dict(zip(columns, row))
                    except Exception:
                        # If translation fails, we still return available data
                        pass
            else:
                select_query_en = """
                    SELECT id, entity, nationality, gender,
                           job_title,
                           job_description,
                           academic_qualification,
                           experience,
                           languages,
                           salary,
                           vacancy_city,
                           working_hours,
                           working_days,
                           application_email, job_date, phone, source, apply_url,
                           company_name,
                           website_url, job_type, translation_status
                    FROM jobs WHERE id = %s
                """
                cursor.execute(select_query_en, (job_id,))
                row = cursor.fetchone()
                if not row:
                    return {
                        "success": False,
                        "message": f"No job found with id {job_id}"
                    }, HTTPStatus.NOT_FOUND
                columns = [desc[0] for desc in cursor.description]
                job = dict(zip(columns, row))

            if not row:
                return {
                    "success": False,
                    "message": f"No job found with id {job_id}"
                }, HTTPStatus.NOT_FOUND

            # --- MATCH SCORE LOGIC ---
            email = request.args.get('email')
            if email:
                try:
                    # Fetch profile from main DB instead of AI DB
                    profile_row = execute_query("""
                        SELECT cp."jobType", cp.skills, cp.location 
                        FROM "CandidateProfile" cp
                        JOIN "Candidate" c ON cp."candidateId" = c.id
                        JOIN users u ON c."userId" = u.id
                        WHERE u.email = %s
                    """, (email,), fetch_one=True)

                    if profile_row:
                        if isinstance(profile_row, dict):
                            skills = profile_row.get('skills')
                            skills_str = ", ".join(skills) if isinstance(skills, list) else (skills or "")
                            match_profile = {
                                "positions": profile_row.get('jobType') or "",
                                "skills": skills_str,
                                "location": profile_row.get('location') or ""
                            }
                        else:
                            skills = profile_row[1]
                            skills_str = ", ".join(skills) if isinstance(skills, list) else (skills or "")
                            match_profile = {
                                "positions": profile_row[0] or "",
                                "skills": skills_str,
                                "location": profile_row[2] or ""
                            }

                        from app.services.job_apply.ai_matching import title_position_match, calculate_skills_match, semantic_location_match
                        title_score = title_position_match(job.get('job_title', ''), match_profile['positions'])
                        skill_score = calculate_skills_match(job.get('job_description', ''), match_profile['skills'])
                        location_score = semantic_location_match(job.get('vacancy_city', ''), match_profile['location'])
                        final_score = round((0.4 * title_score + 0.4 * skill_score + 0.2 * location_score), 3)
                        job['match_percentage'] = str(int(round(final_score * 100, 0)))
                except Exception as e:
                    print(f"[JOBS_NS] Error calculating match for job details from main DB: {e}")

            return {
                "success": True,
                "job": job,
                "language": language
            }, HTTPStatus.OK

        except Exception as e:
            return {
                "success": False,
                "message": "Error retrieving job",
                "error": str(e)
            }, HTTPStatus.INTERNAL_SERVER_ERROR
        finally:
            cursor.close()
            conn.close()
    
    @resumes_ns.doc(params={'job_id': 'ID of the job to edit'})
    @resumes_ns.expect(job_update_model, validate=True)
    def put(self, job_id):
        """
        Edit a specific Job by JobId.
        """
        conn = get_ai_db_connection()
        cursor = conn.cursor()
        try:
            data = request.json
            if not data:
                return {
                    "success": False,
                    "message": "No input data provided"
                }, HTTPStatus.BAD_REQUEST

            allowed_fields = [
                'entity', 'nationality', 'gender', 'job_title', 'academic_qualification', 'experience', 'languages',
                'salary', 'vacancy_city', 'working_hours', 'working_days', 'application_email', 'job_description',
                'job_date', 'phone', 'source', 'apply_url', 'company_name', 'website_url', 'job_type'
            ]

            fields_to_update = {}
            for key, value in data.items():
                if key in allowed_fields:
                    if not isinstance(value, str):
                        return {
                            "success": False,
                            "message": f"Invalid type for field '{key}'; expected string"
                        }, HTTPStatus.BAD_REQUEST

                    if key == 'job_date':
                        try:
                            datetime.strptime(value, "%Y-%m-%d")
                        except ValueError:
                            return {
                                "success": False,
                                "message": "Invalid date format for 'job_date'; expected YYYY-MM-DD"
                            }, HTTPStatus.BAD_REQUEST

                    fields_to_update[key] = value

            if not fields_to_update:
                return {
                    "success": False,
                    "message": "No valid fields provided to update"
                }, HTTPStatus.BAD_REQUEST

            set_clause = ', '.join(f"{key} = %s" for key in fields_to_update)
            values = list(fields_to_update.values()) + [job_id]

            query = f"UPDATE jobs SET {set_clause} WHERE id = %s"
            cursor.execute(query, values)
            conn.commit()

            if cursor.rowcount == 0:
                return {
                    "success": False,
                    "message": f"No job found with id {job_id}"
                }, HTTPStatus.NOT_FOUND

            return {
                "success": True,
                "message": "Job updated successfully"
            }, HTTPStatus.OK

        except Exception as e:
            return {
                "success": False,
                "message": "Error updating job",
                "error": str(e)
            }, HTTPStatus.INTERNAL_SERVER_ERROR
        finally:
            cursor.close()
            conn.close()


email_model = resumes_ns.model('EmailModel', {
    'email': fields.String(required=True, description="Applicant's email")
})
@resumes_ns.route('/applied-jobs-count')
class AppliedJobsCount(Resource):
    @resumes_ns.expect(email_model, validate=True)
    def post(self):
        """
        Get number of jobs applied by email (count of unique job_id entries)
        """
        data = request.json
        email = data.get('email')

        if not email:
            return {
                "success": False,
                "message": "Email is required"
            }, HTTPStatus.BAD_REQUEST

        conn = get_ai_db_connection()
        cursor = conn.cursor()
        try:
            query = """
                SELECT COUNT(DISTINCT job_id) 
                FROM rankings 
                WHERE email = %s AND status='applied'
            """
            cursor.execute(query, (email,))
            result = cursor.fetchone()
            job_count = result[0] if result else 0

            return {
                "success": True,
                "email": email,
                "applied_jobs_count": job_count
            }, HTTPStatus.OK

        except Exception as e:
            return {
                "success": False,
                "message": "Error retrieving applied jobs count",
                "error": str(e)
            }, HTTPStatus.INTERNAL_SERVER_ERROR

        finally:
            cursor.close()
            conn.close()


send_email_model = resumes_ns.model('SendEmailModel', {
    'recipient_email': fields.String(required=True, description='Recipient email address'),
    'recipient_name': fields.String(required=True, description='Recipient name'),
    'payment_intent_id': fields.String(required=True, description='Stripe Payment Intent ID')
})
@resumes_ns.route('/send-linkedin-email')
class SendEmail(Resource):
    @resumes_ns.expect(send_email_model, validate=True)
    def post(self):
        """
        Send career onboarding email to a candidate after verified payment.
        """
        data = request.json
        recipient_email = data.get('recipient_email')
        recipient_name = data.get('recipient_name')
        payment_intent_id = data.get('payment_intent_id')
        
        # Determine userId from email if possible, or use a default/session
        # In this context, we assume the user is authenticated (handled by middleware)
        user_id = getattr(request, 'user_id', None)

        if not recipient_email or not recipient_name or not payment_intent_id:
            return {
                "success": False,
                "message": "Required data missing (email, name, or payment_intent_id)"
            }, HTTPStatus.BAD_REQUEST

        # --- PAYMENT VERIFICATION ---
        conn = get_ai_db_connection()
        cursor = conn.cursor()
        try:
            # 1. Fetch PaymentIntent status from Stripe
            try:
                intent = stripe.PaymentIntent.retrieve(payment_intent_id)
            except Exception as e:
                return {"success": False, "message": f"Stripe Error: {str(e)}"}, HTTPStatus.BAD_REQUEST

            # 2. Basic Security Checks
            if intent.status != 'succeeded':
                return {"success": False, "message": f"Payment not completed ({intent.status})"}, HTTPStatus.PAYMENT_REQUIRED
            
            # Verify Service/Metadata
            stripe_service_id = intent.metadata.get('serviceId')
            if stripe_service_id != 'ai-linkedin-enhancement':
                return {"success": False, "message": "Payment is not for LinkedIn Enhancement"}, HTTPStatus.FORBIDDEN
            
            # Verify Price (19.00 AED = 1900 cents)
            if intent.amount_received != 1900:
                logger.warning(f"Price mismatch: Received {intent.amount_received} instead of 1900")
                return {"success": False, "message": "Payment amount verification failed"}, HTTPStatus.FORBIDDEN

            # 3. Check Idempotency (Prevent double use of payment)
            cursor.execute('SELECT id FROM "Payment" WHERE "transactionId" = %s', (payment_intent_id,))
            if cursor.fetchone():
                return {"success": False, "message": "This payment has already been used"}, HTTPStatus.CONFLICT

            # 4. Atomic Execution: Record Payment + Send Email
            # Insert Payment Record
            payment_id = f"pay_{uuid.uuid4().hex[:12]}"
            cursor.execute(
                """
                INSERT INTO "Payment" 
                (id, amount, currency, status, "paymentMethod", "transactionId", "paymentDate", "userId", "createdAt", "updatedAt") 
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                """,
                (
                    payment_id, 19.0, 'AED', 'COMPLETED', 'stripe', 
                    payment_intent_id, datetime.now(), user_id, 
                    datetime.now(), datetime.now()
                )
            )

            # Send Email
            send_email(recipient_email, recipient_name)

            conn.commit()
            return {
                "success": True,
                "message": f"Payment verified. Email successfully sent to {recipient_email}",
                "payment_id": payment_id
            }, HTTPStatus.OK

        except Exception as e:
            conn.rollback()
            logger.error(f"LinkedIn Enhancement Payment Error: {str(e)}")
            return {
                "success": False,
                "message": "Internal error processing payment/email",
                "error": str(e)
            }, HTTPStatus.INTERNAL_SERVER_ERROR
        finally:
            cursor.close()
            conn.close()


@resumes_ns.route('/jobs/monthly-count')
class JobsMonthlyCount(Resource):
    @resumes_ns.doc(params={
        'keyword': 'Keyword to match in job description',
    })
    def get(self):
        """
        Get monthly job counts for the last 12 months for a given keyword.
        """
        conn = get_ai_db_connection()
        cursor = conn.cursor()
        try:
            keyword = request.args.get('keyword', '').strip().lower()
            if not keyword:
                return {"success": False, "message": "Keyword is required"}, HTTPStatus.BAD_REQUEST

            # end_date = datetime.today().replace(day=1)
            first_day_current_month = datetime.today().replace(day=1)
            end_date = first_day_current_month + relativedelta(months=1)

            start_date = (end_date - timedelta(days=365)).replace(day=1)

            query = """
                SELECT TO_CHAR(TO_DATE(job_date, 'YYYY-MM-DD'), 'YYYY-MM') AS month,
                       COUNT(*) as count
                FROM jobs
                WHERE LOWER(job_description) LIKE %s
                  AND TO_DATE(job_date, 'YYYY-MM-DD') >= %s
                  AND TO_DATE(job_date, 'YYYY-MM-DD') < %s
                GROUP BY month
                ORDER BY month;
            """

            like_pattern = f"%{keyword}%"
            cursor.execute(query, (like_pattern, start_date, end_date))

            raw_result = dict(cursor.fetchall())

            result = []
            current = start_date
            while current < end_date:
                key = current.strftime("%Y-%m")
                result.append({
                    "month": key,
                    "count": raw_result.get(key, 0)
                })
                current = (current + relativedelta(months=1))

            return {
                "success": True,
                "data": result
            }, HTTPStatus.OK

        except Exception as e:
            return {
                "success": False,
                "message": "Error fetching job counts",
                "error": str(e)
            }, HTTPStatus.INTERNAL_SERVER_ERROR
        finally:
            cursor.close()
            conn.close()


@resumes_ns.route('/jobs/count-by-city')
class JobsCountByCity(Resource):
    @resumes_ns.doc(params={
        'job_title': 'Keyword to match in job title (case-insensitive, partial match)'
    })
    def get(self):
        """
        Get counts of jobs grouped by vacancy_city for a given job title keyword.
        """
        conn = get_ai_db_connection()
        cursor = conn.cursor()
        try:
            keyword = request.args.get('keyword', request.args.get('job_title', '')).strip().lower()

            if not keyword:
                query = """
                    SELECT vacancy_city,
                           COUNT(*) as count
                    FROM jobs
                    GROUP BY vacancy_city
                    ORDER BY count DESC;
                """
                cursor.execute(query)
            else:
                query = """
                    SELECT vacancy_city,
                           COUNT(*) as count
                    FROM jobs
                    WHERE LOWER(job_title) LIKE %s
                    GROUP BY vacancy_city
                    ORDER BY count DESC;
                """
                like_pattern = f"%{keyword}%"
                cursor.execute(query, (like_pattern,))

            rows = cursor.fetchall()
            result = []
            for vacancy_city, count in rows:
                result.append({
                    "vacancy_city": vacancy_city if vacancy_city else "Unknown",
                    "count": count
                })

            return {
                "success": True,
                "data": result
            }, HTTPStatus.OK

        except Exception as e:
            return {
                "success": False,
                "message": "Error fetching job counts by city",
                "error": str(e)
            }, HTTPStatus.INTERNAL_SERVER_ERROR
        finally:
            cursor.close()
            conn.close()


@resumes_ns.route('/jobs/match')
class MatchedJobs(Resource):
    @resumes_ns.doc(params={
        'email': 'User email to match jobs against their profile',
        'limit': 'Number of jobs per page (default 15)',
        'page': 'Page number (default 1)',
    })
    def get(self):
        """
        Return jobs ranked by semantic match to user's profile
        """
        conn = get_ai_db_connection()
        cursor = conn.cursor()
        try:
            args = request.args
            email = args.get('email')
            if not email:
                return {"success": False, "message": "Email is required"}, 400

            limit = int(args.get('limit', 15))
            page = int(args.get('page', 1))
            offset = (page - 1) * limit

            # Fetch user profile
            cursor.execute("SELECT positions, skills, location FROM clients WHERE email = %s", (email,))
            profile_row = cursor.fetchone()
            if not profile_row:
                return {"success": False, "message": "User not found in Client."}, 404

            user_profile = {
                "positions": profile_row[0] or "",
                "skills": profile_row[1] or "",
                "location": profile_row[2] or ""
            }

            # Use top position term as a light filter keyword
            filter_term = user_profile["positions"].split(",")[0].strip().lower() if user_profile["positions"] else ""
            search_filter = f"%{filter_term}%"

            # Fetch recent jobs excluding already applied ones with light filtering
            cursor.execute("""
               SELECT *
               FROM jobs
               WHERE id::text NOT IN (
                    SELECT job_id FROM rankings WHERE client_id = (
                        SELECT id::text FROM clients WHERE email = %s
                   )
                   )
                 AND (
                   LOWER (job_title) ILIKE %s
                  OR
                   LOWER (job_description) ILIKE %s
                  OR
                   LOWER (vacancy_city) ILIKE %s
                   )
               ORDER BY NULLIF (job_date, 'Nan'):: date DESC
                   LIMIT 300
               """, (email, search_filter, search_filter, search_filter))

            columns = [desc[0] for desc in cursor.description]
            jobs = []
            for row in cursor.fetchall():
                job = dict(zip(columns, row))
                for key, val in job.items():
                    if isinstance(val, datetime):
                        job[key] = val.isoformat()
                jobs.append(job)
            print(f"Filter term for semantic match: '{filter_term}'")
            print(f"Filtered Jobs Before Scoring: {len(jobs)}")

            # Score and rank jobs
            for job in jobs:
                # Standardize aliases for mobile model compatibility
                job['entity'] = job.get('company_name', '')
                job['job_title'] = job.get('job_title', '') or job.get('title', '')
                job['vacancy_city'] = job.get('vacancy_city', '') or job.get('location', '')
                
                title_score = title_position_match(job['job_title'], user_profile['positions'])
                skill_score = calculate_skills_match(job['job_description'], user_profile['skills'])
                location_score = semantic_location_match(job['vacancy_city'], user_profile['location'])

                final_score = round((0.4 * title_score + 0.4 * skill_score + 0.2 * location_score), 3)
                job['match_percentage'] = str(round(final_score * 100, 2))  # percentage as string

            sorted_matches = sorted(jobs, key=lambda x: (-float(x['match_percentage']), x['id']))
            total_matches = len(sorted_matches)

            print(f"Total Matches After Scoring: {total_matches}")
            if total_matches > 0:
                print("Top 5 Matches:")
                for i, match in enumerate(sorted_matches[:5]):
                    print(f" {i+1}. Job ID: {match['id']}, Title: '{match['job_title']}', Score: {match['match_percentage']}%")

            paginated = sorted_matches[offset:offset + limit]

            return {
                "success": True,
                "matched_jobs": paginated,
                "pagination": {
                    "total_jobs": total_matches,
                    "page": page,
                    "limit": limit,
                    "total_pages": ceil(total_matches / limit)
                }
            }, 200

        except Exception as e:
            return {"success": False, "message": "Matching failed", "error": str(e)}, 500
        finally:
            cursor.close()
            conn.close()

@resumes_ns.route('/jobs/matched')
class MatchedJobsPerClient(Resource):
    @resumes_ns.doc(params={
        'email': 'User email to fetch matched jobs',
        'limit': 'Number of jobs per page (default 15)',
        'page': 'Page number (default 1)',
    })
    def get(self):
        """
        Return matched jobs from rankings table for a given email
        """
        conn = get_ai_db_connection()
        cursor = conn.cursor()
        try:
            args = request.args
            email = args.get('email')
            if not email:
                return {"success": False, "message": "Email is required"}, 400

            limit = int(args.get('limit', 15))
            page = int(args.get('page', 1))
            offset = (page - 1) * limit

            # Count total matches
            cursor.execute("""
                SELECT COUNT(*)
                FROM rankings
                WHERE LOWER(email) = LOWER(%s)
            """, (email,))
            total_matches = cursor.fetchone()[0]

            if total_matches == 0:
                return {
                    "success": True,
                    "matched_jobs": [],
                    "pagination": {
                        "total_jobs": 0,
                        "page": page,
                        "limit": limit,
                        "total_pages": 0
                    }
                }, 200

            # Fetch paginated matched jobs with full job details by joining with jobs table
            cursor.execute("""
                SELECT
                    j.id,
                    j.job_title,
                    j.entity as company_name,
                    j.job_description,
                    j.salary,
                    j.vacancy_city as location,
                    j.job_type,
                    j.languages,
                    j.experience,
                    j.application_email,
                    j.job_date,
                    r.status,
                    r.score as match_percentage
                FROM rankings r
                INNER JOIN jobs j ON r.job_id = j.id::text
                WHERE LOWER(r.email) = LOWER(%s)
                ORDER BY r.score DESC
                LIMIT %s OFFSET %s
            """, (email, limit, offset))

            columns = [desc[0] for desc in cursor.description]
            raw_rows = [dict(zip(columns, row)) for row in cursor.fetchall()]
            matched_jobs = [serialize_row(row) for row in raw_rows]
            client_job_settings = get_client_job_settings(cursor, email)

            return {
                "success": True,
                "client_job_settings": client_job_settings,
                "matched_jobs": matched_jobs,
                "pagination": {
                    "total_jobs": total_matches,
                    "page": page,
                    "limit": limit,
                    "total_pages": ceil(total_matches / limit)
                }
            }, 200

        except Exception as e:
            return {
                "success": False,
                "message": "Failed to fetch matched jobs",
                "error": str(e)
            }, 500
        finally:
            cursor.close()
            conn.close()

suggest_job_titles_parser = reqparse.RequestParser()
suggest_job_titles_parser.add_argument(
    'file',
    type=FileStorage,   # ✅ correct
    location='files',   # ✅ correct
    required=True,
    help='Resume file (PDF, DOCX, RTF)'
)


@resumes_ns.route('/suggest-job-titles')
class SuggestJobTitles(Resource):
    @resumes_ns.expect(suggest_job_titles_parser)
    @resumes_ns.response(200, 'Job titles suggested successfully')
    @resumes_ns.response(400, 'Invalid input')
    @resumes_ns.response(500, 'Internal server error')
    def post(self):
        """
        Suggest job titles based only on resume
        """
        temp_input_path = None

        try:
            args = suggest_job_titles_parser.parse_args()
            file = args['file']

            if file is None or file.filename == '':
                raise ValueError("Resume file is required")

            if not allowed_file(file.filename):
                raise ValueError("File type not allowed. Supported: PDF, DOCX, RTF")

            filename = secure_filename(file.filename)
            temp_input_path = Config.TEMP_FOLDER / filename
            file.save(temp_input_path)

            job_titles = suggest_job_titles_from_resume(temp_input_path)

            if not job_titles:
                raise ValueError("Failed to generate job titles")

            return {
                "success": True,
                "suggested_job_titles": job_titles
            }, 200

        except ValueError as ve:
            return {
                "success": False,
                "message": str(ve)
            }, 400

        except Exception as e:
            return {
                "success": False,
                "message": "Job title suggestion failed",
                "error": str(e)
            }, 500

        finally:
            if temp_input_path and os.path.exists(temp_input_path):
                os.remove(temp_input_path)




@resumes_ns.route('/jobs/<int:job_id>/applicants-count')
class JobApplicantsCount(Resource):
    @resumes_ns.doc(params={
        'job_id': 'ID of the job to get applicant count for',
        'status': 'Status filter (applied, pending, all). Default: applied'
    })
    @resumes_ns.response(HTTPStatus.OK.value, 'Successfully retrieved applicant count')
    @resumes_ns.response(HTTPStatus.NOT_FOUND.value, 'Job not found')
    @resumes_ns.response(HTTPStatus.INTERNAL_SERVER_ERROR.value, 'Internal server error')
    def get(self, job_id):
        """
        GET endpoint to retrieve the total number of applicants for a specific job.
        """
        conn = get_ai_db_connection()
        cursor = conn.cursor()
        try:
            status_filter = request.args.get('status', 'applied').lower()
            
            cursor.execute("SELECT id, job_title FROM jobs WHERE id = %s", (job_id,))
            job_row = cursor.fetchone()
            
            if not job_row:
                return {
                    "success": False,
                    "message": f"Job with ID {job_id} not found"
                }, HTTPStatus.NOT_FOUND

            if status_filter == 'all':
                status_condition = "1=1"
            elif status_filter in ['applied', 'pending']:
                status_condition = f"LOWER(status) = '{status_filter}'"
            else:
                status_condition = "LOWER(status) = 'applied'"

            cursor.execute(f"""
                SELECT COUNT(*) 
                FROM rankings 
                WHERE job_id = %s AND {status_condition}
            """, (str(job_id),))
            
            result = cursor.fetchone()
            applicant_count = result[0] if result else 0

            return {
                "success": True,
                "job_id": job_id,
                "job_title": job_row[1] if job_row[1] else "Unknown",
                "total_applicants": applicant_count,
                "status_filter": status_filter
            }, HTTPStatus.OK

        except Exception as e:
            return {
                "success": False,
                "message": "Error retrieving applicant count",
                "error": str(e)
            }, HTTPStatus.INTERNAL_SERVER_ERROR
        finally:
            cursor.close()
            conn.close()
            
analyze_client_ranking_parser = reqparse.RequestParser()
analyze_client_ranking_parser.add_argument(
    'email',
    type=str,
    required=True,
    help='Client email is required'
)


# ================================
# Endpoint
# ================================

@resumes_ns.route('/analyze-client-ranking')
class AnalyzeClientRanking(Resource):

    @resumes_ns.expect(analyze_client_ranking_parser)
    def post(self):
        try:
            args = analyze_client_ranking_parser.parse_args()
            email = args['email']

            # 1️⃣ Connect to PostgreSQL
            conn = psycopg2.connect(
                dbname=Config.AI_POSTGRES_DB,
                user=Config.AI_POSTGRES_USER,
                password=Config.AI_POSTGRES_PASSWORD,
                host=Config.AI_POSTGRES_HOST,
                port=Config.AI_POSTGRES_PORT
            )

            with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cur:
                cur.execute("""
                    SELECT score
                    FROM rankings
                    WHERE email = %s
                """, (email,))

                records = cur.fetchall()

            conn.close()

            # 2️⃣ Validate Data
            if not records:
                return {
                    "success": False,
                    "message": "No ranking records found for this client"
                }, HTTPStatus.NOT_FOUND.value

            # 3️⃣ Extract Scores
            scores = [r['score'] for r in records if r['score'] is not None]

            if not scores:
                return {
                    "success": False,
                    "message": "Ranking records exist but scores are empty"
                }, HTTPStatus.BAD_REQUEST.value

            total_jobs = len(scores)
            average_score = round(sum(scores) / total_jobs, 2)
            highest_score = max(scores)
            lowest_score = min(scores)

            # 4️⃣ Performance Classification
            if average_score >= 85:
                performance = "Excellent Match Profile"
                recommendation = "Client profile is highly optimized. Continue applying to similar job categories."
            elif average_score >= 70:
                performance = "Strong Candidate"
                recommendation = "Profile is strong but could benefit from keyword enhancement for higher ATS compatibility."
            elif average_score >= 50:
                performance = "Moderate Match"
                recommendation = "CV requires optimization in skills alignment and measurable achievements."
            else:
                performance = "Needs CV Optimization"
                recommendation = "Major CV restructuring recommended. Improve job-title alignment and measurable results."

            # 5️⃣ Return Analysis
            return {
                "success": True,
                "email": email,
                "total_jobs_evaluated": total_jobs,
                "average_score": average_score,
                "highest_score": highest_score,
                "lowest_score": lowest_score,
                "performance_level": performance,
                "recommendation": recommendation
            }, HTTPStatus.OK.value

        except Exception as e:
            return {
                "success": False,
                "message": "Ranking analysis failed",
                "error": str(e)
            }, HTTPStatus.INTERNAL_SERVER_ERROR.value



    def _analyze_scores(self, records):
        """
        Generate professional score analysis
        """

        total_score = 0
        max_score = 0
        highest_score = 0
        lowest_score = 100
        total_jobs = len(records)

        for record in records:
            score = record.get('score', 0)
            total_score += score
            max_score += 100

            if score > highest_score:
                highest_score = score

            if score < lowest_score:
                lowest_score = score

        average_score = round(total_score / total_jobs, 2)

        # Performance Category
        if average_score >= 85:
            performance = "Excellent Match Profile"
        elif average_score >= 70:
            performance = "Strong Candidate"
        elif average_score >= 50:
            performance = "Moderate Match"
        else:
            performance = "Needs CV Optimization"

        return {
            "total_jobs_evaluated": total_jobs,
            "average_score": average_score,
            "highest_score": highest_score,
            "lowest_score": lowest_score,
            "performance_level": performance,
            "recommendation": self._generate_recommendation(average_score)
        }


    def _generate_recommendation(self, avg_score):

        if avg_score >= 85:
            return "Client profile is highly optimized. Continue applying to similar job categories."
        elif avg_score >= 70:
            return "Profile is strong but could benefit from keyword enhancement for higher ATS compatibility."
        elif avg_score >= 50:
            return "CV requires optimization in skills alignment and experience targeting."
        else:
            return "Major CV restructuring recommended. Improve job-title alignment and measurable achievements."


    def _error_response(self, message, error_detail, status_code):
        response = jsonify({
            "success": False,
            "message": message,
            "error": error_detail
        })
        return make_response(response, status_code)

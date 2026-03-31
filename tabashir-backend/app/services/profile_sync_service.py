import uuid
import os
from pathlib import Path
import requests
from app.database.db import execute_query, execute_ai_query
from app.config import Config
from app.services.text_extract_PyMuPDF import extract_text
from app.services.cv_processor import cv_formatter

class ProfileSyncService:
    @staticmethod
    def sync_from_user_id(user_id):
        """
        Triggers a profile sync by finding the latest resume for a user,
        extracting its text, and parsing it with AI.
        """
        print(f"[PROFILE_SYNC] Lazy sync triggered for user: {user_id}")
        try:
            # 1. Find the latest resume for the candidate
            latest_resume = execute_query(
                '''
                SELECT r."originalUrl", r.filename
                FROM "Resume" r
                JOIN "Candidate" c ON r."candidateId" = c.id
                WHERE c."userId" = %s
                ORDER BY r."createdAt" DESC
                LIMIT 1
                ''',
                (user_id,),
                fetch_one=True
            )

            if not latest_resume or not latest_resume.get('originalUrl'):
                print(f"[PROFILE_SYNC] No resume found for user {user_id}, skipping sync")
                return False

            original_url = latest_resume['originalUrl']
            filename = latest_resume.get('filename') or os.path.basename(original_url)
            
            # 2. Resolve File Path (Handle URLs vs Local Paths)
            file_path = None
            if original_url.startswith('http'):
                # It's a remote URL (e.g. UploadThing)
                print(f"[PROFILE_SYNC] Resume is a remote URL: {original_url}")
                temp_dir = Path(Config.CV_STORAGE_PATH) / "temp_sync"
                os.makedirs(temp_dir, exist_ok=True)
                
                # Use a unique name for the temp file to avoid collisions
                temp_filename = f"sync_{uuid.uuid4()}_{filename}"
                file_path = temp_dir / temp_filename
                
                print(f"[PROFILE_SYNC] Downloading resume to {file_path}")
                response = requests.get(original_url, timeout=30)
                if response.status_code == 200:
                    with open(file_path, 'wb') as f:
                        f.write(response.content)
                else:
                    print(f"[PROFILE_SYNC] Failed to download resume: Status {response.status_code}")
                    return False
            else:
                # It's a local filename
                file_path = Path(Config.CV_STORAGE_PATH) / original_url
                if not os.path.exists(file_path):
                    # Fallback: check if filename itself exists in CVs
                    file_path = Path(Config.CV_STORAGE_PATH) / filename
            
            if not file_path or not os.path.exists(file_path):
                print(f"[PROFILE_SYNC] Resume file not found at {file_path}")
                return False

            # 3. Extract and Parse
            print(f"[PROFILE_SYNC] Extracting text from {file_path}")
            raw_text = extract_text(file_path)
            
            # Cleanup temp file if it was downloaded
            if original_url.startswith('http') and os.path.exists(file_path):
                try:
                    os.remove(file_path)
                except Exception: pass

            if not raw_text:
                print(f"[PROFILE_SYNC] Failed to extract text from {file_path}")
                return False

            print(f"[PROFILE_SYNC] Formatting CV with AI...")
            formatted_cv = cv_formatter(raw_text)
            
            # 4. Call existing sync logic
            return ProfileSyncService.sync_from_resume(user_id, formatted_cv)

        except Exception as e:
            print(f"[PROFILE_SYNC] Error during lazy sync: {e}")
            import traceback
            traceback.print_exc()
            return False

    @staticmethod
    def sync_from_resume(user_id, resume_obj):
        """
        Synchronizes AI-parsed resume data into the PostgreSQL CandidateProfile table.
        """
        print(f"[PROFILE_SYNC] Starting sync for user: {user_id}")
        
        try:
            # 1. Get Candidate ID
            candidate = execute_query(
                'SELECT id FROM "Candidate" WHERE "userId" = %s', 
                (user_id,), 
                fetch_one=True
            )
            
            if not candidate:
                candidate_id = str(uuid.uuid4())
                print(f"[PROFILE_SYNC] Creating new Candidate record: {candidate_id}")
                execute_query(
                    'INSERT INTO "Candidate" ("id", "userId", "createdAt", "updatedAt") VALUES (%s, %s, NOW(), NOW())', 
                    (candidate_id, user_id), 
                    commit=True
                )
            else:
                candidate_id = candidate['id']
                print(f"[PROFILE_SYNC] Found existing Candidate: {candidate_id}")

            # 2. Extract Data from Resume Object
            # Merge skillset, softskills and keywords
            skillset = []
            softskills = []
            keywords = []
            
            if hasattr(resume_obj, 'skills') and resume_obj.skills:
                skillset = getattr(resume_obj.skills, 'skillset', [])
                softskills = getattr(resume_obj.skills, 'softskills', [])
            
            keywords = getattr(resume_obj, 'keywords', [])
            
            # Ensure they are lists
            def ensure_list(val):
                if val is None: return []
                if isinstance(val, list): return val
                return [val]
            
            skillset = ensure_list(skillset)
            softskills = ensure_list(softskills)
            keywords = ensure_list(keywords)
            
            # Combine, lowercase, trim, and unique
            combined_skills = skillset + softskills + keywords
            skills = list(set([str(s).strip().lower() for s in combined_skills if s]))
            
            # Primary Role (latest position)
            primary_role = "Professional"
            if hasattr(resume_obj, 'work') and isinstance(resume_obj.work, list) and len(resume_obj.work) > 0:
                # Take the first work experience as the primary role
                work_exp = resume_obj.work[0]
                if hasattr(work_exp, 'position') and work_exp.position:
                    primary_role = work_exp.position

            location = resume_obj.header.location if hasattr(resume_obj, 'header') and hasattr(resume_obj.header, 'location') else None
            phone = resume_obj.header.phone if hasattr(resume_obj, 'header') and hasattr(resume_obj.header, 'phone') else None
            nationality = resume_obj.header.nationality if hasattr(resume_obj, 'header') and hasattr(resume_obj.header, 'nationality') else None
            
            # Languages
            languages = ensure_list([])
            if hasattr(resume_obj, 'languages') and resume_obj.languages:
                if hasattr(resume_obj.languages, 'langs'):
                    languages = [str(l).strip() for l in resume_obj.languages.langs if l]

            # NEW: Extract Degree (most recent/highest)
            degree = None
            if hasattr(resume_obj, 'education') and isinstance(resume_obj.education, list) and len(resume_obj.education) > 0:
                # Education is usually sorted by date in many parsers, otherwise we just take the first
                edu = resume_obj.education[0]
                if hasattr(edu, 'degree') and edu.degree:
                    degree = edu.degree
                    print(f"[PROFILE_SYNC] Extracted Degree: {degree}")

            # NEW: Try to get missing info from AI DB (gender, age)
            gender = None
            age = None
            
            # Get User Email first for AI DB query
            user_info = execute_query('SELECT email FROM "User" WHERE id = %s', (user_id,), fetch_one=True)
            if user_info and user_info.get('email'):
                email = user_info['email']
                print(f"[PROFILE_SYNC] Checking AI DB for extra info for {email}...")
                ai_data = execute_ai_query(
                    'SELECT gender, age FROM clients WHERE email = %s LIMIT 1',
                    (email,),
                    fetch_one=True
                )
                if ai_data:
                    gender = ai_data.get('gender')
                    age = ai_data.get('age')
                    if gender: print(f"[PROFILE_SYNC] Found Gender in AI DB: {gender}")
                    if age: print(f"[PROFILE_SYNC] Found Age in AI DB: {age}")
                    
                    # If nationality was missing from header, try AI DB
                    if not nationality:
                        ai_nat = ai_data.get('nationality')
                        if ai_nat:
                            nationality = ai_nat
                            print(f"[PROFILE_SYNC] Found Nationality in AI DB: {nationality}")

            print(f"[PROFILE_SYNC] Global Sync Data: Role={primary_role}, Skills={len(skills)}, Location={location}, Gender={gender}, Degree={degree}")

            # 3. UPSERT into CandidateProfile
            # Check if profile exists
            profile = execute_query(
                'SELECT id FROM "CandidateProfile" WHERE "candidateId" = %s',
                (candidate_id,),
                fetch_one=True
            )

            if not profile:
                profile_id = str(uuid.uuid4())
                print(f"[PROFILE_SYNC] Inserting new CandidateProfile: {profile_id}")
                execute_query('''
                    INSERT INTO "CandidateProfile" (
                        "id", "candidateId", "jobType", skills, location, phone, 
                        nationality, languages, gender, age, degree, "onboardingCompleted", "createdAt", "updatedAt"
                    )
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, true, NOW(), NOW())
                ''', (profile_id, candidate_id, primary_role, skills, location, phone, nationality, languages, gender, str(age) if age else None, degree), commit=True)
            else:
                print(f"[PROFILE_SYNC] Updating existing CandidateProfile: {profile['id']}")
                execute_query('''
                    UPDATE "CandidateProfile" SET
                        "jobType" = %s,
                        skills = %s,
                        location = %s,
                        phone = %s,
                        nationality = %s,
                        languages = %s,
                        gender = %s,
                        age = %s,
                        degree = %s,
                        "onboardingCompleted" = true,
                        "updatedAt" = NOW()
                    WHERE "candidateId" = %s
                ''', (primary_role, skills, location, phone, nationality, languages, gender, str(age) if age else None, degree, candidate_id), commit=True)

            print(f"[PROFILE_SYNC] Sync completed successfully for user: {user_id}")
            return True

        except Exception as e:
            print(f"[PROFILE_SYNC] Error during sync: {e}")
            import traceback
            traceback.print_exc()
            return False

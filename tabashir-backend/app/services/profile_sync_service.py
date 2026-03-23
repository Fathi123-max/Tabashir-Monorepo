import uuid
import json
from app.database.db import execute_query, execute_ai_query

class ProfileSyncService:
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
                    'INSERT INTO "Candidate" (id, "userId", "createdAt", "updatedAt") VALUES (%s, %s, NOW(), NOW())', 
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
            languages = []
            if hasattr(resume_obj, 'languages') and resume_obj.languages:
                if hasattr(resume_obj.languages, 'langs'):
                    languages = [str(l).strip() for l in resume_obj.languages.langs if l]

            print(f"[PROFILE_SYNC] Extracted: Role={primary_role}, Skills={len(skills)}, Location={location}")

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
                        id, "candidateId", "jobType", skills, location, phone, 
                        nationality, languages, "onboardingCompleted", "createdAt", "updatedAt"
                    )
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, true, NOW(), NOW())
                ''', (profile_id, candidate_id, primary_role, skills, location, phone, nationality, languages), commit=True)
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
                        "onboardingCompleted" = true,
                        "updatedAt" = NOW()
                    WHERE "candidateId" = %s
                ''', (primary_role, skills, location, phone, nationality, languages, candidate_id), commit=True)

            print(f"[PROFILE_SYNC] Sync completed successfully for user: {user_id}")
            return True

        except Exception as e:
            print(f"[PROFILE_SYNC] Error during sync: {e}")
            import traceback
            traceback.print_exc()
            return False

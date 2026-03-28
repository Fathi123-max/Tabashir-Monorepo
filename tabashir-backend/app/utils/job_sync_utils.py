import re
from app.database.db import execute_query, execute_ai_query

def extract_salary(salary_str):
    """Extracts min and max salary as integers from a string."""
    if not salary_str:
        return 0, 0
    
    # Extract all numbers from the string
    numbers = [int(num) for num in re.findall(r'\d+', str(salary_str))]
    
    if not numbers:
        return 0, 0
    if len(numbers) == 1:
        return numbers[0], numbers[0]
    return min(numbers), max(numbers)

def sync_job_from_legacy(job_id_str):
    """
    Looks up a job by ID in the legacy AI 'jobs' table and synchronizes it 
    into the new Prisma 'Job' table if it doesn't already exist.
    """
    try:
        # 1. Check if job already exists in the new 'Job' table
        existing_job = execute_query(
            'SELECT id FROM "Job" WHERE id = %s',
            (str(job_id_str),),
            fetch_one=True
        )
        if existing_job:
            return True, "Job already synced"

        # 2. Lookup in legacy 'jobs' table
        try:
            legacy_job_id = int(job_id_str)
        except ValueError:
            return False, "Invalid Job ID format"

        legacy_job = execute_ai_query(
            'SELECT * FROM jobs WHERE id = %s',
            (legacy_job_id,),
            fetch_one=True
        )

        if not legacy_job:
            return False, "Job not found in legacy system"

        # 3. Map legacy job data to new 'Job' schema
        title = legacy_job.get('job_title') or "Unknown Title"
        company = legacy_job.get('company_name') or legacy_job.get('entity') or "Unknown Company"
        location = legacy_job.get('vacancy_city') or "Unknown Location"
        description = legacy_job.get('job_description') or ""
        experience = legacy_job.get('experience') or ""
        job_type = legacy_job.get('job_type') or "Full-time"
        
        salary_str = legacy_job.get('salary', '')
        salary_min, salary_max = extract_salary(salary_str)

        # Parse languages/skills into an array
        languages_str = legacy_job.get('languages') or ""
        required_skills = [s.strip() for s in languages_str.split(',') if s.strip()]
        
        # We append experience to requirements if available
        requirements = experience if experience else ""

        # 4. Insert into new 'Job' table
        execute_query(
            """
            INSERT INTO "Job" (
                id, title, company, "companyDescription", "companyLogo", "jobType", 
                "salaryMin", "salaryMax", location, description, requirements, 
                benefits, "requiredSkills", views, "applicationsCount", 
                status, "isActive", "externalApiJobId", "createdAt", "updatedAt"
            ) VALUES (
                %s, %s, %s, %s, %s, %s,
                %s, %s, %s, %s, %s,
                %s, %s, 0, 0,
                'ACTIVE', true, %s, NOW(), NOW()
            ) 
            ON CONFLICT (id) DO NOTHING
            """,
            (
                str(job_id_str), title, company, "", "", job_type,
                salary_min, salary_max, location, description, requirements,
                [], required_skills, str(job_id_str)
            ),
            commit=True
        )
        return True, "Job synchronized successfully"

    except Exception as e:
        import traceback
        print(f"[SYNC_JOB_ERROR] Error syncing job {job_id_str}: {e}")
        traceback.print_exc()
        return False, str(e)

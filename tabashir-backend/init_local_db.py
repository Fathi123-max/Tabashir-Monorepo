import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
from datetime import datetime, timedelta
import uuid

# Default macOS postgres connection details
DB_USER = "Apple"
DB_PASSWORD = ""  # standard for local homebrew postgres
DB_HOST = "localhost"
DB_PORT = "5432"

def create_database(db_name):
    print(f"Checking/creating database '{db_name}'...")
    try:
        # Connect to the default 'postgres' db to create other databases
        conn = psycopg2.connect(
            dbname='postgres', 
            user=DB_USER, 
            password=DB_PASSWORD, 
            host=DB_HOST, 
            port=DB_PORT
        )
        conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        cursor = conn.cursor()
        
        # Check if db exists
        cursor.execute(f"SELECT 1 FROM pg_catalog.pg_database WHERE datname = '{db_name}'")
        exists = cursor.fetchone()
        
        if not exists:
            cursor.execute(f"CREATE DATABASE {db_name}")
            print(f"✅ Database '{db_name}' created successfully.")
        else:
            print(f"ℹ️ Database '{db_name}' already exists.")
            
        cursor.close()
        conn.close()
    except Exception as e:
        print(f"❌ Error creating database {db_name}: {e}")
        print("Make sure PostgreSQL is running locally on port 5432.")

def init_tables_and_seed(db_name):
    print(f"Initializing tables in '{db_name}'...")
    try:
        conn = psycopg2.connect(
            dbname=db_name, 
            user=DB_USER, 
            password=DB_PASSWORD, 
            host=DB_HOST, 
            port=DB_PORT
        )
        cursor = conn.cursor()

        # -------------------------------------------------------------------
        # 1. CREATE TABLES (Combined schema from both Main and AI databases)
        # -------------------------------------------------------------------
        
        # Users Table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS users (
                id TEXT PRIMARY KEY,
                email TEXT UNIQUE NOT NULL,
                name TEXT,
                password TEXT,
                "userType" TEXT DEFAULT 'CANDIDATE',
                "createdAt" TIMESTAMP DEFAULT NOW(),
                "updatedAt" TIMESTAMP DEFAULT NOW(),
                "jobCount" INTEGER DEFAULT 0,
                "aiJobApplyCount" INTEGER DEFAULT 0
            );
        """)

        # Candidate Table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS "Candidate" (
                id TEXT PRIMARY KEY,
                "userId" TEXT REFERENCES users(id),
                "createdAt" TIMESTAMP DEFAULT NOW(),
                "updatedAt" TIMESTAMP DEFAULT NOW()
            );
        """)

        # CandidateProfile Table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS "CandidateProfile" (
                id TEXT PRIMARY KEY,
                "candidateId" TEXT REFERENCES "Candidate"(id),
                phone TEXT,
                nationality TEXT,
                gender TEXT,
                languages TEXT[],
                age INTEGER,
                "profilePicture" TEXT,
                "jobType" TEXT,
                skills TEXT[],
                experience TEXT,
                location TEXT,
                education TEXT,
                degree TEXT,
                "onboardingCompleted" BOOLEAN DEFAULT false,
                "createdAt" TIMESTAMP DEFAULT NOW(),
                "updatedAt" TIMESTAMP DEFAULT NOW()
            );
        """)

        # Job Table (Mobile App specific)
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS "Job" (
                id TEXT PRIMARY KEY,
                title TEXT,
                company TEXT,
                "companyLogo" TEXT,
                "jobType" TEXT,
                "salaryMin" INTEGER,
                "salaryMax" INTEGER,
                location TEXT,
                description TEXT,
                requirements TEXT,
                benefits TEXT,
                views INTEGER DEFAULT 0,
                "applicationsCount" INTEGER DEFAULT 0,
                status TEXT DEFAULT 'ACTIVE',
                "isActive" BOOLEAN DEFAULT true,
                "createdAt" TIMESTAMP DEFAULT NOW(),
                "updatedAt" TIMESTAMP DEFAULT NOW()
            );
        """)

        # jobs Table (Legacy / AI Main Database)
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS jobs (
                id SERIAL PRIMARY KEY,
                entity TEXT,
                nationality TEXT,
                gender TEXT,
                job_title TEXT,
                job_title_ar TEXT,
                academic_qualification TEXT,
                academic_qualification_ar TEXT,
                experience TEXT,
                experience_ar TEXT,
                languages TEXT,
                languages_ar TEXT,
                salary TEXT,
                salary_ar TEXT,
                vacancy_city TEXT,
                vacancy_city_ar TEXT,
                working_hours TEXT,
                working_hours_ar TEXT,
                working_days TEXT,
                working_days_ar TEXT,
                application_email TEXT,
                job_description TEXT,
                job_description_ar TEXT,
                job_date TEXT,
                phone TEXT,
                source TEXT,
                apply_url TEXT,
                company_name TEXT,
                company_name_ar TEXT,
                website_url TEXT,
                job_type TEXT,
                translation_status TEXT DEFAULT 'completed',
                translation_updated_at TIMESTAMP DEFAULT NOW()
            );
        """)

        # rankings Table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS rankings (
                id SERIAL PRIMARY KEY,
                client_id TEXT,
                job_id TEXT,
                name TEXT,
                email TEXT,
                major TEXT,
                location TEXT,
                skills TEXT,
                keywords TEXT,
                job_title TEXT,
                job_description TEXT,
                job_application_email TEXT,
                filename TEXT,
                status TEXT DEFAULT 'pending',
                date TEXT,
                score REAL,
                degree TEXT
            );
        """)

        # clients Table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS clients (
                id SERIAL PRIMARY KEY,
                email TEXT UNIQUE,
                name TEXT,
                positions TEXT,
                skills TEXT,
                location TEXT,
                major TEXT,
                keywords TEXT,
                gender TEXT,
                nationality TEXT,
                degree TEXT,
                filename TEXT,
                jobs_to_apply_number INTEGER DEFAULT 0,
                job_location_based TEXT,
                job_matching INTEGER DEFAULT 0,
                fcv_as_string TEXT,
                phone_number TEXT,
                date_in TEXT,
                gpa TEXT
            );
        """)

        # SavedJobPost Table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS "SavedJobPost" (
                id TEXT PRIMARY KEY,
                "jobId" TEXT,
                "userId" TEXT,
                "createdAt" TIMESTAMP DEFAULT NOW(),
                "updatedAt" TIMESTAMP DEFAULT NOW(),
                UNIQUE("jobId", "userId")
            );
        """)

        # JobApplication Table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS "JobApplication" (
                id TEXT PRIMARY KEY,
                "jobId" TEXT,
                "userId" TEXT,
                status TEXT DEFAULT 'pending',
                "createdAt" TIMESTAMP DEFAULT NOW(),
                "updatedAt" TIMESTAMP DEFAULT NOW()
            );
        """)

        # API Tokens Table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS api_tokens (
                id SERIAL PRIMARY KEY,
                token TEXT UNIQUE NOT NULL,
                active BOOLEAN DEFAULT TRUE,
                created_at TIMESTAMP DEFAULT NOW()
            );
        """)

        # -------------------------------------------------------------------
        # 2. SEED MOCK DATA
        # -------------------------------------------------------------------
        print(f"Seeding mock data in '{db_name}'...")
        
        # Helper variables
        today = datetime.now()
        str_today = today.strftime("%Y-%m-%d")

        # Seed API Token
        cursor.execute("INSERT INTO api_tokens (token) VALUES ('test-api-token-123') ON CONFLICT (token) DO NOTHING;")

        # Seed Test User & Candidate Profile
        test_user_id = str(uuid.uuid4())
        cursor.execute("SELECT 1 FROM users WHERE email = 'test@example.com'")
        if not cursor.fetchone():
            import bcrypt
            hashed_pw = bcrypt.hashpw('password123'.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')
            
            cursor.execute("""
                INSERT INTO users (id, email, name, password, "userType", "jobCount") 
                VALUES (%s, 'test@example.com', 'Test User', %s, 'CANDIDATE', 10)
            """, (test_user_id, hashed_pw))

            candidate_id = str(uuid.uuid4())
            cursor.execute("""
                INSERT INTO "Candidate" (id, "userId") VALUES (%s, %s)
            """, (candidate_id, test_user_id))

            cursor.execute("""
                INSERT INTO "CandidateProfile" 
                (id, "candidateId", phone, nationality, gender, "jobType", skills, experience, location) 
                VALUES (%s, %s, '+971501234567', 'UAE', 'Male', 'Full-time', ARRAY['Python', 'Flask', 'React'], '5 years', 'Dubai')
            """, (str(uuid.uuid4()), candidate_id))

            cursor.execute("""
                INSERT INTO clients (email, name, positions, skills, location, nationality, gender)
                VALUES ('test@example.com', 'Test User', 'Software Engineer, Developer', 'Python, Flask, React', 'Dubai', 'UAE', 'Male')
            """)

        # Seed Mobile Jobs ("Job" table)
        cursor.execute('SELECT COUNT(*) FROM "Job"')
        if cursor.fetchone()[0] == 0:
            mobile_jobs = [
                (str(uuid.uuid4()), "Senior Mobile Developer", "Tech Corp", "Full-time", 12000, 18000, "Dubai", "Build cross-platform mobile apps using Flutter.", 120),
                (str(uuid.uuid4()), "Backend Software Engineer", "Innovation Labs", "Full-time", 10000, 15000, "Abu Dhabi", "Develop APIs in Python/Flask.", 85),
                (str(uuid.uuid4()), "UI/UX Designer", "Creative Solutions", "Contract", 8000, 12000, "Remote", "Design intuitive mobile and web interfaces.", 45)
            ]
            for mj in mobile_jobs:
                cursor.execute("""
                    INSERT INTO "Job" (id, title, company, "jobType", "salaryMin", "salaryMax", location, description, views)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
                """, mj)

        # Seed Legacy/AI Jobs ("jobs" table)
        cursor.execute("SELECT COUNT(*) FROM jobs")
        if cursor.fetchone()[0] == 0:
            legacy_jobs = [
                ('Tech Corp', 'Any', 'Any', 'Senior Mobile Developer', 'senior developer', 'Flutter, Dart', '15000 AED', 'Dubai', 'careers@techcorp.ae', 'Build cross platform apps.', str_today, 'Full-time'),
                ('Innovation Labs', 'UAE', 'Any', 'Backend Software Engineer', 'backend engineer', 'Python, PostgreSQL', '12000 AED', 'Abu Dhabi', 'jobs@innovation.ae', 'Develop scalable APIs.', str_today, 'Full-time'),
                ('DataFlow Systems', 'Any', 'Any', 'Data Scientist', 'data scientist', 'Python, ML, SQL', '18000 AED', 'Dubai', 'hr@dataflow.ae', 'Analyze massive datasets.', str_today, 'Contract'),
            ]
            for lj in legacy_jobs:
                cursor.execute("""
                    INSERT INTO jobs (company_name, nationality, gender, job_title, job_title_ar, languages, salary, vacancy_city, application_email, job_description, job_date, job_type)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                """, lj)

        # Commit all changes
        conn.commit()
        print("✅ Tables initialized and mock data seeded successfully.")
        
        cursor.close()
        conn.close()

    except Exception as e:
        print(f"❌ Error initializing tables in {db_name}: {e}")

if __name__ == "__main__":
    print("🚀 Starting Local Database Initialization 🚀")
    
    # Create the two databases required by the app
    create_database("tabashir_main")
    create_database("tabashir_ai")
    
    # Initialize schema and seed data for both
    # In this app, both sets of DB calls tend to cross over depending on if it's new_app or app, 
    # so we initialize the full schema in both local databases to prevent missing relation errors.
    init_tables_and_seed("tabashir_main")
    init_tables_and_seed("tabashir_ai")

    print("\n🎉 Setup Complete!")
    print("You can now test the app with the credentials:")
    print("Email: test@example.com")
    print("Password: password123")

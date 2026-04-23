import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

# Local connection details (from init_local_db.py)
DB_USER = "Apple"
DB_PASSWORD = ""
DB_HOST = "localhost"
DB_PORT = "5432"
DB_NAME = "tabashir_ai"

def align_db():
    print(f"🚀 Aligning local database '{DB_NAME}' with Production schema...")
    try:
        conn = psycopg2.connect(
            dbname=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
            host=DB_HOST,
            port=DB_PORT
        )
        conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        cursor = conn.cursor()

        # 1. Align 'jobs' table
        print("Checking 'jobs' table...")
        cursor.execute("ALTER TABLE jobs ADD COLUMN IF NOT EXISTS phone_number TEXT;")
        cursor.execute("ALTER TABLE jobs ADD COLUMN IF NOT EXISTS apply_type TEXT;")
        cursor.execute("ALTER TABLE jobs ALTER COLUMN id TYPE bigint;")
        # Match production VARCHAR type for translation_status
        cursor.execute("ALTER TABLE jobs ALTER COLUMN translation_status TYPE character varying;")
        cursor.execute("ALTER TABLE jobs ADD COLUMN IF NOT EXISTS source TEXT;")
        cursor.execute("ALTER TABLE jobs ADD COLUMN IF NOT EXISTS apply_url TEXT;")

        # 2. Align 'clients' table
        print("Checking 'clients' table...")
        cursor.execute("ALTER TABLE clients ADD COLUMN IF NOT EXISTS phone_number TEXT;")
        cursor.execute("ALTER TABLE clients ALTER COLUMN jobs_to_apply_number TYPE bigint;")
        cursor.execute("ALTER TABLE clients ALTER COLUMN job_matching TYPE bigint;")
        cursor.execute("ALTER TABLE clients ALTER COLUMN id TYPE bigint;")

        # 3. Align 'rankings' table
        print("Checking 'rankings' table...")
        cursor.execute("ALTER TABLE rankings ADD COLUMN IF NOT EXISTS job_apply_service INTEGER;")

        # 4. Align 'blocked' table
        print("Checking 'blocked' table...")
        # Match production VARCHAR types
        cursor.execute("ALTER TABLE blocked ALTER COLUMN job_title TYPE character varying;")
        cursor.execute("ALTER TABLE blocked ALTER COLUMN email TYPE character varying;")
        # Note: Production is missing 'created_at'. We keep it locally as it's useful for debugging,
        # but the app code must handle its absence in production.

        # 5. Fix 'processedtimestamps'
        print("Checking 'processedtimestamps' table...")
        # Production mismatch showed 'id' and 'created_at' missing in prod but in local. 
        # We'll keep them but ensure the structure is functional.

        # 6. Ensure unique constraints needed for ON CONFLICT
        print("Checking constraints...")
        try:
            cursor.execute("ALTER TABLE clients ADD CONSTRAINT clients_email_key UNIQUE (email);")
        except:
            pass # already exists
        
        try:
            cursor.execute("ALTER TABLE api_tokens ADD CONSTRAINT api_tokens_token_key UNIQUE (token);")
        except:
            pass # already exists

        cursor.close()
        conn.close()
        print("✅ Local database alignment complete!")

    except Exception as e:
        print(f"❌ Error aligning database: {e}")

if __name__ == "__main__":
    align_db()

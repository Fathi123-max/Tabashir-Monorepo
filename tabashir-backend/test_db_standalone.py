
import psycopg2
from psycopg2.extras import RealDictCursor
import os

def test():
    # Credentials from .env
    db_config = {
        'host': 'localhost',
        'port': 5432,
        'user': 'Apple',
        'password': '',
        'dbname': 'tabashir_hr'
    }
    ai_db_config = {
        'host': 'localhost',
        'port': 5432,
        'user': 'Apple',
        'password': '',
        'dbname': 'tabashir_ai'
    }
    
    email = 'pathtopeace467@gmail.com'
    print(f"--- Testing for email: {email} ---")
    
    try:
        # 1. Main DB
        print(f"Connecting to Main DB ({db_config['dbname']})...")
        conn = psycopg2.connect(**db_config)
        cur = conn.cursor(cursor_factory=RealDictCursor)
        cur.execute("SELECT id, name, email FROM users WHERE email = %s", (email,))
        user = cur.fetchone()
        if user:
            print(f"User Found: ID={user['id']}, Name={user['name']}")
            cur.execute("SELECT * FROM \"CandidateProfile\" WHERE \"userId\" = %s", (user['id'],))
            profile = cur.fetchone()
            print(f"Candidate Profile: {profile if profile else 'NOT FOUND'}")
        else:
            print("User NOT found in Main DB")
        cur.close()
        conn.close()
        
        # 2. AI DB
        print(f"\nConnecting to AI DB ({ai_db_config['dbname']})...")
        conn = psycopg2.connect(**ai_db_config)
        cur = conn.cursor(cursor_factory=RealDictCursor)
        cur.execute("SELECT * FROM clients WHERE email = %s", (email,))
        client = cur.fetchone()
        if client:
            print("AI Client record found!")
            for k, v in client.items():
                if v: print(f"  {k}: {v}")
        else:
            print("AI Client record NOT found")
        cur.close()
        conn.close()
        
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    test()

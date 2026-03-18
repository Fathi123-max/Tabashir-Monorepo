import psycopg2
from psycopg2.extras import RealDictCursor
import sys
import os

# Add parent directory to path to import app
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from app.config import Config
from app.database.db import get_db_connection, get_ai_db_connection

def migrate_existing_candidates():
    print("Starting migration of existing candidates to AI DB...")
    
    hr_conn = get_db_connection()
    ai_conn = get_ai_db_connection()
    
    hr_cur = hr_conn.cursor(cursor_factory=RealDictCursor)
    ai_cur = ai_conn.cursor()
    
    try:
        # Fetch all candidates with profiles
        hr_cur.execute("""
            SELECT u.name, u.email, cp.phone, cp.location, cp.nationality, cp.gender, cp."jobType", cp.skills
            FROM users u
            JOIN "Candidate" c ON c."userId" = u.id
            JOIN "CandidateProfile" cp ON cp."candidateId" = c.id
            WHERE u."userType" = 'CANDIDATE'
        """)
        
        candidates = hr_cur.fetchall()
        print(f"Found {len(candidates)} candidates to sync.")
        
        synced_count = 0
        for cand in candidates:
            skills_str = ", ".join(cand['skills']) if isinstance(cand['skills'], list) else cand['skills']
            
            ai_cur.execute("""
                INSERT INTO clients (name, email, phone_number, location, nationality, gender, positions, skills, date_in)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, NOW())
                ON CONFLICT (email) DO UPDATE 
                SET name = EXCLUDED.name, 
                    phone_number = EXCLUDED.phone_number, 
                    location = EXCLUDED.location,
                    nationality = EXCLUDED.nationality,
                    gender = EXCLUDED.gender,
                    positions = EXCLUDED.positions,
                    skills = EXCLUDED.skills
            """, (
                cand['name'], cand['email'], cand['phone'], cand['location'], 
                cand['nationality'], cand['gender'], cand['jobType'], skills_str
            ))
            synced_count += 1
            
        ai_conn.commit()
        print(f"Successfully synced {synced_count} candidates.")
        
    except Exception as e:
        print(f"Error during migration: {e}")
        ai_conn.rollback()
    finally:
        hr_cur.close()
        hr_conn.close()
        ai_cur.close()
        ai_conn.close()

if __name__ == "__main__":
    migrate_existing_candidates()

import os
import requests
from typing import List, Dict, Any
import psycopg2
from psycopg2.extras import execute_values
from dotenv import load_dotenv

load_dotenv()

APIFY_API_TOKEN = os.getenv('APIFY_API_TOKEN')
APIFY_ACTOR_ID = 'bebity~linkedin-jobs-scraper'
DATABASE_URL = os.getenv('AI_DATABASE_URL')

def get_apify_jobs() -> List[Dict[str, Any]]:
    """
    Fetch jobs from Apify API
    """
    url = f'https://api.apify.com/v2/acts/{APIFY_ACTOR_ID}/run-sync-get-dataset-items'
    headers = {
        'Content-Type': 'application/json',
    }
    params = {
        'token': APIFY_API_TOKEN
    }
    
    response = requests.post(url, headers=headers, params=params)
    response.raise_for_status()
    return response.json()

def map_apify_to_db_job(apify_job: Dict[str, Any]) -> Dict[str, Any]:
    """
    Map Apify job fields to database schema
    """
    return {
        'id': apify_job['id'],
        'job_date': apify_job['publishedAt'],
        'salary': apify_job['salary'],
        'job_title': apify_job['title'],
        'website_url': apify_job['jobUrl'],
        'company_name': apify_job['companyName'],
        'vacancy_city': apify_job['location'],
        'job_description': apify_job['description'],
        'job_type': apify_job['contractType'],
        'experience': apify_job['experienceLevel'],
        'apply_url': apify_job['applyUrl'],
        'source': 'Apify',
        'apply_type': 'external'
    }

def sync_apify_jobs():
    """
    Main function to sync jobs from Apify to database
    """
    try:
        # Get jobs from Apify
        apify_jobs = get_apify_jobs()
        
        # Connect to database
        conn = psycopg2.connect(DATABASE_URL)
        cur = conn.cursor()
        
        # Get existing job IDs
        cur.execute("SELECT id FROM jobs WHERE source = 'Apify'")
        existing_ids = {row[0] for row in cur.fetchall()}
        
        # Process new jobs
        new_jobs = []
        for job in apify_jobs:
            if job['id'] not in existing_ids:
                mapped_job = map_apify_to_db_job(job)
                new_jobs.append(mapped_job)
        
        if new_jobs:
            # Prepare insert query
            columns = new_jobs[0].keys()
            query = f"""
                INSERT INTO jobs ({', '.join(columns)})
                VALUES %s
                ON CONFLICT (id) DO NOTHING
            """
            
            # Prepare values for bulk insert
            values = [[job[col] for col in columns] for job in new_jobs]
            
            # Execute bulk insert
            execute_values(cur, query, values)
            conn.commit()
            
            print(f"Successfully inserted {len(new_jobs)} new jobs")
        else:
            print("No new jobs to insert")
            
    except Exception as e:
        print(f"Error syncing jobs: {str(e)}")
        if 'conn' in locals():
            conn.rollback()
    finally:
        if 'cur' in locals():
            cur.close()
        if 'conn' in locals():
            conn.close()

if __name__ == '__main__':
    sync_apify_jobs() 

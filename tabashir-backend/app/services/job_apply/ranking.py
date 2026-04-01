import multiprocessing
import traceback

import time
from datetime import datetime, timedelta

import pandas as pd
import psycopg2

from psycopg2.extras import execute_values

from app import Config
from app.services.notification_service import NotificationService


def preprocess_text(text):
    if isinstance(text, str):
        return text.lower().strip()
    return ""


def match_engineering_discipline(job_title, client_major):
    """Dedicated function to match engineering disciplines between job title and major"""
    # Define engineering disciplines with their related terms
    engineering_disciplines = {
        'mechanical': ['mechanical', 'mech'],
        'electrical': ['electrical', 'electronic', 'electronics'],
        'civil': ['civil', 'structural', 'construction'],
        'software': ['software', 'coding', 'programming', 'web', 'app'],
        'chemical': ['chemical', 'process', 'chemical process'],
        'industrial': ['industrial', 'manufacturing', 'production'],
        'systems': ['system', 'systems integration', 'control systems'],
        'environmental': ['environmental', 'sustainability', 'green'],
        'biomedical': ['biomedical', 'bioengineering', 'medical'],
        'aerospace': ['aerospace', 'aeronautical', 'aviation', 'aircraft'],
        'computer': ['computer', 'computing', 'information technology', 'it'],
        'telecommunications': ['telecommunications', 'telecom', 'network'],
        'mechatronics': ['mechatronics', 'robotics', 'automation'],
        'materials': ['materials', 'metallurgical', 'metallurgy'],
        'mining': ['mining', 'minerals', 'extraction'],
        'petroleum': ['petroleum', 'oil', 'gas', 'petroleum process'],
        'agricultural': ['agricultural', 'agriculture', 'farm'],
        'marine': ['marine', 'naval', 'ocean'],
        'safety': ['safety', 'health', 'occupational'],
        'quality': ['quality', 'qa', 'qc']
    }

    # Check if job contains any engineering discipline
    job_title = job_title.lower()
    job_discipline = None

    # First check for exact "<discipline> engineer" patterns
    for discipline, keywords in engineering_disciplines.items():
        for keyword in keywords:
            if f"{keyword} engineer" in job_title:
                job_discipline = discipline
                print(f"Found specific discipline in job title: {discipline} engineer")
                break
        if job_discipline:
            break

    # If no discipline was found, return None
    if not job_discipline:
        return None, None, False

    # Now check client major for the same discipline
    if not client_major:
        return job_discipline, None, False

    client_major = client_major.lower()
    client_discipline = None

    # Check client major for the matching discipline
    for keyword in engineering_disciplines.get(job_discipline, []):
        # Check for both "X engineer" and "X engineering" in major
        if (f"{keyword} engineer" in client_major or
                f"{keyword} engineering" in client_major):
            client_discipline = job_discipline
            print(f"Found matching discipline in client major: {client_discipline}")
            break

    # Check if client has any engineering background
    has_engineering_background = False
    if 'engineer' in client_major or 'engineering' in client_major:
        has_engineering_background = True

    return job_discipline, client_discipline, has_engineering_background


def check_position_match_fast(job_title, client_positions, client_major=None):
    """Fast check if positions match - simple keyword matching"""
    if not job_title or not client_positions:
        return 0.0

    job_title = job_title.lower()
    client_positions = client_positions.lower()
    client_titles = [title.strip().lower() for title in client_positions.split(',') if title.strip()]

    # Check for engineering positions
    if 'engineer' in job_title:
        if client_major:
            # Use dedicated engineering discipline matching function
            job_discipline, client_discipline, has_engineering_background = match_engineering_discipline(job_title,
                                                                                                         client_major)

            # If a specific engineering discipline was found in the job title
            if job_discipline:
                # Perfect match - exact same discipline
                if client_discipline == job_discipline:
                    print(
                        f"PERFECT MATCH: Job requires '{job_discipline} engineer' and client majored in '{job_discipline} engineering'")
                    return 1.0

                # Client has engineering background but different discipline
                elif has_engineering_background:
                    print(
                        f"DISCIPLINE MISMATCH: Job requires '{job_discipline} engineer' but client has different engineering major")
                    return 0.0  # Very low score for different engineering disciplines
                else:
                    print(
                        f"NO ENGINEERING BACKGROUND: Job requires '{job_discipline} engineer' but client has no engineering degree")
                    return 0.0  # Nearly disqualifying for non-engineering background

            # Generic engineering position (no specific discipline detected)
            else:
                if has_engineering_background:
                    # Client has general engineering background for generic position
                    if job_title in client_positions:
                        return 1.0  # Good match for generic engineering position
                    return 0.0  # Acceptable match for general engineer
                else:
                    # No engineering background for engineering position
                    return 0.0  # Low score for non-engineers

    # Direct match (non-engineering specific)
    if job_title in client_titles:
        return 1.0

    # Word overlap
    job_words = set(job_title.split())
    position_words = set(client_positions.split())
    overlap = job_words.intersection(position_words)

    if len(overlap) >= 2:  # At least 2 words overlap
        return 0.9
    elif len(overlap) == 1 and len(job_words) <= 3:  # 1 word overlap in short title
        return 0.0

    return 0.0  # No match


def check_location_match_fast(job_location, client_location):
    """Fast location matching"""
    if not job_location or not client_location:
        return 0.5

    job_location = job_location.lower()

    # Handle multiple client locations
    locations = client_location.split(',') if isinstance(client_location, str) else [client_location]
    locations = [loc.strip().lower() for loc in locations]

    # Direct match check
    for loc in locations:
        if job_location == loc or job_location in loc or loc in job_location:
            return 1.0

    return 0.3  # No direct match


def check_nationality_match_fast(job_nationality, client_nationality):
    """Fast nationality matching"""
    if not job_nationality:
        return 1.0  # No nationality requirement

    if not client_nationality:
        return 0.5  # Client nationality unknown

    job_nat = job_nationality.lower()
    client_nat = client_nationality.lower()

    # Check UAE nationals requirement
    uae_keywords = ['emarati', 'emirati', 'uae national', 'uae', 'Civil Status Summary']

    if any(keyword in job_nat for keyword in uae_keywords):
        return 1.0 if 'uae' in client_nat or 'emirati' in client_nat else 0.0

    return 1.0  # Accept all nationalities for non-UAE specific jobs


def process_job_chunk(chunk_data):
    """Process a chunk of jobs"""
    job_chunk, clients_data, existing_matches = chunk_data
    chunk_matches = []

    for _, job in job_chunk.iterrows():
        job_id = job['id']
        job_title = job.get('job_title', '')
        job_location = job.get('vacancy_city', '')
        application_email = job.get('application_email')
        job_nationality = job.get('nationality', '')
        job_gender = job.get('gender', '')

        # Skip jobs without application email
        if not application_email or pd.isna(application_email):
            continue

        # Pre-check for UAE-only job for faster filtering
        is_uae_only = any(keyword in job_nationality.lower() for keyword in
                          ['emarati', 'emirati', 'uae national', 'uae',
                           'Civil Status Summary']) if job_nationality else False

        job_matches = []

        # First pass: Ultra-fast keyword-based pre-filtering
        for _, client in clients_data.iterrows():
            client_id = client['id']
            client_email = client['email']

            # Skip if this job-client pair already exists
            match_key = f"{client_email}_{job_id}"
            if match_key in existing_matches:
                continue

            # Skip immediately if nationality doesn't match for UAE-only jobs
            if is_uae_only:
                client_nationality = client.get('nationality', '')
                if client_nationality and not ('uae' in client_nationality.lower() or
                                               'emirati' in client_nationality.lower()):
                    continue

            # Fast position matching with major consideration
            client_positions = client.get('positions', '')
            client_major = client.get('major', '')
            position_score = check_position_match_fast(job_title, client_positions, client_major)

            # Only continue if position score is good enough
            if position_score < 0.5:
                continue

            # Fast location matching
            client_location = client.get('job_location_based', client.get('location', ''))
            location_score = check_location_match_fast(job_location, client_location)

            # Fast gender matching
            client_gender = client.get('gender', '')
            gender_score = 1.0 if not job_gender or job_gender in ['any',
                                                                   'male and female'] or job_gender == client_gender else 0.0

            # Simple score computation
            final_score = (0.5 * position_score + 0.3 * location_score + 0.2 * gender_score)

            # Only include matches that pass the threshold
            if final_score >= 0.85:
                job_matches.append({
                    'job_id': job_id,
                    'client_id': client_id,
                    'email': client_email,
                    'application_email': application_email,
                    'final_score': final_score
                })

        # Add matches for this job
        chunk_matches.extend(job_matches)

    return chunk_matches


def main(client_email):
    print("\n" + "="*60)
    print(f"[RANKING] === run_ranking_main() STARTED ===")
    print(f"[RANKING] Client Email: {client_email}")
    print("="*60)
    
    # Connect to PostgreSQL database
    start_time = time.time()

    if client_email is None:
        print(f"[RANKING] ❌ Email is None")
        raise ValueError("Email must be provided")

    print(f"[RANKING] 🔄 Connecting to database...")
    conn = psycopg2.connect(
        dbname=Config.AI_POSTGRES_DB, user=Config.AI_POSTGRES_USER, password=Config.AI_POSTGRES_PASSWORD,
        host=Config.AI_POSTGRES_HOST, port=Config.AI_POSTGRES_PORT,
    )
    conn.autocommit = False
    cursor = conn.cursor()
    print(f"[RANKING] ✅ Database connected")

    # Only load necessary columns to reduce memory usage
    print("[RANKING] Loading data from database...")

    # Ensure tables exist
    print("[RANKING] Ensuring tables exist...")
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS jobs (
            id SERIAL PRIMARY KEY,
            job_title TEXT,
            job_description TEXT,
            vacancy_city TEXT,
            gender TEXT,
            nationality TEXT,
            application_email TEXT,
            job_date TEXT
        );
    """)
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
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS blocked (
            id SERIAL PRIMARY KEY,
            email TEXT,
            job_title TEXT,
            created_at TIMESTAMP DEFAULT NOW()
        );
    """)
    conn.commit()
    print("[RANKING] ✅ Tables verified")

    # Check if Nationality column exists in jobs
    cursor.execute("SELECT column_name FROM information_schema.columns WHERE table_name = 'jobs'")
    columns = [row[0] for row in cursor.fetchall()]
    two_months_ago = (datetime.now() - timedelta(days=60)).strftime("%Y-%m-%d")

    if 'nationality' in columns:
        jobs_query = """
                     SELECT id, \
                            job_title, \
                            job_description, \
                            vacancy_city,
                            gender, \
                            nationality, \
                            application_email
                     FROM jobs \
                     WHERE job_date >= %s \
                     """
    else:
        print("Nationality column not found, using query without it")
        jobs_query = """
                     SELECT id, \
                            job_title, \
                            job_description, \
                            vacancy_city,
                            gender, \
                            application_email
                     FROM jobs \
                     WHERE job_date >= %s \
                     """

    # Execute the query and fetch results into a DataFrame
    cursor.execute(jobs_query, (two_months_ago,))
    rows = cursor.fetchall()
    columns = [desc[0] for desc in cursor.description]
    jobs_df = pd.DataFrame(rows, columns=columns)

    # Add Nationality column if it doesn't exist
    if 'nationality' not in jobs_df.columns:
        jobs_df['nationality'] = ''

    query = f"""
        SELECT id, name, email, positions, job_location_based, location,
               skills, keywords, gender, nationality, degree, jobs_to_apply_number,
               filename, major
        FROM clients
        WHERE jobs_to_apply_number > 0  AND email = '{client_email}'
    """

    print(f"[RANKING] 📋 Fetching client data for: {client_email}")
    clients_df = pd.read_sql_query(query, conn)
    print(f"[RANKING] 📊 Clients loaded: {len(clients_df)} rows")
    
    if len(clients_df) == 0:
        print(f"[RANKING] ❌ No client found with email: {client_email}")
        print(f"[RANKING] ❌ Check if client exists in clients table with jobs_to_apply_number > 0")
    else:
        print(f"[RANKING] ✅ Client found:")
        for idx, row in clients_df.iterrows():
            print(f"[RANKING]   Name: {row.get('name', 'N/A')}")
            print(f"[RANKING]   Positions: {row.get('positions', 'N/A')}")
            print(f"[RANKING]   Skills: {row.get('skills', 'N/A')[:100]}..." if row.get('skills') else "[RANKING]   Skills: N/A")
            print(f"[RANKING]   Location: {row.get('location', 'N/A')}")
            print(f"[RANKING]   jobs_to_apply_number: {row.get('jobs_to_apply_number', 'N/A')}")

    print(f"[RANKING] 📊 Loaded {len(jobs_df)} jobs and {len(clients_df)} clients")

    # Preprocess data - minimal processing
    print("Preprocessing data...")
    for col in ['job_title', 'vacancy_city', 'gender', 'nationality']:
        if col in jobs_df.columns:
            jobs_df[col] = jobs_df[col].apply(preprocess_text)

    for col in ['positions', 'job_location_based', 'location', 'gender', 'nationality']:
        if col in clients_df.columns:
            clients_df[col] = clients_df[col].apply(preprocess_text)

    # Use job_location_based or fallback to location
    clients_df['job_location_based'] = clients_df.apply(
        lambda row: row['job_location_based'] if pd.notna(row['job_location_based']) else row['location'],
        axis=1
    )

    # Load existing matches to avoid duplicates
    print("Loading existing matches...")
    existing_matches = set()
    try:
        cursor.execute("SELECT email, job_id FROM rankings")
        for email, job_id in cursor.fetchall():
            existing_matches.add(f"{email}_{job_id}")
        print(f"Loaded {len(existing_matches)} existing matches")
    except Exception as e:
        print(f"Error loading existing matches: {e}")
        conn.rollback() # Reset transaction after error

    # Load email to userId mapping from User table for notifications
    print("Loading email to userId mapping for notifications...")
    email_to_userid = {}
    try:
        cursor.execute("SELECT email, id FROM \"User\"")
        for email, user_id in cursor.fetchall():
            if email:
                email_to_userid[email.lower()] = user_id
        print(f"Loaded {len(email_to_userid)} email-to-userId mappings")
    except Exception as e:
        print(f"Error loading User mappings: {e}")
        conn.rollback()

    # Load blocked job-client pairs
    print("Loading blocked job-client pairs...")
    blocked_pairs = set()
    try:
        cursor.execute("SELECT email, job_title FROM blocked")
        for email, job_title in cursor.fetchall():
            blocked_pairs.add((email.lower(), job_title.lower()))
        print(f"Loaded {len(blocked_pairs)} blocked pairs")
    except Exception as e:
        print(f"Error loading blocked pairs: {e}")
        conn.rollback() # Reset transaction after error

    print("Starting synchronous processing...")
    all_jobs_data = (jobs_df, clients_df, existing_matches)
    all_matches = process_job_chunk(all_jobs_data)

    print(f"[RANKING] ✅ Synchronous processing completed. Found {len(all_matches)} matches in {time.time() - start_time:.1f}s")
    
    if len(all_matches) == 0:
        print(f"[RANKING] ⚠️ WARNING: No matches found!")
        print(f"[RANKING] ⚠️ Possible reasons:")
        print(f"[RANKING]   1. Client has jobs_to_apply_number = 0")
        print(f"[RANKING]   2. No jobs match client's positions/locations")
        print(f"[RANKING]   3. All matches already exist in rankings table")
        print(f"[RANKING]   4. Client data is incomplete (missing positions, skills, etc.)")

    # Create indexes for faster lookups
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_rankings_email_job ON rankings(email, job_id)")
    conn.commit()

    # Prepare for batch insertion
    inserted = 0
    current_date = datetime.now().strftime('%Y-%m-%d')

    # Create a mapping of IDs to rows for faster lookups
    jobs_dict = {row['id']: row for _, row in jobs_df.iterrows()}
    clients_dict = {row['email']: row for _, row in clients_df.iterrows()}

    # Insert matches in batches
    batch_size = 1000
    batch_values = []

    print(f"[RANKING] 🔄 Starting batch insertion...")
    print(f"[RANKING] Total matches to insert: {len(all_matches)}")

    # Reset the sequence for the rankings table
    cursor.execute("""
                   SELECT setval(pg_get_serial_sequence('rankings', 'id'), COALESCE(MAX(id), 1))
                   FROM rankings;
                   """)
    conn.commit()
    insert_query = """
                   INSERT INTO rankings (client_id, job_id, name, email, major, location, skills, keywords, job_title, \
                                         job_description, job_application_email, filename, status, date, score, degree) \
                   VALUES %s ON CONFLICT (id) DO NOTHING; \
                   """

    try:
        # Create a set to track unique matches to avoid duplicates within the current batch
        unique_matches = set()

        # Pre-fetch existing matches to avoid duplicate database queries
        cursor.execute("""
                       SELECT client_id, job_title, job_application_email
                       FROM rankings
                       """)
        existing_match_records = set()
        for row in cursor.fetchall():
            existing_match_records.add((row[0], row[1], row[2]))
        print(f"[RANKING] 📊 Loaded {len(existing_match_records)} existing match records for duplicate checking")

        for match in all_matches:
            job_id = match['job_id']
            client_email = match['email']

            # Get job and client data from dictionaries
            job_row = jobs_dict.get(job_id)
            client_row = clients_dict.get(client_email)

            if job_row is None or client_row is None:
                continue

            # Extract values safely, converting to string and handling None values
            def safe_get(row, key, default=''):
                val = row.get(key, default)
                return str(val) if val is not None else ''

            client_id = safe_get(client_row, 'id')
            job_title = safe_get(job_row, 'job_title')
            job_application_email = match['application_email']

            # Check if this match is blocked
            if (client_email.lower(), job_title.lower()) in blocked_pairs:
                print(f"[RANKING] ⚠️ Skipping blocked pair: {client_email} - {job_title}")
                continue

            # Check if this match already exists in the database or current batch
            match_key = (client_id, job_title, job_application_email)
            if match_key in existing_match_records or match_key in unique_matches:
                continue

            # Add to set of unique matches for this batch
            unique_matches.add(match_key)

            values = (
                client_id,
                job_id,
                safe_get(client_row, 'name'),
                client_email,
                safe_get(client_row, 'major'),
                safe_get(client_row, 'location'),
                safe_get(client_row, 'skills'),
                safe_get(client_row, 'keywords'),
                job_title,
                safe_get(job_row, 'job_description'),
                job_application_email,
                safe_get(client_row, 'filename'),
                'pending',
                current_date,
                round(match['final_score'] * 100, 2),
                safe_get(client_row, 'degree')
            )

            batch_values.append(values)

            # Trigger notification for high-score matches (>= 80%)
            final_score = round(match['final_score'] * 100, 2)
            if final_score >= 80.0:
                user_id = email_to_userid.get(client_email.lower())
                if user_id:
                    notif_title = "New Perfect Job Match! 🚀"
                    notif_message = f"We've found a {final_score}% match for: {job_title}. Check it out!"
                    notif_data = {
                        "jobId": str(job_id),
                        "score": final_score,
                        "type": "job_match",
                        "screen": "/job-detail",  # Deep-link for mobile app
                        "click_action": "FLUTTER_NOTIFICATION_CLICK"
                    }
                    # We don't want to block the ranking process if notification fails
                    try:
                        NotificationService.create_notification(
                            user_id=user_id,
                            title=notif_title,
                            message=notif_message,
                            notification_type='job_match',
                            data=notif_data
                        )
                    except Exception as e:
                        print(f"Failed to trigger notification for match: {e}")

            # Insert when batch is full
            if len(batch_values) >= batch_size:
                try:
                    execute_values(cursor, insert_query, batch_values)
                    inserted += len(batch_values)
                    # Commit each batch immediately
                    conn.commit()
                    print(f"[RANKING] 📊 Inserted {inserted} rankings so far...")
                except Exception as e:
                    print(f"[RANKING] ❌ Error inserting batch: {e}")
                    traceback.print_exc()
                    # Continue with next batch rather than aborting completely
                    conn.rollback()
                batch_values = []

        # Insert any remaining records
        if batch_values:
            try:
                execute_values(cursor, insert_query, batch_values)
                inserted += len(batch_values)
                conn.commit()
                print(f"[RANKING] ✅ Successfully inserted final batch of {len(batch_values)} rankings")
            except Exception as e:
                conn.rollback()
                print(f"[RANKING] ❌ Error inserting final batch: {e}")
                traceback.print_exc()

        # Log success
        print(f"[RANKING] ✅✅✅ Successfully inserted {inserted} total rankings")

    except Exception as e:
        conn.rollback()
        print(f"[RANKING] ❌ Error in insertion process: {e}")
        traceback.print_exc()

    # Verify insertion - check if records were actually inserted
    try:
        cursor.execute("SELECT COUNT(*) FROM rankings WHERE date = %s", (current_date,))
        verification_count = cursor.fetchone()[0]
        print(f"[RANKING] 🔍 Verification: Found {verification_count} records in database with today's date")

        if verification_count == 0 and inserted > 0:
            print("[RANKING] ❌ WARNING: No records found in database despite reported insertions!")
        elif verification_count > 0:
            print(f"[RANKING] ✅ Verification successful: {verification_count} records confirmed")
    except Exception as e:
        print(f"[RANKING] ❌ Verification failed: {e}")
        traceback.print_exc()

    # Performance summary
    elapsed_time = time.time() - start_time
    print(f"\n[RANKING] ==================== PERFORMANCE SUMMARY ====================")
    print(f"[RANKING] Total execution time: {elapsed_time:.2f} seconds")
    print(f"[RANKING] Processed {len(jobs_df)} jobs and {len(clients_df)} clients")
    print(f"[RANKING] Generated {len(all_matches)} matches, inserted {inserted}")
    print(f"[RANKING] Average time per job: {elapsed_time / max(1, len(jobs_df)):.4f} seconds")
    print(f"[RANKING] =============================================================\n")

    # Close connection
    cursor.close()
    conn.close()

    # Continue with job application process
    print("[RANKING] ✅ run_ranking_main() COMPLETED")
    return {
        'execution_time_seconds': round(elapsed_time, 2),
        'jobs_processed': len(jobs_df),
        'clients_processed': len(clients_df),
        'matches_found': len(all_matches),
        'matches_inserted': inserted,
        'existing_matches_skipped': len(existing_matches),
        'blocked_pairs_count': len(blocked_pairs),
        'client_email': client_email,
        'processing_date': current_date
    }

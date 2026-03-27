import json
import os
import re
from datetime import datetime, date

import psycopg2
from docx import Document
from PyPDF2 import PdfReader

from app import Config
from app.services.cv_processor import get_openai_client
from pathlib import Path
import shutil
from datetime import datetime
import subprocess

def cv_parsing_model_chat(messages):
    """Chat with model specifically for CV parsing with temperature control."""
    client, model = get_openai_client()
    response = client.chat.completions.create(
        model=model,
        messages=messages,
        temperature=0.2
    )
    return response.choices[0].message.content


def clean_text(text):
    text = text.strip()
    text = re.sub(r'(?i)(curriculum vitae|resume|cv)\n+', '', text)
    text = re.sub(r'\n+', '\n', text)
    text = re.sub(r'(?i)references available upon request', '', text)
    return text

def extract_cv_data(cv_path):
    text = ""
    cv_path = str(cv_path)
    if cv_path.endswith(".docx"):
        doc = Document(cv_path)
        for paragraph in doc.paragraphs:
            text += paragraph.text + "\n"
    elif cv_path.endswith(".pdf"):
        pdf_reader = PdfReader(cv_path)
        for page in pdf_reader.pages:
            text += page.extract_text() + "\n"
    return clean_text(text)


def parse_cv_data(cv_text):
    prompt = f"""
    Extract the following details from this CV text:
    - Name
    - Email
    - Major: you can use experience to extract it
    - Phone Number
    - Location
    - Skills (as a comma-separated list)
    - Keywords (as a comma-separated list)
    - Degree
    - GPA

    CV text:
    {cv_text}

    Return the information in JSON format.
    """

    messages = [
        {"role": "system", "content": "You are a CV parsing expert."},
        {"role": "user", "content": prompt}
    ]

    content = cv_parsing_model_chat(messages)
    content = content.replace("```json", "").replace("```", "").strip()
    cv_data = json.loads(content)

    return cv_data


def mark_timestamp_as_processed(conn, timestamp):
    try:
        cursor = conn.cursor()
        # Ensure the table exists
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS ProcessedTimestamps (
                id SERIAL PRIMARY KEY,
                timestamp TEXT,
                created_at TIMESTAMP DEFAULT NOW()
            );
        """)
        conn.commit()

        query = "INSERT INTO ProcessedTimestamps (timestamp) VALUES (%s)"
        cursor.execute(query, (timestamp,))
        conn.commit()
        cursor.close()
    except Exception as e:
        print(f"Warning: Failed to mark timestamp as processed: {e}")


def process_ai_job_input(email, resume_path, nationality, gender, location_preferred, preferred_positions):
    try:
        SERVER_CV_DIR = str(Config.CV_STORAGE_PATH)
        os.makedirs(SERVER_CV_DIR, exist_ok=True)


        backup_path = os.path.join(
            SERVER_CV_DIR,
            os.path.basename(resume_path)
        )
        shutil.copy2(resume_path, backup_path)

        cv_text = extract_cv_data(resume_path)
        cv_data = parse_cv_data(cv_text)
        timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

        positions = preferred_positions if preferred_positions else cv_data.get('positions', 'General Positions')
        job_location_based = location_preferred if location_preferred else cv_data.get('Location')

        data = {
            'name': cv_data.get('Name', ''),
            'date_in': datetime.now().strftime('%Y-%m-%d'),
            'email': email,
            'major': cv_data.get('Major', ''),
            'filename': os.path.basename(resume_path),
            'fcv_as_string': cv_text,
            'phone_number': cv_data.get('Phone Number', ''),
            'location': ', '.join(job_location_based) if isinstance(job_location_based, list) else job_location_based,
            'skills': cv_data.get('Skills', ''),
            'keywords': cv_data.get('Keywords', ''),
            'degree': cv_data.get('Degree', ''),
            'GPA': cv_data.get('GPA', ''),
            'job_matching': 1,
            'job_location_based': ', '.join(job_location_based) if isinstance(job_location_based, list) else job_location_based,
            'gender': gender,
            'nationality': nationality,
            'jobs_to_apply_number': 100,
            'positions': ', '.join(positions.split(', ')) if isinstance(positions, str) else positions
        }

        conn = psycopg2.connect(
            dbname=Config.AI_POSTGRES_DB, user=Config.AI_POSTGRES_USER, password=Config.AI_POSTGRES_PASSWORD,
            host=Config.AI_POSTGRES_HOST, port=Config.AI_POSTGRES_PORT
        )
        conn.autocommit = False
        cursor = conn.cursor()

        # Ensure clients table exists
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
        conn.commit()

        cursor.execute("SELECT 1 FROM clients WHERE email = %s", (data['email'],))
        if cursor.fetchone():
            print(f"Email {data['email']} already exists.")
            mark_timestamp_as_processed(conn, timestamp)
            return data['email']

        columns = ', '.join(data.keys())
        placeholders = ', '.join(['%s'] * len(data))
        query = f"INSERT INTO clients ({columns}) VALUES ({placeholders})"
        cursor.execute(query, tuple(data.values()))
        conn.commit()

        mark_timestamp_as_processed(conn, timestamp)
        return data['email']
    except Exception as e:
        print(f"Error processing CV: {e}")
        return None

def process_ai_job_input_not_active(email, resume_path, nationality, gender, location_preferred, preferred_positions):
   try:
        SERVER_CV_DIR = str(Config.CV_STORAGE_PATH / "temp_CVs")
        os.makedirs(SERVER_CV_DIR, exist_ok=True)
        resume_path = str(resume_path)

        backup_path = os.path.join(
            SERVER_CV_DIR,
            os.path.basename(resume_path)
        )
        shutil.copy2(resume_path, backup_path)

        cv_text = extract_cv_data(resume_path)
        cv_data = parse_cv_data(cv_text)
        timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

        positions = preferred_positions if preferred_positions else cv_data.get('positions', 'General Positions')
        job_location_based = location_preferred if location_preferred else cv_data.get('Location')

        data = {
            'name': cv_data.get('Name', ''),
            'date_in': datetime.now().strftime('%Y-%m-%d'),
            'email': email,
            'major': cv_data.get('Major', ''),
            'filename': os.path.basename(resume_path),
            'fcv_as_string': cv_text,
            'phone_number': cv_data.get('Phone Number', ''),
            'location': ', '.join(job_location_based) if isinstance(job_location_based, list) else job_location_based,
            'skills': cv_data.get('Skills', ''),
            'keywords': cv_data.get('Keywords', ''),
            'degree': cv_data.get('Degree', ''),
            'GPA': cv_data.get('GPA', ''),
            'job_matching': 0,
            'job_location_based': ', '.join(job_location_based) if isinstance(job_location_based, list) else job_location_based,
            'gender': gender,
            'nationality': nationality,
            'jobs_to_apply_number': 0,
            'positions': ', '.join(positions.split(', ')) if isinstance(positions, str) else positions
        }

        conn = psycopg2.connect(
            dbname=Config.AI_POSTGRES_DB, user=Config.AI_POSTGRES_USER, password=Config.AI_POSTGRES_PASSWORD,
            host=Config.AI_POSTGRES_HOST, port=Config.AI_POSTGRES_PORT
        )
        conn.autocommit = False
        cursor = conn.cursor()

        # Ensure clients table exists
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
        conn.commit()

        cursor.execute("SELECT 1 FROM clients WHERE email = %s", (data['email'],))
        if cursor.fetchone():
            print(f"Email {data['email']} already exists.")
            mark_timestamp_as_processed(conn, timestamp)
            return data['email']

        columns = ', '.join(data.keys())
        placeholders = ', '.join(['%s'] * len(data))
        query = f"INSERT INTO clients ({columns}) VALUES ({placeholders})"
        cursor.execute(query, tuple(data.values()))
        conn.commit()

        mark_timestamp_as_processed(conn, timestamp)
        return data['email']
   except Exception as e:
        print(f"Error processing CV: {e}")
        return None
   
def activate_client_job_apply(email, jobs_number):
    try:
        conn = psycopg2.connect(
            dbname=Config.AI_POSTGRES_DB,
            user=Config.AI_POSTGRES_USER,
            password=Config.AI_POSTGRES_PASSWORD,
            host=Config.AI_POSTGRES_HOST,
            port=Config.AI_POSTGRES_PORT
        )
        conn.autocommit = False
        cursor = conn.cursor()

        cursor.execute(
            """
            UPDATE Clients
            SET job_matching = 1,
                jobs_to_apply_number = %s
            WHERE email = %s
            """,
            (jobs_number, email)
        )

        if cursor.rowcount == 0:
            conn.rollback()
            return False

        conn.commit()
        return True

    except Exception as e:
        print(f"Error activating job matching: {e}")
        if conn:
            conn.rollback()
        return False
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()


def get_jobs_by_email(email: str):
    query = """
        SELECT
            job_title,
            company_name,
            job_location,
            job_description,
            status,
            score
        FROM rankings
        WHERE LOWER(email) = LOWER(%s)
        ORDER BY score DESC
    """

    conn = psycopg2.connect(
        dbname=Config.AI_POSTGRES_DB,
        user=Config.AI_POSTGRES_USER,
        password=Config.AI_POSTGRES_PASSWORD,
        host=Config.AI_POSTGRES_HOST,
        port=Config.AI_POSTGRES_PORT
    )

    try:
        with conn.cursor(cursor_factory=RealDictCursor) as cursor:
            cursor.execute(query, (email,))
            rows = cursor.fetchall()

            return {
                "email": email,
                "count": len(rows),
                "jobs": rows
            }

    finally:
        conn.close()

def serialize_row(row: dict):
    for key, value in row.items():
        if isinstance(value, (datetime, date)):
            row[key] = value.isoformat()
    return row     

def get_client_job_settings(cursor, email: str):
    cursor.execute("""
        SELECT
            job_matching,
            jobs_to_apply_number
        FROM clients
        WHERE LOWER(email) = LOWER(%s)
        LIMIT 1
    """, (email,))

    row = cursor.fetchone()

    if not row:
        return {
            "job_matching": None,
            "jobs_to_apply_number": None
        }

    return {
        "job_matching": row[0],
        "jobs_to_apply_number": row[1]
    }

def suggest_job_titles_from_resume(resume_path):
    cv_text = extract_cv_data(resume_path)

    messages = [
        {
            "role": "system",
            "content": (
                "You are an expert recruitment and HR AI. "
                "Your task is to analyze CVs and suggest suitable job titles."
            )
        },
        {
            "role": "user",
            "content": (
                "Based on the following CV text, suggest the most relevant job titles.\n\n"
                "Rules:\n"
                "- Return ONLY job titles\n"
                "- No explanations\n"
                "- 5 to 10 job titles\n"
                "- Titles must be realistic and ATS-friendly\n"
                "- One title per line\n\n"
                f"CV TEXT:\n{cv_text}"
            )
        }
    ]

    response = cv_parsing_model_chat(messages)

    # Normalize output
    job_titles = [
        title.strip()
        for title in response.split("\n")
        if title.strip()
    ]

    return job_titles



def get_client_cv_filename(email):
    conn = None
    try:
        conn = psycopg2.connect(
            dbname=Config.AI_POSTGRES_DB,
            user=Config.AI_POSTGRES_USER,
            password=Config.AI_POSTGRES_PASSWORD,
            host=Config.AI_POSTGRES_HOST,
            port=Config.AI_POSTGRES_PORT
        )

        query = """
            SELECT filename
            FROM clients
            WHERE email = %s
            LIMIT 1
        """

        with conn.cursor() as cur:
            cur.execute(query, (email,))
            row = cur.fetchone()
            return row[0] if row and row[0] else None

    except psycopg2.Error as e:
        # Optional: log this
        raise Exception(f"Database error while fetching CV filename: {e}")

    finally:
        if conn:
            conn.close()


LIBREOFFICE_BIN = "/usr/lib/libreoffice/program/soffice.bin"

def convert_docx_to_pdf(docx_path: Path) -> Path:
    pdf_path = docx_path.with_suffix(".pdf")

    cmd = [
        LIBREOFFICE_BIN,
        "--headless",
        "--convert-to", "pdf",
        "--outdir", str(docx_path.parent),
        str(docx_path)
    ]

    result = subprocess.run(
        cmd,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        env={"PATH": "/usr/bin:/bin"}  # force basic tools
    )

    if result.returncode != 0:
        raise RuntimeError(
            "LibreOffice failed:\n" + result.stderr.decode()
        )

    if not pdf_path.exists():
        raise RuntimeError("PDF not created")

    return pdf_path

PANDOC_BIN = "/usr/bin/pandoc"

def convert_docx_to_pdf_new(docx_path: Path) -> Path:
    pdf_path = docx_path.with_suffix(".pdf")

    result = subprocess.run(
        [PANDOC_BIN, str(docx_path), "-o", str(pdf_path)],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE
    )

    if result.returncode != 0:
        raise RuntimeError(result.stderr.decode())

    if not pdf_path.exists():
        raise RuntimeError("PDF was not created")

    return pdf_path

import psycopg2

def update_client_cv_filename(email, new_filename):
    conn = None
    try:
        conn = psycopg2.connect(
            dbname=Config.AI_POSTGRES_DB,
            user=Config.AI_POSTGRES_USER,
            password=Config.AI_POSTGRES_PASSWORD,
            host=Config.AI_POSTGRES_HOST,
            port=Config.AI_POSTGRES_PORT
        )

        query = """
            UPDATE clients
            SET filename = %s
            WHERE email = %s
        """

        with conn.cursor() as cur:
            cur.execute(query, (new_filename, email))
            conn.commit()

            # Optional: check if anything was updated
            if cur.rowcount == 0:
                raise Exception("No client found with the given email")

    except psycopg2.Error as e:
        if conn:
            conn.rollback()
        raise Exception(f"Database error while updating CV filename: {e}")

    finally:
        if conn:
            conn.close()

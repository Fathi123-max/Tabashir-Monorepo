import os
import smtplib
from datetime import datetime
from email import encoders
from email.mime.base import MIMEBase
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

import psycopg2

from app import Config
from app.services.cv_processor import get_openai_client

# Email credentials
SMTP_SERVER = "smtp.hostinger.com"
SMTP_PORT = 465
EMAIL_ADDRESS = "application@tabashirai.com"
EMAIL_PASSWORD = "Tabashir@uae2024#*"


def generate_cover_letter(client_details, job_description):
    prompt = f"""
    Create a professional cover letter for the following candidate applying for the given job. Use the exact format provided below and avoid using any formatting like stars, bold text, or special characters. Only plain text is allowed.

    ---
    Subject: Application for [Job Title] – [Your Name]

    Dear Hiring Manager,

    I am writing to express my interest in the [Job Title] position at your esteemed organization. As a dedicated professional with a strong background in [Your Field], I believe my qualifications and skills align well with the requirements of this role.

    I hold a [Your Educational Qualification] and have developed a robust skill set through my academic and professional experiences. My expertise includes [List Key Skills Relevant to the Job]. Additionally, I possess strong [List Soft Skills Relevant to the Job], which are essential for excelling in this role.

    Throughout my career, I have successfully demonstrated my ability to [Mention a Key Achievement or Experience That Matches the Job Requirements]. My attention to detail, compliance, and ability to multitask under pressure have consistently contributed to achieving positive outcomes.

    I am eager to bring my skills and experience to your organization and contribute to its continued success. I am available for an interview at your convenience and look forward to the opportunity to discuss how I can add value to your team.

    Thank you for your time and consideration.

    Best Regards,
    [Your Name]
    [Email]
    ---

    Candidate Details:
    Name: {client_details['name']}
    Email: {client_details['email']}
    Major: {client_details['major']}
    Skills: {client_details['skills']}
    Degree: {client_details['Degree']}
    Experience: {client_details.get('experience', 'X years')}  # Add experience if available

    Job Description:
    {job_description}

    Important Note: Do not use any formatting (like **stars**, bold, or italics). Only plain text is allowed in the output.
    """

    messages = [
        {"role": "user", "content": prompt}
    ]
    client, model = get_openai_client()
    response = client.chat.completions.create(
        model=model,
        messages=messages,
        temperature=0.7
    )

    cover_letter = response.choices[0].message.content

    return cover_letter


def send_email(to_email, cc_email, subject, cover_letter, pdf_path):
    try:
        cover_letter_lines = cover_letter.split("\n")
        cover_letter_body = "\n".join(cover_letter_lines[1:])

        msg = MIMEMultipart()
        msg['From'] = EMAIL_ADDRESS
        msg['To'] = f"{to_email}, {cc_email}"
        msg['Bcc'] = 'application@tabashirai.com'
        msg['Subject'] = subject

        msg.attach(MIMEText(cover_letter_body, 'plain'))

        with open(pdf_path, "rb") as attachment:
            mime_base = MIMEBase('application', 'pdf')  # Correct MIME type for PDF
            mime_base.set_payload(attachment.read())
            encoders.encode_base64(mime_base)
            mime_base.add_header(
                'Content-Disposition',
                f'attachment; filename="{os.path.basename(pdf_path)}"'  # Explicitly specify the filename
            )
            msg.attach(mime_base)

        server = smtplib.SMTP_SSL(SMTP_SERVER, SMTP_PORT)
        server.login(EMAIL_ADDRESS, EMAIL_PASSWORD)
        server.send_message(msg)
        server.quit()

        print(f"Email sent to {to_email}")

    except Exception as e:
        print(f"Failed to send email to {to_email}: {e}")


def update_status_to_applied(conn, match_id):
    try:
        cursor = conn.cursor()

        cursor.execute("""
                       UPDATE rankings
                       SET status = 'applied'
                       WHERE id = %s
                       """, (match_id,))
        conn.commit()

        if cursor.rowcount > 0:
            print(f"Status updated to 'applied' for match ID {match_id}")
        else:
            print(f"No updates made for match ID {match_id}. Check if the ID is correct.")
    except Exception as e:
        print(f"Failed to update status for match ID {match_id}: {e}")


def decrement_jobs_to_apply(conn, client_email):
    try:
        cursor = conn.cursor()

        cursor.execute("""
                       UPDATE clients
                       SET jobs_to_apply_number = jobs_to_apply_number - 1
                       WHERE email = %s
                         AND jobs_to_apply_number > 0
                       """, (client_email,))
        conn.commit()

        if cursor.rowcount > 0:
            print(f"Decremented jobs_to_apply_number for client {client_email}")
        else:
            print(
                f"No updates made for client {client_email}. Check if the email is correct or jobs_to_apply_number is already 0.")

    except Exception as e:
        print(f"Failed to decrement jobs_to_apply_number for client {client_email}: {e}")


def apply(email, file_path):
    current_date = datetime.now().strftime("%Y-%m-%d")
    try:
        conn = psycopg2.connect(
            dbname=Config.AI_POSTGRES_DB, user=Config.AI_POSTGRES_USER, password=Config.AI_POSTGRES_PASSWORD,
            host=Config.AI_POSTGRES_HOST, port=Config.AI_POSTGRES_PORT,
        )
        cursor = conn.cursor()

        cursor.execute("""
                       SELECT id,
                              name,
                              email,
                              major,
                              location,
                              skills,
                              keywords,
                              job_description,
                              filename,
                              job_application_email,
                              job_title,
                              degree
                       FROM rankings
                       WHERE status = 'pending' and email = %s
                       """, (email,))
        matches = cursor.fetchall()
        match_id = None
        for match in matches:
            try:
                match_id, name, email, major, location, skills, keywords, job_description, filename, job_application_email, job_title, Degree = match

                client_details = {
                    'name': name,
                    'email': email,
                    'major': major,
                    'location': location,
                    'skills': skills,
                    'keywords': keywords,
                    'Degree': Degree
                }

                if not file_path:
                    print(f"File missing for {filename}. Skipping match ID {match_id}.")
                    continue

                cover_letter = generate_cover_letter(client_details, job_description)
                subject = "Job Application"
                send_email(job_application_email, email, subject, cover_letter, file_path)
                update_status_to_applied(conn, match_id)
                decrement_jobs_to_apply(conn, email)

            except Exception as e:
                print(f"Error processing match ID {match_id}: {e}")

        conn.close()

        return {
            "email": email,
            "date": current_date,
            "matches_processed": len(matches)
        }

    except Exception as e:
        print(f"Failed to fetch matches: {e}")


def apply_single_job(email, file_path, job_id):
    from psycopg2.extras import RealDictCursor
    current_date = datetime.now().strftime("%Y-%m-%d")
    inserted_ranking_id = None

    try:
        conn = psycopg2.connect(
            dbname=Config.AI_POSTGRES_DB, user=Config.AI_POSTGRES_USER,
            password=Config.AI_POSTGRES_PASSWORD,
            host=Config.AI_POSTGRES_HOST, port=Config.AI_POSTGRES_PORT,
        )
        conn.autocommit = False
        cursor = conn.cursor(cursor_factory=RealDictCursor)

        # Fetch client and job data
        cursor.execute("""
            SELECT id as client_id, name, email, major, location, skills,
                   keywords, gender, nationality, degree, filename
            FROM clients
            WHERE email = %s
        """, (email,))
        client = cursor.fetchone()

        if not client:
            raise ValueError(f"No client found for email: {email}")

        cursor.execute("""
            SELECT id as job_id, job_title, job_description, vacancy_city,
                   gender, nationality, application_email
            FROM jobs
            WHERE id = %s
        """, (job_id,))
        job = cursor.fetchone()

        if not job:
            raise ValueError(f"No job found with ID: {job_id}")

        # Insert ranking with 'pending' status, return its id
        cursor.execute("""
            INSERT INTO rankings (client_id, job_id, name, email, major, location, skills,
                                  keywords, job_title, job_description, job_application_email,
                                  filename, status, date, score, degree)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, 'pending', %s, %s, %s)
            RETURNING id
        """, (
            client['client_id'], job['job_id'], client['name'], client['email'], client['major'],
            client['location'], client['skills'], client['keywords'], job['job_title'],
            job['job_description'], job['application_email'], client['filename'],
            current_date, 100.0, client['degree']
        ))
        inserted_ranking_id = cursor.fetchone()['id']
        print(f"Inserted ranking with ID: {inserted_ranking_id}")

        # Now retrieve and apply only that inserted row
        cursor.execute("""
            SELECT id, name, email, major, location, skills, keywords,
                   job_description, filename, job_application_email,
                   job_title, degree
            FROM rankings
            WHERE id = %s
        """, (inserted_ranking_id,))
        match = cursor.fetchone()

        if not match:
            raise ValueError("Failed to retrieve inserted ranking by ID")

        client_details = {
            'name': match['name'],
            'email': match['email'],
            'major': match['major'],
            'location': match['location'],
            'skills': match['skills'],
            'keywords': match['keywords'],
            'Degree': match['degree']
        }

        cover_letter = generate_cover_letter(client_details, match['job_description'])
        subject = "Job Application"
        send_email(match['job_application_email'], email, subject, cover_letter, file_path)

        update_status_to_applied(conn, match['id'])
        decrement_jobs_to_apply(conn, email)

        conn.commit()
        return {
            "email": email,
            "date": current_date,
            "job_applied": job_id,
            "ranking_id": inserted_ranking_id
        }

    except Exception as e:
        if conn:
            conn.rollback()
        print(f"Error in apply_single_job: {e}")
        raise
    finally:
        if conn:
            conn.close()


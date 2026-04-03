"""
Comprehensive seed script for the AI backend PostgreSQL database.
Populates the `clients` table with 100+ realistic fake candidate profiles.

Usage:
    cd tabashir-backend
    source venv/bin/activate
    python scripts/seed_ai_db.py

Dependencies:
    pip install Faker psycopg2-binary
"""

import os
import sys
import random
from datetime import datetime, timedelta

import psycopg2
from faker import Faker

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------

# Load environment variables from .env if present
from dotenv import load_dotenv
load_dotenv()

DB_HOST = os.getenv("AI_POSTGRES_HOST", "localhost")
DB_PORT = os.getenv("AI_POSTGRES_PORT", "5432")
DB_NAME = os.getenv("AI_POSTGRES_DB", "tabashir_ai")
DB_USER = os.getenv("AI_POSTGRES_USER", "Apple")
DB_PASSWORD = os.getenv("AI_POSTGRES_PASSWORD", "")

NUM_RECORDS = 120  # Number of client records to generate

# ---------------------------------------------------------------------------
# Data pools
# ---------------------------------------------------------------------------

POSITIONS_POOL = [
    "Software Engineer", "Senior Developer", "Product Manager", "Data Scientist",
    "DevOps Engineer", "UX Designer", "Full Stack Developer", "Backend Engineer",
    "Frontend Developer", "ML Engineer", "Cloud Architect", "Mobile Developer",
    "QA Engineer", "Technical Lead", "Engineering Manager", "Solutions Architect",
    "Site Reliability Engineer", "Data Engineer", "Security Engineer",
    "Blockchain Developer", "AI Engineer", "Systems Engineer",
    "Database Administrator", "Scrum Master", "Business Analyst",
]

SKILLS_POOL = [
    "JavaScript", "TypeScript", "Python", "React", "Node.js", "Flutter", "Dart",
    "AWS", "Azure", "GCP", "Docker", "Kubernetes", "PostgreSQL", "MongoDB",
    "Redis", "Git", "CI/CD", "Agile", "Scrum", "REST APIs", "GraphQL",
    "Microservices", "Terraform", "Jenkins", "Linux", "Java", "Spring Boot",
    ".NET", "C#", "Go", "Rust", "Swift", "Kotlin", "iOS", "Android",
    "Figma", "Adobe XD", "Machine Learning", "Deep Learning", "TensorFlow",
    "PyTorch", "SQL", "NoSQL", "Elasticsearch", "Kafka", "RabbitMQ",
    "Nginx", "Apache", "MySQL", "DynamoDB", "S3", "Lambda", "EC2",
]

LOCATIONS_POOL = [
    "Dubai, UAE", "Abu Dhabi, UAE", "Sharjah, UAE", "Riyadh, Saudi Arabia",
    "Jeddah, Saudi Arabia", "Doha, Qatar", "Manama, Bahrain", "Muscat, Oman",
    "Cairo, Egypt", "Alexandria, Egypt", "Bangalore, India", "Mumbai, India",
    "London, UK", "Remote", "Kuwait City, Kuwait", "Amman, Jordan",
    "Beirut, Lebanon", "Casablanca, Morocco",
]

NATIONALITIES_POOL = [
    "Emirati", "Saudi", "Egyptian", "Indian", "Pakistani", "British",
    "American", "Filipino", "Lebanese", "Jordanian", "Syrian", "Moroccan",
    "Tunisian", "Sudanese", "Kenyan", "Nigerian", "Yemeni", "Iraqi",
    "Palestinian", "Bangladeshi", "Sri Lankan", "Nepalese", "Indonesian",
    "Malaysian", "Turkish", "South African", "Ethiopian", "Ghanaian",
]

DEGREES_POOL = [
    "Bachelor of Science in Computer Science",
    "Master of Business Administration",
    "Bachelor of Engineering",
    "Master of Science in Data Science",
    "PhD in Artificial Intelligence",
    "Bachelor of Information Technology",
    "Diploma in Software Engineering",
    "Bachelor of Science in Software Engineering",
    "Master of Science in Computer Science",
    "Bachelor of Science in Information Systems",
    "Master of Science in Artificial Intelligence",
    "PhD in Computer Science",
    "Bachelor of Science in Cybersecurity",
    "Master of Science in Cybersecurity",
    "Diploma in Information Technology",
    "Bachelor of Science in Electrical Engineering",
    "Master of Science in Machine Learning",
    "Bachelor of Commerce",
    "Master of Science in Software Engineering",
    "PhD in Data Science",
]

MAJORS_POOL = [
    "Computer Science", "Software Engineering", "Information Technology",
    "Data Science", "Business Administration", "Computer Engineering",
    "Electrical Engineering", "Artificial Intelligence", "Cybersecurity",
    "Information Systems", "Mathematics", "Statistics", "Mechanical Engineering",
    "Finance", "Marketing", "Communications",
]

GENDERS_POOL = ["Male", "Female"]

GPA_POOL = [
    "3.9", "3.8", "3.7", "3.6", "3.5", "3.4", "3.3", "3.2", "3.1", "3.0",
    "2.9", "2.8", "3.85", "3.75", "3.65", "3.55", "3.45",
    "4.0", "First Class Honours", "Second Class Upper", "Second Class Lower",
]

# CV text templates for realistic fcv_as_string
CV_TEMPLATES = [
    """{name}
{email} | {phone} | {location}

PROFESSIONAL SUMMARY
Experienced {position} with {years} years of expertise in {skill1}, {skill2}, and {skill3}.
Proven track record of delivering high-quality software solutions in fast-paced environments.

EXPERIENCE

{position} | {company} | {start_year} - Present
- Led development of scalable microservices architecture serving 100K+ users
- Implemented CI/CD pipelines reducing deployment time by 60%
- Mentored junior developers and conducted code reviews
- Collaborated with cross-functional teams to deliver products on time

Junior {position} | {prev_company} | {prev_start_year} - {end_year}
- Developed and maintained web applications using {skill4} and {skill5}
- Participated in agile ceremonies and sprint planning
- Wrote comprehensive unit and integration tests

EDUCATION
{degree}
{major} | GPA: {gpa}

SKILLS
{skills}

LANGUAGES
English (Fluent), Arabic (Conversational)
""",
    """{name}
{location} | {email} | {phone}

CAREER OBJECTIVE
Motivated {position} seeking to leverage {years}+ years of experience in building
innovative technology solutions. Specialized in {skill1} and {skill2}.

WORK EXPERIENCE

Senior {position}
{company}, {location}
{start_year} - Present

Key Achievements:
- Architected cloud-native applications on {skill3} reducing infrastructure costs by 40%
- Designed and implemented RESTful APIs consumed by mobile and web clients
- Led migration from monolith to microservices architecture
- Established coding standards and best practices across the team

{position}
{prev_company}, {location}
{prev_start_year} - {end_year}

- Built responsive web interfaces using {skill4}
- Optimized database queries improving performance by 35%
- Integrated third-party payment and notification services

EDUCATION
{degree}
GPA: {gpa}

TECHNICAL SKILLS
Programming: {skill1}, {skill2}, {skill5}
Frameworks: {skill3}, {skill4}
Tools: Git, Docker, Jenkins, Jira
Databases: PostgreSQL, MongoDB, Redis
""",
    """CURRICULUM VITAE

{name}
Email: {email}
Phone: {phone}
Location: {location}
Nationality: {nationality}

SUMMARY
Results-driven {position} with extensive experience in {skill1}, {skill2},
and {skill3}. Adept at translating business requirements into technical solutions.

PROFESSIONAL EXPERIENCE

{company} — {location}
{position} ({start_year} - Present)
• Spearheaded the development of a real-time analytics dashboard
• Reduced application load time by 50% through performance optimization
• Managed a team of 5 developers in an agile environment
• Implemented automated testing achieving 90%+ code coverage

{prev_company} — {location}
{position} ({prev_start_year} - {end_year})
• Developed and deployed {skill4}-based microservices
• Collaborated with product managers to define feature requirements
• Conducted technical interviews and onboarded new team members

EDUCATION
{degree}
{major} — GPA: {gpa}

CORE COMPETENCIES
{skills}

CERTIFICATIONS
- AWS Certified Solutions Architect
- Certified Scrum Master (CSM)
""",
]


def get_connection():
    """Establish connection to the AI backend PostgreSQL database."""
    return psycopg2.connect(
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
        host=DB_HOST,
        port=DB_PORT,
    )


def pick_random(items, count=None):
    """Pick one or more random items from a list."""
    if count is None:
        return random.choice(items)
    count = min(count, len(items))
    return random.sample(items, count)


def generate_cv_text(fake, name, email, phone, location, nationality, position,
                     degree, major, gpa, skills):
    """Generate a realistic CV text string."""
    template = random.choice(CV_TEMPLATES)
    years = random.randint(2, 15)
    current_year = datetime.now().year
    start_year = current_year - years
    end_year = start_year + random.randint(2, 5)
    prev_start_year = start_year - random.randint(1, 4)

    skill_list = skills.split(", ")
    return template.format(
        name=name,
        email=email,
        phone=phone,
        location=location,
        nationality=nationality,
        position=position,
        years=years,
        skill1=skill_list[0] if len(skill_list) > 0 else "Python",
        skill2=skill_list[1] if len(skill_list) > 1 else "JavaScript",
        skill3=skill_list[2] if len(skill_list) > 2 else "AWS",
        skill4=skill_list[3] if len(skill_list) > 3 else "React",
        skill5=skill_list[4] if len(skill_list) > 4 else "Docker",
        skills=skills,
        degree=degree,
        major=major,
        gpa=gpa,
        company=fake.company(),
        prev_company=fake.company(),
        start_year=start_year,
        end_year=end_year,
        prev_start_year=prev_start_year,
    )


def generate_client(faker_en, faker_ar, faker_in):
    """Generate a single realistic client record."""
    # Randomly pick a faker locale for variety
    faker = random.choice([faker_en, faker_ar, faker_in])

    name = faker.name()
    email = faker.email().lower()
    phone = faker.phone_number()

    # Ensure phone looks somewhat realistic for GCC
    if random.random() > 0.5:
        phone = f"+971{random.randint(50, 56)}{random.randint(1000000, 9999999)}"

    nationality = pick_random(NATIONALITIES_POOL)
    gender = pick_random(GENDERS_POOL)
    location = pick_random(LOCATIONS_POOL)
    degree = pick_random(DEGREES_POOL)
    major = pick_random(MAJORS_POOL)
    gpa = pick_random(GPA_POOL)

    # Positions: 1-3 positions
    num_positions = random.randint(1, 3)
    positions = ", ".join(pick_random(POSITIONS_POOL, num_positions))

    # Skills: 5-12 skills
    num_skills = random.randint(5, 12)
    skills = ", ".join(pick_random(SKILLS_POOL, num_skills))

    # Keywords: derived from skills + positions
    keywords_parts = skills.split(", ")[:5] + positions.split(", ")[:2]
    keywords = ", ".join(keywords_parts)

    # Job settings
    jobs_to_apply_number = random.randint(5, 20)
    job_matching = random.randint(60, 95)
    job_location_based = pick_random(LOCATIONS_POOL)

    # Date in: within last 2 years
    days_ago = random.randint(1, 730)
    date_in = (datetime.now() - timedelta(days=days_ago)).strftime("%Y-%m-%d")

    # Filename: realistic resume filename
    extensions = [".pdf", ".docx", ".pdf", ".pdf"]  # bias toward PDF
    ext = pick_random(extensions)
    safe_name = name.lower().replace(" ", "_").replace(".", "")
    filename = f"{safe_name}_resume{ext}"

    # Generate CV text
    fcv_as_string = generate_cv_text(
        faker, name, email, phone, location, nationality,
        pick_random(positions.split(", ")), degree, major, gpa, skills,
    )

    return {
        "email": email,
        "name": name,
        "positions": positions,
        "skills": skills,
        "location": location,
        "major": major,
        "keywords": keywords,
        "gender": gender,
        "nationality": nationality,
        "degree": degree,
        "filename": filename,
        "jobs_to_apply_number": jobs_to_apply_number,
        "job_location_based": job_location_based,
        "job_matching": job_matching,
        "fcv_as_string": fcv_as_string,
        "phone_number": phone,
        "date_in": date_in,
        "gpa": gpa,
    }


def seed_database(num_records=NUM_RECORDS):
    """Main seed function. Idempotent — clears existing data first."""
    print("=" * 60)
    print("AI Backend Database Seeder")
    print("=" * 60)
    print(f"Database: {DB_NAME}@{DB_HOST}:{DB_PORT}")
    print(f"Records to generate: {num_records}")
    print()

    # Initialize Faker instances with different locales
    faker_en = Faker("en_US")
    faker_ar = Faker("ar_SA")
    faker_in = Faker("en_IN")

    conn = None
    try:
        conn = get_connection()
        cursor = conn.cursor()

        # Ensure table exists
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

        # Clear existing data (idempotent)
        cursor.execute("DELETE FROM clients")
        conn.commit()
        print("Cleared existing client records.")

        # Generate and insert records
        columns = [
            "email", "name", "positions", "skills", "location", "major",
            "keywords", "gender", "nationality", "degree", "filename",
            "jobs_to_apply_number", "job_location_based", "job_matching",
            "fcv_as_string", "phone_number", "date_in", "gpa",
        ]
        placeholders = ", ".join(["%s"] * len(columns))
        col_names = ", ".join(columns)
        insert_sql = f"INSERT INTO clients ({col_names}) VALUES ({placeholders})"

        print(f"Inserting {num_records} client records...")
        batch_size = 50

        for i in range(num_records):
            client = generate_client(faker_en, faker_ar, faker_in)
            values = [client[col] for col in columns]

            try:
                cursor.execute(insert_sql, values)
            except psycopg2.errors.UniqueViolation:
                conn.rollback()
                # Regenerate email and retry once
                client["email"] = faker_en.unique.email().lower()
                values = [client[col] for col in columns]
                cursor.execute(insert_sql, values)

            if (i + 1) % batch_size == 0:
                conn.commit()
                print(f"  Inserted {i + 1}/{num_records} records...")

        # Final commit
        conn.commit()

        # Verify insertion
        cursor.execute("SELECT COUNT(*) FROM clients")
        total = cursor.fetchone()[0]
        print(f"\nTotal records in clients table: {total}")

        # Show sample records
        cursor.execute("""
            SELECT id, name, email, nationality, gender, positions,
                   jobs_to_apply_number, job_matching
            FROM clients
            LIMIT 5
        """)
        print("\nSample records:")
        print(f"{'ID':<5} {'Name':<25} {'Email':<35} {'Nationality':<15} {'Gender':<8} {'Jobs':<6} {'Match':<6}")
        print("-" * 100)
        for row in cursor.fetchall():
            print(f"{row[0]:<5} {row[1]:<25} {row[2]:<35} {row[3]:<15} {row[4]:<8} {row[5]:<6} {row[6]:<6}")

        # Show diversity stats
        cursor.execute("SELECT COUNT(DISTINCT nationality) FROM clients")
        unique_nationalities = cursor.fetchone()[0]

        cursor.execute("SELECT COUNT(DISTINCT gender) FROM clients")
        unique_genders = cursor.fetchone()[0]

        cursor.execute("SELECT gender, COUNT(*) FROM clients GROUP BY gender")
        gender_dist = dict(cursor.fetchall())

        cursor.execute("SELECT nationality, COUNT(*) as cnt FROM clients GROUP BY nationality ORDER BY cnt DESC LIMIT 10")
        top_nationalities = cursor.fetchall()

        print(f"\nDiversity Stats:")
        print(f"  Unique nationalities: {unique_nationalities}")
        print(f"  Unique genders: {unique_genders}")
        print(f"  Gender distribution: {gender_dist}")
        print(f"  Top 10 nationalities:")
        for nat, cnt in top_nationalities:
            print(f"    {nat}: {cnt}")

        print(f"\n{'=' * 60}")
        print(f"Seeding complete! {total} records inserted successfully.")
        print(f"{'=' * 60}")

        cursor.close()

    except psycopg2.OperationalError as e:
        print(f"\nERROR: Could not connect to database: {e}")
        print("Make sure PostgreSQL is running and connection settings are correct.")
        print(f"  Host: {DB_HOST}, Port: {DB_PORT}, DB: {DB_NAME}, User: {DB_USER}")
        sys.exit(1)
    except Exception as e:
        print(f"\nERROR: {e}")
        if conn:
            conn.rollback()
        sys.exit(1)
    finally:
        if conn:
            conn.close()


if __name__ == "__main__":
    seed_database()

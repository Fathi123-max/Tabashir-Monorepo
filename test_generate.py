import sys
import os
sys.path.append(os.path.abspath("tabashir-backend"))

from app.models.cv_models import Resume, Header, CareerObjective, EducationExperience, WorkAndLeadershipExperience, Project, Skills, Languages
from docxtpl import DocxTemplate

data = {
    "header": {
        "name": "John Doe",
        "email": "john@email.com",
        "phone": "+1 (555) 123-4567",
        "location": "US",
        "nationality": None,
        "linkedin": None,
        "github": None
    },
    "objective": "Experienced Senior Software Engineer with 6+ years developing scalable web applications and mobile solutions. Proven track record of leading cross-functional teams to deliver high-impact projects that increased user engagement by 40%. Passionate about clean code, mentoring junior developers, and implementing cutting-edge technologies to solve complex business problems",
    "work": [
        {
            "position": "Senior Software Engineer",
            "company": "Tech Innovations Inc.",
            "location": "San Francisco, CA",
            "date": "2021-03-01 - Present",
            "details": " • Led a team of 5 engineers to develop a React-based customer portal serving 100K+ users\n • Implemented microservices architecture reducing API response time by 50%\n • Mentored 3 junior developers and conducted code reviews\n • Collaborated with product managers to define technical requirements"
        },
        {
            "position": "Software Engineer",
            "company": "Digital Solutions LLC",
            "location": "San Jose, CA",
            "date": "2019-01-01 - 2021-02-01",
            "details": " • Developed full-stack applications using React, Node.js, and MongoDB\n • Built RESTful APIs serving 10K+ requests per day\n • Optimized database queries improving performance by 30%"
        }
    ],
    "education": [
        {
            "degree": "Bachelor of Science in Computer Science",
            "university": "University of California, Berkeley",
            "location": "Berkeley, CA",
            "date": "2015-08-01 - 2018-05-01",
            "details": " Graduated Magna Cum Laude. Relevant coursework: Data Structures, Algorithms, Software Engineering, Database Systems."
        }
    ],
    "skills": {
        "softskills": ["Leadership", "Communication", "Problem Solving"],
        "skillset": ["JavaScript", "React", "Node.js", "Python"]
    },
    "languages": ["English - expert", "Spanish - intermediate"]
}

resume = Resume.from_dict(data)
resume.write_document('tabashir-backend/templates/Docxtpl Compatible CV Template.docx', 'test_output_premium.docx')
print("Successfully generated test_output_premium.docx")

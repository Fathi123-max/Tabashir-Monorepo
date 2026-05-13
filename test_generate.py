import sys
import os
sys.path.append(os.path.abspath("tabashir-backend"))

from app.models.cv_models import Resume

data = {
    "header": {
        "name": "John Doe",
        "email": "john.doe@example.com",
        "phone": "+1 (555) 123-4567",
        "city": "San Francisco",
        "country": "US",
        "nationality": "American",
        "social_links": [
            {"platform": "linkedin", "url": "https://linkedin.com/in/johndoe"},
            {"platform": "github", "url": "https://github.com/johndoe"},
            {"platform": "portfolio", "url": "https://johndoe.com"}
        ]
    },
    "objective": "Experienced Senior Software Engineer with 6+ years developing scalable web applications and mobile solutions. Proven track record of leading cross-functional teams to deliver high-impact projects that increased user engagement by 40%. Passionate about clean code, mentoring junior developers, and implementing cutting-edge technologies to solve complex business problems",
    "work": [
        {
            "position": "Senior Software Engineer",
            "company": "Tech Innovations Inc.",
            "location": "San Francisco, CA",
            "date": "2021-03-01 - Present",
            "details": "Led a team of 5 engineers to develop a React-based customer portal serving 100K+ users\nImplemented microservices architecture reducing API response time by 50%\nMentored 3 junior developers and conducted code reviews\nCollaborated with product managers to define technical requirements"
        },
        {
            "position": "Software Engineer",
            "company": "Digital Solutions LLC",
            "location": "San Jose, CA",
            "date": "2019-01-01 - 2021-02-01",
            "details": "Developed full-stack applications using React, Node.js, and MongoDB\nBuilt RESTful APIs serving 10K+ requests per day\nOptimized database queries improving performance by 30%"
        }
    ],
    "leadership": [
        {
            "position": "President",
            "company": "Computer Science Club",
            "location": "Berkeley, CA",
            "date": "2017-08-01 - 2018-05-01",
            "details": "Organized weekly coding workshops for 50+ students.\nHosted hackathons with industry sponsors."
        }
    ],
    "education": [
        {
            "degree": "Bachelor of Science",
            "major": "Computer Science",
            "university": "University of California, Berkeley",
            "location": "Berkeley, CA",
            "date": "2015-08-01 - 2018-05-01",
            "GPA": "3.8/4.0",
            "details": "Graduated Magna Cum Laude.",
            "coursework": "Data Structures\nAlgorithms\nSoftware Engineering\nDatabase Systems"
        }
    ],
    "projects": [
        {
            "title": "E-Commerce Platform",
            "position": "Lead Backend Developer",
            "location": "Remote",
            "date": "2020-05-01 - 2021-01-01",
            "details": "Architected the backend using Node.js and Express.\nIntegrated Stripe for payments."
        }
    ],
    "skills": {
        "softskills": ["Leadership", "Communication", "Problem Solving"],
        "skillset": ["JavaScript", "React", "Node.js", "Python"],
        "training": ["AWS Certified Solutions Architect"]
    },
    "languages": ["English (Expert)", "Spanish (Intermediate)"]
}

resume = Resume.from_dict(data)
resume.write_document('tabashir-backend/templates/Docxtpl Compatible CV Template.docx', 'test_output_premium.docx')
print("Successfully generated test_output_premium.docx")

import sys
import os
sys.path.append(os.path.abspath("tabashir-backend"))

from app.models.cv_models import Resume, Header, CareerObjective, EducationExperience, WorkAndLeadershipExperience, Project, Skills, Languages
from docxtpl import DocxTemplate

header = Header(name="John Doe", email="john@example.com", phone="555-1234", location="San Francisco, CA", linkedin="linkedin.com/in/johndoe", github=None)
objective = CareerObjective("To be the best software engineer.")

edu = EducationExperience(
    degree="B.S.", major="Computer Science", university="Stanford", location="Stanford, CA", date="2015 - 2019", GPA="3.8",
    details=["Graduated with honors", "Dean's List"], coursework=["Algorithms", "Data Structures"]
)

work = WorkAndLeadershipExperience(
    company="Google", position="Software Engineer", location="Mountain View, CA", date="2019 - Present",
    details=["Developed scalable systems", "Improved performance by 20%"]
)

skills = Skills(softskills=["Leadership"], skillset=["Python", "Flutter"], training=[])
languages = Languages(["English (Native)", "Spanish (Fluent)"])

resume = Resume(
    education=[edu], header=header, objective=objective, skills=skills, languages=languages,
    work=[work], lship=[], projects=[], keywords=[]
)

resume.write_document('tabashir-backend/templates/Docxtpl Compatible CV Template.docx', 'test_output.docx')
print("Successfully generated test_output.docx")

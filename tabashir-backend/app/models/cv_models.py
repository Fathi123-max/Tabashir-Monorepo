from pathlib import Path
from typing import Optional

from docx2pdf import convert
from docxtpl import DocxTemplate, RichText


class Header:
    def __init__(self, email: str, location: str, name: str, phone: str, 
                 github: Optional[str] = None, linkedin: Optional[str] = None, nationality: Optional[str] = None):
        self.email = email
        self.github = github
        self.linkedin = linkedin
        self.location = location 
        self.name = name
        self.phone = phone
        self.nationality = nationality

    def __str__(self):
        return f"Name: {self.name}, Email: {self.email}, Phone: {self.phone}, Location: {self.location}, LinkedIn: {self.linkedin}, Github: {self.github}, Nationality: {self.nationality}"

class CareerObjective:
    def __init__(self, objective: str):
        self.objective = objective
    
    def __str__(self):
        return f"Objective: {self.objective}"    
    
class Project:
    def __init__(self, date: str, details: list[str], location: str, title: str, position: str): 
        self.date = date
        self.details = details
        self.location = location
        self.title = title
        self.position = position
    
    def __str__(self):
        return f"Title: {self.title}, Position: {self.position}, Date: {self.date}, Location: {self.location}, Details: {self.details}"
        
class WorkAndLeadershipExperience:
    def __init__(self, company: str, date: str, details: list[str], location: str, position: str): 
        self.company = company
        self.date = date
        self.details = details
        self.location = location
        self.position = position

    def __str__(self):
        return f"Company: {self.company}, Position: {self.position}, Date: {self.date}, Location: {self.location}, Details: {self.details}"

class EducationExperience:
    def __init__(self, coursework: list[str], date: str, details: list[str], 
                 location: str, major: str, degree: str, university: str, GPA: str):  
        self.coursework = coursework
        self.date = date
        self.details = details
        self.location = location
        self.major = major
        self.degree = degree
        self.university = university
        self.gpa = GPA
        self.gpa_hidden = GPA if GPA else "N/A"

    def __str__(self):
        return f"University: {self.university}, Location: {self.location}, Date: {self.date}, Major: {self.major}, degree: {self.degree}, GPA: {self.gpa_hidden}, Details: {self.details}, Coursework: {self.coursework}"

    @property
    def gpa(self):
        return getattr(self, '_gpa', '')
    
    @gpa.setter
    def gpa(self, gpa):
        if gpa:    
            try:
                gpa_float = float(gpa)
                if 3.2 <= gpa_float <= 5.0:
                    self._gpa = gpa
                elif 90.0 <= gpa_float <= 100.0:
                    self._gpa = gpa + "%"
                else:
                    self._gpa = ""
            except ValueError:
                self._gpa = ""
        else:
            self._gpa = ""

class Skills: 
    def __init__(self, softskills: list, skillset: list, training: Optional[list]): 
        self.skillset = skillset
        self.training = training
        self.softskills = softskills

    def __str__(self):
        return f"Softskills: {self.softskills}, Skillset: {self.skillset}, Training: {self.training}"

class Languages:
    def __init__(self, langs: list):
        self.langs = langs    
    
    def __str__(self):
        return f"Langs: {self.langs}"    

class Resume:
    def __init__(self, education: list[EducationExperience], header: Header, 
                 objective: CareerObjective, skills: Skills, languages: Languages, 
                 work: list[WorkAndLeadershipExperience], 
                 lship: Optional[list[WorkAndLeadershipExperience]], 
                 projects: Optional[list[Project]], keywords: Optional[list[str]]):
        self.education = education
        self.header = header
        self.objective = objective
        self.lship = lship
        self.projects = projects
        self.skills = skills
        self.languages = languages
        self.work = work
        self.keywords = keywords

    def __str__(self):
        objective_str = str(self.objective) if self.objective else ''
        education_str = ', '.join([str(education) for education in self.education]) if self.education else ''
        work_str = ', '.join([str(work) for work in self.work]) if self.work else ''
        projects_str = ', '.join([str(project) for project in self.projects]) if self.projects else ''
        leadership_str = ', '.join([str(lship) for lship in self.lship]) if self.lship else ''
        skills_str = str(self.skills) if self.skills else ''
        languages_str = str(self.languages) if self.languages else ''

        return f"Header: {str(self.header)}, CareerObjective: {objective_str}, Education: {education_str}, Work: {work_str}, Projects: {projects_str}, Leadership: {leadership_str}, Skills: {skills_str}, Languages: {languages_str}"

    def write_document(self, template_path: str, output_path: str) -> None:
        """
        Writes the resume document to a file.

        Args:
            template_path (str): The path to the template file.
            output_path (str): The path to save the output file.
        """

        # Load the template
        doc = DocxTemplate(template_path)

        # Add Hyper link to Email
        email_text = RichText()
        if self.header.email:
            email_text.add("Email", font="Times New Roman", underline="single", color="0000FF", url_id=doc.build_url_id(f"mailto:{self.header.email}"))

        # Add Linkedin Hyper Link
        linkedin_text = RichText()
        if self.header.linkedin:
            linkedin_text.add("LinkedIn",font="Times New Roman", underline="single", color="0000FF", url_id=doc.build_url_id(self.header.linkedin))

        # Add GitHub Hyper Link
        github_text = RichText()
        if self.header.github:
            github_text.add("GitHub",font="Times New Roman", underline="single", color="0000FF", url_id=doc.build_url_id(self.header.github))

        # Create context from the provided data
        # Objective can be None for some CVs, so guard against that
        objective_text = ""
        if getattr(self, "objective", None) is not None:
            raw_obj = getattr(self.objective, "objective", "") or ""
            objective_text = clean_objective_text(raw_obj)

        context = {
            "header": self.header,
            "email_text": email_text,
            "linkedin_text": linkedin_text,
            "github_text": github_text,
            "objective": objective_text,
            "education_list": self.education,
            "work_list": self.work,
            "lship_list": self.lship if self.lship else [],  # The same as 'training'.
            "project_list": self.projects if self.projects else [],
            "skills": {"softskills": self.skills.softskills, "skillset": self.skills.skillset,
                       "training": self.skills.training if self.skills.training else []},
            # This will assign 'training' to its attribute if training exits.
            # "languages": self.languages.langs if self.languages and self.languages.langs else [],
            "languages": format_languages(self.languages.langs if self.languages and self.languages.langs else [])

        }
        try:
            # Render and Save the Document
            doc.render(context)
            doc.save(output_path)
            output_path = Path(output_path)
            pdf_path = output_path.with_suffix('.pdf')
            convert(output_path, pdf_path)
        except Exception as e:
            print(f"Error rendering template: {e}")

def format_languages(lang_list):
    formatted = []
    for lang in lang_list:
        if isinstance(lang, list) and len(lang) == 2:
            # Case: ['English', 'Fluent']
            formatted.append(f"{lang[0].strip()} - {lang[1].strip()}")
        elif isinstance(lang, str) and '(' in lang and ')' in lang:
            # Case: "English (Fluent)"
            name, level = lang.split('(', 1)
            formatted.append(f"{name.strip()} - {level.replace(')', '').strip()}")
        else:
            # Fallback
            formatted.append(str(lang).strip())
    return formatted

def clean_objective_text(text):
    """Comprehensive text cleaning for objective"""
    if not text:
        return ""
    
    # Clean various quote types
    text = text.replace(''', "'").replace(''', "'")
    text = text.replace('"', '"').replace('"', '"')
    
    # Remove problematic characters
    text = text.replace('\n', ' ').replace('\r', ' ')
    text = text.replace('\t', ' ')
    
    # Fix hyphens (don't escape them unless needed for LaTeX)
    text = text.replace('–', '-').replace('—', '-')
    
    # Remove multiple spaces
    text = ' '.join(text.split())
    
    # Remove leading/trailing punctuation issues
    text = text.strip('.,;- ')
    
    return text


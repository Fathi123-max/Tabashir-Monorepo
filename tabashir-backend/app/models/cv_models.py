from pathlib import Path
from typing import Optional

try:
    from docx2pdf import convert
except ImportError:
    convert = None
    print("Warning: docx2pdf not found, PDF conversion will be disabled")

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
                 projects: Optional[list[Project]], keywords: Optional[list[str]],
                 source_data: Optional[dict] = None):
        self.education = education
        self.header = header
        self.objective = objective
        self.lship = lship
        self.projects = projects
        self.skills = skills
        self.languages = languages
        self.work = work
        self.keywords = keywords
        self.source_data = source_data

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
            print(f"Rendering template from: {template_path}")
            doc.render(context)
            
            print(f"Saving DOCX to: {output_path}")
            doc.save(output_path)
            
            output_path_obj = Path(output_path)
            pdf_path = output_path_obj.with_suffix('.pdf')
            
            print(f"Attempting PDF conversion to: {pdf_path}")
            try:
                # docx2pdf requires Microsoft Word on macOS/Windows and is often unstable in backends
                convert(str(output_path), str(pdf_path))
                print("PDF conversion successful")
            except Exception as pdf_err:
                print(f"Warning: PDF conversion failed (this is common in server environments): {pdf_err}")
                # We don't raise here because we still have the DOCX saved
                
        except Exception as e:
            import traceback
            print(f"Error during document generation:")
            traceback.print_exc()
            raise Exception(f"Document generation failed: {str(e)}")

    def to_dict(self) -> dict:
        """Converts Resume object to dictionary."""
        return {
            "header": vars(self.header),
            "objective": self.objective.objective if self.objective else "",
            "education": [vars(edu) for edu in self.education],
            "work": [vars(work) for work in self.work],
            "leadership": [vars(l) for l in self.lship] if self.lship else [],
            "projects": [vars(p) for p in self.projects] if self.projects else [],
            "skills": {
                "softskills": self.skills.softskills,
                "skillset": self.skills.skillset,
                "training": self.skills.training if self.skills.training else []
            },
            "languages": format_languages(self.languages.langs) if self.languages else [],
            "keywords": self.keywords if self.keywords else [],
            "source_data": self.source_data
        }

    @staticmethod
    def from_dict(data: dict) -> 'Resume':
        """Converts dictionary to Resume object with defaults for missing fields."""
        h = data.get('header', {})
        header = Header(
            email=h.get('email', ''),
            location=h.get('location', h.get('address', '')),
            name=h.get('name', ''),
            phone=h.get('phone', ''),
            github=h.get('github'),
            linkedin=h.get('linkedin'),
            nationality=h.get('nationality')
        )

        objective_data = data.get('objective', '')
        if isinstance(objective_data, dict):
            objective_str = objective_data.get('summary', objective_data.get('objective', ''))
        else:
            objective_str = str(objective_data)
        objective = CareerObjective(objective_str)

        education = []
        for edu in data.get('education', []):
            if not isinstance(edu, dict):
                continue
            
            # Robustly handle details/coursework as string or list
            raw_details = edu.get('details', [])
            if isinstance(raw_details, str):
                raw_details = [raw_details]
            elif raw_details is None:
                raw_details = []
            
            raw_coursework = edu.get('coursework', [])
            if isinstance(raw_coursework, str):
                raw_coursework = [raw_coursework]
            elif raw_coursework is None:
                raw_coursework = []

            # Handle date range if missing
            edu_date = edu.get('date', '')
            if not edu_date and (edu.get('start_date') or edu.get('startDate')):
                start = edu.get('start_date') or edu.get('startDate', '')
                end = edu.get('end_date') or edu.get('endDate', 'Present')
                # Simple extraction of Year-Month if it's ISO format
                if isinstance(start, str) and 'T' in start: start = start.split('T')[0]
                if isinstance(end, str) and 'T' in end: end = end.split('T')[0]
                edu_date = f"{start} - {end}"

            education.append(EducationExperience(
                coursework=raw_coursework,
                date=edu_date,
                details=raw_details,
                location=edu.get('location', edu.get('city', '')),
                major=edu.get('major', ''),
                degree=edu.get('degree', ''),
                university=edu.get('university', edu.get('school', '')),
                GPA=str(edu.get('GPA', edu.get('gpa', '')))
            ))

        work = []
        for w in data.get('work', []):
            if not isinstance(w, dict):
                continue
            
            raw_details = w.get('details', [])
            if isinstance(raw_details, str):
                raw_details = [raw_details]
            elif raw_details is None:
                raw_details = []
            elif not raw_details and w.get('description'):
                raw_details = [w.get('description')]

            work_date = w.get('date', '')
            if not work_date and (w.get('start_date') or w.get('startDate')):
                start = w.get('start_date') or w.get('startDate', '')
                end = w.get('end_date') or w.get('endDate', 'Present')
                if isinstance(start, str) and 'T' in start: start = start.split('T')[0]
                if isinstance(end, str) and 'T' in end: end = end.split('T')[0]
                work_date = f"{start} - {end}"

            work.append(WorkAndLeadershipExperience(
                company=w.get('company', w.get('organization', '')),
                date=work_date,
                details=raw_details,
                location=w.get('location', w.get('city', '')),
                position=w.get('position', '')
            ))

        leadership = []
        for l in data.get('leadership', []):
            if not isinstance(l, dict):
                continue
            
            raw_details = l.get('details', [])
            if isinstance(raw_details, str):
                raw_details = [raw_details]
            elif raw_details is None:
                raw_details = []
            elif not raw_details and l.get('description'):
                raw_details = [l.get('description')]

            l_date = l.get('date', '')
            if not l_date and (l.get('start_date') or l.get('startDate')):
                start = l.get('start_date') or l.get('startDate', '')
                end = l.get('end_date') or l.get('endDate', 'Present')
                if isinstance(start, str) and 'T' in start: start = start.split('T')[0]
                if isinstance(end, str) and 'T' in end: end = end.split('T')[0]
                l_date = f"{start} - {end}"

            leadership.append(WorkAndLeadershipExperience(
                company=l.get('company', l.get('organization', '')),
                date=l_date,
                details=raw_details,
                location=l.get('location', l.get('city', '')),
                position=l.get('position', '')
            ))

        projects = []
        for p in data.get('projects', []):
            if not isinstance(p, dict):
                continue
            
            raw_details = p.get('details', p.get('highlights', []))
            if isinstance(raw_details, str):
                raw_details = [raw_details]
            elif raw_details is None:
                raw_details = []
            elif not raw_details and p.get('description'):
                raw_details = [p.get('description')]

            p_date = p.get('date', '')
            if not p_date and (p.get('start_date') or p.get('startDate')):
                start = p.get('start_date') or p.get('startDate', '')
                end = p.get('end_date') or p.get('endDate', 'Present')
                if isinstance(start, str) and 'T' in start: start = start.split('T')[0]
                if isinstance(end, str) and 'T' in end: end = end.split('T')[0]
                p_date = f"{start} - {end}"

            projects.append(Project(
                date=p_date,
                details=raw_details,
                location=p.get('location', p.get('city', '')),
                title=p.get('title', p.get('name', '')),
                position=p.get('position', '')
            ))

        skills_data = data.get('skills', {})
        if isinstance(skills_data, list):
            # Handle list of skill objects (common from mobile app)
            soft_skills = []
            technical_skills = []
            training_list = []
            for s in skills_data:
                if not isinstance(s, dict):
                    continue
                name = s.get('name', '')
                category = s.get('category', '')
                if category == 'soft':
                    soft_skills.append(name)
                elif category == 'training':
                    training_list.append(name)
                else:
                    technical_skills.append(name)
            skills = Skills(
                softskills=soft_skills,
                skillset=technical_skills,
                training=training_list
            )
        else:
            skills = Skills(
                softskills=skills_data.get('softskills', []),
                skillset=skills_data.get('skillset', []),
                training=skills_data.get('training', [])
            )

        # Handle languages which might be a list of objects or list of strings/lists
        raw_languages = data.get('languages', [])
        processed_languages = []
        if isinstance(raw_languages, list):
            for lang in raw_languages:
                if isinstance(lang, dict):
                    # Handle Language object from mobile: {"name": "English", "proficiency": "Fluent"}
                    name = lang.get('name', '')
                    prof = lang.get('proficiency', '')
                    if name and prof:
                        processed_languages.append(f"{name} ({prof})")
                    elif name:
                        processed_languages.append(name)
                else:
                    processed_languages.append(lang)
        
        languages = Languages(processed_languages)
        keywords = data.get('keywords', [])

        return Resume(
            education=education,
            header=header,
            objective=objective,
            skills=skills,
            languages=languages,
            work=work,
            lship=leadership,
            projects=projects,
            keywords=keywords,
            source_data=data.get('source_data')
        )

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


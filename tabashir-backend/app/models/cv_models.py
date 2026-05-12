import subprocess
import os
from pathlib import Path
from typing import Optional

def convert_to_pdf(docx_path: str, output_dir: str) -> bool:
    """
    Converts a DOCX file to PDF using LibreOffice (soffice).
    """
    try:
        print(f"Attempting PDF conversion for: {docx_path}")
        # Use LibreOffice to convert
        result = subprocess.run([
            'soffice', 
            '--headless', 
            '--convert-to', 'pdf', 
            '--outdir', str(output_dir), 
            str(docx_path)
        ], capture_output=True, text=True)
        
        if result.returncode == 0:
            print("PDF conversion successful via LibreOffice")
            return True
        else:
            print(f"LibreOffice conversion failed: {result.stderr}")
            return False
    except Exception as e:
        print(f"Error during LibreOffice conversion: {e}")
        return False

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

def format_date_string(date_str):
    if not date_str:
        return ""
    # Try to parse YYYY-MM-DD or similar and convert to "Month YYYY"
    import re
    from datetime import datetime
    
    # Handle "2021-03-01 - Present"
    parts = date_str.split(' - ')
    formatted_parts = []
    for part in parts:
        part = part.strip()
        if part.lower() == 'present':
            formatted_parts.append('Present')
            continue
        try:
            # Match YYYY-MM-DD or YYYY-MM
            match = re.match(r'(\d{4})-(\d{2})(?:-\d{2})?', part)
            if match:
                dt = datetime.strptime(f"{match.group(1)}-{match.group(2)}", "%Y-%m")
                formatted_parts.append(dt.strftime("%b %Y"))
            else:
                formatted_parts.append(part)
        except:
            formatted_parts.append(part)
    return " - ".join(formatted_parts)

def clean_detail_line(line):
    # Strip leading bullets, spaces, and weird characters like '' and '•'
    import re
    line = line.strip()
    line = re.sub(r'^[\s\-\*\•\·\▪\●\◦\‣\⁃\⁌\־\−\—\–\xad\x95\xb7\u2022\u2023\u25E6\u2043\u2219\uf0b7]+\s*', '', line)
    return line

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

        # Build contact info dynamically to avoid trailing/leading separators
        contact_parts = []

        if self.header:
            if getattr(self.header, 'location', None):
                contact_parts.append(self.header.location)
            if getattr(self.header, 'phone', None):
                contact_parts.append(self.header.phone)
            if getattr(self.header, 'email', None):
                contact_parts.append(self.header.email)
            if getattr(self.header, 'linkedin', None):
                display_li = self.header.linkedin.replace('https://', '').replace('http://', '').replace('www.', '')
                contact_parts.append(display_li)
            if getattr(self.header, 'github', None):
                display_gh = self.header.github.replace('https://', '').replace('http://', '').replace('www.', '')
                contact_parts.append(display_gh)
            if getattr(self.header, 'nationality', None):
                contact_parts.append(self.header.nationality)
            if getattr(self.header, 'extra_links', None):
                for link in self.header.extra_links:
                    display_link = link.replace('https://', '').replace('http://', '').replace('www.', '')
                    contact_parts.append(display_link)

        contact_text = " | ".join(contact_parts)

        # Create context from the provided data
        objective_text = ""
        if self.objective and getattr(self.objective, "objective", None):
            objective_text = clean_objective_text(self.objective.objective)

        context = {
            "header": self.header if self.header else Header(name="CANDIDATE", email="", phone="", location=""),
            "contact_info": contact_text,
            "objective": objective_text,
            "education_list": self.education if self.education else [],
            "work_list": self.work if self.work else [],
            "lship_list": self.lship if self.lship else [],
            "project_list": self.projects if self.projects else [],
            "skills": {
                "softskills": self.skills.softskills if self.skills else [],
                "skillset": self.skills.skillset if self.skills else [],
                "training": self.skills.training if self.skills and self.skills.training else []
            },
            "languages": format_languages(self.languages.langs if self.languages and self.languages.langs else [])
        }
        try:
            # Render and Save the Document
            print(f"Rendering template from: {template_path}")
            doc.render(context)
            
            print(f"Saving DOCX to: {output_path}")
            doc.save(output_path)
            
            print(f"Attempting PDF conversion...")
            # Use new LibreOffice converter
            success = convert_to_pdf(output_path, Path(output_path).parent)
            if success:
                print("PDF conversion successful")
            else:
                print("Warning: PDF conversion failed via LibreOffice")
                
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
        # Support both 'header' and 'personal_details' (from mobile)
        h = data.get('header') or data.get('personal_details') or {}
        
        country = h.get('location') or h.get('country') or ''
        city = h.get('city') or h.get('address') or ''
        full_location = f"{city}, {country}".strip(', ') if city and country else city or country
        
        header = Header(
            email=h.get('email') or h.get('fullName') or h.get('name') or '',
            location=full_location,
            name=h.get('name') or h.get('fullName') or '',
            phone=h.get('phone') or h.get('phoneNumber') or '',
            github=h.get('github') or '',
            linkedin=h.get('linkedin') or '',
            nationality=h.get('nationality') or ''
        )

        extra_links = []
        # Handle social links if they are in a list (mobile format)
        social_links = h.get('socialLinks') or []
        if isinstance(social_links, list):
            for link in social_links:
                if not isinstance(link, dict): continue
                platform = str(link.get('platform') or '').lower()
                url = link.get('url') or ''
                if 'linkedin' in platform: header.linkedin = url
                elif 'github' in platform: header.github = url
                elif url: extra_links.append(url)
        header.extra_links = extra_links

        # Support both 'objective' and 'professional_summary' (from mobile)
        objective_data = data.get('objective') or data.get('professional_summary') or ''
        if isinstance(objective_data, dict):
            objective_str = objective_data.get('summary') or objective_data.get('objective') or ''
        else:
            objective_str = str(objective_data) if objective_data else ''
        objective = CareerObjective(objective_str)

        education = []
        for edu in data.get('education') or []:
            if not isinstance(edu, dict):
                continue
            
            # Robustly handle details/coursework as string or list
            raw_details = edu.get('details') or []
            if isinstance(raw_details, str):
                raw_details = [clean_detail_line(line) for line in raw_details.split('\n') if line.strip()]
            elif raw_details is None:
                raw_details = []
            else:
                raw_details = [clean_detail_line(str(line)) for line in raw_details if str(line).strip()]

            if not raw_details and edu.get('description'):
                desc = edu.get('description') or ''
                raw_details = [clean_detail_line(line) for line in desc.split('\n') if line.strip()] if isinstance(desc, str) else [clean_detail_line(desc)]
            
            raw_coursework = edu.get('coursework') or []
            if isinstance(raw_coursework, str):
                raw_coursework = [clean_detail_line(line) for line in raw_coursework.split('\n') if line.strip()]
            elif raw_coursework is None:
                raw_coursework = []
            else:
                raw_coursework = [clean_detail_line(str(line)) for line in raw_coursework if str(line).strip()]

            # Handle date range if missing
            edu_date = edu.get('date') or ''
            if not edu_date and (edu.get('start_date') or edu.get('startDate')):
                start = edu.get('start_date') or edu.get('startDate') or ''
                end = edu.get('end_date') or edu.get('endDate') or 'Present'
                if isinstance(start, str) and 'T' in start: start = start.split('T')[0]
                if isinstance(end, str) and 'T' in end: end = end.split('T')[0]
                edu_date = f"{start} - {end}"
            edu_date = format_date_string(edu_date)

            education.append(EducationExperience(
                coursework=raw_coursework,
                date=edu_date,
                details=raw_details,
                location=edu.get('location') or edu.get('city') or '',
                major=edu.get('major') or '',
                degree=edu.get('degree') or '',
                university=edu.get('university') or edu.get('school') or '',
                GPA=str(edu.get('GPA') or edu.get('gpa') or '')
            ))

        # Support both 'work' and 'work_experience' (from mobile)
        work_list = data.get('work') or data.get('work_experience') or []
        work = []
        for w in work_list:
            if not isinstance(w, dict):
                continue
            
            raw_details = w.get('details') or []
            if isinstance(raw_details, str):
                raw_details = [clean_detail_line(line) for line in raw_details.split('\n') if line.strip()]
            elif raw_details is None:
                raw_details = []
            else:
                raw_details = [clean_detail_line(str(line)) for line in raw_details if str(line).strip()]

            if not raw_details and (w.get('description') or w.get('keyTasks')):
                desc = w.get('description') or w.get('keyTasks') or ''
                raw_details = [clean_detail_line(line) for line in desc.split('\n') if line.strip()] if isinstance(desc, str) else [clean_detail_line(desc)]

            work_date = w.get('date') or ''
            if not work_date and (w.get('start_date') or w.get('startDate')):
                start = w.get('start_date') or w.get('startDate') or ''
                end = w.get('end_date') or w.get('endDate') or 'Present'
                if isinstance(start, str) and 'T' in start: start = start.split('T')[0]
                if isinstance(end, str) and 'T' in end: end = end.split('T')[0]
                work_date = f"{start} - {end}"
            work_date = format_date_string(work_date)

            work.append(WorkAndLeadershipExperience(
                company=w.get('company') or w.get('organization') or '',
                date=work_date,
                details=raw_details,
                location=w.get('location') or w.get('city') or '',
                position=w.get('position') or ''
            ))

        leadership = []
        for l in data.get('leadership') or []:
            if not isinstance(l, dict):
                continue
            
            raw_details = l.get('details') or []
            if isinstance(raw_details, str):
                raw_details = [clean_detail_line(line) for line in raw_details.split('\n') if line.strip()]
            elif raw_details is None:
                raw_details = []
            else:
                raw_details = [clean_detail_line(str(line)) for line in raw_details if str(line).strip()]

            if not raw_details and l.get('description'):
                desc = l.get('description') or ''
                raw_details = [clean_detail_line(line) for line in desc.split('\n') if line.strip()] if isinstance(desc, str) else [clean_detail_line(desc)]

            l_date = l.get('date') or ''
            if not l_date and (l.get('start_date') or l.get('startDate')):
                start = l.get('start_date') or l.get('startDate') or ''
                end = l.get('end_date') or l.get('endDate') or 'Present'
                if isinstance(start, str) and 'T' in start: start = start.split('T')[0]
                if isinstance(end, str) and 'T' in end: end = end.split('T')[0]
                l_date = f"{start} - {end}"
            l_date = format_date_string(l_date)

            leadership.append(WorkAndLeadershipExperience(
                company=l.get('company') or l.get('organization') or '',
                date=l_date,
                details=raw_details,
                location=l.get('location') or l.get('city') or '',
                position=l.get('position') or ''
            ))

        projects = []
        for p in data.get('projects') or []:
            if not isinstance(p, dict):
                continue
            
            raw_details = p.get('details') or p.get('highlights') or []
            if isinstance(raw_details, str):
                raw_details = [clean_detail_line(line) for line in raw_details.split('\n') if line.strip()]
            elif raw_details is None:
                raw_details = []
            else:
                raw_details = [clean_detail_line(str(line)) for line in raw_details if str(line).strip()]

            if not raw_details and p.get('description'):
                desc = p.get('description') or ''
                raw_details = [clean_detail_line(line) for line in desc.split('\n') if line.strip()] if isinstance(desc, str) else [clean_detail_line(desc)]

            p_date = p.get('date') or ''
            if not p_date and (p.get('start_date') or p.get('startDate')):
                start = p.get('start_date') or p.get('startDate') or ''
                end = p.get('end_date') or p.get('endDate') or 'Present'
                if isinstance(start, str) and 'T' in start: start = start.split('T')[0]
                if isinstance(end, str) and 'T' in end: end = end.split('T')[0]
                p_date = f"{start} - {end}"
            p_date = format_date_string(p_date)

            projects.append(Project(
                date=p_date,
                details=raw_details,
                location=p.get('location') or p.get('city') or '',
                title=p.get('title') or p.get('name') or '',
                position=p.get('position') or ''
            ))

        skills_data = data.get('skills') or {}
        # Handle languages which might be a list of objects or list of strings/lists
        raw_languages = data.get('languages') or []
        processed_languages = []
        
        if isinstance(skills_data, list):
            # Handle list of skill objects (common from mobile app)
            soft_skills = []
            technical_skills = []
            training_list = []
            for s in skills_data:
                if not isinstance(s, dict):
                    continue
                name = s.get('name') or ''
                category = str(s.get('category') or '').lower()
                if 'soft' in category:
                    soft_skills.append(name)
                elif 'training' in category:
                    training_list.append(name)
                elif 'language' in category:
                    prof = s.get('proficiency') or ''
                    if name and prof:
                        processed_languages.append(f"{name} ({prof})")
                    elif name:
                        processed_languages.append(name)
                else:
                    technical_skills.append(name)
            skills = Skills(
                softskills=soft_skills,
                skillset=technical_skills,
                training=training_list
            )
        else:
            skills = Skills(
                softskills=skills_data.get('softskills') or [],
                skillset=skills_data.get('skillset') or [],
                training=skills_data.get('training') or []
            )

        if isinstance(raw_languages, list):
            for lang in raw_languages:
                if isinstance(lang, dict):
                    # Handle Language object from mobile: {"name": "English", "proficiency": "Fluent"}
                    name = lang.get('name') or ''
                    prof = lang.get('proficiency') or ''
                    if name and prof:
                        processed_languages.append(f"{name} ({prof})")
                    elif name:
                        processed_languages.append(name)
                else:
                    processed_languages.append(lang)
        
        languages = Languages(processed_languages)
        keywords = data.get('keywords') or []

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


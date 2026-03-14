"""
Job Translation Service using LLM API
Handles translation of job fields from English to Arabic
"""

from typing import Dict, Optional
from app.services.cv_processor import get_openai_client
from app.config import Config

class JobTranslationService:
    """Service for translating job fields using LLM API"""
    
    def __init__(self):
        """Initialize the translation service"""
        # We don't instantiate the client here, we will fetch it dynamically per request
        self.translatable_fields = [
            'job_title', 'job_description', 'academic_qualification',
            'experience', 'languages', 'salary', 'working_hours', 
            'working_days', 'company_name', 'vacancy_city'
        ]
    
    def translate_job_fields(self, job_data: Dict) -> Dict[str, str]:
        """
        Translate job fields from English to Arabic
        
        Args:
            job_data: Dictionary containing job information
            
        Returns:
            Dictionary with Arabic translations (field_name_ar: translated_text)
        """
        translated_data = {}
        
        for field in self.translatable_fields:
            if job_data.get(field) and job_data[field].strip():
                try:
                    translated_text = self.translate_text(
                        job_data[field], 
                        context=f"Job {field.replace('_', ' ')}"
                    )
                    translated_data[f"{field}_ar"] = translated_text
                    print(f"Translated {field} for job {job_data.get('id', 'unknown')}")
                except Exception as e:
                    print(f"Failed to translate {field} for job {job_data.get('id', 'unknown')}: {e}")
                    # Don't add the field if translation fails
                    continue
        
        return translated_data
    
    def translate_text(self, text: str, context: str = "") -> str:
        """
        Translate text using LLM API
        
        Args:
            text: Text to translate
            context: Context for better translation (e.g., "Job title", "Job description")
            
        Returns:
            Translated Arabic text
        """
        if not text or not text.strip():
            return ""
        
        prompt = self._create_translation_prompt(text, context)
        
        try:
            client, model = get_openai_client()
            response = client.chat.completions.create(
                model=model,
                messages=[{"role": "user", "content": prompt}],
                max_tokens=2000,
                temperature=0.3,
                timeout=30
            )
            
            translated_text = response.choices[0].message.content.strip()
            
            if not translated_text or len(translated_text) < 2:
                raise ValueError("Translation result is too short or empty")
            
            return translated_text
            
        except Exception as e:
            print(f"LLM API error for text '{text[:50]}...': {e}")
            raise
    
    def _create_translation_prompt(self, text: str, context: str) -> str:
        """Create a context-aware translation prompt with enhanced Arabic translation"""
        
        context_instructions = {
            "job title": """Translate this job title to Arabic. Use professional and commonly used Arabic job titles. 
            Examples: Software Engineer = مهندس برمجيات, Marketing Manager = مدير تسويق, Sales Representative = مندوب مبيعات""",
            
            "job description": """Translate this job description to Arabic. Maintain professional tone and technical accuracy.
            - Translate all technical terms to their Arabic equivalents
            - Keep company names, email addresses, and URLs in English
            - Use formal Arabic (الفصحى) for professional context
            - Ensure all requirements and responsibilities are clearly translated""",
            
            "academic qualification": """Translate academic qualification requirements to Arabic.
            - Translate degree names: Bachelor = بكالوريوس, Master = ماجستير, PhD = دكتوراه
            - Keep institution names in English if they are international
            - Translate field names: Computer Science = علوم الحاسوب, Engineering = هندسة""",
            
            "experience": """Translate experience requirements to Arabic.
            - Translate years and experience levels clearly
            - Use Arabic numerals for years: 3 years = 3 سنوات
            - Translate experience types: Technical = تقني, Management = إداري""",
            
            "languages": """Translate language requirements to Arabic.
            - Keep language names in English: English = English, Arabic = Arabic
            - Translate proficiency levels: Fluent = بطلاقة, Native = لغته الأم
            - Translate requirements: Required = مطلوب, Preferred = مفضل""",
            
            "salary": """Translate salary information to Arabic.
            - Keep currency amounts in English format: $5000 = $5000
            - Translate salary terms: Salary = راتب, Benefits = مزايا, Bonus = مكافأة
            - Translate payment terms: Monthly = شهري, Annual = سنوي""",
            
            "working hours": """Translate working hours to Arabic.
            - Keep time formats in English: 9:00 AM - 5:00 PM = 9:00 AM - 5:00 PM
            - Translate work terms: Full-time = دوام كامل, Part-time = دوام جزئي
            - Translate shift terms: Day shift = دوام صباحي, Night shift = دوام ليلي""",
            
            "working days": """Translate working days to Arabic.
            - Keep day names in English format: Monday = Monday, Friday = Friday
            - Translate work week terms: Weekdays = أيام الأسبوع, Weekend = عطلة نهاية الأسبوع
            - Translate schedule terms: Flexible = مرن, Fixed = ثابت""",
            
            "company name": """Translate company name to Arabic if it's a generic name.
            - Keep proper company names in English
            - Translate generic terms: Company = شركة, Corporation = مؤسسة, LLC = ذ.م.م""",
            
            "vacancy city": """Translate city names to Arabic.
            - Keep well-known international cities in English: Dubai = Dubai, London = London
            - Translate local city names to Arabic
            - Keep country names in English: UAE = UAE, Saudi Arabia = Saudi Arabia"""
        }
        
        instruction = context_instructions.get(context.lower(), 
            "Translate this text to Arabic while maintaining professional tone and keeping proper nouns in English.")
        
        prompt = f"""
        {instruction}
        
        CRITICAL TRANSLATION GUIDELINES:
        - Return ONLY the Arabic translation, no explanations
        - Use Modern Standard Arabic (العربية الفصحى)
        - Translate ALL words and phrases completely - do not leave any English words untranslated
        - Maintain professional and formal tone throughout
        - Ensure complete translation of technical terms and job requirements
        - Keep only proper nouns, company names, email addresses, and URLs in English
        - Use appropriate Arabic terminology for the job market context
        - Make sure the translation is complete and comprehensive
        
        Text to translate: {text}
        
        Arabic Translation:
        """
        
        return prompt
    
    def is_translation_needed(self, job_data: Dict) -> bool:
        """
        Check if a job needs translation
        
        Args:
            job_data: Job data dictionary
            
        Returns:
            True if translation is needed, False otherwise
        """
        for field in self.translatable_fields:
            if job_data.get(field) and job_data[field].strip():
                arabic_field = f"{field}_ar"
                if not job_data.get(arabic_field) or not job_data[arabic_field].strip():
                    return True
        
        return False
    
    def get_translation_status(self, job_data: Dict) -> str:
        """
        Determine translation status for a job
        
        Args:
            job_data: Job data dictionary
            
        Returns:
            Translation status: 'completed', 'partial', 'pending', or 'failed'
        """
        if not self.is_translation_needed(job_data):
            return 'completed'
        
        has_any_translation = any(
            job_data.get(f"{field}_ar") and job_data[f"{field}_ar"].strip()
            for field in self.translatable_fields
            if job_data.get(field) and job_data[field].strip()
        )
        
        if has_any_translation:
            return 'partial'
        else:
            return 'pending'

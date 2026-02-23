# CV Models - stub implementation
# TODO: Implement actual CV model classes

from dataclasses import dataclass
from typing import Optional, List

@dataclass
class Resume:
    """Resume data model"""
    name: Optional[str] = None
    email: Optional[str] = None
    phone: Optional[str] = None
    summary: Optional[str] = None
    experience: List = None
    education: List = None
    skills: List = None

    def __post_init__(self):
        if self.experience is None:
            self.experience = []
        if self.education is None:
            self.education = []
        if self.skills is None:
            self.skills = []

class CVData:
    """Represents parsed CV data"""
    header = None

class CVFormatter:
    """Formats CV data to document"""
    def __init__(self, raw_data):
        self.raw_data = raw_data
        self.header = type('obj', (object,), {'name': 'Formatted'})()

    def write_document(self, template, output_path):
        pass

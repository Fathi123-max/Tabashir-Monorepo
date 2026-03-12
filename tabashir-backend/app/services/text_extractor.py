import os
import docx2txt
from PyPDF2 import PdfReader

def extract_text(file_path: str) -> str:
    """Extract text from Unformatted DOCX, PDF, and RTF files."""
    if not os.path.exists(file_path):
        raise FileNotFoundError(f"Couldn't Find the File: {file_path}")
    
    _, file_type = os.path.splitext(file_path)
    text = ""

    # Handle Word Docx Documents
    if file_type.lower() in [".docx", ".rtf"]:
        text = docx2txt.process(file_path)

    # Handle PDFs
    elif file_type.lower() == ".pdf":
        reader = PdfReader(file_path)
        for page in reader.pages:
            text += page.extract_text()
    else:
        raise ValueError(f"Unsupported file type: {file_type}")

    if not text.strip():
        raise ValueError("Couldn't Extract Text from the file.")
    
    return text

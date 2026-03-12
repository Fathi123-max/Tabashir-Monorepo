import os
import docx2txt
import fitz

def extract_text(file_path: str) -> str:
    """Extract raw visible text from DOCX, RTF, and PDF files (cross-platform)."""
    if not os.path.exists(file_path):
        raise ValueError(f"Couldn't find the file: {file_path}")

    _, file_type = os.path.splitext(file_path)
    file_type = file_type.lower()
    text = ""

    if file_type in [".docx", ".rtf"]:
        text = docx2txt.process(file_path)

    elif file_type == ".pdf":
        try:
            doc = fitz.open(file_path)
            for page in doc:
                text += page.get_text("text")
        except Exception as e:
            raise RuntimeError(f"Error extracting PDF text: {e}")

    else:
        raise ValueError(f"Unsupported file type: {file_type}")

    if not text.strip():
        raise ValueError("Couldn't extract any text from the file.")

    return text

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

    # Helper for PDF extraction
    def try_pdf(path):
        try:
            pdf_text = ""
            doc = fitz.open(path)
            for page in doc:
                pdf_text += page.get_text("text")
            return pdf_text
        except:
            return None

    # Helper for DOCX extraction
    def try_docx(path):
        try:
            return docx2txt.process(path)
        except:
            return None

    if file_type == ".pdf":
        text = try_pdf(file_path)
        # Fallback to DOCX if PDF fails (mislabeled file)
        if not text or not text.strip():
            text = try_docx(file_path)
    elif file_type in [".docx", ".rtf"]:
        text = try_docx(file_path)
        # Fallback to PDF if DOCX fails
        if not text or not text.strip():
            text = try_pdf(file_path)
    else:
        # Unknown extension, try both
        text = try_pdf(file_path) or try_docx(file_path)

    if not text or not text.strip():
        raise ValueError(f"Couldn't extract any text from the file: {file_path}")

    return text

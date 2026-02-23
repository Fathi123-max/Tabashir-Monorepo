# File utilities - stub implementation

def allowed_file(filename):
    """Check if file extension is allowed"""
    allowed_extensions = {'pdf', 'doc', 'docx'}
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in allowed_extensions

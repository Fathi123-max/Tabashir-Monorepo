# CV Processor service - stub implementation
# TODO: Implement actual CV processing

def cv_formatter(raw_cv_data):
    """Format raw CV data"""
    from app.models.cv_models import CVFormatter
    return CVFormatter(raw_cv_data)

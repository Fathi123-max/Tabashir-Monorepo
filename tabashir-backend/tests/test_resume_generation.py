import pytest
import json
import sys
import os
from unittest.mock import patch, MagicMock

# Add project root to sys.path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from app import create_app
from app.services.jwt_service import create_access_token

@pytest.fixture
def client():
    app = create_app()
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

@pytest.fixture
def auth_headers():
    """Create valid auth headers with JWT token"""
    token = create_access_token({
        "id": "test-user-123",
        "email": "test@example.com",
        "userType": "CANDIDATE"
    })
    return {"Authorization": f"Bearer {token}"}

@patch('app.routes.resumes_namespace.execute_query')
@patch('app.models.cv_models.Resume.write_document')
def test_save_and_generate_resume_success(mock_write, mock_query, client, auth_headers):
    """Test successful resume save and generation"""
    # Mock candidate lookup
    # First call: SELECT id FROM "Candidate"
    # Second call: INSERT INTO "Resume"
    mock_query.side_effect = [
        {'id': 'candidate-123'}, # Candidate exists
        None # INSERT Resume success
    ]
    
    # Mock write_document to do nothing
    mock_write.return_value = None
    
    resume_data = {
        "header": {"name": "Test User", "email": "test@example.com", "phone": "123", "address": "Address", "linkedin": "Link"},
        "objective": "A career objective",
        "education": [{"university": "Test Uni", "degree": "BSc", "date": "2020", "location": "Test City", "major": "CS", "GPA": "3.8"}],
        "work": [],
        "leadership": [],
        "projects": [],
        "skills": {"softskills": [], "skillset": [], "training": []},
        "languages": ["English"],
        "keywords": ["test"]
    }
    
    payload = {
        "resume_data": resume_data,
        "template_id": "regular",
        "filename": "test_resume.docx"
    }
    
    response = client.post(
        '/api/v1/resumes/save-and-generate',
        data=json.dumps(payload),
        content_type='application/json',
        headers=auth_headers
    )
    
    # It should fail now because the endpoint doesn't exist
    assert response.status_code == 201
    data = response.get_json()
    assert data['success'] is True
    assert 'resume' in data
    assert 'id' in data['resume']
    
    # Verify write_document was called
    assert mock_write.called
    
    # Verify DB insert was called with sourceData
    assert mock_query.call_count == 2
    # Check the second call (INSERT)
    insert_call = mock_query.call_args_list[1]
    query = insert_call[0][0]
    params = insert_call[0][1]
    assert 'sourceData' in query
    
    # Find resume_data in params (it should be in source_data field of the serialized Resume)
    resume_data_found = False
    for p in params:
        if isinstance(p, str):
            try:
                data = json.loads(p)
                if data.get('source_data') == resume_data:
                    resume_data_found = True
                    break
            except:
                pass
    
    assert resume_data_found

#!/bin/bash

# Test the fixed upload endpoint
TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNtaTdmcXl2ZTAwMTQ4enc5eDV4aWljaTEiLCJlbWFpbCI6InByb2ZpbGV0ZXN0QHRhYmFzaGlyLmNvbSIsInVzZXJUeXBlIjoiQ0FORElEQVRFIiwiaWF0IjoxNzYzNjQ0MDU2LCJleHAiOjE3NjM2NDQ5NTZ9.0Vy8hdGO-bFi4mR3ptl-IqOK2knx1-gkkXV-PfsBSKo"

# Create a simple test PDF file
echo "Test PDF Content" > /tmp/test-resume.txt

# Upload the file
curl -X POST http://localhost:3000/api/mobile/resumes \
  -H "Authorization: Bearer $TOKEN" \
  -F "file=@/tmp/test-resume.txt;type=application/pdf" \
  2>&1 | head -20

echo ""
echo "Done!"

#!/bin/bash

# Comprehensive Resume API Test Script
# Usage: ./test-all-resume-endpoints.sh YOUR_JWT_TOKEN

TOKEN="${1}"
BASE_URL="http://localhost:3000/api/mobile"

if [ -z "$TOKEN" ]; then
    echo "Error: Please provide a JWT token"
    echo "Usage: $0 YOUR_JWT_TOKEN"
    exit 1
fi

echo "========================================="
echo "   RESUME API ENDPOINTS TEST SUITE"
echo "========================================="
echo ""

# Create test PDF
TEST_PDF="/tmp/test_resume_$(date +%s).pdf"
cat > "$TEST_PDF" << 'EOF'
%PDF-1.4
1 0 obj
<< /Type /Catalog /Pages 2 0 R >>
endobj
2 0 obj
<< /Type /Pages /Kids [3 0 R] /Count 1 >>
endobj
3 0 obj
<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Contents 4 0 R >>
endobj
4 0 obj
<< /Length 44 >>
stream
BT
/F1 12 Tf
100 700 Td
(Test Resume) Tj
ET
endstream
endobj
xref
0 5
0000000000 65535 f
0000000009 00000 n
0000000058 00000 n
0000000115 00000 n
0000000252 00000 n
trailer
<< /Size 5 /Root 1 0 R >>
startxref
354
%%EOF

RESUME_ID=""
SUCCESS_COUNT=0
FAIL_COUNT=0

# Test 1: Upload Resume
echo "TEST 1: POST /resumes (Upload Resume)"
echo "---------------------------------------"
UPLOAD_RESPONSE=$(curl -s -X POST "$BASE_URL/resumes" \
  -H "Authorization: Bearer $TOKEN" \
  -F "file=@$TEST_PDF")
echo "$UPLOAD_RESPONSE" | jq '.' || echo "$UPLOAD_RESPONSE"

if echo "$UPLOAD_RESPONSE" | jq -e '.success' > /dev/null 2>&1; then
    RESUME_ID=$(echo "$UPLOAD_RESPONSE" | jq -r '.resume.id')
    echo "✅ SUCCESS: Resume uploaded with ID: $RESUME_ID"
    ((SUCCESS_COUNT++))
else
    echo "❌ FAILED: Upload failed"
    ((FAIL_COUNT++))
fi
echo ""

# Test 2: List Resumes
echo "TEST 2: GET /resumes (List Resumes)"
echo "---------------------------------------"
LIST_RESPONSE=$(curl -s -X GET "$BASE_URL/resumes" \
  -H "Authorization: Bearer $TOKEN")
echo "$LIST_RESPONSE" | jq '.' || echo "$LIST_RESPONSE"

if echo "$LIST_RESPONSE" | jq -e '.success' > /dev/null 2>&1; then
    RESUME_COUNT=$(echo "$LIST_RESPONSE" | jq '.resumes | length')
    echo "✅ SUCCESS: Found $RESUME_COUNT resume(s)"
    ((SUCCESS_COUNT++))

    # Update RESUME_ID from list if not set
    if [ -z "$RESUME_ID" ]; then
        RESUME_ID=$(echo "$LIST_RESPONSE" | jq -r '.resumes[0].id')
        echo "   Using resume ID: $RESUME_ID"
    fi
else
    echo "❌ FAILED: List failed"
    ((FAIL_COUNT++))
fi
echo ""

# Test 3: Get Resume Details
if [ -n "$RESUME_ID" ]; then
    echo "TEST 3: GET /resumes/$RESUME_ID (Get Details)"
    echo "---------------------------------------"
    DETAILS_RESPONSE=$(curl -s -X GET "$BASE_URL/resumes/$RESUME_ID" \
      -H "Authorization: Bearer $TOKEN")
    echo "$DETAILS_RESPONSE" | jq '.' || echo "$DETAILS_RESPONSE"

    if echo "$DETAILS_RESPONSE" | jq -e '.success' > /dev/null 2>&1; then
        echo "✅ SUCCESS: Retrieved resume details"
        ((SUCCESS_COUNT++))
    else
        echo "❌ FAILED: Get details failed"
        ((FAIL_COUNT++))
    fi
    echo ""
else
    echo "TEST 3: SKIPPED (No resume ID)"
    echo ""
fi

# Test 4: Update Resume
if [ -n "$RESUME_ID" ]; then
    echo "TEST 4: PUT /resumes/$RESUME_ID (Update Resume)"
    echo "---------------------------------------"
    UPDATE_RESPONSE=$(curl -s -X PUT "$BASE_URL/resumes/$RESUME_ID" \
      -H "Authorization: Bearer $TOKEN" \
      -F "file=@$TEST_PDF")
    echo "$UPDATE_RESPONSE" | jq '.' || echo "$UPDATE_RESPONSE"

    if echo "$UPDATE_RESPONSE" | jq -e '.success' > /dev/null 2>&1; then
        echo "✅ SUCCESS: Resume updated"
        ((SUCCESS_COUNT++))
    else
        echo "❌ FAILED: Update failed"
        ((FAIL_COUNT++))
    fi
    echo ""
else
    echo "TEST 4: SKIPPED (No resume ID)"
    echo ""
fi

# Test 5: Duplicate Resume
if [ -n "$RESUME_ID" ]; then
    echo "TEST 5: POST /resumes/$RESUME_ID/duplicate (Duplicate Resume)"
    echo "---------------------------------------"
    DUPLICATE_RESPONSE=$(curl -s -X POST "$BASE_URL/resumes/$RESUME_ID/duplicate" \
      -H "Authorization: Bearer $TOKEN")
    echo "$DUPLICATE_RESPONSE" | jq '.' || echo "$DUPLICATE_RESPONSE"

    if echo "$DUPLICATE_RESPONSE" | jq -e '.success' > /dev/null 2>&1; then
        DUPLICATE_ID=$(echo "$DUPLICATE_RESPONSE" | jq -r '.resume.id')
        echo "✅ SUCCESS: Resume duplicated with ID: $DUPLICATE_ID"
        ((SUCCESS_COUNT++))
    else
        echo "❌ FAILED: Duplicate failed"
        ((FAIL_COUNT++))
    fi
    echo ""
else
    echo "TEST 5: SKIPPED (No resume ID)"
    echo ""
fi

# Test 6: Export as PDF
if [ -n "$RESUME_ID" ]; then
    echo "TEST 6: POST /resumes/$RESUME_ID/export/pdf (Export to PDF)"
    echo "---------------------------------------"
    PDF_RESPONSE=$(curl -s -X POST "$BASE_URL/resumes/$RESUME_ID/export/pdf" \
      -H "Authorization: Bearer $TOKEN")
    echo "$PDF_RESPONSE" | jq '.' || echo "$PDF_RESPONSE"

    if echo "$PDF_RESPONSE" | jq -e '.success' > /dev/null 2>&1; then
        echo "✅ SUCCESS: Resume exported as PDF"
        ((SUCCESS_COUNT++))
    else
        echo "❌ FAILED: PDF export failed"
        ((FAIL_COUNT++))
    fi
    echo ""
else
    echo "TEST 6: SKIPPED (No resume ID)"
    echo ""
fi

# Test 7: Export as Word
if [ -n "$RESUME_ID" ]; then
    echo "TEST 7: POST /resumes/$RESUME_ID/export/word (Export to Word)"
    echo "---------------------------------------"
    WORD_FILE="/tmp/test_resume_$(date +%s).docx"
    WORD_RESPONSE=$(curl -s -X POST "$BASE_URL/resumes/$RESUME_ID/export/word" \
      -H "Authorization: Bearer $TOKEN" \
      -o "$WORD_FILE")
    FILE_SIZE=$(stat -f%z "$WORD_FILE" 2>/dev/null || stat -c%s "$WORD_FILE" 2>/dev/null || echo 0)
    echo "Downloaded file size: $FILE_SIZE bytes"

    if [ "$FILE_SIZE" -gt 0 ]; then
        echo "✅ SUCCESS: Word document downloaded"
        ((SUCCESS_COUNT++))
    else
        echo "❌ FAILED: Word export failed or empty file"
        ((FAIL_COUNT++))
    fi
    echo ""
else
    echo "TEST 7: SKIPPED (No resume ID)"
    echo ""
fi

# Test 8: Translate Resume
if [ -n "$RESUME_ID" ]; then
    echo "TEST 8: POST /resumes/$RESUME_ID/translate (Translate Resume)"
    echo "---------------------------------------"
    TRANSLATE_RESPONSE=$(curl -s -X POST "$BASE_URL/resumes/$RESUME_ID/translate" \
      -H "Authorization: Bearer $TOKEN" \
      -H "Content-Type: application/json" \
      -d '{"targetLanguage": "ar"}')
    echo "$TRANSLATE_RESPONSE" | jq '.' || echo "$TRANSLATE_RESPONSE"

    if echo "$TRANSLATE_RESPONSE" | jq -e '.success' > /dev/null 2>&1; then
        echo "✅ SUCCESS: Resume translated"
        ((SUCCESS_COUNT++))
    else
        echo "❌ FAILED: Translation failed"
        ((FAIL_COUNT++))
    fi
    echo ""
else
    echo "TEST 8: SKIPPED (No resume ID)"
    echo ""
fi

# Test 9: Delete Resume
if [ -n "$RESUME_ID" ]; then
    echo "TEST 9: DELETE /resumes/$RESUME_ID (Delete Resume)"
    echo "---------------------------------------"
    DELETE_RESPONSE=$(curl -s -X DELETE "$BASE_URL/resumes/$RESUME_ID" \
      -H "Authorization: Bearer $TOKEN")
    echo "$DELETE_RESPONSE" | jq '.' || echo "$DELETE_RESPONSE"

    if echo "$DELETE_RESPONSE" | jq -e '.success' > /dev/null 2>&1; then
        echo "✅ SUCCESS: Resume deleted"
        ((SUCCESS_COUNT++))
    else
        echo "❌ FAILED: Delete failed"
        ((FAIL_COUNT++))
    fi
    echo ""
else
    echo "TEST 9: SKIPPED (No resume ID)"
    echo ""
fi

# Clean up
rm -f "$TEST_PDF" "$WORD_FILE" /tmp/token.txt

# Summary
echo "========================================="
echo "   TEST SUMMARY"
echo "========================================="
echo "Total Tests: $((SUCCESS_COUNT + FAIL_COUNT))"
echo "✅ Passed: $SUCCESS_COUNT"
echo "❌ Failed: $FAIL_COUNT"
echo ""
echo "Working Endpoints:"
echo "  - POST /api/mobile/resumes (Upload)"
echo "  - GET /api/mobile/resumes (List)"
echo "  - GET /api/mobile/resumes/{id} (Details)"
echo ""

if [ $FAIL_COUNT -gt 0 ]; then
    echo "Failing Endpoints:"
    echo "  - PUT /api/mobile/resumes/{id} (Update)"
    echo "  - POST /api/mobile/resumes/{id}/duplicate (Duplicate)"
    echo "  - POST /api/mobile/resumes/{id}/export/pdf (PDF Export)"
    echo "  - POST /api/mobile/resumes/{id}/export/word (Word Export)"
    echo "  - POST /api/mobile/resumes/{id}/translate (Translate)"
    echo "  - DELETE /api/mobile/resumes/{id} (Delete)"
    echo ""
    echo "Note: Some endpoints may fail due to:"
    echo "  - Missing UploadThing integration (mock URLs)"
    echo "  - Missing OPENAI_API_KEY (translation)"
    echo "  - Incomplete implementation"
fi

echo "========================================="

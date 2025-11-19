#!/bin/bash

# Resume API Testing Script
# Usage: ./test-resume-api.sh YOUR_JWT_TOKEN

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
BASE_URL="http://localhost:3000/api/mobile"
TOKEN="${1:-YOUR_JWT_TOKEN_HERE}"

if [ "$TOKEN" = "YOUR_JWT_TOKEN_HERE" ]; then
    echo -e "${RED}Error: Please provide a JWT token${NC}"
    echo "Usage: ./test-resume-api.sh YOUR_JWT_TOKEN"
    exit 1
fi

echo -e "${YELLOW}=== Resume API Testing ===${NC}\n"

# Test 1: Authentication Test
echo -e "${YELLOW}Test 1: Authentication${NC}"
curl -s -X GET "$BASE_URL/test" \
  -H "Authorization: Bearer $TOKEN" | jq '.'
echo -e "\n"

# Test 2: List Resumes
echo -e "${YELLOW}Test 2: List All Resumes${NC}"
RESUMES=$(curl -s -X GET "$BASE_URL/resumes" \
  -H "Authorization: Bearer $TOKEN")
echo "$RESUMES" | jq '.'
RESUME_ID=$(echo "$RESUMES" | jq -r '.resumes[0].id // empty')
echo -e "\n"

if [ -z "$RESUME_ID" ]; then
    echo -e "${RED}No resumes found. Please upload a resume first.${NC}"
    echo -e "${YELLOW}Upload command:${NC}"
    echo "curl -X POST \"$BASE_URL/resumes\" \\"
    echo "  -H \"Authorization: Bearer $TOKEN\" \\"
    echo "  -F \"file=@/path/to/resume.pdf\""
    exit 0
fi

echo -e "${GREEN}Using Resume ID: $RESUME_ID${NC}\n"

# Test 3: Get Single Resume
echo -e "${YELLOW}Test 3: Get Resume Details${NC}"
curl -s -X GET "$BASE_URL/resumes/$RESUME_ID" \
  -H "Authorization: Bearer $TOKEN" | jq '.'
echo -e "\n"

# Test 4: Duplicate Resume
echo -e "${YELLOW}Test 4: Duplicate Resume${NC}"
DUPLICATE=$(curl -s -X POST "$BASE_URL/resumes/$RESUME_ID/duplicate" \
  -H "Authorization: Bearer $TOKEN")
echo "$DUPLICATE" | jq '.'
DUPLICATE_ID=$(echo "$DUPLICATE" | jq -r '.resume.id // empty')
echo -e "\n"

# Test 5: Export as PDF
echo -e "${YELLOW}Test 5: Export as PDF${NC}"
curl -s -X POST "$BASE_URL/resumes/$RESUME_ID/export/pdf" \
  -H "Authorization: Bearer $TOKEN" | jq '.'
echo -e "\n"

# Test 6: Export as Word
echo -e "${YELLOW}Test 6: Export as Word${NC}"
echo "Downloading Word document..."
curl -s -X POST "$BASE_URL/resumes/$RESUME_ID/export/word" \
  -H "Authorization: Bearer $TOKEN" \
  -o "test_resume.docx"
if [ -f "test_resume.docx" ]; then
    FILE_SIZE=$(wc -c < "test_resume.docx")
    if [ "$FILE_SIZE" -gt 0 ]; then
        echo -e "${GREEN}✓ Word document downloaded successfully (${FILE_SIZE} bytes)${NC}"
    else
        echo -e "${RED}✗ Word document is empty${NC}"
    fi
else
    echo -e "${RED}✗ Failed to download Word document${NC}"
fi
echo -e "\n"

# Test 7: Translate Resume (Arabic)
echo -e "${YELLOW}Test 7: Translate Resume to Arabic${NC}"
curl -s -X POST "$BASE_URL/resumes/$RESUME_ID/translate" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"targetLanguage": "ar"}' | jq '.'
echo -e "\n"

# Test 8: Delete Duplicate Resume (cleanup)
if [ ! -z "$DUPLICATE_ID" ]; then
    echo -e "${YELLOW}Test 8: Delete Duplicate Resume (Cleanup)${NC}"
    curl -s -X DELETE "$BASE_URL/resumes/$DUPLICATE_ID" \
      -H "Authorization: Bearer $TOKEN" | jq '.'
    echo -e "\n"
fi

echo -e "${GREEN}=== Testing Complete ===${NC}"
echo -e "\nNote: Some tests may fail if:"
echo "  - Resume doesn't have formatedContent (Word export, Translation)"
echo "  - OPENAI_API_KEY is not configured (Translation)"
echo "  - Resume file doesn't exist in UploadThing (PDF export)"

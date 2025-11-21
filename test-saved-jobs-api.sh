#!/bin/bash

# Saved Jobs API Testing Script
# Usage: ./test-saved-jobs-api.sh YOUR_JWT_TOKEN

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
BASE_URL="http://localhost:3001/api/mobile"
TOKEN="${1:-YOUR_JWT_TOKEN_HERE}"

if [ "$TOKEN" = "YOUR_JWT_TOKEN_HERE" ]; then
    echo -e "${YELLOW}Note: No JWT token provided, testing without authentication (should fail with 401)${NC}"
    TOKEN="INVALID_TOKEN"
fi

echo -e "${YELLOW}=== Saved Jobs API Testing ===${NC}\n"

# Test 1: GET saved jobs (should return empty list or error)
echo -e "${YELLOW}Test 1: GET saved jobs${NC}"
curl -s -X GET "$BASE_URL/saved-jobs" \
  -H "Authorization: Bearer $TOKEN" | jq '.' || echo "Failed to parse JSON"
echo -e "\n"

# Test 2: POST save a job
echo -e "${YELLOW}Test 2: POST save a job (test-job-123)${NC}"
curl -s -X POST "$BASE_URL/saved-jobs" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"jobId": "test-job-123"}' | jq '.' || echo "Failed to parse JSON"
echo -e "\n"

# Test 3: GET saved jobs again
echo -e "${YELLOW}Test 3: GET saved jobs (should show test-job-123)${NC}"
curl -s -X GET "$BASE_URL/saved-jobs" \
  -H "Authorization: Bearer $TOKEN" | jq '.' || echo "Failed to parse JSON"
echo -e "\n"

# Test 4: DELETE saved job
echo -e "${YELLOW}Test 4: DELETE saved job (test-job-123)${NC}"
curl -s -X DELETE "$BASE_URL/saved-jobs/test-job-123" \
  -H "Authorization: Bearer $TOKEN" | jq '.' || echo "Failed to parse JSON"
echo -e "\n"

# Test 5: GET saved jobs again
echo -e "${YELLOW}Test 5: GET saved jobs (should be empty)${NC}"
curl -s -X GET "$BASE_URL/saved-jobs" \
  -H "Authorization: Bearer $TOKEN" | jq '.' || echo "Failed to parse JSON"
echo -e "\n"

echo -e "${GREEN}=== Testing Complete ===${NC}"

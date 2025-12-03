#!/bin/bash

# API Test script for Tabashir Resume Processing API
# Testing the seventh set of 3 endpoints

BASE_URL="https://backend.tabashir.ae"
API_TOKEN="a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5"

echo "Testing Tabashir Resume Processing API endpoints - Set 7"
echo "Base URL: $BASE_URL"
echo "API Token: $API_TOKEN"
echo

# Test 1: Jobs monthly count endpoint (without required keyword parameter)
echo "1. Testing Jobs Monthly Count endpoint: $BASE_URL/api/v1/resume/jobs/monthly-count (without required keyword parameter)"
response=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  --request GET \
  "$BASE_URL/api/v1/resume/jobs/monthly-count")
echo "Response status code: $response"
if [ "$response" -ge 400 ] && [ "$response" -lt 500 ]; then
  echo "  ⚠️  Jobs monthly count endpoint returned client error (expected for missing keyword)"
elif [ "$response" -eq 200 ]; then
  echo "  ⚠️  Jobs monthly count endpoint unexpectedly returned 200"
else
  echo "  ❌ Jobs monthly count endpoint failed with server error: $response"
fi
echo

# Test 2: Jobs monthly count endpoint with a keyword
echo "2. Testing Jobs Monthly Count endpoint with keyword"
response_with_param=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  --request GET \
  "$BASE_URL/api/v1/resume/jobs/monthly-count?keyword=software")
echo "Response status code: $response_with_param"
if [ "$response_with_param" -eq 200 ]; then
  echo "  ✅ Jobs monthly count endpoint returned 200"
  # Get actual response content
  content=$(curl -s \
    --header "X-API-TOKEN: $API_TOKEN" \
    --request GET \
    "$BASE_URL/api/v1/resume/jobs/monthly-count?keyword=software")
  echo "  Content: $content"
else
  echo "  ❌ Jobs monthly count endpoint failed with status: $response_with_param"
fi
echo

# Test 3: Job by ID endpoint (with a test ID)
echo "3. Testing Job by ID endpoint: $BASE_URL/api/v1/resume/jobs/1 (with test job ID)"
response_job_id=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  --request GET \
  "$BASE_URL/api/v1/resume/jobs/1")
echo "Response status code: $response_job_id"
if [ "$response_job_id" -eq 200 ]; then
  echo "  ✅ Job by ID endpoint returned 200"
  # Get actual response content
  content=$(curl -s \
    --header "X-API-TOKEN: $API_TOKEN" \
    --request GET \
    "$BASE_URL/api/v1/resume/jobs/1")
  echo "  Content length: $(echo $content | wc -c) characters"
elif [ "$response_job_id" -eq 404 ]; then
  echo "  ⚠️  Job by ID endpoint returned 404 (job not found)"
else
  echo "  ❌ Job by ID endpoint failed with status: $response_job_id"
fi

echo
echo "Seventh set of tests completed."
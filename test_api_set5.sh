#!/bin/bash

# API Test script for Tabashir Resume Processing API
# Testing the fifth set of 3 endpoints

BASE_URL="https://backend.tabashir.ae"
API_TOKEN="a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5"

echo "Testing Tabashir Resume Processing API endpoints - Set 5"
echo "Base URL: $BASE_URL"
echo "API Token: $API_TOKEN"
echo

# Test 1: Jobs endpoint POST (without required payload)
echo "1. Testing Jobs endpoint (POST): $BASE_URL/api/v1/resume/jobs (without required payload)"
response=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  --header "Content-Type: application/json" \
  --request POST \
  "$BASE_URL/api/v1/resume/jobs")
echo "Response status code: $response"
if [ "$response" -eq 400 ]; then
  echo "  ✅ Jobs POST endpoint correctly returned 400 for missing payload"
elif [ "$response" -ge 500 ]; then
  echo "  ❌ Jobs POST endpoint failed with server error: $response"
else
  echo "  ⚠️  Jobs POST endpoint returned unexpected status: $response"
fi
echo

# Test 2: Jobs endpoint POST with minimal valid payload
echo "2. Testing Jobs endpoint (POST) with minimal valid payload"
response_post=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  --header "Content-Type: application/json" \
  --request POST \
  --data '{"job_title":"Software Engineer","job_date":"2025-01-01"}' \
  "$BASE_URL/api/v1/resume/jobs")
echo "Response status code: $response_post"
if [ "$response_post" -eq 200 ]; then
  echo "  ✅ Jobs POST endpoint returned 200"
  # Get actual response content
  content=$(curl -s \
    --header "X-API-TOKEN: $API_TOKEN" \
    --header "Content-Type: application/json" \
    --request POST \
    --data '{"job_title":"Software Engineer","job_date":"2025-01-01"}' \
    "$BASE_URL/api/v1/resume/jobs")
  echo "  Content: $content"
elif [ "$response_post" -ge 500 ]; then
  echo "  ❌ Jobs POST endpoint failed with server error: $response_post"
else
  echo "  ❌ Jobs POST endpoint returned unexpected status: $response_post"
fi
echo

# Test 3: Jobs endpoint GET (with no parameters to test general functionality)
echo "3. Testing Jobs endpoint (GET): $BASE_URL/api/v1/resume/jobs (with no parameters)"
response_get=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  --request GET \
  "$BASE_URL/api/v1/resume/jobs")
echo "Response status code: $response_get"
if [ "$response_get" -eq 200 ]; then
  echo "  ✅ Jobs GET endpoint returned 200"
  # Get actual response content
  content=$(curl -s \
    --header "X-API-TOKEN: $API_TOKEN" \
    --request GET \
    "$BASE_URL/api/v1/resume/jobs")
  echo "  Content length: $(echo $content | wc -c) characters"
elif [ "$response_get" -ge 500 ]; then
  echo "  ❌ Jobs GET endpoint failed with server error: $response_get"
else
  echo "  ⚠️  Jobs GET endpoint returned unexpected status: $response_get"
fi

echo
echo "Fifth set of tests completed."
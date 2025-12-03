#!/bin/bash

# API Test script for Tabashir Resume Processing API
# Testing the sixth set of 3 endpoints

BASE_URL="https://backend.tabashir.ae"
API_TOKEN="a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5"

echo "Testing Tabashir Resume Processing API endpoints - Set 6"
echo "Base URL: $BASE_URL"
echo "API Token: $API_TOKEN"
echo

# Test 1: Jobs count by city endpoint (without required parameter)
echo "1. Testing Jobs Count by City endpoint: $BASE_URL/api/v1/resume/jobs/count-by-city (without required job_title parameter)"
response=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  --request GET \
  "$BASE_URL/api/v1/resume/jobs/count-by-city")
echo "Response status code: $response"
if [ "$response" -ge 400 ] && [ "$response" -lt 500 ]; then
  echo "  ⚠️  Jobs count by city endpoint returned client error (expected for missing parameter)"
elif [ "$response" -eq 200 ]; then
  echo "  ⚠️  Jobs count by city endpoint unexpectedly returned 200"
else
  echo "  ❌ Jobs count by city endpoint failed with server error: $response"
fi
echo

# Test 2: Jobs count by city endpoint with a job title
echo "2. Testing Jobs Count by City endpoint with job title"
response_with_param=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  --request GET \
  "$BASE_URL/api/v1/resume/jobs/count-by-city?job_title=software")
echo "Response status code: $response_with_param"
if [ "$response_with_param" -eq 200 ]; then
  echo "  ✅ Jobs count by city endpoint returned 200"
  # Get actual response content
  content=$(curl -s \
    --header "X-API-TOKEN: $API_TOKEN" \
    --request GET \
    "$BASE_URL/api/v1/resume/jobs/count-by-city?job_title=software")
  echo "  Content: $content"
else
  echo "  ❌ Jobs count by city endpoint failed with status: $response_with_param"
fi
echo

# Test 3: Jobs match endpoint (without required email parameter)
echo "3. Testing Jobs Match endpoint: $BASE_URL/api/v1/resume/jobs/match (without required email parameter)"
response_match=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  --request GET \
  "$BASE_URL/api/v1/resume/jobs/match")
echo "Response status code: $response_match"
if [ "$response_match" -ge 400 ] && [ "$response_match" -lt 500 ]; then
  echo "  ⚠️  Jobs match endpoint returned client error (expected for missing email)"
elif [ "$response_match" -eq 200 ]; then
  echo "  ⚠️  Jobs match endpoint unexpectedly returned 200"
else
  echo "  ❌ Jobs match endpoint failed with server error: $response_match"
fi

echo
echo "Sixth set of tests completed."
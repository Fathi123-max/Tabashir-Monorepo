#!/bin/bash

# API Test script for Tabashir Resume Processing API
# Testing the eighth set of 3 endpoints

BASE_URL="https://backend.tabashir.ae"
API_TOKEN="a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5"

echo "Testing Tabashir Resume Processing API endpoints - Set 8"
echo "Base URL: $BASE_URL"
echo "API Token: $API_TOKEN"
echo

# Test 1: Job applicants count endpoint (without required job_id parameter)
echo "1. Testing Job Applicants Count endpoint: $BASE_URL/api/v1/resume/jobs/1/applicants-count (with test job ID)"
response=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  --request GET \
  "$BASE_URL/api/v1/resume/jobs/1/applicants-count")
echo "Response status code: $response"
if [ "$response" -eq 200 ]; then
  echo "  ✅ Job applicants count endpoint returned 200"
  # Get actual response content
  content=$(curl -s \
    --header "X-API-TOKEN: $API_TOKEN" \
    --request GET \
    "$BASE_URL/api/v1/resume/jobs/1/applicants-count")
  echo "  Content: $content"
elif [ "$response" -eq 404 ]; then
  echo "  ⚠️  Job applicants count endpoint returned 404 (job not found)"
else
  echo "  ❌ Job applicants count endpoint failed with status: $response"
fi
echo

# Test 2: Send email endpoint (without required payload)
echo "2. Testing Send Email endpoint: $BASE_URL/api/v1/resume/send-linkedin-email (without required payload)"
response_email=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  --header "Content-Type: application/json" \
  --request POST \
  "$BASE_URL/api/v1/resume/send-linkedin-email")
echo "Response status code: $response_email"
if [ "$response_email" -ge 400 ] && [ "$response_email" -lt 500 ]; then
  echo "  ⚠️  Send email endpoint returned client error (expected for missing payload)"
elif [ "$response_email" -eq 200 ]; then
  echo "  ⚠️  Send email endpoint unexpectedly returned 200"
else
  echo "  ❌ Send email endpoint failed with server error: $response_email"
fi
echo

# Test 3: Send email endpoint with minimal valid payload
echo "3. Testing Send Email endpoint with minimal valid payload"
response_email_valid=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  --header "Content-Type: application/json" \
  --request POST \
  --data '{"recipient_email":"test@example.com","recipient_name":"Test User"}' \
  "$BASE_URL/api/v1/resume/send-linkedin-email")
echo "Response status code: $response_email_valid"
if [ "$response_email_valid" -eq 200 ]; then
  echo "  ✅ Send email endpoint returned 200"
  # Get actual response content
  content=$(curl -s \
    --header "X-API-TOKEN: $API_TOKEN" \
    --header "Content-Type: application/json" \
    --request POST \
    --data '{"recipient_email":"test@example.com","recipient_name":"Test User"}' \
    "$BASE_URL/api/v1/resume/send-linkedin-email")
  echo "  Content: $content"
else
  echo "  ❌ Send email endpoint failed with status: $response_email_valid"
fi

echo
echo "Eighth set of tests completed."
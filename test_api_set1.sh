#!/bin/bash

# API Test script for Tabashir Resume Processing API
# Testing the first set of 3 endpoints

BASE_URL="https://backend.tabashir.ae"
API_TOKEN="a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5"

echo "Testing Tabashir Resume Processing API endpoints"
echo "Base URL: $BASE_URL"
echo "API Token: $API_TOKEN"
echo

# Test 1: Health check endpoint
echo "1. Testing Health Check endpoint: $BASE_URL/api/v1/resume/health"
response=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  "$BASE_URL/api/v1/resume/health")
echo "Response status code: $response"
if [ "$response" -eq 200 ]; then
  echo "  ✅ Health check endpoint is working"
else
  echo "  ❌ Health check endpoint failed with status: $response"
fi
echo

# Test 2: Applied jobs endpoint (without email parameter to test error response)
echo "2. Testing Applied Jobs endpoint: $BASE_URL/api/v1/resume/applied-jobs (without required email)"
response=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  "$BASE_URL/api/v1/resume/applied-jobs")
echo "Response status code: $response"
if [ "$response" -eq 400 ]; then
  echo "  ✅ Applied jobs endpoint correctly returned 400 for missing email"
elif [ "$response" -eq 200 ]; then
  echo "  ⚠️  Applied jobs endpoint returned 200 (might be working or returning empty results)"
else
  echo "  ❌ Applied jobs endpoint failed with status: $response"
fi
echo

# Test 3: Applied jobs endpoint with a test email
echo "3. Testing Applied Jobs endpoint with test email"
response_with_email=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  "$BASE_URL/api/v1/resume/applied-jobs?email=test@example.com")
echo "Response status code: $response_with_email"
if [ "$response_with_email" -eq 200 ]; then
  echo "  ✅ Applied jobs endpoint returned 200 with test email"
  # Get actual response content
  content=$(curl -s \
    --header "X-API-TOKEN: $API_TOKEN" \
    "$BASE_URL/api/v1/resume/applied-jobs?email=test@example.com")
  echo "  Content: $content"
elif [ "$response_with_email" -eq 400 ]; then
  echo "  ❌ Applied jobs endpoint returned 400 with test email (invalid input)"
elif [ "$response_with_email" -eq 500 ]; then
  echo "  ❌ Applied jobs endpoint returned 500 (internal server error)"
else
  echo "  ❓ Applied jobs endpoint returned unexpected status: $response_with_email"
fi

echo
echo "First set of tests completed."
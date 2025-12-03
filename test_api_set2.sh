#!/bin/bash

# API Test script for Tabashir Resume Processing API
# Testing the second set of 3 endpoints

BASE_URL="https://backend.tabashir.ae"
API_TOKEN="a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5"

echo "Testing Tabashir Resume Processing API endpoints - Set 2"
echo "Base URL: $BASE_URL"
echo "API Token: $API_TOKEN"
echo

# Test 1: Applied Jobs Count endpoint (without required payload)
echo "1. Testing Applied Jobs Count endpoint: $BASE_URL/api/v1/resume/applied-jobs-count (without required payload)"
response=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  --header "Content-Type: application/json" \
  --request POST \
  "$BASE_URL/api/v1/resume/applied-jobs-count")
echo "Response status code: $response"
if [ "$response" -ge 400 ] && [ "$response" -lt 500 ]; then
  echo "  ⚠️  Applied jobs count endpoint returned client error (expected for missing payload)"
elif [ "$response" -eq 200 ]; then
  echo "  ⚠️  Applied jobs count endpoint unexpectedly returned 200"
else
  echo "  ❌ Applied jobs count endpoint failed with status: $response"
fi
echo

# Test 2: Applied Jobs Count endpoint with valid payload
echo "2. Testing Applied Jobs Count endpoint with valid payload"
response_with_payload=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  --header "Content-Type: application/json" \
  --request POST \
  --data '{"email":"test@example.com"}' \
  "$BASE_URL/api/v1/resume/applied-jobs-count")
echo "Response status code: $response_with_payload"
if [ "$response_with_payload" -eq 200 ]; then
  content=$(curl -s \
    --header "X-API-TOKEN: $API_TOKEN" \
    --header "Content-Type: application/json" \
    --request POST \
    --data '{"email":"test@example.com"}' \
    "$BASE_URL/api/v1/resume/applied-jobs-count")
  echo "  ✅ Applied jobs count endpoint returned 200"
  echo "  Content: $content"
else
  echo "  ❌ Applied jobs count endpoint failed with status: $response_with_payload"
fi
echo

# Test 3: Resume Apply endpoint (without required multipart data)
echo "3. Testing Resume Apply endpoint: $BASE_URL/api/v1/resume/apply (without required multipart data)"
response_apply=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  --request POST \
  "$BASE_URL/api/v1/resume/apply")
echo "Response status code: $response_apply"
if [ "$response_apply" -ge 400 ] && [ "$response" -lt 500 ]; then
  echo "  ⚠️  Resume apply endpoint returned client error (expected for missing multipart data)"
elif [ "$response_apply" -eq 200 ]; then
  echo "  ⚠️  Resume apply endpoint unexpectedly returned 200"
else
  echo "  ❌ Resume apply endpoint failed with status: $response_apply"
fi

echo
echo "Second set of tests completed."
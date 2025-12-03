#!/bin/bash

# API Test script for Tabashir Resume Processing API
# Testing the fourth set of 3 endpoints

BASE_URL="https://backend.tabashir.ae"
API_TOKEN="a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5"

echo "Testing Tabashir Resume Processing API endpoints - Set 4"
echo "Base URL: $BASE_URL"
echo "API Token: $API_TOKEN"
echo

# Test 1: Format CV Object endpoint (without required payload)
echo "1. Testing Format CV Object endpoint: $BASE_URL/api/v1/resume/format-cv-object (without required payload)"
response=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  --header "Content-Type: application/json" \
  --request POST \
  "$BASE_URL/api/v1/resume/format-cv-object")
echo "Response status code: $response"
if [ "$response" -eq 400 ]; then
  echo "  ✅ Format CV object endpoint correctly returned 400 for missing payload"
elif [ "$response" -ge 500 ]; then
  echo "  ❌ Format CV object endpoint failed with server error: $response"
else
  echo "  ⚠️  Format CV object endpoint returned unexpected status: $response"
fi
echo

# Test 2: Format CV Object endpoint with minimal valid payload
echo "2. Testing Format CV Object endpoint with minimal valid payload"
response_valid=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  --header "Content-Type: application/json" \
  --request POST \
  --data '{"raw_data":"John Doe\nSoftware Engineer\n5 years of experience"}' \
  "$BASE_URL/api/v1/resume/format-cv-object")
echo "Response status code: $response_valid"
if [ "$response_valid" -eq 200 ]; then
  echo "  ✅ Format CV object endpoint returned 200"
  # Get actual response content
  content=$(curl -s \
    --header "X-API-TOKEN: $API_TOKEN" \
    --header "Content-Type: application/json" \
    --request POST \
    --data '{"raw_data":"John Doe\nSoftware Engineer\n5 years of experience"}' \
    "$BASE_URL/api/v1/resume/format-cv-object")
  echo "  Content: $content"
elif [ "$response_valid" -ge 500 ]; then
  echo "  ❌ Format CV object endpoint failed with server error: $response_valid"
else
  echo "  ❌ Format CV object endpoint returned unexpected status: $response_valid"
fi
echo

# Test 3: Generate Docx from JSON endpoint (without required payload)
echo "3. Testing Generate Docx from JSON endpoint: $BASE_URL/api/v1/resume/generate-docx-from-json (without required payload)"
response_docx=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  --header "Content-Type: application/json" \
  --request POST \
  "$BASE_URL/api/v1/resume/generate-docx-from-json")
echo "Response status code: $response_docx"
if [ "$response_docx" -eq 400 ]; then
  echo "  ✅ Generate docx from JSON endpoint correctly returned 400 for missing payload"
elif [ "$response_docx" -ge 500 ]; then
  echo "  ❌ Generate docx from JSON endpoint failed with server error: $response_docx"
else
  echo "  ⚠️  Generate docx from JSON endpoint returned unexpected status: $response_docx"
fi

echo
echo "Fourth set of tests completed."
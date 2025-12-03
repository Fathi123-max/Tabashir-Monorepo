#!/bin/bash

# API Test script for Tabashir Resume Processing API
# Testing the third set of 3 endpoints

BASE_URL="https://backend.tabashir.ae"
API_TOKEN="a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5"

echo "Testing Tabashir Resume Processing API endpoints - Set 3"
echo "Base URL: $BASE_URL"
echo "API Token: $API_TOKEN"
echo

# Test 1: CV Format endpoint (without required file)
echo "1. Testing CV Format endpoint: $BASE_URL/api/v1/resume/format (without required file)"
response=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  --request POST \
  "$BASE_URL/api/v1/resume/format")
echo "Response status code: $response"
if [ "$response" -eq 400 ]; then
  echo "  ✅ CV format endpoint correctly returned 400 for missing file"
elif [ "$response" -ge 500 ]; then
  echo "  ❌ CV format endpoint failed with server error: $response"
else
  echo "  ⚠️  CV format endpoint returned unexpected status: $response"
fi
echo

# Test 2: Format from Raw endpoint without required payload
echo "2. Testing Format from Raw endpoint: $BASE_URL/api/v1/resume/format-from-raw (without required payload)"
response_raw=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  --header "Content-Type: application/json" \
  --request POST \
  "$BASE_URL/api/v1/resume/format-from-raw")
echo "Response status code: $response_raw"
if [ "$response_raw" -eq 400 ]; then
  echo "  ✅ Format from raw endpoint correctly returned 400 for missing payload"
elif [ "$response_raw" -ge 500 ]; then
  echo "  ❌ Format from raw endpoint failed with server error: $response_raw"
else
  echo "  ⚠️  Format from raw endpoint returned unexpected status: $response_raw"
fi
echo

# Test 3: Format from Raw endpoint with minimal valid payload
echo "3. Testing Format from Raw endpoint with minimal valid payload"
response_raw_valid=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  --header "Content-Type: application/json" \
  --request POST \
  --data '{"raw_data":"John Doe\nSoftware Engineer\n5 years of experience"}' \
  "$BASE_URL/api/v1/resume/format-from-raw")
echo "Response status code: $response_raw_valid"
if [ "$response_raw_valid" -eq 200 ]; then
  echo "  ✅ Format from raw endpoint returned 200"
  # Get actual response content
  content=$(curl -s \
    --header "X-API-TOKEN: $API_TOKEN" \
    --header "Content-Type: application/json" \
    --request POST \
    --data '{"raw_data":"John Doe\nSoftware Engineer\n5 years of experience"}' \
    "$BASE_URL/api/v1/resume/format-from-raw")
  echo "  Content: $content"
elif [ "$response_raw_valid" -ge 500 ]; then
  echo "  ❌ Format from raw endpoint failed with server error: $response_raw_valid"
else
  echo "  ❌ Format from raw endpoint returned unexpected status: $response_raw_valid"
fi

echo
echo "Third set of tests completed."
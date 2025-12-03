#!/bin/bash

# API Test script for Tabashir Resume Processing API
# Testing the ninth/final set of 3 endpoints

BASE_URL="https://backend.tabashir.ae"
API_TOKEN="a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5"

echo "Testing Tabashir Resume Processing API endpoints - Set 9 (Final)"
echo "Base URL: $BASE_URL"
echo "API Token: $API_TOKEN"
echo

# Test 1: CV Translation endpoint (without required file)
echo "1. Testing CV Translation endpoint: $BASE_URL/api/v1/resume/translate (without required file)"
response=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  --request POST \
  "$BASE_URL/api/v1/resume/translate")
echo "Response status code: $response"
if [ "$response" -eq 400 ]; then
  echo "  ✅ CV translation endpoint correctly returned 400 for missing file"
elif [ "$response" -ge 500 ]; then
  echo "  ❌ CV translation endpoint failed with server error: $response"
else
  echo "  ⚠️  CV translation endpoint returned unexpected status: $response"
fi
echo

# Test 2: Specific Job Apply endpoint (without required multipart data)
echo "2. Testing Specific Job Apply endpoint: $BASE_URL/api/v1/resume/1/apply (without required multipart data)"
response_job_apply=$(curl -s -o /dev/null -w "%{http_code}" \
  --header "X-API-TOKEN: $API_TOKEN" \
  --request POST \
  "$BASE_URL/api/v1/resume/1/apply")
echo "Response status code: $response_job_apply"
if [ "$response_job_apply" -ge 400 ] && [ "$response_job_apply" -lt 500 ]; then
  echo "  ⚠️  Specific job apply endpoint returned client error (expected for missing multipart data)"
elif [ "$response_job_apply" -eq 200 ]; then
  echo "  ⚠️  Specific job apply endpoint unexpectedly returned 200"
else
  echo "  ❌ Specific job apply endpoint failed with server error: $response_job_apply"
fi

echo
echo "Final set of tests completed."
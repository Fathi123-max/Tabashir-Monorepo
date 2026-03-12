#!/bin/bash

# Change to the project directory
cd /root/resume_api

# Activate virtual environment
source .venv/bin/activate

# Run the Python script
python app/apify_integration.py

# Log the execution
echo "Apify sync completed at $(date)" >> /root/resume_api/logs/apify_sync.log

#!/bin/bash

# Define colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting Tabashir Backend Setup...${NC}"

# 1. Create necessary directories
echo -e "${GREEN}Creating required file processing directories...${NC}"
mkdir -p uploads/temp
mkdir -p uploads/processed/formatted
mkdir -p uploads/processed/translated
mkdir -p CVs

# 2. Setup Virtual Environment (if it doesn't exist)
if [ ! -d "venv" ]; then
    echo -e "${GREEN}Creating Python virtual environment (venv) using python3.11...${NC}"
    python3.11 -m venv venv
else
    echo -e "${BLUE}Virtual environment 'venv' already exists. Skipping creation.${NC}"
fi

# 3. Activate the Virtual Environment
echo -e "${GREEN}Activating virtual environment...${NC}"
source venv/bin/activate

# 4. Install dependencies
echo -e "${GREEN}Installing Python dependencies from requirements.txt...${NC}"
pip install --upgrade pip
pip install -r requirements.txt

# 5. Download SpaCy Model
echo -e "${GREEN}Downloading spaCy 'en_core_web_sm' model...${NC}"
python -m spacy download en_core_web_sm

echo -e "${BLUE}======================================================${NC}"
echo -e "${GREEN}Setup is complete!${NC}"
echo -e "Next steps:"
echo -e "1. Fill out the missing credentials in the ${RED}.env${NC} file."
echo -e "2. Ensure PostgreSQL is running and the databases are created."
echo -e "3. Activate your virtual environment: ${BLUE}source venv/bin/activate${NC}"
echo -e "4. Run the server: ${BLUE}python run.py${NC}"
echo -e "${BLUE}======================================================${NC}"

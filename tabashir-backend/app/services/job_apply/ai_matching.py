
import logging
from typing import Dict

import numpy as np
import spacy
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
from app.database.db import execute_query, execute_ai_query

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def ensure_user_in_ai_db(email):
    """
    Ensures that a user with the given email exists in the AI database.
    If not, it attempts to sync them from the main database.
    """
    # 1. Check AI DB
    client = execute_ai_query("SELECT id FROM clients WHERE email = %s", (email,), fetch_one=True)
    if client:
        return True
        
    # 2. Fallback to Main DB
    user = execute_query('SELECT id, name FROM users WHERE email = %s', (email,), fetch_one=True)
    if not user:
        return False
        
    # 3. Provision in AI DB
    execute_ai_query(
        "INSERT INTO clients (email, name, created_at) VALUES (%s, %s, NOW())",
        (email, user['name']),
        commit=True
    )
    return True

# Load spaCy model
try:
    nlp = spacy.load("en_core_web_sm")
    logger.info("Loaded spaCy model")
except OSError:
    logger.error("Failed to load spaCy model. Please run: python -m spacy download en_core_web_sm")
    nlp = None

def extract_job_title(description: str) -> str:
    """Extract job title using NLP techniques"""
    try:
        logger.info(f"Extracting job title from description: {description[:100]}...")
        
        # Use NLP to extract job titles
        if nlp is not None:
            doc = nlp(description[:500])  # Process first 500 chars for efficiency
            
            # Common job title indicators
            title_indicators = ["position", "job title", "role", "looking for", "hiring", "seeking"]
            
            # Find sentences that might contain the job title
            potential_title_sentences = []
            for sent in doc.sents:
                sent_text = sent.text.lower()
                if any(indicator in sent_text for indicator in title_indicators):
                    potential_title_sentences.append(sent)
            
            # Extract potential job titles
            if potential_title_sentences:
                # Extract noun chunks that could be job titles
                for sent in potential_title_sentences:
                    sent_doc = nlp(sent.text)
                    for chunk in sent_doc.noun_chunks:
                        if len(chunk.text.split()) <= 5:  # Reasonable title length
                            return chunk.text.strip()
            
            # Fallback to first sentence nouns if no clear indicators
            for sent in doc.sents:
                for chunk in nlp(sent.text).noun_chunks:
                    if len(chunk.text.split()) <= 5:
                        return chunk.text.strip()
                break  # Only check first sentence in fallback
                
        # Simple fallback if NLP processing fails
        lines = description.split('\n')
        for line in lines[:5]:  # Check first few lines
            if 'position' in line.lower() or 'title' in line.lower() or 'role' in line.lower():
                return line.strip()
                
        # Last resort: return first 50 chars
        return description[:50].strip()
    except Exception as e:
        logger.error(f"Error extracting job title: {e}")
        return description[:50].strip()

def calculate_skills_match(job_text: str, candidate_skills: str) -> float:
    """Calculate skills match score using NLP"""
    try:
        logger.info("Calculating skills match using NLP")
        
        # Use TF-IDF and cosine similarity
        if not job_text or not candidate_skills:
            return 0.0
            
        vectorizer = TfidfVectorizer(stop_words='english')
        try:
            tfidf_matrix = vectorizer.fit_transform([job_text, candidate_skills])
            similarity = cosine_similarity(tfidf_matrix[0:1], tfidf_matrix[1:2])[0][0]
        except:
            # Fallback for vectorizer failures
            return 0.5
            
        # Enhance with spaCy similarity if available
        if nlp is not None:
            doc1 = nlp(job_text[:5000])  # Limit text size for performance
            doc2 = nlp(candidate_skills[:5000])
            spacy_similarity = doc1.similarity(doc2)
            
            # Combine TF-IDF and spaCy similarity
            combined_score = (similarity + spacy_similarity) / 2
            logger.info(f"Skills match score: {combined_score:.2f}")
            return combined_score
        
        logger.info(f"Skills match score (TF-IDF only): {similarity:.2f}")
        return similarity
    except Exception as e:
        logger.error(f"Error calculating skills match: {e}")
        return 0.5

def analyze_job_requirements(description: str) -> Dict:
    """Analyze job requirements using NLP"""
    try:
        logger.info(f"Analyzing job requirements: {description[:100]}...")
        requirements = []
        
        if nlp is not None:
            doc = nlp(description[:10000])  # Limit size for performance
            
            # Extract requirements from bulleted lists
            lines = description.split('\n')
            for line in lines:
                line = line.strip()
                if line.startswith(('•', '-', '*', '·')) or (len(line) > 0 and line[0].isdigit() and line[1:3] in ['. ', ') ']):
                    requirements.append(line.strip('•-*· 0123456789.)'))
            
            # If no bullet points found, try sentences with requirement indicators
            if len(requirements) < 3:
                requirement_indicators = ["required", "must have", "qualification", "skill", "experience", "knowledge", "ability"]
                for sent in doc.sents:
                    sent_lower = sent.text.lower()
                    if any(indicator in sent_lower for indicator in requirement_indicators):
                        requirements.append(sent.text.strip())
        
        # Fallback to simple line extraction
        if len(requirements) < 3:
            lines = description.split('\n')
            for line in lines:
                line = line.strip()
                if 5 < len(line) < 200 and line not in requirements:  # Reasonable requirement length
                    requirements.append(line)
                if len(requirements) >= 10:  # Cap at 10 requirements
                    break
        
        result = {
            "requirements": requirements[:10],  # Limit to top 10 requirements
            "raw_analysis": "\n".join(requirements[:10])
        }
        logger.info(f"Extracted {len(result['requirements'])} requirements")
        return result
    except Exception as e:
        logger.error(f"Error analyzing job requirements: {e}")
        return {"requirements": [], "raw_analysis": "Analysis failed"}

def semantic_location_match(job_location: str, candidate_location: str) -> float:
    """Calculate semantic location match score using NLP with strong preference for exact matches"""
    try:
        logger.info(f"Calculating location match between {job_location} and {candidate_location}")
        
        # Handle empty values
        if not job_location or not candidate_location:
            return 0.0  # Changed from 0.5 to be more strict
            
        # Direct match - exact match is highly preferred
        if job_location.lower() == candidate_location.lower():
            return 1.0
            
        # Substring match (e.g., "New York" matches "New York City")
        if job_location.lower() in candidate_location.lower():
            return 0.95  # High score for contains relationship
        elif candidate_location.lower() in job_location.lower():
            return 0.85  # Good score for reverse contains
            
        # Word overlap - e.g., "San Francisco" and "San Jose" both have "San"
        job_words = set(job_location.lower().split())
        candidate_words = set(candidate_location.lower().split())
        word_overlap = len(job_words.intersection(candidate_words))
        
        if word_overlap > 0:
            overlap_ratio = word_overlap / max(len(job_words), len(candidate_words))
            # Stricter scoring - require more overlap
            if overlap_ratio >= 0.5:  # At least half the words match
                return 0.7
            elif overlap_ratio >= 0.25:  # At least a quarter of words match
                return 0.5
            else:
                return 0.3  # Just a few words match
        
        # Use spaCy similarity as fallback for remaining cases
        if nlp is not None:
            doc1 = nlp(job_location)
            doc2 = nlp(candidate_location)
            similarity = doc1.similarity(doc2)
            # Scale down NLP similarity a bit to prefer exact matches
            return similarity * 0.8
            
        return 0.2  # Lower match if nothing else works - more strict
    except Exception as e:
        logger.error(f"Error calculating location match: {e}")
        return 0.0  # Changed from 0.5 to be more strict on errors

def title_position_match(job_title: str, candidate_positions: str) -> float:
    """Calculate job title to preferred positions match score with extreme emphasis on exact matches"""
    try:
        logger.info(f"Calculating title match between '{job_title}' and '{candidate_positions}'")
        
        # Handle empty values
        if not job_title or not candidate_positions:
            return 0.2  # Give a small base score even if empty to ensure inclusion
        
        # Split candidate positions to check each one separately
        candidate_position_list = [pos.strip() for pos in candidate_positions.split(',')]
        
        # Clean up job title and positions for better matching
        job_title_lower = job_title.lower().strip()
        
        # Print debug info
        logger.info(f"Candidate positions: {candidate_position_list}")
        logger.info(f"Job title: {job_title_lower}")
        
        # Exact match check - highest priority
        if any(pos.lower().strip() == job_title_lower for pos in candidate_position_list):
            logger.info("EXACT MATCH FOUND!")
            return 1.0  # Perfect match
            
        # Check partial word matches with high importance
        # E.g. "Software Engineer" should match with "Engineer"
        # Check if job title appears in any of the candidate positions (more specific match)
        if any(job_title_lower in pos.lower().strip() for pos in candidate_position_list):
            logger.info("JOB TITLE CONTAINED IN POSITION")
            return 0.98  # Very strong match, increased priority
            
        # Check if any candidate position appears in the job title
        if any(pos.lower().strip() in job_title_lower for pos in candidate_position_list):
            logger.info("POSITION CONTAINED IN JOB TITLE")
            return 0.95  # Strong match, increased priority
            
        # Check word-level matches (e.g. "Software Engineer" matches "Senior Software Engineer")
        job_title_words = set(job_title_lower.split())
        
        best_word_match = 0.0
        for position in candidate_position_list:
            position_words = set(position.lower().split())
            common_words = job_title_words.intersection(position_words)
            
            if common_words:
                # Calculate word overlap ratio
                match_ratio = len(common_words) / max(len(job_title_words), len(position_words))
                best_word_match = max(best_word_match, match_ratio)
        
        if best_word_match > 0.5:  # More than half of words match
            return 0.7 * best_word_match + 0.3  # Scale between 0.65-1.0
        elif best_word_match > 0.0:  # At least some words match
            return 0.5 * best_word_match + 0.2  # Ensure some score for partial matches
            
        # Check for related roles that might not share exact words (e.g. "Developer" and "Programmer")
        related_role_mappings = {
            "developer": ["programmer", "coder", "engineer", "software"],
            "engineer": ["developer", "programmer", "technician"],
            "manager": ["lead", "head", "director", "supervisor"],
            "analyst": ["specialist", "consultant", "advisor"],
            "marketing": ["seo", "content", "digital", "social media"],
            "sales": ["business development", "account manager"],
            "finance": ["accounting", "financial", "accountant"],
            "hr": ["human resources", "talent", "recruitment"]
        }
        
        # Check for related roles
        for key, related_terms in related_role_mappings.items():
            if key in job_title_lower:
                if any(term in candidate_positions.lower() for term in related_terms):
                    logger.info(f"RELATED ROLE MATCH: {key}")
                    return 0.7  # Good match for related roles
            elif any(term in job_title_lower for term in related_terms):
                if key in candidate_positions.lower():
                    logger.info(f"RELATED ROLE MATCH: {key}")
                    return 0.7  # Good match for related roles
        
        # If no good word matches, use semantic similarity
        # TF-IDF similarity between job title and all positions
        vectorizer = TfidfVectorizer(stop_words='english')
        try:
            tfidf_matrix = vectorizer.fit_transform([job_title, candidate_positions])
            tfidf_similarity = cosine_similarity(tfidf_matrix[0:1], tfidf_matrix[1:2])[0][0]
        except:
            tfidf_similarity = 0.3  # Higher default to ensure inclusion
            
        # spaCy semantic similarity
        if nlp is not None:
            doc1 = nlp(job_title)
            doc2 = nlp(candidate_positions)
            spacy_similarity = doc1.similarity(doc2)
            
            # Return weighted average of similarities
            combined_score = (0.6 * tfidf_similarity + 0.4 * spacy_similarity)
            logger.info(f"Title-Position match score: {combined_score:.2f}")
            return max(0.3, combined_score)  # Ensure minimum score of 0.3
            
        logger.info(f"Title-Position match score (TF-IDF only): {tfidf_similarity:.2f}")
        return max(0.3, tfidf_similarity)  # Ensure minimum score of 0.3
    except Exception as e:
        logger.error(f"Error calculating title match: {e}")
        return 0.3  # Provide a base score to ensure inclusion

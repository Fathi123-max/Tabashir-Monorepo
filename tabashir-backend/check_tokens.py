"""
Simple script to check API tokens without Flask imports
"""

import psycopg2
import os
from dotenv import load_dotenv

load_dotenv()

def check_api_tokens():
    """Check for available API tokens"""
    try:
        conn = psycopg2.connect(
            host=os.getenv("POSTGRES_HOST"),
            port=os.getenv("POSTGRES_PORT"),
            dbname=os.getenv("POSTGRES_DB"),
            user=os.getenv("POSTGRES_USER"),
            password=os.getenv("POSTGRES_PASSWORD"),
            sslmode='require'
        )
        cursor = conn.cursor()
        
        cursor.execute("""
            SELECT EXISTS (
                SELECT FROM information_schema.tables 
                WHERE table_name = 'api_tokens'
            );
        """)
        
        table_exists = cursor.fetchone()[0]
        
        if not table_exists:
            print("api_tokens table does not exist")
            return
        
        cursor.execute("SELECT token FROM api_tokens WHERE active = TRUE")
        tokens = cursor.fetchall()
        
        if tokens:
            print("Available API tokens:")
            for token in tokens:
                print(f"   {token[0]}")
        else:
            print("No active API tokens found")
            
        cursor.close()
        conn.close()
        
    except Exception as e:
        print(f"Error checking tokens: {e}")

if __name__ == "__main__":
    check_api_tokens()

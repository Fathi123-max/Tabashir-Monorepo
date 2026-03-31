
import sys
import os

# Add the project root to sys.path
sys.path.append('/Users/Apple/Documents/tabashir/tabashir-backend')

from app.database.db import execute_query

def test():
    email = 'pathtopeace467@gmail.com'
    print(f"Testing for email: {email}")
    
    try:
        # 1. Check if user exists in main DB
        user = execute_query('SELECT id, email FROM users WHERE email = %s', (email,), fetch_one=True)
        if user:
            print(f"User in main DB: {user['id']}")
        else:
            print("User NOT found in main DB")
        
        # 2. Check AI client data directly from 'clients' table
        print("Fetching AI client data from 'clients' table...")
        client = execute_query('SELECT * FROM clients WHERE email = %s', (email,), fetch_one=True)
        if client:
            print(f"AI Client record found!")
            print(f"Nationality: {client.get('nationality')}")
            print(f"Gender: {client.get('gender')}")
            print(f"Positions: {client.get('positions')}")
            print(f"Location: {client.get('location')}")
        else:
            print("AI Client record NOT found")
            
    except Exception as e:
        print(f"Error occurred: {str(e)}")

if __name__ == "__main__":
    test()

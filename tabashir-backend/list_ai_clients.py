
import psycopg2
from psycopg2.extras import RealDictCursor

def list_clients():
    ai_db_config = {
        'host': 'localhost',
        'port': 5432,
        'user': 'Apple',
        'password': '',
        'dbname': 'tabashir_ai'
    }
    
    print(f"--- Listing Clients in {ai_db_config['dbname']} ---")
    try:
        conn = psycopg2.connect(**ai_db_config)
        cur = conn.cursor(cursor_factory=RealDictCursor)
        cur.execute("SELECT email, nationality, gender, positions, location, filename FROM clients LIMIT 10")
        clients = cur.fetchall()
        if clients:
            for c in clients:
                print(f"Email: {c['email']}")
                print(f"  Nationality: {c['nationality']}, Gender: {c['gender']}")
                print(f"  Positions: {c['positions']}, Location: {c['location']}")
                print(f"  CV: {c['filename']}")
                print("-" * 20)
        else:
            print("No clients found in 'clients' table.")
        cur.close()
        conn.close()
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    list_clients()

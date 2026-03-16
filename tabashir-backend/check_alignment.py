from app.database.db import get_db_connection, get_ai_db_connection
import psycopg2

def check_db_alignment():
    print("--- Checking Main Database (tabashir_hr) ---")
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # Get tables
        cursor.execute("""
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public'
        """)
        tables = [row['table_name'] for row in cursor.fetchall()]
        print(f"Total tables: {len(tables)}")
        print(f"Tables: {', '.join(tables)}")
        
        # Key record counts
        for table in ['users', 'Candidate', 'Job', 'JobApplication', 'api_tokens']:
            try:
                # Use double quotes for case-sensitive table names if necessary
                cursor.execute(f'SELECT COUNT(*) FROM "{table}"' if table in ['Candidate', 'Job', 'JobApplication'] else f'SELECT COUNT(*) FROM {table}')
                count = cursor.fetchone()['count']
                print(f"Count in '{table}': {count}")
            except Exception as e:
                print(f"Error counting table '{table}': {e}")
                conn.rollback() # Important to rollback after an error in a transaction
        
        cursor.close()
        conn.close()
    except Exception as e:
        print(f"Main DB Error: {e}")

    print("\n--- Checking AI Database (tabashir_ai) ---")
    try:
        conn = get_ai_db_connection()
        cursor = conn.cursor()
        
        # Get tables
        cursor.execute("""
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public'
        """)
        tables = [row[0] for row in cursor.fetchall()] # AI DB connection might return tuples
        print(f"Total tables: {len(tables)}")
        print(f"Tables: {', '.join(tables)}")
        
        # Key record counts
        for table in ['jobs', 'clients', 'rankings']:
            try:
                cursor.execute(f"SELECT COUNT(*) FROM {table}")
                count = cursor.fetchone()[0]
                print(f"Count in '{table}': {count}")
            except Exception as e:
                print(f"Error counting table '{table}': {e}")
                conn.rollback()
        
        cursor.close()
        conn.close()
    except Exception as e:
        print(f"AI DB Error: {e}")

if __name__ == "__main__":
    check_db_alignment()

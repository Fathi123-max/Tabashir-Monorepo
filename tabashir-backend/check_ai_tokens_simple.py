from app.database.db import get_ai_db_connection

def check_ai_tokens():
    try:
        conn = get_ai_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT COUNT(*) FROM api_tokens")
        count = cursor.fetchone()[0]
        print(f"Count in 'api_tokens' (AI DB): {count}")
        
        if count > 0:
            cursor.execute("SELECT token, active FROM api_tokens")
            tokens = cursor.fetchall()
            for token, active in tokens:
                print(f"Token: {token}, Active: {active}")
        
        cursor.close()
        conn.close()
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    check_ai_tokens()

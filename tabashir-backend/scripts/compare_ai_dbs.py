import psycopg2
import os
from dotenv import load_dotenv

load_dotenv()

def get_db_info(conn):
    cursor = conn.cursor()
    # Get all tables
    cursor.execute("""
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'public'
    """)
    tables = [row[0] for row in cursor.fetchall()]
    
    info = {}
    for table in tables:
        # Get column names and types
        cursor.execute(f"""
            SELECT column_name, data_type 
            FROM information_schema.columns 
            WHERE table_name = '{table}'
        """)
        columns = {row[0]: row[1] for row in cursor.fetchall()}
        
        # Get row count
        try:
            cursor.execute(f'SELECT COUNT(*) FROM "{table}"')
            count = cursor.fetchone()[0]
        except:
            conn.rollback()
            count = "Error"
        
        info[table] = {
            'columns': columns,
            'count': count
        }
    return info

def compare():
    print("🚀 Starting Database Comparison...")
    
    # 1. Connect to "Production" (from .env)
    # Using individual variables or AI_DATABASE_URL if available
    prod_url = os.getenv('AI_DATABASE_URL')
    print(f"Connecting to Production (AI_POSTGRES)...")
    try:
        if prod_url:
            prod_conn = psycopg2.connect(prod_url)
        else:
            prod_conn = psycopg2.connect(
                host=os.getenv("AI_POSTGRES_HOST"),
                port=os.getenv("AI_POSTGRES_PORT"),
                dbname=os.getenv("AI_POSTGRES_DB"),
                user=os.getenv("AI_POSTGRES_USER"),
                password=os.getenv("AI_POSTGRES_PASSWORD")
            )
        prod_info = get_db_info(prod_conn)
    except Exception as e:
        print(f"❌ Could not connect to Production: {e}")
        return

    # 2. Connect to "Local" (Default local settings)
    print("Connecting to Local: localhost/tabashir_ai...")
    try:
        local_conn = psycopg2.connect(
            host="localhost",
            port="5432",
            dbname="tabashir_ai",
            user="Apple", # Default user from init_local_db.py
            password=""    
        )
        local_info = get_db_info(local_conn)
    except Exception as e:
        print(f"❌ Could not connect to Local: {e}")
        # Try with postgres/postgres as fallback
        try:
            print("Retrying with postgres/postgres...")
            local_conn = psycopg2.connect(
                host="localhost",
                port="5432",
                dbname="tabashir_ai",
                user="postgres",
                password="postgres"
            )
            local_info = get_db_info(local_conn)
        except:
             print("❌ Could not connect to Local even with fallback.")
             return

    # 3. Compare
    all_tables = set(prod_info.keys()) | set(local_info.keys())
    
    print("\n" + "="*70)
    print(f"{'Table Name':<25} | {'Status':<20} | {'Row Diff (P-L)'}")
    print("-" * 70)
    
    for table in sorted(all_tables):
        status = "Match"
        row_diff = "N/A"
        
        if table not in prod_info:
            status = "Local Only"
        elif table not in local_info:
            status = "Prod Only"
        else:
            p_count = prod_info[table]['count']
            l_count = local_info[table]['count']
            if isinstance(p_count, int) and isinstance(l_count, int):
                row_diff = f"{p_count - l_count:+d}"
            
            if prod_info[table]['columns'] != local_info[table]['columns']:
                status = "Schema Mismatch"
        
        print(f"{table:<25} | {status:<20} | {row_diff}")

    # Detailed Schema Mismatch
    for table in sorted(all_tables):
        if table in prod_info and table in local_info:
            if prod_info[table]['columns'] != local_info[table]['columns']:
                print(f"\n⚠️ Schema differences in '{table}':")
                p_cols = set(prod_info[table]['columns'].keys())
                l_cols = set(local_info[table]['columns'].keys())
                
                for col in p_cols - l_cols:
                    print(f"  - Column '{col}' ({prod_info[table]['columns'][col]}) exists in Production but NOT Local")
                for col in l_cols - p_cols:
                    print(f"  - Column '{col}' ({local_info[table]['columns'][col]}) exists in Local but NOT Production")
                
                # Check for type differences
                for col in p_cols & l_cols:
                    if prod_info[table]['columns'][col] != local_info[table]['columns'][col]:
                        print(f"  - Type mismatch in '{col}': Prod={prod_info[table]['columns'][col]}, Local={local_info[table]['columns'][col]}")

if __name__ == "__main__":
    compare()

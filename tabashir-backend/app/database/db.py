import psycopg2
from psycopg2.extras import RealDictCursor
from app.config import Config

def get_db_connection():
    try:
        conn = psycopg2.connect(
            host=Config.POSTGRES_HOST,
            port=Config.POSTGRES_PORT,
            dbname=Config.POSTGRES_DB,
            user=Config.POSTGRES_USER,
            password=Config.POSTGRES_PASSWORD,
            cursor_factory=RealDictCursor,
            sslmode=Config.POSTGRES_SSLMODE,
            connect_timeout=50
        )
        print("Connected to Neon PostgreSQL")
        return conn
    except Exception as e:
        print("Failed to connect to the database")
        print(e)
        raise ValueError("Failed to connect to the database")

def get_ai_db_connection():
    try:
        conn = psycopg2.connect(
            dbname=Config.AI_POSTGRES_DB,
            user=Config.AI_POSTGRES_USER,
            password=Config.AI_POSTGRES_PASSWORD,
            host=Config.AI_POSTGRES_HOST,
            port=Config.AI_POSTGRES_PORT,
        )
        conn.autocommit = False
        print("Connected to AI PostgreSQL DB")
        return conn
    except Exception as e:
        print("Failed to connect to the AI database")
        print(e)
        raise ValueError("Failed to connect to the AI database")


_column_cache = {}

def get_table_columns(table_name, conn_type='main'):
    if table_name in _column_cache:
        return _column_cache[table_name]
    
    conn = get_db_connection() if conn_type == 'main' else get_ai_db_connection()
    # Ensure we use a standard cursor to get column names as tuples (indexable)
    # even if get_db_connection sets a RealDictCursor factory
    import psycopg2.extensions
    cursor = conn.cursor(cursor_factory=psycopg2.extensions.cursor)
    try:
        cursor.execute("""
            SELECT column_name 
            FROM information_schema.columns 
            WHERE table_name = %s
        """, (table_name,))
        columns = [row[0] for row in cursor.fetchall()]
        _column_cache[table_name] = columns
        return columns
    finally:
        cursor.close()
        conn.close()


def execute_ai_query(query, params=None, fetch_one=False, fetch_all=False, commit=False):
    """Execute a query on the AI database."""
    conn = get_ai_db_connection()
    cursor = conn.cursor(cursor_factory=RealDictCursor)
    try:
        cursor.execute(query, params)
        if commit:
            conn.commit()
        if fetch_one:
            return cursor.fetchone()
        if fetch_all:
            return cursor.fetchall()
        return None
    finally:
        cursor.close()
        conn.close()


def execute_query(query, params=None, fetch_one=False, fetch_all=False, commit=False):
    """Execute a query on the main database (replaces execute_prisma_query)."""
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(query, params)
        if commit:
            conn.commit()
        if fetch_one:
            return cursor.fetchone()
        if fetch_all:
            return cursor.fetchall()
        return None
    finally:
        cursor.close()
        conn.close()


if __name__ == "__main__":
    # conn = get_db_connection()
    conn = get_ai_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT 1;")
    print(cur.fetchone())
    cur.close()
    conn.close()

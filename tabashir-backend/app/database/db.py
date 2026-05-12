import psycopg2
from psycopg2.pool import ThreadedConnectionPool
from psycopg2.extras import RealDictCursor
from app.config import Config
import atexit

# Initialize pools as None, create them lazily
main_pool = None
ai_pool = None

def init_pools():
    global main_pool, ai_pool
    if main_pool is None:
        try:
            main_pool = ThreadedConnectionPool(
                minconn=1,
                maxconn=20,
                host=Config.POSTGRES_HOST,
                port=Config.POSTGRES_PORT,
                dbname=Config.POSTGRES_DB,
                user=Config.POSTGRES_USER,
                password=Config.POSTGRES_PASSWORD,
                cursor_factory=RealDictCursor,
                sslmode=Config.POSTGRES_SSLMODE,
                connect_timeout=50
            )
            print("Initialized Main DB Connection Pool")
        except Exception as e:
            print("Failed to initialize Main DB pool:", e)
            
    if ai_pool is None:
        try:
            ai_pool = ThreadedConnectionPool(
                minconn=1,
                maxconn=20,
                dbname=Config.AI_POSTGRES_DB,
                user=Config.AI_POSTGRES_USER,
                password=Config.AI_POSTGRES_PASSWORD,
                host=Config.AI_POSTGRES_HOST,
                port=Config.AI_POSTGRES_PORT,
            )
            print("Initialized AI DB Connection Pool")
        except Exception as e:
            print("Failed to initialize AI DB pool:", e)

@atexit.register
def close_pools():
    global main_pool, ai_pool
    if main_pool:
        main_pool.closeall()
    if ai_pool:
        ai_pool.closeall()

def get_db_connection():
    init_pools()
    if main_pool:
        return main_pool.getconn()
    raise ValueError("Main DB pool not initialized")

def release_db_connection(conn):
    if main_pool and conn:
        # Rollback any uncommitted transaction before putting it back
        try:
            conn.rollback()
        except:
            pass
        main_pool.putconn(conn)

def get_ai_db_connection():
    init_pools()
    if ai_pool:
        return ai_pool.getconn()
    raise ValueError("AI DB pool not initialized")

def release_ai_db_connection(conn):
    if ai_pool and conn:
        try:
            conn.rollback()
        except:
            pass
        ai_pool.putconn(conn)


_column_cache = {}

def get_table_columns(table_name, conn_type='main'):
    if table_name in _column_cache:
        return _column_cache[table_name]
    
    conn = get_db_connection() if conn_type == 'main' else get_ai_db_connection()
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
        if conn_type == 'main':
            release_db_connection(conn)
        else:
            release_ai_db_connection(conn)


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
    except Exception as e:
        conn.rollback()
        raise e
    finally:
        cursor.close()
        release_ai_db_connection(conn)


def execute_query(query, params=None, fetch_one=False, fetch_all=False, commit=False):
    """Execute a query on the main database."""
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
    except Exception as e:
        conn.rollback()
        raise e
    finally:
        cursor.close()
        release_db_connection(conn)


if __name__ == "__main__":
    init_pools()
    conn = get_ai_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT 1;")
    print(cur.fetchone())
    cur.close()
    release_ai_db_connection(conn)

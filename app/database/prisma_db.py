import psycopg2
from psycopg2.extras import RealDictCursor
from config import Config


def get_prisma_connection():
    """Create and return a connection to the Prisma database."""
    return psycopg2.connect(
        host=Config.PRISMA_DB_HOST,
        port=Config.PRISMA_DB_PORT,
        database=Config.PRISMA_DB_NAME,
        user=Config.PRISMA_DB_USER,
        password=Config.PRISMA_DB_PASSWORD,
        cursor_factory=RealDictCursor
    )


def execute_prisma_query(query, params=None, fetch_one=False, fetch_all=False, commit=False):
    """
    Execute a query on the Prisma database.

    Args:
        query: SQL query string
        params: Query parameters tuple
        fetch_one: If True, return single row
        fetch_all: If True, return all rows
        commit: If True, commit the transaction

    Returns:
        Query results based on fetch_one/fetch_all flags
    """
    conn = get_prisma_connection()
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

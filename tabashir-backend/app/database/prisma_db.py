import psycopg2
from psycopg2.extras import RealDictCursor
from app.config import Config


def get_prisma_connection():
    """Create and return a connection to the Prisma (main) database."""
    host = getattr(Config, 'PRISMA_DB_HOST', None) or Config.POSTGRES_HOST
    port = getattr(Config, 'PRISMA_DB_PORT', None) or Config.POSTGRES_PORT
    database = getattr(Config, 'PRISMA_DB_NAME', None) or Config.POSTGRES_DB
    user = getattr(Config, 'PRISMA_DB_USER', None) or Config.POSTGRES_USER
    password = getattr(Config, 'PRISMA_DB_PASSWORD', None) or Config.POSTGRES_PASSWORD

    return psycopg2.connect(
        host=host,
        port=port,
        database=database,
        user=user,
        password=password,
        cursor_factory=RealDictCursor,
        sslmode=Config.POSTGRES_SSLMODE
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

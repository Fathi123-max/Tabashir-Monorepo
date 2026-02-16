from app.database.prisma_db import (
    get_prisma_connection,
    execute_prisma_query
)

__all__ = [
    "get_prisma_connection",
    "execute_prisma_query"
]

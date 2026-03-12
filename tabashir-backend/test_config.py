import os
import sys
import pytest
from unittest.mock import patch, MagicMock

# Set up environment variables for testing
os.environ["PRISMA_DB_HOST"] = "localhost"
os.environ["PRISMA_DB_PORT"] = "5432"
os.environ["PRISMA_DB_NAME"] = "tabashir"
os.environ["PRISMA_DB_USER"] = "test_user"
os.environ["PRISMA_DB_PASSWORD"] = "test_pass"
os.environ["AI_DB_HOST"] = "localhost"
os.environ["AI_DB_PORT"] = "5432"
os.environ["AI_DB_NAME"] = "ai_job_matching"
os.environ["AI_DB_USER"] = "test_user"
os.environ["AI_DB_PASSWORD"] = "test_pass"
os.environ["JWT_SECRET_KEY"] = "test-secret-key"


class TestConfig:
    """Tests for Config class"""

    def test_config_defaults(self):
        """Test Config class has correct default values"""
        from config import Config

        assert Config.PRISMA_DB_HOST == "localhost"
        assert Config.PRISMA_DB_PORT == "5432"
        assert Config.PRISMA_DB_NAME == "tabashir"
        assert Config.PRISMA_DB_USER == "postgres"
        assert Config.PRISMA_DB_PASSWORD == ""

    def test_config_env_override(self):
        """Test Config class can be overridden by environment variables"""
        from config import Config

        assert Config.PRISMA_DB_USER == "test_user"
        assert Config.PRISMA_DB_PASSWORD == "test_pass"
        assert Config.AI_DB_NAME == "ai_job_matching"

    def test_config_jwt_settings(self):
        """Test JWT settings are configured"""
        from config import Config

        assert Config.JWT_SECRET_KEY == "test-secret-key"
        assert Config.JWT_ACCESS_EXPIRE == 15 * 60  # 15 minutes
        assert Config.JWT_REFRESH_EXPIRE == 7 * 24 * 60 * 60  # 7 days


class TestPrismaDatabase:
    """Tests for Prisma database connection"""

    @patch('psycopg2.connect')
    def test_get_prisma_connection(self, mock_connect):
        """Test get_prisma_connection creates connection with correct params"""
        from config import Config
        from app.database.prisma_db import get_prisma_connection

        mock_conn = MagicMock()
        mock_connect.return_value = mock_conn

        conn = get_prisma_connection()

        mock_connect.assert_called_once_with(
            host=Config.PRISMA_DB_HOST,
            port=Config.PRISMA_DB_PORT,
            database=Config.PRISMA_DB_NAME,
            user=Config.PRISMA_DB_USER,
            password=Config.PRISMA_DB_PASSWORD,
            cursor_factory=RealDictCursor
        )
        assert conn == mock_conn

    @patch('psycopg2.connect')
    def test_execute_prisma_query_fetch_one(self, mock_connect):
        """Test execute_prisma_query fetches one result"""
        from app.database.prisma_db import execute_prisma_query

        mock_cursor = MagicMock()
        mock_cursor.fetchone.return_value = {"id": 1, "name": "test"}

        mock_conn = MagicMock()
        mock_conn.cursor.return_value = mock_cursor
        mock_connect.return_value = mock_conn

        result = execute_prisma_query("SELECT * FROM users WHERE id = %s", params=(1,), fetch_one=True)

        mock_cursor.execute.assert_called_once_with("SELECT * FROM users WHERE id = %s", (1,))
        mock_conn.commit.assert_not_called()
        assert result == {"id": 1, "name": "test"}

    @patch('psycopg2.connect')
    def test_execute_prisma_query_fetch_all(self, mock_connect):
        """Test execute_prisma_query fetches all results"""
        from app.database.prisma_db import execute_prisma_query

        mock_cursor = MagicMock()
        mock_cursor.fetchall.return_value = [{"id": 1}, {"id": 2}]

        mock_conn = MagicMock()
        mock_conn.cursor.return_value = mock_cursor
        mock_connect.return_value = mock_conn

        result = execute_prisma_query("SELECT * FROM users", fetch_all=True)

        assert result == [{"id": 1}, {"id": 2}]

    @patch('psycopg2.connect')
    def test_execute_prisma_query_commit(self, mock_connect):
        """Test execute_prisma_query commits when requested"""
        from app.database.prisma_db import execute_prisma_query

        mock_cursor = MagicMock()

        mock_conn = MagicMock()
        mock_conn.cursor.return_value = mock_cursor
        mock_connect.return_value = mock_conn

        result = execute_prisma_query("INSERT INTO users (name) VALUES (%s)", params=("test",), commit=True)

        mock_conn.commit.assert_called_once()
        mock_cursor.close.assert_called_once()
        mock_conn.close.assert_called_once()

    @patch('psycopg2.connect')
    def test_execute_prisma_query_closes_connection(self, mock_connect):
        """Test execute_prisma_query properly closes connection on error"""
        from app.database.prisma_db import execute_prisma_query

        mock_cursor = MagicMock()
        mock_cursor.execute.side_effect = Exception("Database error")

        mock_conn = MagicMock()
        mock_conn.cursor.return_value = mock_cursor
        mock_connect.return_value = mock_conn

        with pytest.raises(Exception):
            execute_prisma_query("SELECT * FROM users", fetch_one=True)

        mock_cursor.close.assert_called_once()
        mock_conn.close.assert_called_once()

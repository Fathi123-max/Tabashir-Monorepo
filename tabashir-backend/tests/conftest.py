# pytest configuration
import pytest


def pytest_configure(config):
    """Register custom markers"""
    config.addinivalue_line("markers", "database: marks tests that require a database connection")

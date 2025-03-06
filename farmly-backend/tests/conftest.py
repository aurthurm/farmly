import uuid
from unittest.mock import patch

import pytest
from fastapi.testclient import TestClient

from src.apps.user.models import User
from src.main import app
from src.core.security import get_password_hash, create_access_token
from src.apps.user.enum import UserRole
from datetime import timedelta
from src.core.config import settings

@pytest.fixture
def client():
    return TestClient(app)


@pytest.fixture
def mock_admin_user():
    return User(**{"id": str(uuid.uuid4()), "username": "admin", "password": get_password_hash("adminpass"), "role": UserRole.ADMIN})

@pytest.fixture
def mock_clerk_user():
    return User(**{"id": str(uuid.uuid4()), "username": "clerk", "password": get_password_hash("clerkpass"), "role": UserRole.CLERK})

@pytest.fixture
def access_token(mock_admin_user):
    expires = timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    return create_access_token(mock_admin_user.id, expires_delta=expires)

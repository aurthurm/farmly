from unittest.mock import patch

from src.api.v_1.deps import get_current_user
from src.apps.user.models import User
from src.main import app
from tests.do import patch_dependency


def test_login_access_token(client, mock_admin_user):
    with patch("src.apps.user.models.User.where") as mock_where:
        mock_where.return_value.first.return_value = mock_admin_user
        response = client.post("/users/login/access-token", data={"username": "admin", "password": "adminpass"})
        assert response.status_code == 200
        data = response.json()
        assert "token" in data
        assert data["token_type"] == "bearer"

def test_login_invalid_user(client):
    with patch("src.apps.user.models.User.where") as mock_where:
        mock_where.return_value.first.return_value = None
        response = client.post("/users/login/access-token", data={"username": "wronguser", "password": "testpass"})
        assert response.status_code == 400
        assert response.json()["detail"] == "Incorrect username"

def test_login_invalid_password(client, mock_admin_user):
    with patch("src.apps.user.models.User.where") as mock_where:
        mock_where.return_value.first.return_value = mock_admin_user
        response = client.post("/users/login/access-token", data={"username": "admin", "password": "wrongpass"})
        assert response.status_code == 400
        assert response.json()["detail"] == "Incorrect password"

def test_create_user(client, mock_admin_user, access_token):
    new_user_data = {
        "username": "newclerk",
        "password": "securepass",
        "firstname": "New",
        "lastname": "Clerk",
        "role": "clerk"
    }
    headers = {"Authorization": f"Bearer {access_token}"}
    with patch_dependency(app, get_current_user, lambda: mock_admin_user):
        with patch("src.apps.user.models.User.create") as mock_create:
            mock_create.return_value = new_user_data
            response = client.post("/users", json={**new_user_data, "passwordc": "securepass"}, headers=headers)

            assert response.status_code == 201
            assert response.json()["username"] == "newclerk"

def test_create_user_unauthorized(client, mock_clerk_user):
    new_user_data = {
        "username": "newclerk",
        "password": "securepass",
        "firstname": "New",
        "lastname": "Clerk",
        "role": "clerk"
    }
    with patch_dependency(app, get_current_user, lambda: mock_clerk_user):
        with patch("src.apps.user.models.User.create") as mock_create:
            mock_create.return_value = User(**new_user_data)
            response = client.post("/users", json={**new_user_data, "passwordc": "securepass",})
            assert response.status_code == 401

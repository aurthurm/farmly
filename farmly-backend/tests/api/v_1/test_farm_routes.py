import uuid
from unittest.mock import patch

from src.api.v_1.deps import get_current_user
from src.apps.farm.models import FarmerData
from src.main import app
from tests.do import patch_dependency


def test_add_crop(client, mock_admin_user, access_token):
    new_crop = {"name": "Wheat"}
    headers = {"Authorization": f"Bearer {access_token}"}

    with patch_dependency(app, get_current_user, lambda: mock_admin_user):
        with patch("src.apps.farm.models.Crop.create") as mock_create:
            mock_create.return_value = new_crop
            response = client.post("/farms/crops", json=new_crop, headers=headers)
            assert response.status_code == 201
            assert response.json()["name"] == "Wheat"

def test_add_farm_type(client, mock_admin_user, access_token):
    new_farm_type = {"name": "Irrigated"}
    headers = {"Authorization": f"Bearer {access_token}"}
    with patch_dependency(app, get_current_user, lambda: mock_admin_user):
        with patch("src.apps.farm.models.FarmType.create") as mock_create:
            mock_create.return_value = new_farm_type
            response = client.post("/farms/farm_types", json=new_farm_type, headers=headers)
            assert response.status_code == 201
            assert response.json()["name"] == "Irrigated"

def test_submit_farmer_data(client, mock_clerk_user, access_token):
    payload = {
        "farmer_name": "John Doe",
        "national_id": "23-02839923Z24",
        "farm_type_id": str(uuid.uuid4()),
        "crop_id": str(uuid.uuid4()),
        "location": "Mwenezi",
    }
    farmer_data = FarmerData(**{**payload, "id": str(uuid.uuid4())})
    headers = {"Authorization": f"Bearer {access_token}"}
    with patch_dependency(app, get_current_user, lambda: mock_clerk_user):
        with patch("src.apps.farm.models.FarmerData.create") as mock_create:
            mock_create.return_value = farmer_data
            response = client.post("/farms/farmer-data", json=payload, headers=headers)
            assert response.status_code == 201
            assert response.json()["farmer_name"] == "John Doe"

def test_add_crop_unauthorized(client, mock_clerk_user, access_token):
    new_crop = {"name": "Corn"}
    headers = {"Authorization": f"Bearer {access_token}"}
    with patch_dependency(app, get_current_user, lambda: mock_clerk_user):
        with patch("src.api.v_1.deps.get_current_user", return_value=mock_clerk_user):
            response = client.post("/farms/crops", json=new_crop, headers=headers)
            assert response.status_code == 400
            assert response.json()["detail"] == "Only admins can add crops"

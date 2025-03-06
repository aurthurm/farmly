from fastapi import APIRouter, status, Depends, HTTPException

from src.api.v_1.deps import get_current_user
from src.apps.farm.models import FarmerData, Crop, FarmType
from src.apps.farm.schema import FarmerDataCreate, CropCreate, FarmTypeCreate, CropSchema, FarmTypeSchema, \
    FarmerDataSchema
from src.apps.user.enum import UserRole
from src.apps.user.models import User

farmer_routes = APIRouter(prefix="/farms",tags=["farms"],)

@farmer_routes.post("/crops", status_code=status.HTTP_201_CREATED)
def add_crop(*, create_in: CropCreate, current_user: User = Depends(get_current_user)):
    """Add a new crop (admin only)."""
    if current_user.role != UserRole.ADMIN:
        raise HTTPException(status_code=400, detail="Only admins can add crops")
    return Crop.create(**create_in.model_dump())

@farmer_routes.post("/crops/sync", status_code=status.HTTP_202_ACCEPTED)
def sync_crops(*, schema_in: list[CropSchema]):
    """Sync crops."""
    crops_out = []
    for sc_in in schema_in:
        crop = Crop.where(id=sc_in.id).first()
        if crop:
            crop = crop.update(**sc_in.model_dump())
        else:
            crop = Crop.create(**sc_in.model_dump())
        crops_out.append(crop)
    return crops_out

@farmer_routes.get("/crops/sync", status_code=status.HTTP_200_OK)
def fetch_crops():
    """fetch all crops."""
    return Crop.all()

@farmer_routes.post("/farm_types", status_code=status.HTTP_201_CREATED)
def add_farm_type(*, create_in: FarmTypeCreate, current_user: User = Depends(get_current_user)):
    """Add a new farm type (admin only)."""
    if current_user.role != UserRole.ADMIN:
        raise HTTPException(status_code=400, detail="Only admins can add farm types")
    return FarmType.create(**create_in.model_dump())

@farmer_routes.post("/farm-types/sync", status_code=status.HTTP_202_ACCEPTED)
def sync_farm_types(*, schema_in: list[FarmTypeSchema]):
    """Sync farm-types."""
    farm_types_out = []
    for sc_in in schema_in:
        ft = FarmType.where(id=sc_in.id).first()
        if ft:
            ft = ft.update(**sc_in.model_dump())
        else:
            ft = FarmType.create(**sc_in.model_dump())
        farm_types_out.append(ft)
    return farm_types_out

@farmer_routes.get("/farm-types/sync", status_code=status.HTTP_200_OK)
def fetch_farm_types():
    """fetch all farm_types."""
    return FarmType.all()

@farmer_routes.post("/farmer-data", status_code=status.HTTP_201_CREATED)
def submit_farmer_data(*, create_in: FarmerDataCreate, current_user: User = Depends(get_current_user)):
    """Submit farmer data collected by clerks."""
    return FarmerData.create(**create_in.model_dump())

@farmer_routes.post("/farmer-data/sync", status_code=status.HTTP_202_ACCEPTED)
def sync_farmer_data(*, schema_in: list[FarmerDataSchema]):
    """Sync farm-data."""
    farm_data_out = []
    for sc_in in schema_in:
        fd = FarmerData.where(id=sc_in.id).first()
        if fd:
            fd = fd.update(**sc_in.model_dump())
        else:
            fd = FarmerData.create(**sc_in.model_dump())
        farm_data_out.append(fd)
    return farm_data_out


@farmer_routes.get("/farmer-data/sync", status_code=status.HTTP_200_OK)
def fetch_farmer_data():
    """fetch all farmer-data."""
    return FarmerData.all()
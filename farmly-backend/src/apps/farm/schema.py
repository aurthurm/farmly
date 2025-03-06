from pydantic import BaseModel


########################
class FarmerDataBase(BaseModel):
    """Base schema for FarmerData."""
    farmer_name: str | None = None
    national_id: str | None = None
    farm_type_id: str | None = None
    crop_id: str | None = None
    location: str | None = None

class FarmerDataCreate(FarmerDataBase):
    """Schema for FarmerData creation."""
    farmer_name: str
    national_id: str
    farm_type_id: str
    crop_id: str
    location: str

class FarmerDataUpdate(FarmerDataBase):
    """Schema for FarmerData updating."""
    ...

class FarmerDataSchema(FarmerDataBase):
    """Schema for FarmerData response."""
    id: str



##########################
class CropBase(BaseModel):
    """Base schema for Crop."""
    name: str | None = None

class CropCreate(CropBase):
    """Schema for Crop creation."""
    name: str

class CropUpdate(CropBase):
    """Schema for Crop updating."""
    ...

class CropSchema(CropBase):
    """Schema for Crop response."""
    id: str



########################
class FarmTypeBase(BaseModel):
    """Base schema for FarmType."""
    name: str | None = None

class FarmTypeCreate(FarmTypeBase):
    """Schema for FarmType creation."""
    name: str

class FarmTypeUpdate(FarmTypeBase):
    """Schema for FarmType updating."""
    ...

class FarmTypeSchema(FarmTypeBase):
    """Schema for FarmType response."""
    id: str


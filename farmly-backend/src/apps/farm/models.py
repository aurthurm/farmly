from sqlalchemy import Column, String, ForeignKey
from sqlalchemy.orm import relationship
from src.database.base import BaseEntity


class Crop(BaseEntity):
    """Crop model for storing different types of crops."""
    __tablename__ = "crops"

    name = Column(String, unique=True)

class FarmType(BaseEntity):
    """FarmType model for different farm types."""
    __tablename__ = "farm_types"

    name = Column(String, unique=True)

class FarmerData(BaseEntity):
    """FarmerData model to store collected data from clerks."""
    __tablename__ = "farmer_data"

    farmer_name = Column(String)
    national_id = Column(String, unique=True)
    farm_type_id = Column(String, ForeignKey("farm_types.id"))
    crop_id = Column(String, ForeignKey("crops.id"))
    location = Column(String)
    farm_type = relationship("FarmType")
    crop = relationship("Crop")

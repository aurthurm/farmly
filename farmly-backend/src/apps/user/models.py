from sqlalchemy import Column, Integer, String, Enum

from src.apps.user.enum import UserRole
from src.database.base import BaseEntity


class User(BaseEntity):
    """User model"""
    __tablename__ = "users"

    username = Column(String, unique=True, index=True)
    firstname = Column(String)
    lastname = Column(String)
    password = Column(String)
    role = Column(Enum(UserRole))
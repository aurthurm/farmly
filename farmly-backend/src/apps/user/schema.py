# Pydantic Schemas
from pydantic import BaseModel

from src.apps.user.enum import UserRole



class UserBase(BaseModel):
    """Base schema for user."""
    firstname: str | None = None
    lastname: str | None = None
    username: str | None = None
    password: str | None = None
    role: UserRole | None = None

class UserCreate(UserBase):
    """Schema for user creation."""
    firstname: str
    lastname: str
    username: str
    password: str
    passwordc: str
    role: UserRole

class UserUpdate(UserBase):
    """Schema for user updating."""
    ...

class UserSchema(UserBase):
    """Schema for user response."""
    id: str

class UserLogin(BaseModel):
    """Schema for user login."""
    username: str
    password: str

class TokenResponse(BaseModel):
    token: str
    token_type: str
    user: UserSchema

from datetime import timedelta
from typing import Any

from fastapi import APIRouter, status, Depends, HTTPException
from fastapi.security import OAuth2PasswordRequestForm

from src.api.v_1.deps import get_current_user
from src.apps.user.enum import UserRole
from src.apps.user.models import User
from src.apps.user.schema import UserCreate, TokenResponse
from src.core.config import settings
from src.core.security import get_password_hash, verify_password, create_access_token

user_routes = APIRouter(prefix="/users",tags=["users"],)


@user_routes.post("/login/access-token", response_model=TokenResponse)
def login_access_token(form_data: OAuth2PasswordRequestForm = Depends()) -> Any:
    """
    OAuth2 compatible token login, get an access token for future requests
    """
    user = User.where(username=form_data.username).first()
    if not user:
        raise HTTPException(status_code=400, detail="Incorrect username")

    if not verify_password(form_data.password, user.password):
        raise HTTPException(status_code=400, detail="Incorrect password")

    access_token_expires = timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    return {
        "token": create_access_token(
            user.id, expires_delta=access_token_expires
        ),
        "token_type": "bearer",
        "user": user
    }

@user_routes.post("", status_code=status.HTTP_201_CREATED)
def create_user(*, create_in: UserCreate, current_user: User = Depends(get_current_user)):
    """Create a new user (clerk or admin)."""
    if current_user.role != UserRole.ADMIN:
        raise HTTPException(status_code=401, detail="Only admins can create users")
    if create_in.password != create_in.passwordc:
        raise HTTPException(status_code=400, detail="Passwords do not match")
    data_in = create_in.model_dump()
    del data_in["passwordc"]
    data_in['password'] = get_password_hash(data_in['password'])
    return User.create(**data_in)

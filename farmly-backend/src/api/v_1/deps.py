from typing import Annotated

from fastapi import Depends
from fastapi.security import OAuth2PasswordBearer

from src.apps.user.models import User
from src.core.config import settings
from src.core.security import verify_password_reset_token

reusable_oauth2 = OAuth2PasswordBearer(
    tokenUrl=f"{settings.API_V1_STR}/login/access-token"
)

async def get_current_user(token: Annotated[str, Depends(reusable_oauth2)]) -> User | None:
    user_id = verify_password_reset_token(token)
    return User.where(id=user_id).first() if user_id else None

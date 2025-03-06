from src.apps.user.enum import UserRole
from src.apps.user.models import User
from src.core.security import get_password_hash

USERS = [
    {
        "username": "admin",
        "firstname": "System",
        "lastname": "Administrator",
        "password": "Access123",
        "role": UserRole.ADMIN
    },{
        "username": "clerk",
        "firstname": "System",
        "lastname": "Clerk",
        "password": "Clerk123",
        "role": UserRole.CLERK
    }
]

def seed_super_user():
    for _user in USERS:
        user = User.where(username=_user["username"]).first()
        if not user:
            _user["password"] = get_password_hash(_user["password"])
            User.create(**_user)

from fastapi import APIRouter

from src.api.v_1.farm import farmer_routes
from src.api.v_1.user import user_routes

api_routes = APIRouter()

api_routes.include_router(user_routes)
api_routes.include_router(farmer_routes)
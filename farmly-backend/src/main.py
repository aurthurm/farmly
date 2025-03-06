from contextlib import asynccontextmanager

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from src.api.v_1 import api_routes
from src.core.config import settings
from src.seeds import seed_super_user


@asynccontextmanager
async def lifespan(app: FastAPI):
    seed_super_user()
    yield
    ...


app = FastAPI(
    title=settings.PROJECT_NAME,
    openapi_url=f"{settings.API_V1_STR}/openapi.json",
    lifespan=lifespan
)

app.add_middleware(
    CORSMiddleware, # noqa
    allow_origins=settings.CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(api_routes)

@app.get("/health")
async def health():
    return {"message": "I'm very healthy"}

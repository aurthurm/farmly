import os
from functools import lru_cache
from pathlib import Path

from dotenv import load_dotenv
from pydantic import AnyHttpUrl
from pydantic_settings import BaseSettings, SettingsConfigDict

from ..utils.env import getenv_value

ROOT_DIR: str = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", '..'))
BASE_DIR: str = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
ENV_FILE: Path = Path(BASE_DIR, "./../.env")
load_dotenv(dotenv_path=ENV_FILE)


class Settings(BaseSettings):
    BASE_DIR: str = BASE_DIR
    API_V1_STR: str = "/api/v1"
    ALGORITHM: str = "HS256"
    # secrets.token_urlsafe(32)
    SECRET_KEY: str = "Eoy7XAjJWnr6PcgFi0FK37XbjXEfx2PdFV8GFbucReDbWiew8T79ob3ZIF3bgYi62THktkoTNdC1SrFyd_k4xQ"
    REFRESH_SECRET_KEY: str = "KKj6HeSWwizXDnzc1SS_e-PYn3EwA4XuotoOD3J0mvmu1PLdVzbDkAeThJDTQsgYHVgYwbV5PnSbo_ZJZHEMEg"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60 * 4 * 1  # 4 hours
    REFRESH_TOKEN_EXPIRE_MINUTES: int = 60 * 12 * 1  # 1/2 day / 12 hours
    PROJECT_NAME: str = getenv_value("PROJECT_NAME", "E-Port Farmly")
    SERVER_NAME: str = getenv_value("SERVER_NAME", "ePort-farmly")
    SERVER_HOST: AnyHttpUrl = getenv_value("SERVER_HOST", "https://localhost")
    CORS_ORIGINS: list[str] = [
        "http://localhost:5173",
        "http://localhost:3000",
        "http://localhost:8000",
        "http://0.0.0.0:8000",
    ]
    CORS_SUPPORTS_CREDENTIALS: bool = True
    CORS_ALLOW_HEADERS: list[str] = [
        "Authorization",
        "access-control-allow-methods",
        "content-type",
        "access-control-allow-origin",
        "access-control-allow-headers",
    ]
    SQLALCHEMY_DATABASE_URI: str = "sqlite:///./eport.db"

    model_config = SettingsConfigDict(
        env_file=ENV_FILE,
        env_file_encoding="utf-8",
        extra="allow",
    )


@lru_cache
def get_settings() -> Settings:
    return Settings()


settings = get_settings()

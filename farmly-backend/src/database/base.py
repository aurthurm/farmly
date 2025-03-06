import uuid

from sqlalchemy import create_engine, Column, String
from sqlalchemy.orm import sessionmaker, as_declarative, scoped_session
from sqlalchemy_mixins import AllFeaturesMixin, TimestampsMixin # noqa

from ..core.config import settings

engine = create_engine(settings.SQLALCHEMY_DATABASE_URI, connect_args={"check_same_thread": False})
session = scoped_session(sessionmaker(bind=engine, autocommit=False))


@as_declarative()
class BaseEntity(AllFeaturesMixin, TimestampsMixin):
    __abstract__ = True

    id = Column(String, default=lambda: str(uuid.uuid4()), primary_key=True, unique=True, nullable=False)

#
BaseEntity.set_session(session) # noqa

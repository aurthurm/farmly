
from contextlib import contextmanager
from copy import deepcopy
from typing import Callable

from fastapi import FastAPI


@contextmanager
def patch_dependency(app: FastAPI, dependency: Callable, replacement: Callable):
    """Replace a FastAPI dependency (Depends) with another. This acts as a
    contextmanager, restoring the dependency overrides on __exit__().
    """
    original_overrides = deepcopy(app.dependency_overrides)
    app.dependency_overrides[dependency] = replacement
    yield
    app.dependency_overrides = original_overrides
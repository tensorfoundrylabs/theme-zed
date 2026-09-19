"""A compact Python syntax gallery for the TensorFoundry theme."""

from __future__ import annotations

from dataclasses import dataclass, field
from enum import StrEnum
from pathlib import Path
from typing import Callable, Final

DEFAULT_ROUTE_ORDER: Final = 100
Handler = Callable[[str], str]


class Method(StrEnum):
    GET = "GET"
    POST = "POST"


@dataclass(slots=True)
class RouteInfo:
    handler: Handler
    description: str
    method: Method = Method.GET
    order: int = DEFAULT_ROUTE_ORDER
    is_proxy: bool = True
    tags: list[str] = field(default_factory=list)


class RouteRegistry:
    def __init__(self, root: Path) -> None:
        self.root = root
        self._routes: dict[str, RouteInfo] = {}

    @property
    def route_count(self) -> int:
        return len(self._routes)

    def register_proxy_route(
        self,
        route: str,
        handler: Handler,
        description: str,
        *,
        method: Method = Method.GET,
    ) -> RouteInfo:
        if not route.startswith("/"):
            raise ValueError(f"route must begin with '/': {route!r}")

        info = RouteInfo(handler, description.strip(), method)
        self._routes[route] = info
        return info

    def matching_routes(self, prefix: str | None = None) -> list[str]:
        routes = self._routes if prefix is None else {
            route: info for route, info in self._routes.items() if route.startswith(prefix)
        }
        return sorted(routes)

//! A compact Rust syntax gallery for the TensorFoundry theme.

use std::collections::HashMap;
use std::fmt::{self, Display};

const DEFAULT_ROUTE_ORDER: u16 = 100;
type Handler = fn(&Request) -> Response;

#[derive(Clone, Copy, Debug, Eq, PartialEq)]
enum Method {
    Get,
    Post,
}

#[derive(Debug)]
struct RouteInfo<'a> {
    handler: Handler,
    description: &'a str,
    method: Method,
    order: u16,
    is_proxy: bool,
}

#[derive(Debug)]
struct RouteError(String);

impl Display for RouteError {
    fn fmt(&self, formatter: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(formatter, "invalid route: {}", self.0)
    }
}

#[derive(Default)]
struct RouteRegistry<'a> {
    routes: HashMap<String, RouteInfo<'a>>,
}

impl<'a> RouteRegistry<'a> {
    fn register_proxy_route(
        &mut self,
        route: impl Into<String>,
        handler: Handler,
        description: &'a str,
        method: Method,
    ) -> Result<(), RouteError> {
        let route = route.into();
        if route.trim().is_empty() {
            return Err(RouteError(route));
        }

        self.routes.insert(
            route,
            RouteInfo {
                handler,
                description,
                method,
                order: DEFAULT_ROUTE_ORDER,
                is_proxy: true,
            },
        );
        Ok(())
    }
}

struct Request;
struct Response;

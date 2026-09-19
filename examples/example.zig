//! A compact Zig syntax gallery for the TensorFoundry theme.

const std = @import("std");

const default_route_order: u16 = 100;

const Method = enum {
    get,
    post,
};

const RouteError = error{
    EmptyRoute,
    DuplicateRoute,
};

const RouteInfo = struct {
    handler: *const fn ([]const u8) anyerror![]const u8,
    description: []const u8,
    method: Method,
    order: u16 = default_route_order,
    is_proxy: bool = true,
};

const RouteRegistry = struct {
    allocator: std.mem.Allocator,
    routes: std.StringHashMap(RouteInfo),

    pub fn init(allocator: std.mem.Allocator) RouteRegistry {
        return .{
            .allocator = allocator,
            .routes = std.StringHashMap(RouteInfo).init(allocator),
        };
    }

    pub fn registerProxyRoute(
        self: *RouteRegistry,
        route: []const u8,
        handler: *const fn ([]const u8) anyerror![]const u8,
        description: []const u8,
        method: Method,
    ) RouteError!void {
        if (route.len == 0) return RouteError.EmptyRoute;
        if (self.routes.contains(route)) return RouteError.DuplicateRoute;

        try self.routes.put(route, .{
            .handler = handler,
            .description = std.mem.trim(u8, description, " \\t\\n"),
            .method = method,
        });
    }

    pub fn deinit(self: *RouteRegistry) void {
        self.routes.deinit();
    }
};

fn identityHandler(route: []const u8) ![]const u8 {
    return route;
}

test "registers a proxy route" {
    var registry = RouteRegistry.init(std.testing.allocator);
    defer registry.deinit();

    try registry.registerProxyRoute("/health", identityHandler, "Health check", .get);
    try std.testing.expectEqual(@as(usize, 1), registry.routes.count());
}

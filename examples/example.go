// Package preview provides a compact syntax gallery for the TensorFoundry theme.
package preview

import (
	"context"
	"fmt"
	"net/http"
	"sort"
	"strings"
)

const defaultRouteOrder = 100

type HTTPMethod string

const (
	MethodGet  HTTPMethod = "GET"
	MethodPost HTTPMethod = "POST"
)

type RouteInfo struct {
	Handler     http.HandlerFunc
	Description string
	Method      HTTPMethod
	Order       int
	IsProxy     bool
}

type RouteRegistry struct {
	routes map[string]RouteInfo
}

func NewRouteRegistry() *RouteRegistry {
	return &RouteRegistry{routes: make(map[string]RouteInfo)}
}

func (r *RouteRegistry) RegisterProxyRoute(
	route string,
	handler http.HandlerFunc,
	description string,
	method HTTPMethod,
) error {
	if route == "" {
		return fmt.Errorf("route must not be empty")
	}

	wrappedHandler := func(w http.ResponseWriter, req *http.Request) {
		ctx := context.WithValue(req.Context(), routeContextKey{}, route)
		handler(w, req.WithContext(ctx))
	}

	r.routes[route] = RouteInfo{
		Handler:     wrappedHandler,
		Description: strings.TrimSpace(description),
		Method:      method,
		Order:       defaultRouteOrder,
		IsProxy:     true,
	}
	return nil
}

func (r *RouteRegistry) SortedRoutes() []string {
	routes := make([]string, 0, len(r.routes))
	for route := range r.routes {
		routes = append(routes, route)
	}
	sort.Strings(routes)
	return routes
}

type routeContextKey struct{}

package com.orderpipe.gateway.config;

import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;

@Configuration
public class GatewayConfig {

    @Bean
    public RouteLocator customRouteLocator(RouteLocatorBuilder builder) {
        return builder.routes()
            .route("order-service-bulk", r -> r
                .path("/api/orders/bulk")
                .and().method(HttpMethod.POST)
                .uri("lb://order-service"))
            .route("inventory-check-bulk", r -> r
                .path("/api/inventory/check-bulk")
                .and().method(HttpMethod.POST)
                .uri("lb://inventory-service"))
            .route("notification-send-bulk", r -> r
                .path("/api/notifications/send-bulk")
                .and().method(HttpMethod.POST)
                .uri("lb://notification-service"))
            .build();
    }
}
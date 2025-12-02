package com.orderpipe.gateway.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.Map;

@RestController
@RequestMapping("/fallback")
public class FallbackController {

    @GetMapping("/orders")
    @PostMapping("/orders")
    public ResponseEntity<Map<String, Object>> orderServiceFallback() {
        return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE)
            .body(Map.of(
                "message", "Order service is currently unavailable",
                "timestamp", LocalDateTime.now(),
                "status", HttpStatus.SERVICE_UNAVAILABLE.value()
            ));
    }

    @GetMapping("/inventory")
    @PostMapping("/inventory")
    public ResponseEntity<Map<String, Object>> inventoryServiceFallback() {
        return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE)
            .body(Map.of(
                "message", "Inventory service is currently unavailable",
                "timestamp", LocalDateTime.now(),
                "status", HttpStatus.SERVICE_UNAVAILABLE.value()
            ));
    }

    @GetMapping("/payments")
    @PostMapping("/payments")
    public ResponseEntity<Map<String, Object>> paymentServiceFallback() {
        return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE)
            .body(Map.of(
                "message", "Payment service is currently unavailable",
                "timestamp", LocalDateTime.now(),
                "status", HttpStatus.SERVICE_UNAVAILABLE.value()
            ));
    }
}
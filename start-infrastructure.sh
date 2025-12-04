#!/bin/bash

echo "🚀 Starting OrderPipe Infrastructure Services..."

# Start only the infrastructure services first
echo "📦 Starting PostgreSQL, RabbitMQ, and Redis..."
docker-compose up -d postgresql rabbitmq redis

echo "⏳ Waiting for infrastructure services to be ready..."
sleep 30

# Check if infrastructure services are healthy
echo "🔍 Checking infrastructure health..."
docker-compose ps postgresql rabbitmq redis

# Start service registry first
echo "🗂️  Starting Service Registry..."
docker-compose up -d service-registry

echo "⏳ Waiting for Service Registry to be ready..."
sleep 20

# Start config server
echo "⚙️  Starting Config Server..."
docker-compose up -d config-server

echo "⏳ Waiting for Config Server to be ready..."
sleep 20

# Start API Gateway
echo "🌐 Starting API Gateway..."
docker-compose up -d api-gateway

echo "⏳ Waiting for API Gateway to be ready..."
sleep 15

echo "✅ Infrastructure services started successfully!"
echo ""
echo "🔗 Service URLs:"
echo "   • Eureka Service Registry: http://localhost:8761"
echo "   • Config Server: http://localhost:8888"
echo "   • API Gateway: http://localhost:8080"
echo "   • RabbitMQ Management: http://localhost:15672 (user: orderpipe, pass: orderpipe123)"
echo "   • PostgreSQL: localhost:5432 (user: orderpipe, pass: orderpipe123)"
echo "   • Redis: localhost:6379 (pass: orderpipe123)"
echo ""
echo "🚀 To start business services, run:"
echo "   docker-compose up -d order-service inventory-service payment-service notification-service shipping-service"
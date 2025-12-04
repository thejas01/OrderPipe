#!/bin/bash

echo "🚀 Starting Complete OrderPipe System..."

# Start infrastructure services first
echo "📦 Starting infrastructure services..."
./start-infrastructure.sh

echo "⏳ Waiting for infrastructure to stabilize..."
sleep 30

# Start all business services
echo "🏢 Starting business services..."
docker-compose up -d order-service inventory-service payment-service notification-service shipping-service

echo "⏳ Waiting for business services to start..."
sleep 45

echo "✅ All services started successfully!"
echo ""
echo "🔗 Service URLs:"
echo "   📋 Infrastructure:"
echo "      • Eureka Service Registry: http://localhost:8761"
echo "      • Config Server: http://localhost:8888"
echo "      • API Gateway: http://localhost:8080"
echo "      • RabbitMQ Management: http://localhost:15672 (user: orderpipe, pass: orderpipe123)"
echo ""
echo "   🏢 Business Services:"
echo "      • Order Service: http://localhost:8081"
echo "      • Inventory Service: http://localhost:8082"
echo "      • Payment Service: http://localhost:8083"
echo "      • Notification Service: http://localhost:8084"
echo "      • Shipping Service: http://localhost:8085"
echo ""
echo "   🔍 Health Checks:"
echo "      • All Services: http://localhost:8080/actuator/health"
echo ""
echo "📊 To view logs: docker-compose logs -f [service-name]"
echo "🛑 To stop all: docker-compose down"
# OrderPipe Infrastructure Setup

## Overview
This document describes the complete infrastructure setup for the OrderPipe microservices system, including all required infrastructure services and container orchestration.

## Infrastructure Components

### ✅ Implemented Services

#### 1. **Eureka Server (Service Registry)**
- **Port**: 8761
- **Purpose**: Service discovery and registration
- **URL**: http://localhost:8761
- **Configuration**: Auto-configured with Docker networking

#### 2. **Spring Cloud Gateway (API Gateway)**  
- **Port**: 8080
- **Purpose**: API routing, load balancing, circuit breakers
- **Features**:
  - Route-based load balancing
  - Circuit breaker patterns (Resilience4j)
  - Service discovery integration
  - Fallback mechanisms

#### 3. **Config Server**
- **Port**: 8888  
- **Purpose**: Centralized configuration management
- **Configuration**: Native profile with classpath configs
- **URL**: http://localhost:8888

#### 4. **PostgreSQL Database**
- **Port**: 5432
- **Database**: orderpipe
- **Credentials**: orderpipe/orderpipe123
- **Purpose**: Primary data storage for all business services

#### 5. **RabbitMQ Message Broker**
- **Port**: 5672 (AMQP), 15672 (Management UI)
- **Credentials**: orderpipe/orderpipe123  
- **Management UI**: http://localhost:15672
- **Purpose**: Asynchronous message communication between services

#### 6. **Redis Cache**
- **Port**: 6379
- **Password**: orderpipe123
- **Purpose**: Distributed caching and session storage

## Docker Configuration

### Multi-Stage Builds
All services use optimized multi-stage Docker builds:
- **Stage 1**: Maven-based build with dependency caching
- **Stage 2**: Minimal JRE runtime with security hardening
- **Security**: Non-root user execution
- **Health Checks**: Built-in health monitoring

### Service Dependencies
The docker-compose.yml includes proper service dependencies and health checks:
- Infrastructure services start first
- Service Registry → Config Server → API Gateway → Business Services
- Health checks ensure proper startup sequencing

## Quick Start

### Start Infrastructure Only
```bash
./start-infrastructure.sh
```

### Start Complete System
```bash
./start-all-services.sh
```

### Manual Docker Compose
```bash
# Infrastructure services
docker-compose up -d postgresql rabbitmq redis service-registry config-server api-gateway

# Business services  
docker-compose up -d order-service inventory-service payment-service notification-service shipping-service
```

## Service Configurations

### Environment Profiles
- **Default**: H2 database, local development
- **Docker**: PostgreSQL, RabbitMQ, Redis integration
- **Production**: Optimized logging, database validation

### Database Configuration
Each service automatically switches between:
- **Local**: H2 in-memory database
- **Docker**: PostgreSQL with connection pooling
- **Production**: PostgreSQL with validation mode

### Message Queue Setup
Services configured for RabbitMQ integration:
- Order Service: Publishes order events
- Inventory Service: Listens for inventory updates
- Payment Service: Handles payment processing events
- Notification Service: Processes notification requests
- Shipping Service: Manages shipping events

### Caching Strategy
Redis integration for:
- Order Service: Order caching
- Inventory Service: Product inventory caching  
- Payment Service: Transaction caching
- Shipping Service: Delivery status caching

## Monitoring & Health Checks

### Actuator Endpoints
All services expose:
- `/actuator/health` - Service health status
- `/actuator/info` - Service information
- `/actuator/metrics` - Prometheus metrics
- `/actuator/prometheus` - Prometheus endpoint

### Service URLs
- **API Gateway**: http://localhost:8080
- **Service Registry**: http://localhost:8761  
- **Config Server**: http://localhost:8888
- **RabbitMQ Management**: http://localhost:15672

### Business Services
- **Order Service**: http://localhost:8081
- **Inventory Service**: http://localhost:8082
- **Payment Service**: http://localhost:8083  
- **Notification Service**: http://localhost:8084
- **Shipping Service**: http://localhost:8085

## Troubleshooting

### Common Commands
```bash
# View service logs
docker-compose logs -f [service-name]

# Check service status
docker-compose ps

# Restart specific service
docker-compose restart [service-name]

# Stop all services
docker-compose down

# Clean restart
docker-compose down -v && docker-compose up -d
```

### Port Conflicts
If ports are already in use, update the port mappings in docker-compose.yml:
```yaml
ports:
  - "NEW_PORT:CONTAINER_PORT"
```

## Security Considerations

- All services run as non-root users
- Database credentials should be externalized in production
- RabbitMQ and Redis passwords should be rotated regularly
- Health check endpoints are publicly accessible (configure security as needed)

## Production Deployment

For production deployment:
1. Use external managed databases (RDS, Cloud SQL)
2. Use managed message queues (Amazon MQ, Google Cloud Pub/Sub)  
3. Use managed Redis (ElastiCache, MemoryStore)
4. Implement proper secret management
5. Configure proper logging and monitoring
6. Set up backup and disaster recovery procedures
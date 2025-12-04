FROM openjdk:21-jdk-slim AS builder

WORKDIR /app

COPY pom.xml .
COPY src ./src

COPY ../pom.xml ./parent-pom.xml

RUN apt-get update && apt-get install -y maven && \
    mvn dependency:go-offline -B

RUN mvn clean package -DskipTests

FROM openjdk:21-jre-slim

WORKDIR /app

RUN addgroup --system spring && adduser --system spring --ingroup spring

COPY --from=builder /app/target/inventory-service-*.jar app.jar

RUN chown spring:spring app.jar

USER spring:spring

EXPOSE 8082

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8082/actuator/health || exit 1

ENTRYPOINT ["java", "-jar", "app.jar"]
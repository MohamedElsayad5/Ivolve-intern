# =========================
# Stage 1: Build Stage (Maven)
# =========================
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app

COPY Docker-1 .

RUN mvn clean package

# =========================
# Stage 2: Runtime Stage (Java)
# =========================
FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY --from=builder /app/target/demo-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]

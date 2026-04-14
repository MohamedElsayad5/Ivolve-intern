# Java 17 base image
FROM eclipse-temurin:17-jdk

# Create work directory
WORKDIR /app

# Copy JAR file into container
COPY Docker-1/target/demo-0.0.1-SNAPSHOT.jar app.jar

# Expose port
EXPOSE 8080

# Run application
ENTRYPOINT ["java", "-jar", "app.jar"]

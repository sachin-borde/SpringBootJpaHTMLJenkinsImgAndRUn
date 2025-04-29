# Use a lightweight OpenJDK image
FROM openjdk:17-jdk-alpine

# Copy the Spring Boot fat JAR (built by Maven)
COPY target/*.jar app.jar

# Expose the default port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java","-jar","/app.jar"]

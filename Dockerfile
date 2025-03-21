# Use a base image with Java 17
FROM amazoncorretto:17-alpine-jdk

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven wrapper and project files
COPY mvnw .
COPY .mvn .
COPY pom.xml .

# Download Maven dependencies (this will be cached in subsequent builds)
RUN ./mvnw dependency:go-offline -B

# Copy the application source code
COPY src ./src

# Build the application
RUN ./mvnw package -DskipTests

# Specify the command to run the application
CMD ["java", "-jar", "target/DevOpsSummative-1.0-SNAPSHOT.jar"]

# Expose the default Spring Boot port
EXPOSE 8080

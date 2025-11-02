# Use official Maven image to build the app
FROM maven:3.8.8-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Use lightweight Java image to run the app
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Render provides PORT automatically, so use it
ENV PORT=8080
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]

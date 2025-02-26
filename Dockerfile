FROM openjdk:17-jdk-slim
WORKDIR /app
COPY target/app-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 10000
CMD ["java", "-jar", "app.jar"]

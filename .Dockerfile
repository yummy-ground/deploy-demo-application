ARG profile
ENV profile $profile
RUN mkdir -p "app"

FROM gradle:8.10.2-jdk21-alpine as builder
WORKDIR /app
COPY . /app
RUN gradle clean build --no-daemon

FROM openjdk:21-jre-slim
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar /app/cddemo.jar

EXPOSE 8080
ENTRYPOINT ["java", "-Dspring.profiles.active=${profile}", "-jar", "/app/demo.jar"]
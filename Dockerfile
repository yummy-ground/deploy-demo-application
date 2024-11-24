FROM gradle:8.10.2 AS builder

# mkdir /app-build && cd /app-build
WORKDIR /app-build

# docker cp . gradle:app-build
COPY . /app-build

# set property
#COPY ./src/main/resources/application.properties /app-build/src/main/resources/application.properties

# create .jar
RUN gradle build -x test

# Run-Time Image Setting
FROM openjdk:21-jdk-slim AS production

# mkdir /app-run && cd /app-run
WORKDIR /app-run

# copy .jar to Run-Time Image
COPY --from=builder /app-build/build/libs/*.jar demo.jar


EXPOSE 8080
ENTRYPOINT ["java"]
CMD ["-jar", "/app-run/demo.jar"]

HEALTHCHECK --interval=30s --timeout=10s --start-period=15s --retries=3 \
  CMD curl -f http://localhost:8080/actuator/health || exit 1
FROM gradle:8.10.2 as builder

# mkdir /app-build && cd /app-build
WORKDIR /app-build

# docker cp . gradle:app-build
COPY . /app-build

# set property
ARG PROPERTIES
COPY ${PROPERTIES} /app-build/src/main/resources

# create .jar
RUN gradle clean build --no-daemon

# Run-Time Image Setting
FROM openjdk:21-jdk-slim as production

# mkdir /app-run && cd /app-run
WORKDIR /app-run

# copy .jar to Run-Time Image
COPY --from=builder /app-build/build/libs/*.jar /app-run/demo.jar


EXPOSE 8080
ENTRYPOINT ["java"]
CMD ["-jar", "demo.jar"]
FROM openjdk:11-jdk-slim as builder
WORKDIR /app
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY src src
RUN chmod +x ./gradlew
RUN ./gradlew bootJar --no-daemon

FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app1.jar

RUN mkdir -p /app/logs

ENV SPRING_PROFILES_ACTIVE=prod
ENV SERVER_PORT=8083

EXPOSE 8083
ENTRYPOINT ["java", "-jar", "app1.jar"]

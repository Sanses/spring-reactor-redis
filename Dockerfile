FROM openjdk:8-jdk-alpine as build
WORKDIR /

RUN gradlew build -DskipTests

FROM openjdk:8-jdk-alpine

COPY --from=build ${DEPENDENCY}/build/lib/*.jar .

ENTRYPOINT ["java","-jar","*.jar"]
FROM gradle:4.2.1-jdk8-alpine as build

WORKDIR /app

COPY . /app
COPY ./src /app/src

user root

RUN chmod +x ./gradlew
RUN ./gradlew build


FROM openjdk:8-jdk-alpine
WORKDIR /app

ENV ARTIFACT_NAME=demo-0.0.1-SNAPSHOT.jar
COPY --from=build /app/build/libs/$ARTIFACT_NAME /app 

EXPOSE 8080

ENTRYPOINT /usr/bin/java -jar $ARTIFACT_NAME


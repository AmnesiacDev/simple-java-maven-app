FROM eclipse-temurin:25.0.4_7-jre-noble

WORKDIR /app

COPY target/my-app-1.0-SNAPSHOT.jar simple-java-maven-app-1.0-SNAPSHOT.jar

CMD ["java", "-jar", "simple-java-maven-app-1.0-SNAPSHOT.jar"]
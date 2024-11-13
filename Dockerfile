# Use uma imagem base com Maven e JDK 21
FROM maven:3.9.9-eclipse-temurin-21 AS build

WORKDIR /app

# Copiar o Maven Wrapper e o arquivo de configuração de dependências
COPY .mvn .mvn
COPY mvnw .
COPY pom.xml .

# Baixar dependências
RUN ./mvnw dependency:go-offline -B

# Copiar o código-fonte do projeto
COPY src ./src

# Compilar e construir o projeto
RUN ./mvnw -B -DskipTests clean install

# Fase de execução, com JDK 21
FROM eclipse-temurin:21-jre AS runtime
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Comando para rodar o aplicativo
ENTRYPOINT ["java", "-jar", "app.jar"]


---

# **Game Listing System**

![Spring Boot](https://img.shields.io/badge/Spring%20Boot-6DB33F?style=for-the-badge&logo=springboot&logoColor=white)  
![Java](https://img.shields.io/badge/Java-21-blue?style=for-the-badge&logo=java&logoColor=white)  
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)  
![Postgres](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)

Este é um sistema de listagem de jogos desenvolvido em **Java** utilizando o framework **Spring Boot**. O projeto segue os princípios de **Clean Code** e **Clean Architecture**, garantindo um código limpo, modular e fácil de manter.

## **📋 Funcionalidades**
- **Listagem de jogos**: Listar informações de jogos armazenados em um banco de dados relacional.
- **Conexão com banco de dados**:
  - Ambiente de **testes**: Banco de dados em memória **H2**.
  - Ambiente de **homologação/produção**: Banco de dados **PostgreSQL** hospedado na **Railway**.
- **Arquitetura limpa**: Estrutura organizada em camadas como `Entities`, `Services`, `Repositories`, `Controllers`, `DTOs`, entre outras.
- **Respostas otimizadas**: Utilização de **DTOs** para transferir dados e melhorar a performance nas listagens.
- **Configuração containerizada**: Inclusão de um arquivo **Dockerfile** para compatibilidade com Java 21 e integração com a nuvem.

---

## **🛠️ Ferramentas e Tecnologias**

### **Linguagens e Frameworks**

- **Java 21**: Linguagem principal para desenvolvimento.
- **Spring Boot**: Framework para construção de APIs RESTful e gerenciamento de dependências.
- **JPA/Hibernate**: Framework ORM para interação com o banco de dados.

### **Banco de Dados**

- **H2**: Banco em memória para testes.
- **PostgreSQL**: Banco relacional para ambientes de homologação e produção.

### **Containerização**

- **Docker**: Usado para criar imagens e containers do projeto.
- **Railway**: Plataforma de hospedagem para o banco de dados PostgreSQL.

### **Build e Dependências**

- **Maven**: Gerenciador de dependências e build do projeto.

---

## **🗂️ Estrutura do Projeto**

O projeto é organizado em camadas, seguindo boas práticas e princípios da arquitetura limpa:

```
src/
├── main/
│   ├── java/com/example/project/
│   │   ├── config/       # Configurações gerais do sistema
│   │   ├── controller/   # Controladores REST
│   │   ├── dto/          # Data Transfer Objects
│   │   ├── entity/       # Entidades do domínio
│   │   ├── repository/   # Interfaces de Repositório (JPA)
│   │   ├── service/      # Regras de negócio e lógica de aplicação
│   │   ├── projections/  # Projeções específicas para queries
│   ├── resources/
│       ├── application.properties # Configurações do ambiente
│       ├── application-dev.properties 
│       ├── application-prod.properties 
│       ├── data.sql        # Dados de inicialização (opcional)
```

---

## **🚀 Como Executar**

### **Pré-requisitos**

- **Java 21**
- **Maven**
- **Docker**

### **Configuração Local**

1. Clone o repositório:
   ```bash
   git clone https://github.com/KaikeBrito/dslist
   cd dslist
   ```
2. Configure o ambiente:

   - No arquivo `docker-compose.yml`, ajuste as configurações para o banco H2 ou PostgreSQL, conforme necessário.

3. Compile e execute o projeto:
   ```
   version: "3.7"
    services:
        pg-docker:
        image: postgres:14-alpine
        container_name: dev-postgresql
        environment:
            POSTGRES_DB: mydatabase
            POSTGRES_PASSWORD: 1234567
        ports:
            - 5433:5432
        volumes:
            - ./.data/postgresql/data:/var/lib/postgresql/data
        networks:
            - dev-network
    pgadmin-docker:
        image: dpage/pgadmin4
        container_name: dev-pgadmin
        environment:
             PGADMIN_DEFAULT_EMAIL: me@example.com
        PGADMIN_DEFAULT_PASSWORD: 1234567
        ports:
            - 5050:80
        volumes:
            - ./.data/pgadmin:/var/lib/pgadmin
        depends_on:
            - pg-docker
        networks:
            - dev-network
    networks:
        dev-network:
            driver: bridge


   ```

### **Executando com Docker**

1. Crie a imagem Docker:
   ```bash
   docker build -t dslist .
   ```
2. Execute o container:
   ```bash
   docker run -p 8080:8080 dslist
   ```

### **Railway**

O sistema está integrado com o Railway para hospedar o banco PostgreSQL. Certifique-se de configurar as credenciais no `docker-compose.yml`.

---

## **🧪 Testes**

Este projeto utiliza o banco de dados H2 para testes. Para executá-los, utilize:

```bash
./mvnw test
```

---

## **📂 Endpoints**

### **Base URL:** `http://localhost:8080`

- **GET** `/games`: Lista todos os jogos cadastrados.

  - **Resposta Exemplo**:
    ```json
    [
      {
        "id": 1,
        "title": "Mass Effect Trilogy",
        "year": 2012,
        "imgUrl": "https://raw.githubusercontent.com/devsuperior/java-spring-dslist/main/resources/1.png",
        "shortDescription": "Lorem ipsum dolor sit amet consectetur adipisicing elit. Odit esse officiis corrupti unde repellat non quibusdam! Id nihil itaque ipsum!"
      }
    ]
    ```

- **GET** `/lists`: Lista todos as categorias de jogos cadastrados.
  - **Resposta Exemplo**:
    ```json
    [
      {
        "id": 1,
        "name": "Aventura e RPG"
      },
      {
        "id": 2,
        "name": "Jogos de plataforma"
      }
    ]
    ```

- **GET** `/lists/1/games`: Lista jogos por categoria .
  - **Resposta Exemplo**:
    ```json
    [
    {
        "id": 1,
        "title": "Mass Effect Trilogy",
        "year": 2012,
        "imgUrl": "https://raw.githubusercontent.com/devsuperior/java-spring-dslist/main/resources/1.png",
        "shortDescription": "Lorem ipsum dolor sit amet consectetur adipisicing elit. Odit esse officiis corrupti unde repellat non quibusdam! Id nihil itaque ipsum!"
    },
    {
        "id": 2,
        "title": "Red Dead Redemption 2",
        "year": 2018,
        "imgUrl": "https://raw.githubusercontent.com/devsuperior/java-spring-dslist/main/resources/2.png",
        "shortDescription": "Lorem ipsum dolor sit amet consectetur adipisicing elit. Odit esse officiis corrupti unde repellat non quibusdam! Id nihil itaque ipsum!"
    },
    {
        "id": 3,
        "title": "The Witcher 3: Wild Hunt",
        "year": 2014,
        "imgUrl": "https://raw.githubusercontent.com/devsuperior/java-spring-dslist/main/resources/3.png",
        "shortDescription": "Lorem ipsum dolor sit amet consectetur adipisicing elit. Odit esse officiis corrupti unde repellat non quibusdam! Id nihil itaque ipsum!"
    },
    {
        "id": 4,
        "title": "Sekiro: Shadows Die Twice",
        "year": 2019,
        "imgUrl": "https://raw.githubusercontent.com/devsuperior/java-spring-dslist/main/resources/4.png",
        "shortDescription": "Lorem ipsum dolor sit amet consectetur adipisicing elit. Odit esse officiis corrupti unde repellat non quibusdam! Id nihil itaque ipsum!"
    },
    {
        "id": 5,
        "title": "Ghost of Tsushima",
        "year": 2012,
        "imgUrl": "https://raw.githubusercontent.com/devsuperior/java-spring-dslist/main/resources/5.png",
        "shortDescription": "Lorem ipsum dolor sit amet consectetur adipisicing elit. Odit esse officiis corrupti unde repellat non quibusdam! Id nihil itaque ipsum!"
    }
    ]
    ```
### Consulta para listar os games por categorias
```
@Query(nativeQuery = true, value = """
		SELECT tb_game.id, tb_game.title, tb_game.game_year AS `year`, tb_game.img_url AS imgUrl,
		tb_game.short_description AS shortDescription, tb_belonging.position
		FROM tb_game
		INNER JOIN tb_belonging ON tb_game.id = tb_belonging.game_id
		WHERE tb_belonging.list_id = :listId
		ORDER BY tb_belonging.position
			""")
List<GameMinProjection> searchByList(Long listId);
```
---

## **📸 Imagens**

### Arquitetura do Banco de Dados

![Arquitetura](https://raw.githubusercontent.com/devsuperior/java-spring-dslist/main/resources/dslist-model.png)

---

## **🛡️ Boas Práticas**

- **Clean Code**: Código claro e legível, com nomenclaturas consistentes.
- **Clean Architecture**: Separação clara de responsabilidades entre as camadas.
- **Uso de DTOs**: Reduz a transferência desnecessária de dados.

---

## **📦 Deploy**

Este sistema pode ser facilmente integrado em pipelines CI/CD com ferramentas como **GitHub Actions**.

---

## **🤝 Contribuições**

Sinta-se à vontade para contribuir com melhorias, abrindo issues ou enviando pull requests.

---

### **💡 Autor**

Desenvolvido por **[Kaike Brito](https://github.com/Kaikebrito)** feito baseado no Intensivão do DevSuperior. Para dúvidas ou sugestões, entre em contato!

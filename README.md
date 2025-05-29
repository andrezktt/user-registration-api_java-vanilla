# Sistema de Cadastro e Login de Usuários - Java EE Clássico

## 📜 Visão Geral

Este projeto é um sistema simples de cadastro e login de usuários desenvolvido como um exercício exploratório das tecnologias "clássicas" do Java para desenvolvimento web. O objetivo principal é demonstrar os fundamentos do backend Java utilizando Servlets, JavaServer Pages (JSP) e JDBC para interação com o banco de dados, sem o uso de frameworks modernos como Spring ou Hibernate.

É importante notar que, por ser um projeto focado nos aspectos didáticos e na "maneira antiga" de desenvolvimento, algumas práticas (especialmente de segurança e design) foram simplificadas e podem não ser adequadas para um ambiente de produção moderno.

## ✨ Funcionalidades

* Cadastro de novos usuários (com nome de usuário, email, senha, nome e sobrenome).
* Validação de dados no backend:
    * Campos obrigatórios.
    * Formato de email.
    * Confirmação de senha.
    * Verificação de duplicidade de nome de usuário e email.
* Login de usuários existentes.
* Armazenamento de senhas utilizando hash (SHA-256 simplificado para fins didáticos).
* Gerenciamento básico de sessão HTTP para manter o usuário logado.
* Logout do sistema.
* Página de boas-vindas acessível apenas para usuários autenticados.

## 🛠️ Tecnologias Utilizadas ("Stack Clássico")

* **Java:** JDK 11 ou superior (utilizado JDK 17 durante o desenvolvimento)
* **Jakarta Servlets:** API Servlet 6.0 (via Jakarta EE 10)
* **Jakarta Server Pages (JSP):** API JSP 4.0 (via Jakarta EE 10)
* **JDBC (Java Database Connectivity):** Para acesso direto ao banco de dados.
* **Banco de Dados:** MySQL (configurado no exemplo, mas adaptável para outros bancos SQL).
* **Servidor de Aplicação:** Apache Tomcat 10.1.x (compatível com Jakarta EE 10).
* **HTML/CSS:** Para a estrutura e estilização básica das páginas.
* **Maven:** Utilizado para gerenciamento de dependências e build do projeto.

## ⚙️ Pré-requisitos

* JDK 11 ou superior.
* Apache Tomcat 10.1.x.
* Servidor de Banco de Dados MySQL (ou outro compatível com as queries SQL fornecidas).
* Maven (se for compilar o projeto usando o `pom.xml`).

## 🗄️ Configuração do Banco de Dados

1.  Certifique-se de que seu servidor MySQL está em execução.
2.  Crie um banco de dados (schema). No exemplo, o nome utilizado é `userdb`:
    ```sql
    CREATE DATABASE IF NOT EXISTS userdb;
    USE userdb;
    ```
3.  Crie a tabela `users` executando o seguinte script SQL:
    ```sql
    CREATE TABLE IF NOT EXISTS users (
        id INT AUTO_INCREMENT PRIMARY KEY,
        username VARCHAR(50) NOT NULL UNIQUE,
        password_hash VARCHAR(255) NOT NULL,
        email VARCHAR(100) NOT NULL UNIQUE,
        first_name VARCHAR(50),
        last_name VARCHAR(50),
        registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    ```
4.  Configure as credenciais de acesso ao banco de dados no arquivo `src/main/java/com/exemplo/util/DatabaseUtil.java`:
    ```java
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/userdb?useSSL=false&serverTimezone=UTC";
    private static final String JDBC_USERNAME = "seu_usuario_db"; // Ex: root
    private static final String JDBC_PASSWORD = "sua_senha_db";   // Ex: admin
    ```

## 🚀 Compilação e Empacotamento (Build)

* **Usando Maven:**
  Navegue até o diretório raiz do projeto (onde está o `pom.xml`) e execute:
    ```bash
    mvn clean package
    ```
  Isso gerará um arquivo `.war` (ex: `SeuProjetoWeb-1.0-SNAPSHOT.war`) no diretório `target/`. Renomeie este arquivo para algo mais simples, como `minhaApp.war`, para facilitar o deploy.

* **Usando uma IDE (Eclipse/IntelliJ IDEA):**
    * **Eclipse:** Clique com o botão direito no projeto -> "Export" -> "Web" -> "WAR file".
    * **IntelliJ IDEA:** "Build" -> "Build Artifacts..." -> Escolha seu artefato WAR -> "Build".

## 📤 Implantação (Deploy) no Tomcat

1.  Inicie o Apache Tomcat (execute `<TOMCAT_HOME>/bin/startup.bat` ou `./startup.sh`).
2.  **Método Simples:** Copie o arquivo `.war` (ex: `minhaApp.war`) para o diretório `<TOMCAT_HOME>/webapps/`. O Tomcat fará o deploy automaticamente.
3.  **Via Tomcat Manager:** Acesse `http://localhost:8080/manager/html` (requer configuração de usuário no `tomcat-users.xml`), e use a interface para fazer o upload do arquivo WAR.
4.  **Via IDE:** Se configurou o Tomcat na sua IDE, você pode iniciar o servidor e fazer o deploy diretamente por ela ("Run on Server").

## 🌐 Acessando a Aplicação

Após o deploy, acesse a aplicação no seu navegador. A URL base para iniciar o cadastro será:

`http://localhost:8080/nome_do_seu_war/register.jsp`

(Substitua `nome_do_seu_war` pelo nome do arquivo `.war` sem a extensão. Se o nome for `minhaApp.war`, a URL será `http://localhost:8080/minhaApp/register.jsp`).

## 📝 Observações sobre a Abordagem "Clássica"

* **Foco no Fundamental:** Este projeto evita deliberadamente frameworks modernos para focar nos componentes básicos da especificação Java EE para web (Servlets, JSP, JDBC).
* **Segurança das Senhas:** O método de hashing de senhas (SHA-256 sem um salt único e gerenciado de forma robusta por usuário) é **altamente simplificado para fins didáticos e não é seguro para produção**. Em aplicações reais, utilize bibliotecas como jBCrypt ou Argon2, que são projetadas para isso.
* **Scriptlets JSP:** O uso de scriptlets `<% ... %>` em JSPs é uma prática antiga. Em projetos mais modernos, prefere-se JSTL (JavaServer Pages Standard Tag Library) e Expression Language (EL) para minimizar código Java nas JSPs.
* **Gerenciamento de Conexões:** A classe `DatabaseUtil` abre e fecha conexões diretamente. Em produção, um pool de conexões (como HikariCP ou C3P0) é essencial para performance e gerenciamento de recursos.
* **Ausência de ORM:** A persistência é feita com JDBC puro. ORMs como Hibernate/JPA abstraem grande parte dessa complexidade.

Este projeto serve como uma janela para o passado do desenvolvimento web Java, útil para entender a base sobre a qual muitas tecnologias modernas foram construídas.

## 💡 Possíveis Melhorias e Próximos Passos

Para quem desejar expandir este projeto ou modernizá-lo:

* Implementar hashing de senha seguro com jBCrypt.
* Adicionar funcionalidade de "Lembrar-me" no login.
* Criar um fluxo de recuperação de senha.
* Utilizar um pool de conexões JDBC.
* Refatorar as JSPs para usar JSTL e EL, eliminando scriptlets.
* Melhorar a interface do usuário com CSS mais elaborado ou um framework frontend básico.
* Adicionar validações no lado do cliente (JavaScript).
* Considerar a migração para um framework como Spring MVC + Spring Security + Spring Data JPA para ver a abordagem moderna.

---

Sinta-se à vontade para usar este projeto como base para seus estudos e explorações!
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cadastro de Usuário</title>
    <style>
        body { font-family: sans-serif; margin: 20px; }
        .container { width: 400px; margin: auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px; }
        label { display: block; margin-bottom: 5px; }
        input[type="text"], input[type="email"], input[type="password"] {
            width: calc(100% - 12px); padding: 8px; margin-bottom: 10px; border: 1px solid #ddd; border-radius: 3px;
        }
        input[type="submit"] { background-color: #4CAF50; color: white; padding: 10px 15px; border: none; border-radius: 3px; cursor: pointer; }
        input[type="submit"]:hover { background-color: #45a049; }
        .error { color: red; margin-bottom: 10px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Cadastro de Novo Usuário</h2>

        <%-- Exibir mensagens de erro, se houver --%>
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null && !errorMessage.isEmpty()) {
        %>
            <p class="error"><%= errorMessage %></p>
        <%
            }
        %>

        <form action="registerServlet" method="post">
            <div>
                <label for="username">Usuário:</label>
                <input type="text" id="username" name="username" required value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
            </div>
            <div>
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
            </div>
            <div>
                <label for="password">Senha:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div>
                <label for="confirmPassword">Confirmar Senha:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>
            <div>
                <label for="firstName">Primeiro Nome:</label>
                <input type="text" id="firstName" name="firstName" value="<%= request.getParameter("firstName") != null ? request.getParameter("firstName") : "" %>">
            </div>
            <div>
                <label for="lastName">Último Nome:</label>
                <input type="text" id="lastName" name="lastName" value="<%= request.getParameter("lastName") != null ? request.getParameter("lastName") : "" %>">
            </div>
            <div>
                <input type="submit" value="Cadastrar">
            </div>
        </form>
        <p>Já tem uma conta? <a href="login.jsp">Faça login aqui</a>.</p>
    </div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
     <style> /* Mesmos estilos do register.jsp ou um CSS centralizado */
        body { font-family: sans-serif; margin: 20px; }
        .container { width: 300px; margin: auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px; }
        label { display: block; margin-bottom: 5px; }
        input[type="text"], input[type="password"] {
            width: calc(100% - 12px); padding: 8px; margin-bottom: 10px; border: 1px solid #ddd; border-radius: 3px;
        }
        input[type="submit"] { background-color: #007bff; color: white; padding: 10px 15px; border: none; border-radius: 3px; cursor: pointer; }
        .error { color: red; margin-bottom: 10px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Login</h2>
        <%
            String loginError = (String) request.getAttribute("loginError");
            if (loginError != null) {
        %>
            <p class="error"><%= loginError %></p>
        <%
            }
            String logoutParam = request.getParameter("logout");
            if ("true".equals(logoutParam)) {
        %>
            <p style="color: green;">Você saiu do sistema com sucesso.</p>
        <%
            }
        %>
        <form action="loginServlet" method="post"> <div>
                <label for="username">Usuário:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div>
                <label for="password">Senha:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div>
                <input type="submit" value="Entrar">
            </div>
        </form>
        <p>Não tem uma conta? <a href="register.jsp">Cadastre-se aqui</a>.</p>
    </div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userFirstName = (String) session.getAttribute("userFirstName");
    if (userFirstName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) session.getAttribute("username");
%>
<html>
<head>
    <title>Bem-vindo!</title>
    <style>
        body { font-family: sans-serif; margin: 20px; }
        .container { width: 500px; margin: auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px; background-color: #f9f9f9; text-align: center; }
        .logout-link { margin-top: 20px; display: inline-block; padding: 10px 15px; background-color: #f44336; color: white; text-decoration: none; border-radius: 3px; }
        .logout-link:hover { background-color: #da190b; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Bem-vindo(a), <%= userFirstName != null ? userFirstName : username %>!</h2>
        <p>Você está logado no sistema.</p>
        <p>Seu nome de usuário é: <strong><%= username %></strong>.</p>
        <p>ID da sessão: <%= session.getId() %></p>

        <a href="logoutServlet" class="logout-link">Sair (Logout)</a>
    </div>
</body>
</html>
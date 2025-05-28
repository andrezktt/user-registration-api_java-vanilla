package org.example.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.bean.User;
import org.example.dao.UserDAO;

import java.io.IOException;

@WebServlet("/registerServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");

        String errorMessage = "";

        if (username == null || username.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()
                || confirmPassword == null || confirmPassword.trim().isEmpty()) {
            errorMessage = "Todos os campos obrigatórios (usuário, email, senha, confirmar senha) deve, ser preenchidos";
        } else if (!password.equals(confirmPassword)) {
            errorMessage = "As senhas não coincidem.";
        } else if (password.length() < 6) {
            errorMessage = "A senha deve ter pelo menos 6 caracteres.";
        } else if (userDAO.usernameExists(username)) {
            errorMessage = "Este nome de usuário já está em uso.";
        } else if (userDAO.emailExists(email)) {
            errorMessage = "Este email já está cadastrado.";
        }

        if (!errorMessage.isEmpty()) {
            request.setAttribute("errorMessage", errorMessage);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
        } else {
            User newUser = new User();
            newUser.setUsername(username);
            newUser.setEmail(email);
            newUser.setPassword(password);
            newUser.setFirstName(firstName);
            newUser.setLastName(lastName);

            boolean success = userDAO.addUser(newUser);

            if (success) {
                response.sendRedirect("registration_success.jsp");
            } else {
                request.setAttribute("errorMessage", "Ocorreu um erro ao tentar registrar o usuário. Tente novamente.");
                request.setAttribute("username", username);
                request.setAttribute("email", email);
                request.setAttribute("firstName", firstName);
                request.setAttribute("lastName", lastName);
                RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
                dispatcher.forward(request, response);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }
}

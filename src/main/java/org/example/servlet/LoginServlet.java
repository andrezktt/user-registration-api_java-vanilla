package org.example.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.dao.UserDAO;

import java.io.IOException;
import java.util.Map;

@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String errorMessage = null;

        if (username == null || username.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {
            errorMessage = "Usuário e senha são obrigatórios";
        } else {
            Map<String, Object> userData = userDAO.getUserByUsernameForLogin(username);

            if (userData != null) {
                String storedPassword = (String) userData.get("password_hash");
                if (userDAO.checkPassword(password, storedPassword)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("userId", userData.get("id"));
                    session.setAttribute("username", userData.get("username"));
                    session.setAttribute("userFirstName", userData.get("firstName"));
                    session.setMaxInactiveInterval(30 * 60);

                    response.sendRedirect("welcome.jsp");
                    return;
                } else {
                    errorMessage = "Usuário ou senha inválidos.";
                }
            } else {
                errorMessage = "Usuário ou senha inválidos.";
            }
        }

        request.setAttribute("loginError", errorMessage);
        request.setAttribute("username", username);
        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}

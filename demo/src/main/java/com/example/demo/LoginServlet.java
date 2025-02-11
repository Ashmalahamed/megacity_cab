package com.example.demo;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final String ADMIN_EMAIL = "admin@example.com";
    private static final String ADMIN_PASSWORD = "admin123";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println(" Login Attempt: Email = " + email + ", Password = " + password);

        HttpSession session = request.getSession();

        if (ADMIN_EMAIL.equals(email) && ADMIN_PASSWORD.equals(password)) {
            session.setAttribute("userRole", "admin");
            session.setAttribute("userName", "Admin");
            System.out.println(" Admin Login Successful: Redirecting to admin-interface.jsp");
            response.sendRedirect("admin-interface.jsp");
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.validateUser(email, password);

        if (user != null) {
            session.setAttribute("userRole", "user");
            session.setAttribute("userName", user.getName());
            System.out.println(" User Login Successful: Redirecting to users-interface.jsp");
            response.sendRedirect("users-interface.jsp");
        } else {
            System.out.println(" Login Failed: Invalid email or password.");
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}

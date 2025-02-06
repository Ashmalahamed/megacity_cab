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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("🟢 Login Attempt: Email = " + email + ", Password = " + password);

        UserDAO userDAO = new UserDAO();
        User user = userDAO.validateUser(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("userName", user.getName()); // Store user name in session

            System.out.println("✅ Login Successful: Redirecting to welcome.jsp");
            response.sendRedirect("welcome.jsp");
        } else {
            System.out.println("❌ Login Failed: Invalid email or password.");
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}

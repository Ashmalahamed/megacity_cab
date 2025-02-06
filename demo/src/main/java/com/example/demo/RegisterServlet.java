package com.example.demo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.Serial;


public class RegisterServlet extends HttpServlet {
    @Serial
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Print received parameters
        System.out.println("🟢 Received Registration Data: ");
        System.out.println("Name: " + name);
        System.out.println("Email: " + email);
        System.out.println("Password: " + password);

        if (name == null || name.isEmpty() || email == null || email.isEmpty() || password == null || password.isEmpty()) {
            System.out.println("❌ Missing form data!");
            response.sendRedirect("register-failed.jsp");
            return;
        }

        User user = new User(name, email, password);
        UserDAO userDAO = new UserDAO();

        try {
            boolean success = userDAO.registerUser(user);

            if (success) {
                System.out.println("✅ User registered successfully!");
                response.sendRedirect("register-success.jsp");
            } else {
                System.out.println("❌ Registration failed: Could not insert user");
                response.sendRedirect("register-failed.jsp");
            }
        } catch (Exception e) {
            System.out.println("❌ Registration error: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("register-failed.jsp");
        }
        HttpSession session = request.getSession();
        session.setAttribute("userName", name); // Store user's name in session

    }
}

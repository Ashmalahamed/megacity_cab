package com.example.demo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/BookCabServlet")
public class BookCabServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String userName = (session != null) ? (String) session.getAttribute("userName") : null;

        if (userName == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve form data
        String pickupLocation = request.getParameter("pickupLocation");
        String dropLocation = request.getParameter("dropLocation");
        String cabType = request.getParameter("cabType");
        String bookingTime = request.getParameter("bookingTime");

        // Validate form data
        if (pickupLocation == null || pickupLocation.isEmpty() ||
                dropLocation == null || dropLocation.isEmpty() ||
                cabType == null || cabType.isEmpty() ||
                bookingTime == null || bookingTime.isEmpty()) {
            response.sendRedirect("booking-failed.jsp");
            return;
        }

        // Database connection details
        String dbURL = "jdbc:mysql://127.0.0.1:3306/magacabs";
        String dbUser = "root";
        String dbPassword = "abc123";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // Insert booking into the database
            String sql = "INSERT INTO bookings (userName, pickupLocation, dropLocation, cabType, bookingTime) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, userName);
            stmt.setString(2, pickupLocation);
            stmt.setString(3, dropLocation);
            stmt.setString(4, cabType);
            stmt.setString(5, bookingTime);

            int rowsInserted = stmt.executeUpdate();
            stmt.close();
            conn.close();

            if (rowsInserted > 0) {
                response.sendRedirect("booking-success.jsp");
            } else {
                response.sendRedirect("booking-failed.jsp");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("booking-failed.jsp");
        }
    }
}

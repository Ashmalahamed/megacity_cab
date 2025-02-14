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

@WebServlet("/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String userName = (session != null) ? (String) session.getAttribute("userName") : null;
        String userRole = (session != null) ? (String) session.getAttribute("userRole") : null;

        if (userName == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve booking ID from request
        String bookingId = request.getParameter("bookingId");

        if (bookingId == null || bookingId.isEmpty()) {
            response.sendRedirect("viewbooking.jsp");
            return;
        }

        // Database connection details
        String dbURL = "jdbc:mysql://127.0.0.1:3306/magacabs";
        String dbUser = "root";
        String dbPassword = "abc123";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // Delete booking based on ID
            String sql = "DELETE FROM bookings WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(bookingId));

            int rowsDeleted = stmt.executeUpdate();
            stmt.close();
            conn.close();

            if (rowsDeleted > 0) {
                response.sendRedirect("viewbooking.jsp?status=success");
            } else {
                response.sendRedirect("viewbooking.jsp?status=failed");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("viewbooking.jsp?status=error");
        }
    }
}
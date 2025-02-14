package com.example.demo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

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

        if (pickupLocation == null || pickupLocation.isEmpty() ||
                dropLocation == null || dropLocation.isEmpty() ||
                cabType == null || cabType.isEmpty() ||
                bookingTime == null || bookingTime.isEmpty()) {
            response.sendRedirect("booking-failed.jsp");
            return;
        }

        String dbURL = "jdbc:mysql://127.0.0.1:3306/magacabs";
        String dbUser  = "root";
        String dbPassword = "abc123";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbURL, dbUser , dbPassword);

            // Insert booking into the database
            String bookingSQL = "INSERT INTO bookings (userName, pickupLocation, dropLocation, cabType, bookingTime) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement bookingStmt = conn.prepareStatement(bookingSQL, Statement.RETURN_GENERATED_KEYS);
            bookingStmt.setString(1, userName);
            bookingStmt.setString(2, pickupLocation);
            bookingStmt.setString(3, dropLocation);
            bookingStmt.setString(4, cabType);
            bookingStmt.setString(5, bookingTime);
            int rowsInserted = bookingStmt.executeUpdate();

            if (rowsInserted > 0) {
                ResultSet generatedKeys = bookingStmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int bookingId = generatedKeys.getInt(1);
                    double fare = generateBill(conn, bookingId, userName, pickupLocation, dropLocation, cabType, bookingTime);
                    // Redirect with fare information
                    response.sendRedirect("booking-success.jsp?fare=" + fare);
                    return; // Ensure to return after redirect
                }
            }

            bookingStmt.close();
            conn.close();
            response.sendRedirect("booking-failed.jsp");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("booking-failed.jsp");
        }
    }

    private double generateBill(Connection conn, int bookingId, String userName, String pickup, String drop, String cabType, String time) throws SQLException {
        double fare = calculateFare(pickup, drop, cabType);
        String billSQL = "INSERT INTO bills (bookingId, userName, pickupLocation, dropLocation, cabType, bookingTime, fare, paymentStatus) VALUES (?, ?, ?, ?, ?, ?, ?, 'Pending')";
        PreparedStatement billStmt = conn.prepareStatement(billSQL);
        billStmt.setInt(1, bookingId);
        billStmt.setString(2, userName);
        billStmt.setString(3, pickup);
        billStmt.setString(4, drop);
        billStmt.setString(5, cabType);
        billStmt.setString(6, time);
        billStmt.setDouble(7, fare);
        billStmt.executeUpdate();
        billStmt.close();
        return fare; // Return the fare for redirection
    }

    private double calculateFare(String pickup, String drop, String cabType) {
        double baseFare = 10.0;
        double distanceRate = 2.0;
        double cabMultiplier = cabType.equals("Luxury") ? 200 : cabType.equals("SUV") ? 150 : 100;
        return baseFare + (distanceRate * 5) * cabMultiplier;
    }
}
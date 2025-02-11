package com.example.demo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ViewBookServlet")
public class ViewBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String userName = (session != null) ? (String) session.getAttribute("userName") : null;
        String userRole = (session != null) ? (String) session.getAttribute("userRole") : null;

        if (userName == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Booking> bookings = new ArrayList<>();

        try {
            Connection conn = DatabaseConnection.getConnection();
            if (conn != null) {
                String sql;
                PreparedStatement stmt;

                if ("admin".equals(userRole)) {
                    sql = "SELECT id, userName, pickupLocation, dropLocation, cabType, bookingTime FROM bookings";
                    stmt = conn.prepareStatement(sql);
                } else {
                    sql = "SELECT id, pickupLocation, dropLocation, cabType, bookingTime FROM bookings WHERE userName = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, userName);
                }

                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    if ("admin".equals(userRole)) {
                        bookings.add(new Booking(
                                rs.getInt("id"),
                                rs.getString("userName"),
                                rs.getString("pickupLocation"),
                                rs.getString("dropLocation"),
                                rs.getString("cabType"),
                                rs.getString("bookingTime")
                        ));
                    } else {
                        bookings.add(new Booking(
                                rs.getInt("id"),
                                userName,
                                rs.getString("pickupLocation"),
                                rs.getString("dropLocation"),
                                rs.getString("cabType"),
                                rs.getString("bookingTime")
                        ));
                    }
                }
                rs.close();
                stmt.close();
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("viewbooking.jsp").forward(request, response);
    }
}

<%--
  Created by IntelliJ IDEA.
  User: ahame
  Date: 2025-02-10
  Time: 5:06 PM
  To change this template use File | Settings | File Templates.
--%>
package com.example.demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/BookDriverServlet")
public class BookDriverServlet extends HttpServlet {
private static final long serialVersionUID = 1L;

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
HttpSession session = request.getSession(false);
String userName = (session != null) ? (String) session.getAttribute("userName") : null;

if (userName == null) {
response.sendRedirect("login.jsp");
return;
}

String driverEmail = request.getParameter("driverEmail");
String pickupLocation = request.getParameter("pickupLocation");
String dropLocation = request.getParameter("dropLocation");
String bookingTime = request.getParameter("bookingTime");

if (driverEmail == null || pickupLocation == null || dropLocation == null || bookingTime == null ||
driverEmail.isEmpty() || pickupLocation.isEmpty() || dropLocation.isEmpty() || bookingTime.isEmpty()) {
response.sendRedirect("user-dashboard.jsp?error=missing_fields");
return;
}

try {
Connection conn = DatabaseConnection.getConnection();
if (conn != null) {
String sql = "INSERT INTO driver_bookings (userName, driverEmail, pickupLocation, dropLocation, bookingTime) VALUES (?, ?, ?, ?, ?)";
PreparedStatement stmt = conn.prepareStatement(sql);
stmt.setString(1, userName);
stmt.setString(2, driverEmail);
stmt.setString(3, pickupLocation);
stmt.setString(4, dropLocation);
stmt.setString(5, bookingTime);

int rowsInserted = stmt.executeUpdate();
stmt.close();
conn.close();

if (rowsInserted > 0) {
response.sendRedirect("user-dashboard.jsp?success=booking_confirmed");
} else {
response.sendRedirect("user-dashboard.jsp?error=insert_failed");
}
}
} catch (SQLException e) {
e.printStackTrace();
response.sendRedirect("user-dashboard.jsp?error=server_error");
}
}
}

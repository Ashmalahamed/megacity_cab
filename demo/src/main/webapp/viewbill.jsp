<%--
  Created by IntelliJ IDEA.
  User: ahame
  Date: 2025-02-11
  Time: 5:38 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="jakarta.servlet.http.HttpSession, java.sql.*" %>

<%
    HttpSession sessionObj = request.getSession(false);
    String userRole = (sessionObj != null) ? (String) sessionObj.getAttribute("userRole") : null;

    // Ensure only admins or authenticated users can see this page
    if (userRole == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Bills</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 50px;
            text-align: center;
        }
        table {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px;
        }
        th {
            background-color: #f2f2f2;
        }
        .paid { color: green; }
        .pending { color: red; }
    </style>
</head>
<body>
<h2>📜 All Bills</h2>

<table>
    <tr>
        <th>User</th>
        <th>Pickup</th>
        <th>Drop</th>
        <th>Cab Type</th>
        <th>Booking Time</th>
        <th>Fare</th>
        <th>Status</th>
    </tr>
    <%
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/magacabs", "root", "abc123");
            String sql = "SELECT userName, pickupLocation, dropLocation, cabType, bookingTime, fare, paymentStatus FROM bills";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
    %>
    <tr>
        <td><%= rs.getString("userName") %></td>
        <td><%= rs.getString("pickupLocation") %></td>
        <td><%= rs.getString("dropLocation") %></td>
        <td><%= rs.getString("cabType") %></td>
        <td><%= rs.getString("bookingTime") %></td>
        <td>Rs.<%= rs.getDouble("fare") %></td>
        <td class="<%= rs.getString("paymentStatus").equals("Paid") ? "paid" : "pending" %>">
            <%= rs.getString("paymentStatus") %>
        </td>
    </tr>
    <%
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</table>

<br>
<a href="index.jsp">⬅ Go Back to Home</a>
</body>
</html>

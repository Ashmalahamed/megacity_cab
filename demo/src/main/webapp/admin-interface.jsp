<%--
  Created by IntelliJ IDEA.
  User: ahame
  Date: 2025-02-07
  Time: 10:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // Get the session
    HttpSession sessionObj = request.getSession(false);
    String userName = (sessionObj != null) ? (String) sessionObj.getAttribute("userName") : null;
    String userRole = (sessionObj != null) ? (String) sessionObj.getAttribute("userRole") : null;

    // Redirect to login if not logged in
    if (userName == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Ensure only admins can access
    if (!"admin".equals(userRole)) {
        response.sendRedirect("unauthorized.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        /* General body styling */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* Container for the dashboard */
        .dashboard-container {
            background-color: #ffffff;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 300px;
        }

        /* Heading styling */
        h2 {
            color: #333;
            margin-bottom: 1.5rem;
            font-size: 24px;
        }

        /* Link/button styling */
        .dashboard-link {
            display: block;
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            font-size: 16px;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            text-align: center;
            transition: background-color 0.3s ease;
        }

        .dashboard-link:hover {
            background-color: #0056b3;
        }

        /* Specific button colors */
        .register-driver {
            background-color: #28a745;
        }

        .register-driver:hover {
            background-color: #218838;
        }

        .view-bookings {
            background-color: #17a2b8;
        }

        .view-bookings:hover {
            background-color: #138496;
        }

        .go-home {
            background-color: #6c757d;
        }

        .go-home:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <h2>Admin Dashboard</h2>
    <a href="Register-Driver.jsp" class="dashboard-link register-driver">Register a Driver</a>
    <a href="ViewBookServlet" class="dashboard-link view-bookings">View All Bookings</a>
    <a href="viewbill.jsp" class="dashboard-link go-home">View All Bills</a>
    <a href="index.jsp" class="dashboard-link go-home">Log Out</a>
</div>
</body>
</html>
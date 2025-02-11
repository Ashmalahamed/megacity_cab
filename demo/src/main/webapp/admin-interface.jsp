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
<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>
<h2>Admin Dashboard</h2>
<a href="Register-Driver.jsp">Register a Driver</a><br>
<a href="ViewBookServlet">View All Bookings</a> <!-- Changed to servlet -->
</body>
</html>

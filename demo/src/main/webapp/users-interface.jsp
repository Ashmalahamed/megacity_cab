<%--
  Created by IntelliJ IDEA.
  User: ahame
  Date: 2025-02-07
  Time: 11:09 AM
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: kavee
  Date: 2/5/2025
  Time: 7:07 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.io.IOException" %>

<%
  // Get the session
  HttpSession sessionObj = request.getSession(false);
  String userName = (sessionObj != null) ? (String) sessionObj.getAttribute("userName") : null;

  // Redirect to login if not logged in
  if (userName == null) {
    response.sendRedirect("login.jsp");
    return;
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Welcome</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      text-align: center;
      margin: 50px;
    }
    .container {
      background: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      max-width: 400px;
      margin: auto;
    }
    h1 {
      color: #4CAF50;
    }
    .logout {
      display: inline-block;
      padding: 10px 20px;
      margin-top: 20px;
      background: #d9534f;
      color: white;
      text-decoration: none;
      border-radius: 5px;
    }
    .logout:hover {
      background: #c9302c;
    }
  </style>
</head>
<body>
<div class="container">
  <h1>Welcome, <%= userName %>! 🎉</h1>
  <p>You have successfully registered.</p>
  <a href="bookcab.jsp" class="logout">Book A Cab</a>
  <a href="logout.jsp" class="logout">Logout</a>
</div>
</body>
</html>

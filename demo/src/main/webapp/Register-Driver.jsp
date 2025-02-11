<%--
  Created by IntelliJ IDEA.
  User: ahame
  Date: 2025-02-07
  Time: 7:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Driver</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 50px;
            text-align: center;
        }
        form {
            display: inline-block;
            text-align: left;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        label {
            font-weight: bold;
        }
        input {
            width: 100%;
            padding: 8px;
            margin: 8px 0;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
<h2>🚖 Register as a Driver</h2>
<% if (request.getParameter("error") != null) { %>
<p style="color: red;">Error: <%= request.getParameter("error") %></p>
<% } %>

<form action="RegisterDriverServlet" method="post">
    <label for="name">Full Name:</label>
    <input type="text" name="name" id="name" required>

    <label for="email">Email:</label>
    <input type="email" name="email" id="email" required>

    <label for="phone">Phone Number:</label>
    <input type="text" name="phone" id="phone" required>

    <label for="licenseNumber">License Number:</label>
    <input type="text" name="licenseNumber" id="licenseNumber" required>

    <button type="submit">Register</button>
</form>
<br>
<a href="index.jsp">⬅ Go Back to Home</a>
</body>
</html>

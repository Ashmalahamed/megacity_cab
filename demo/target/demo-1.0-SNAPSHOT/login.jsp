<%--
  Created by IntelliJ IDEA.
  User: kavee
  Date: 2/4/2025
  Time: 9:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>User Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding: 20px;
        }
        form {
            background: white;
            padding: 20px;
            max-width: 400px;
            margin: auto;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px gray;
        }
        input {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            background-color: #007bff;
            color: white;
            padding: 10px;
            width: 100%;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<h2>User Login</h2>
<form action="LoginServlet" method="post">
    <input type="email" name="email" placeholder="Email" required><br>
    <input type="password" name="password" placeholder="Password" required><br>
    <button type="submit">Login</button>
</form>
<p>Don't have an account? <a href="register.jsp">Register here</a></p>
<%
    String error = request.getParameter("error");
%>

<% if ("invalid".equals(error)) { %>
<p style="color:red;">Invalid email or password. Please try again.</p>
<% } %>

</body>
</html>

<%--
  Created by IntelliJ IDEA.
  User: kavee
  Date: 2/4/2025
  Time: 9:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
  <title>User Registration</title>
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
      background-color: #28a745;
      color: white;
      padding: 10px;
      width: 100%;
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

<h2>User Registration</h2>
<form action="RegisterServlet" method="post">
  <input type="text" name="name" placeholder="Enter your name" required>
  <input type="email" name="email" placeholder="Enter your email" required>
  <input type="password" name="password" placeholder="Enter your password" required>
  <button type="submit">Register</button>
</form>

<p>Already have an account? <a href="login.jsp">Login here</a></p>

</body>
</html>


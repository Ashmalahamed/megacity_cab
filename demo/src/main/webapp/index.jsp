<%--
  Created by IntelliJ IDEA.
  User: ahame
  Date: 2/5/2025
  Time: 7:19 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Maga Cab Service</title>
</head>
<body>
<style>
    /* General Reset */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Poppins', sans-serif;
        background-color: #f4f4f9;
        color: #333;
        line-height: 1.6;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    .container {
        text-align: center;
        background: #fff;
        padding: 2rem;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        max-width: 400px;
        width: 100%;
    }

    header h1 {
        font-size: 2.5rem;
        margin-bottom: 0.5rem;
        color: #333;
    }

    header p {
        font-size: 1rem;
        color: #666;
        margin-bottom: 2rem;
    }

    nav {
        display: flex;
        justify-content: space-around;
    }

    .btn {
        text-decoration: none;
        color: #fff;
        background-color: #007bff;
        padding: 0.75rem 1.5rem;
        border-radius: 5px;
        font-size: 1rem;
        transition: background-color 0.3s ease;
    }

    .btn:hover {
        background-color: #0056b3;
    }
</style>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">


<div class="container">
    <header>
        <h1>Welcome to Maga Cab Service</h1>
        <p>Your reliable partner for safe and comfortable rides.</p>
    </header>
    <nav>
        <a href="register.jsp" class="btn">Register</a>
        <a href="login.jsp" class="btn">Login</a>
    </nav>
</div>
</body>
</html>

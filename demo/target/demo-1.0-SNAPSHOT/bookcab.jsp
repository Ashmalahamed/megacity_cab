<%--
  Created by IntelliJ IDEA.
  User: Ashmal
  Date: 2/5/2025
  Time: 7:21 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
  // Check if the user is logged in
  HttpSession sessionObj = request.getSession(false);
  String userName = (sessionObj != null) ? (String) sessionObj.getAttribute("userName") : null;

  if (userName == null) {
    response.sendRedirect("login.jsp"); // Redirect to login if not logged in
    return;
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Book a Cab</title>
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
    input, select {
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

<h2>🚖 Book Your Cab</h2>
<p>Welcome, <b><%= userName %></b>! Fill in the details below to book your ride.</p>

<form action="BookCabServlet" method="post">
  <label for="pickupLocation">Pickup Location:</label>
  <input type="text" name="pickupLocation" id="pickupLocation" required>

  <label for="dropLocation">Drop Location:</label>
  <input type="text" name="dropLocation" id="dropLocation" required>

  <label for="cabType">Select Cab Type:</label>
  <select name="cabType" id="cabType" required>
    <option value="Standard">Standard</option>
    <option value="Luxury">Luxury</option>
    <option value="SUV">SUV</option>
  </select>

  <label for="bookingTime">Booking Time:</label>
  <input type="datetime-local" name="bookingTime" id="bookingTime" required>

  <button type="submit">Book Now</button>
</form>

<br>
<a href="index.jsp">⬅ Go Back to Home</a>
<a href="logout.jsp" class="logout">Logout</a>
</body>
</html>


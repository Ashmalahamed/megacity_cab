<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="jakarta.servlet.http.HttpSession, java.sql.*, java.util.List, com.example.demo.Booking" %>

<%
  HttpSession sessionObj = request.getSession(false);
  String userName = (sessionObj != null) ? (String) sessionObj.getAttribute("userName") : null;
  String userRole = (sessionObj != null) ? (String) sessionObj.getAttribute("userRole") : null;

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
  <title>Your Bookings</title>
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
    button {
      padding: 5px 10px;
      background-color: #dc3545;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }
    button:hover {
      background-color: #c82333;
    }
  </style>
</head>
<body>
<h2>🚖 Your Cab Bookings</h2>
<p>Welcome, <b><%= userName %></b>! Here are your bookings:</p>

<table>
  <tr>
    <% if ("admin".equals(userRole)) { %>
    <th>User</th>
    <% } %>
    <th>Pickup</th>
    <th>Drop</th>
    <th>Cab Type</th>
    <th>Booking Time</th>
    <th>Action</th>
  </tr>
  <%
    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
    if (bookings != null && !bookings.isEmpty()) {
      for (Booking booking : bookings) {
  %>
  <tr>
    <% if ("admin".equals(userRole)) { %>
    <td><%= booking.getUserName() %></td>
    <% } %>
    <td><%= booking.getPickupLocation() %></td>
    <td><%= booking.getDropLocation() %></td>
    <td><%= booking.getCabType() %></td>
    <td><%= booking.getBookingTime() %></td>
    <td>
      <form action="CancelBookingServlet" method="post">
        <input type="hidden" name="bookingId" value="<%= booking.getId() %>">
        <button type="submit">Cancel</button>
      </form>
    </td>
  </tr>
  <%
    }
  } else {
  %>
  <tr><td colspan="6">No bookings available.</td></tr>
  <%
    }
  %>
</table>

<br>
<a href="index.jsp">⬅ Go Back to Home</a>
<a href="logout.jsp" class="logout">Logout</a>
</body>
</html>

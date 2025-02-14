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
  <title>All Bookings</title>
  <style>
    body { font-family: Arial, sans-serif; text-align: center; }
    table { width: 80%; margin: auto; border-collapse: collapse; }
    th, td { border: 1px solid #ccc; padding: 10px; }
    th { background-color: #f2f2f2; }
    .cancel-button {
      padding: 5px 10px;
      background-color: red;
      color: white;
      border: none;
      cursor: pointer;
    }
    .cancel-button:hover {
      background-color: darkred;
    }
  </style>
</head>
<body>

<h2>🚖 Your Bookings</h2>
<p>Welcome, <b><%= userName %></b>!</p>

<% String successMessage = request.getParameter("success"); %>
<% if ("cancelled".equals(successMessage)) { %>
<p style="color: green;">✅ Booking successfully cancelled.</p>
<% } %>

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
        <button type="submit" class="cancel-button">Cancel</button>
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
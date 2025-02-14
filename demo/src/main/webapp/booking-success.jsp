<%--
  Created by IntelliJ IDEA.
  User: ahame
  Date: 2/5/2025
  Time: 7:19 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.*" %>

<%
    HttpSession sessionObj = request.getSession(false);
    String userName = (sessionObj != null) ? (String) sessionObj.getAttribute("userName") : null;

    if (userName == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String fare = request.getParameter("fare");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Success</title>
    <script>
        function showBill() {
            const fare = "<%= fare %>";
            alert("Your booking is successful! The fare for your ride is: Rs." + fare);
        }
    </script>
</head>
<body onload="showBill()">

<h2>Booking Successful!</h2>
<p>Thank you, <b><%= userName %></b>! Your cab has been booked successfully.</p>
<p>The fare for your ride is: <b>Rs.<%= fare %></b></p>

<a href="index.jsp">⬅ Go Back to Home</a>
<a href="logout.jsp" class="logout">Logout</a>
</body>
</html>
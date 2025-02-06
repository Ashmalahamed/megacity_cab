package com.example.demo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

// Servlet to handle cab booking requests
@WebServlet("/ViewBookServelet")
public class ViewBookServelet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve user session
        HttpSession session = request.getSession(false);
        String userName = (session != null) ? (String) session.getAttribute("userName") : null;

        // If user is not logged in, redirect to login page
        if (userName == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve form data from the request
        String pickupLocation = request.getParameter("pickupLocation");
        String dropLocation = request.getParameter("dropLocation");
        String cabType = request.getParameter("cabType");
        String bookingTime = request.getParameter("bookingTime");

        // Print received data for debugging
        System.out.println("🟢 Received Cab Booking Request:");
        System.out.println("User: " + userName);
        System.out.println("Pickup: " + pickupLocation);
        System.out.println("Drop: " + dropLocation);
        System.out.println("Cab Type: " + cabType);
        System.out.println("Booking Time: " + bookingTime);

        // Basic form validation
        if (pickupLocation == null || pickupLocation.isEmpty() ||
                dropLocation == null || dropLocation.isEmpty() ||
                cabType == null || cabType.isEmpty() ||
                bookingTime == null || bookingTime.isEmpty()) {

            System.out.println("❌ Booking failed: Missing form data!");
            response.sendRedirect("booking-failed.jsp");
            return;
        }

        // Simulate booking process (In a real application, this should interact with a database)
        boolean bookingSuccess = true; // Assume success for now

        if (bookingSuccess) {
            System.out.println("✅ Cab booked successfully for " + userName);
            response.sendRedirect("booking-success.jsp");
        } else {
            System.out.println("❌ Booking failed: Internal error");
            response.sendRedirect("booking-failed.jsp");
        }
    }
}

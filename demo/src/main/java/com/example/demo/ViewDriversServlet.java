package com.example.demo;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

@WebServlet("/ViewDriversServlet")
public class ViewDriversServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Driver> drivers = new ArrayList<>();

        try {
            Connection conn = DatabaseConnection.getConnection();
            if (conn != null) {
                String sql = "SELECT name, email, phone FROM drivers";
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    drivers.add(new Driver(
                            rs.getString("name"),
                            rs.getString("email"),
                            rs.getString("phone")
                    ));
                }
                rs.close();
                stmt.close();
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("drivers", drivers);
        RequestDispatcher dispatcher = request.getRequestDispatcher("ViewDrivers.jsp"); // Forward to correct JSP
        dispatcher.forward(request, response);
    }
}

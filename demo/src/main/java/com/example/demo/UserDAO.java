package com.example.demo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    public boolean registerUser(User user) {
        Connection conn = DatabaseConnection.getConnection();

        if (conn == null) {
            System.out.println("❌ Database connection failed in UserDAO!");
            return false;
        }

        String query = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());

            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                System.out.println("✅ User inserted successfully in database!");
                return true;
            } else {
                System.out.println("❌ No rows inserted!");
                return false;
            }
        } catch (SQLException e) {
            System.out.println("❌ SQL Error in UserDAO: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }



public User validateUser(String email, String password) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new User(rs.getString("name"), rs.getString("email"), rs.getString("password"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}

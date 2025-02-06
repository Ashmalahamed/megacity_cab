package com.example.demo;


import com.example.demo.DatabaseConnection;
import java.sql.Connection;

public class TestDB {
    public static void main(String[] args) {
        Connection conn = DatabaseConnection.getConnection();
        if (conn != null) {
            System.out.println("✅ Database Connected Successfully!");
        } else {
            System.out.println("❌ Database Connection Failed!");
        }
    }
}



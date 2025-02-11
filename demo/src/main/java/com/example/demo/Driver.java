package com.example.demo;

public class Driver {
    private String name;
    private String email;
    private String phone;

    // Constructor
    public Driver(String name, String email, String phone) {
        this.name = name;
        this.email = email;
        this.phone = phone;
    }

    // Getters
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getPhone() { return phone; }
}

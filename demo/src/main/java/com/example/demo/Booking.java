package com.example.demo;

public class Booking {
    private int id;
    private String userName;
    private String pickupLocation;
    private String dropLocation;
    private String cabType;
    private String bookingTime;

    public Booking(int id, String userName, String pickupLocation, String dropLocation, String cabType, String bookingTime) {
        this.id = id;
        this.userName = userName;
        this.pickupLocation = pickupLocation;
        this.dropLocation = dropLocation;
        this.cabType = cabType;
        this.bookingTime = bookingTime;
    }

    public int getId() { return id; }
    public String getUserName() { return userName; }
    public String getPickupLocation() { return pickupLocation; }
    public String getDropLocation() { return dropLocation; }
    public String getCabType() { return cabType; }
    public String getBookingTime() { return bookingTime; }
}

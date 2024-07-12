package com.spring.app.domain;

public class RoomSubVO {
	   private int roomSubSeq;
	    private int roomMainSeq;
	    private String roomSubName;

	    // Getters and Setters
	    public int getRoomSubSeq() {
	        return roomSubSeq;
	    }

	    public void setRoomSubSeq(int roomSubSeq) {
	        this.roomSubSeq = roomSubSeq;
	    }

	    public int getRoomMainSeq() {
	        return roomMainSeq;
	    }

	    public void setRoomMainSeq(int roomMainSeq) {
	        this.roomMainSeq = roomMainSeq;
	    }

	    public String getRoomSubName() {
	        return roomSubName;
	    }

	    public void setRoomSubName(String roomSubName) {
	        this.roomSubName = roomSubName;
	    }
	}

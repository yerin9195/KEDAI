package com.spring.app.domain;

public class MinutesVO {
	private String minutes_code;   	// 회의록시퀀스
	private String fk_doc_no; 	   	// 기안문서번호
	private String meeting_date;	// 회의일자
	private String content; 	   	// 회의록내용
	private String attendees; 	   	// 회의참석자
	
	
	public String getMinutes_code() {
		return minutes_code;
	}
	public void setMinutes_code(String minutes_code) {
		this.minutes_code = minutes_code;
	}
	
	public String getFk_doc_no() {
		return fk_doc_no;
	}
	public void setFk_doc_no(String fk_doc_no) {
		this.fk_doc_no = fk_doc_no;
	}
	
	public String getMeeting_date() {
		return meeting_date;
	}
	public void setMeeting_date(String meeting_date) {
		this.meeting_date = meeting_date;
	}
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getAttendees() {
		return attendees;
	}
	public void setAttendees(String attendees) {
		this.attendees = attendees;
	}
	

}

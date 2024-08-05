package com.spring.app.domain;

public class CalendarSmallCategoryVO {

	private String smcatgono;     // 캘린더 소분류 번호
	private String fk_lgcatgono;  // 캘린더 대분류 번호
	private String smcatgoname;   // 캘린더 소분류 명
	private String fk_empid;     // 캘린더 소분류 작성자 유저아이디
	
	public String getSmcatgono() {
		return smcatgono;
	}
	
	public void setSmcatgono(String smcatgono) {
		this.smcatgono = smcatgono;
	}
	
	public String getFk_lgcatgono() {
		return fk_lgcatgono;
	}
	
	public void setFk_lgcatgono(String fk_lgcatgono) {
		this.fk_lgcatgono = fk_lgcatgono;
	}
	
	public String getSmcatgoname() {
		return smcatgoname;
	}
	
	public void setSmcatgoname(String smcatgoname) {
		this.smcatgoname = smcatgoname;
	}

	public String getFk_empid() {
		return fk_empid;
	}

	public void setFk_empid(String fk_empid) {
		this.fk_empid = fk_empid;
	}
	

	
}

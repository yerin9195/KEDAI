package com.spring.app.domain;

public class DoctypeVO {
	private int doctype_code;	// 기안종류코드
	private String doctype_name;	// 기안종류명
	
	public int getDoctype_code() {
		return doctype_code;
	}
	public void setDoctype_code(int doctype_code) {
		this.doctype_code = doctype_code;
	}
	
	
	public String getDoctype_name() {
		return doctype_name;
	}
	public void setDoctype_name(String doctype_name) {
		this.doctype_name = doctype_name;
	}
}

package com.spring.app.domain;

public class DocVO {
	private String doc_no;   			// 기안문서번호(EX. KD-100-2407)
	private int fk_doctype_code;   	// 기안종류코드 100:연차신청서 101:회의록 102:야간근무신청
	private String fk_empid;   			// 기안자사원아이디
	private String subject;   			// 기안문서제목
	private String content;   			// 기안문서내용
	private String created_date;   		// 서류작성일자
	private String doc_comment;   		// 기안의견
	private int doc_status;   		// 기안상태  0:기안 1:반려
	private String doc_org_filename;	// 원래 파일명
	private String doc_filename;   		// 첨부 파일명
	private String doc_filesize;   		// 파일크기
	
	
	
	public String getDoc_no() {
		return doc_no;
	}
	
	public void setDoc_no(String doc_no) {
		this.doc_no = doc_no;
	}
	
	public  int getFk_doctype_code() {
		return fk_doctype_code;
	}
	
	public void setFk_doctype_code(int fk_doctype_code) {
		this.fk_doctype_code = fk_doctype_code;
	}
	
	public String getFk_empid() {
		return fk_empid;
	}
	
	public void setFk_empid(String fk_empid) {
		this.fk_empid = fk_empid;
	}
	
	public String getSubject() {
		return subject;
	}
	
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getCreated_date() {
		return created_date;
	}
	
	public void setCreated_date(String created_date) {
		this.created_date = created_date;
	}
	
	public String getDoc_comment() {
		return doc_comment;
	}
	
	public void setDoc_comment(String doc_comment) {
		this.doc_comment = doc_comment;
	}
	
	public int getDoc_status() {
		return doc_status;
	}
	
	public void setDoc_status(int doc_status) {
		this.doc_status = doc_status;
	}
	
	public String getDoc_org_filename() {
		return doc_org_filename;
	}
	
	public void setDoc_org_filename(String doc_org_filename) {
		this.doc_org_filename = doc_org_filename;
	}
	
	public String getDoc_filename() {
		return doc_filename;
	}
	
	public void setDoc_filename(String doc_filename) {
		this.doc_filename = doc_filename;
	}
	
	public String getDoc_filesize() {
		return doc_filesize;
	}
	
	public void setDoc_filesize(String doc_filesize) {
		this.doc_filesize = doc_filesize;
	}
	
}
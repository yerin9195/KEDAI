package com.spring.app.domain;

import org.springframework.web.multipart.MultipartFile;

public class DocVO {
	private String doc_no;   			// 기안문서번호(EX. KD-100-2407)
	private int fk_doctype_code;   	// 기안종류코드 100:연차신청서 101:회의록 102:야간근무신청
	private String fk_empid;   			// 기안자사원아이디
	private String doc_subject;   			// 기안문서제목
	private String doc_content;   			// 기안문서내용
	private String created_date;   		// 서류작성일자
	private String doc_comment;   		// 기안의견
	private int doc_status;   		// 기안상태  0:기안 1:반려
	
	///////////////////////////////////////////tbl_doc_file////////////////////////////////
/*	private int doc_file_no;			//첨부파일번호
	private String doc_org_filename;	// 원래 파일명
	private String doc_filename;   		// 첨부 파일명
	private String doc_filesize;   		// 파일크기
	*/
	// !!! 먼저, 댓글쓰기에 파일첨부까지 한 것을 위해서 오라클에서 tbl_comment 테이블에 3개 컬럼(fileName, orgFilename, fileSize)을 추가한 다음에 아래의 작업을 한다. !!!  
	private MultipartFile attach;
	   /* form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다. 
	         진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
	             조심할것은 MultipartFile attach 는 오라클 데이터베이스 tbl_comment 테이블의 컬럼이 아니다.   
	      /board/src/main/webapp/WEB-INF/views/tiles1/board/view.jsp 파일에서 input type="file" 인 name 의 이름(attach)과  
	        동일해야만 파일첨부가 가능해진다.!!!!
	 */
	
	
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
	
	public String getDoc_subject() {
		return doc_subject;
	}

	public void setDoc_subject(String doc_subject) {
		this.doc_subject = doc_subject;
	}

	public String getDoc_content() {
		return doc_content;
	}

	public void setDoc_content(String doc_content) {
		this.doc_content = doc_content;
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
/*	
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
	*/
}
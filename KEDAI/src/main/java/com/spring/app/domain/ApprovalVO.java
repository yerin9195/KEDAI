package com.spring.app.domain;

public class ApprovalVO {
	
	private String approval_no;    			//결재번호 
	private String fk_doc_no;  				// 기안문서번호
	private String fk_empid;        		//결재자사원아이디  
	private String status;     				//결재상태         
	private String approval_comment;        //결재의견   
	private String approval_date;           //결재일자
	private String level_no;                //결재단계
	
	public String getApproval_no() {
		return approval_no;
	}
	public void setApproval_no(String approval_no) {
		this.approval_no = approval_no;
	}
	
	public String getFk_doc_no() {
		return fk_doc_no;
	}
	public void setFk_doc_no(String fk_doc_no) {
		this.fk_doc_no = fk_doc_no;
	}
	
	public String getFk_empid() {
		return fk_empid;
	}
	public void setFk_empid(String fk_empid) {
		this.fk_empid = fk_empid;
	}
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getApproval_comment() {
		return approval_comment;
	}
	public void setApproval_comment(String approval_comment) {
		this.approval_comment = approval_comment;
	}
	
	public String getApproval_date() {
		return approval_date;
	}
	public void setApproval_date(String approval_date) {
		this.approval_date = approval_date;
	}
	
	public String getLevel_no() {
		return level_no;
	}
	public void setLevel_no(String level_no) {
		this.level_no = level_no;
	}

}
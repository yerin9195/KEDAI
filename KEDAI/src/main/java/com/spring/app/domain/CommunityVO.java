package com.spring.app.domain;

public class CommunityVO {

	private String community_seq;
	private String fk_category_code;
	private String fk_empid;
	private String name;
	private String subject;
	private String content;
	private String pwd;
	private String read_count;
	private String registerday;
	private String status;
	private String commentCount;
	
	// getters & setters
	public String getCommunity_seq() {
		return community_seq;
	}
	
	public void setCommunity_seq(String community_seq) {
		this.community_seq = community_seq;
	}
	
	public String getFk_category_code() {
		return fk_category_code;
	}
	
	public void setFk_category_code(String fk_category_code) {
		this.fk_category_code = fk_category_code;
	}
	
	public String getFk_empid() {
		return fk_empid;
	}
	
	public void setFk_empid(String fk_empid) {
		this.fk_empid = fk_empid;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
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
	
	public String getPwd() {
		return pwd;
	}
	
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	
	public String getRead_count() {
		return read_count;
	}
	
	public void setRead_count(String read_count) {
		this.read_count = read_count;
	}
	
	public String getRegisterday() {
		return registerday;
	}
	
	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}
	
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getCommentCount() {
		return commentCount;
	}
	
	public void setCommentCount(String commentCount) {
		this.commentCount = commentCount;
	}
	
}

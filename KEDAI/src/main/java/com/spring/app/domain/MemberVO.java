package com.spring.app.domain;

public class MemberVO {

	private String empid;              
	private String pwd;                
	private String name;               
	private String nickname;          
	private String jubun;              
	private String email;              
	private String mobile;             
	private String postcode;           
	private String address;            
	private String detailaddress;      
	private String extraaddress;       
	private String imgfilename;        
	private String hire_date;          
	private String salary;             
	private String commission_pct;     
	private int    point;              
	private String fk_dept_code;       
	private String fk_job_code;             
	private String dept_tel;           
	private String lastpwdchangedate;  
	private int    status;              
	private String sign_img;
	private int    annual_leave;

	// select 용
	private int pwdchangegap; // 마지막으로 암호를 변경한지가 몇개월인지 알려주는 개월수(3개월 동안 암호를 변경 안 했을시 암호를 변경하라는 메시지를 보여주기 위함이다.)

	// alert 용
	private boolean requirePwdChange = false; // 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
											  // 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false

	// getters & setters
	public String getEmpid() {
		return empid;
	}

	public void setEmpid(String empid) {
		this.empid = empid;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getJubun() {
		return jubun;
	}

	public void setJubun(String jubun) {
		this.jubun = jubun;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDetailaddress() {
		return detailaddress;
	}

	public void setDetailaddress(String detailaddress) {
		this.detailaddress = detailaddress;
	}

	public String getExtraaddress() {
		return extraaddress;
	}

	public void setExtraaddress(String extraaddress) {
		this.extraaddress = extraaddress;
	}

	public String getImgfilename() {
		return imgfilename;
	}

	public void setImgfilename(String imgfilename) {
		this.imgfilename = imgfilename;
	}

	public String getHire_date() {
		return hire_date;
	}

	public void setHire_date(String hire_date) {
		this.hire_date = hire_date;
	}

	public String getSalary() {
		return salary;
	}

	public void setSalary(String salary) {
		this.salary = salary;
	}

	public String getCommission_pct() {
		return commission_pct;
	}

	public void setCommission_pct(String commission_pct) {
		this.commission_pct = commission_pct;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public String getFk_dept_code() {
		return fk_dept_code;
	}

	public void setFk_dept_code(String fk_dept_code) {
		this.fk_dept_code = fk_dept_code;
	}

	public String getFk_job_code() {
		return fk_job_code;
	}

	public void setFk_job_code(String fk_job_code) {
		this.fk_job_code = fk_job_code;
	}

	public String getDept_tel() {
		return dept_tel;
	}

	public void setDept_tel(String dept_tel) {
		this.dept_tel = dept_tel;
	}

	public String getLastpwdchangedate() {
		return lastpwdchangedate;
	}

	public void setLastpwdchangedate(String lastpwdchangedate) {
		this.lastpwdchangedate = lastpwdchangedate;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getSign_img() {
		return sign_img;
	}

	public void setSign_img(String sign_img) {
		this.sign_img = sign_img;
	}   

	public int getPwdchangegap() {
		return pwdchangegap;
	}

	public void setPwdchangegap(int pwdchangegap) {
		this.pwdchangegap = pwdchangegap;
	}

	public boolean isRequirePwdChange() {
		return requirePwdChange;
	}

	public void setRequirePwdChange(boolean requirePwdChange) {
		this.requirePwdChange = requirePwdChange;
	}

	public int getAnnual_leave() {
		return annual_leave;
	}

	public void setAnnual_leave(int annual_leave) {
		this.annual_leave = annual_leave;
	}
	
}

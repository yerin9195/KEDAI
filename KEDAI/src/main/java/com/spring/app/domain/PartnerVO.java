package com.spring.app.domain;

import org.springframework.web.multipart.MultipartFile;

public class PartnerVO {

	private String partner_no;
	private String partner_type;
	private String partner_name;  
	private String partner_url; 
	private String partner_postcode;
	private String partner_address;
	private String partner_detailaddress;
	private String partner_extraaddress;
	private MultipartFile imgfilename;
	private int lat;
	private int lng;
	private int zindex;
	private String part_emp_name;
	private String part_emp_tel;
	private String part_emp_email;
	private String part_emp_dept;
	
	
	
	//////////////////////////////////////////////////////////////////////////
	public String getPartner_no() {
		return partner_no;
	}
	public void setPartner_no(String partner_no) {
		this.partner_no = partner_no;
	}
	public String getPartner_type() {
		return partner_type;
	}
	public void setPartner_type(String partner_type) {
		this.partner_type = partner_type;
	}
	public String getPartner_name() {
		return partner_name;
	}
	public void setPartner_name(String partner_name) {
		this.partner_name = partner_name;
	}
	public String getPartner_url() {
		return partner_url;
	}
	public void setPartner_url(String partner_url) {
		this.partner_url = partner_url;
	}
	public String getPartner_postcode() {
		return partner_postcode;
	}
	public void setPartner_postcode(String partner_postcode) {
		this.partner_postcode = partner_postcode;
	}
	public String getPartner_address() {
		return partner_address;
	}
	public void setPartner_address(String partner_address) {
		this.partner_address = partner_address;
	}
	public String getPartner_detailaddress() {
		return partner_detailaddress;
	}
	public void setPartner_detailaddress(String partner_detailaddress) {
		this.partner_detailaddress = partner_detailaddress;
	}
	public String getPartner_extraaddress() {
		return partner_extraaddress;
	}
	public void setPartner_extraaddress(String partner_extraaddress) {
		this.partner_extraaddress = partner_extraaddress;
	}
	public MultipartFile getImgfilename() {
		return imgfilename;
	}
	public void setImgfilename(MultipartFile imgfilename) {
		this.imgfilename = imgfilename;
	}
	public int getLat() {
		return lat;
	}
	public void setLat(int lat) {
		this.lat = lat;
	}
	public int getLng() {
		return lng;
	}
	public void setLng(int lng) {
		this.lng = lng;
	}
	public int getZindex() {
		return zindex;
	}
	public void setZindex(int zindex) {
		this.zindex = zindex;
	}
	public String getPart_emp_name() {
		return part_emp_name;
	}
	public void setPart_emp_name(String part_emp_name) {
		this.part_emp_name = part_emp_name;
	}
	public String getPart_emp_tel() {
		return part_emp_tel;
	}
	public void setPart_emp_tel(String part_emp_tel) {
		this.part_emp_tel = part_emp_tel;
	}
	public String getPart_emp_email() {
		return part_emp_email;
	}
	public void setPart_emp_email(String part_emp_email) {
		this.part_emp_email = part_emp_email;
	}
	public String getPart_emp_dept() {
		return part_emp_dept;
	}
	public void setPart_emp_dept(String part_emp_dept) {
		this.part_emp_dept = part_emp_dept;
	}
	
}
  
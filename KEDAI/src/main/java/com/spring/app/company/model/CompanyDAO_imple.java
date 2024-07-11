package com.spring.app.company.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import com.spring.app.company.service.CompanyService;
import com.spring.app.domain.PartnerVO;

@Repository
public class CompanyDAO_imple implements CompanyDAO{
	
	@Autowired
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;
	
	// 거래처 사업자등록번호 이미 있는지 중복확인
	@Override
	public String partnerNoDuplicateCheck(String partner_no) {
		String searchPartnerNo = sqlsession.selectOne("company.partnerNoDuplicateCheck", partner_no);
		
		return searchPartnerNo;
	}
	
	// 거래처 정보 등록하기
	/*
	 * @Override public int othercom_register(PartnerVO partvo) { int n =
	 * sqlsession.insert("company.othercom_register",partvo);
	 * 
	 * return n; }
	 */
	
	// 거래처 정보 등록하기
	@Override
	public int othercomRegister_submit(PartnerVO partvo) {
	
	 /*
		#{partner_no}, #{partner_type}, #{partner_name}, #{partner_url}, #{partner_postcode}, #{partner_address},
		#{partner_detailaddress}, #{partner_extraaddress}, #{imgfilename}, #{originalfilename}, #{part_emp_name}, #{part_emp_tel}, #{part_emp_email}, #{part_emp_dept}
	 */
		System.out.println("========= DAO 임 ========");
		System.out.println("~~~~~~ partvo.getpartner_no() : " + partvo.getPartner_no());
		System.out.println("~~~~~~ partvo.getpartner_type() : " + partvo.getPartner_type());
		System.out.println("~~~~~~ partvo.getpartner_name() : " + partvo.getPartner_name());
		System.out.println("~~~~~~ partvo.getPartner_url() : " + partvo.getPartner_url());
		System.out.println("~~~~~~ partvo.getPartner_postcode : " + partvo.getPartner_postcode());
		System.out.println("~~~~~~ partvo.getPartner_address : " + partvo.getPartner_address());
		System.out.println("~~~~~~ partvo.getPartner_detailaddress : " + partvo.getPartner_detailaddress());
		System.out.println("~~~~~~ partvo.getPartner_extraaddress : " + partvo.getPartner_extraaddress());
		System.out.println("~~~~~~ partvo.getimgfilename : " + partvo.getImgfilename());
		System.out.println("~~~~~~ partvo.getorignalfilename : " + partvo.getOriginalfilename());
		System.out.println("~~~~~~ partvo.getpart_emp_name : " + partvo.getPart_emp_name());
		System.out.println("~~~~~~ partvo.getpart_emp_tel : " + partvo.getPart_emp_tel());
		System.out.println("~~~~~~ partvo.getpart_emp_emile : " + partvo.getPart_emp_email());
		System.out.println("~~~~~~ partvo.getpart_emp_dept : " + partvo.getPart_emp_dept());
	
		
		
		
		
		int n = sqlsession.insert("company.othercomRegister_submit",partvo);
		return n;
	}

	
	
}

package com.spring.app.company.model;

public interface CompanyDAO {
	
	// 거래처 사업자등록번호 이미 있는지 중복확인
	String partnerNoDuplicateCheck(String partner_no);
	

}

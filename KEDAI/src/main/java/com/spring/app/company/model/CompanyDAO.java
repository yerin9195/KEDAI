package com.spring.app.company.model;

import com.spring.app.domain.PartnerVO;

public interface CompanyDAO {
	
	// 거래처 사업자등록번호 이미 있는지 중복확인
	String partnerNoDuplicateCheck(String partner_no);
	
	
	// int othercom_register(PartnerVO partvo);
	// 거래처 정보 등록하기
	int othercomRegister_submit(PartnerVO partvo);
	

}

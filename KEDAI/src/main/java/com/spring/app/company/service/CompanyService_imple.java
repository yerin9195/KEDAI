package com.spring.app.company.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.spring.app.company.model.CompanyDAO;
import com.spring.app.domain.PartnerVO;
@Service
public class CompanyService_imple implements CompanyService{
	
	@Autowired
	private CompanyDAO dao;
	
	// 거래처 사업자등록번호 이미 있는지 중복확인
	@Override
	public String partnerNoDuplicateCheck(String partner_no) {
		
		String searchPartnerNo = dao.partnerNoDuplicateCheck(partner_no);
		
		return searchPartnerNo;
	}
	
	
	//@Override
	//public int othercom_register(PartnerVO partvo) {
		
	//	int n = dao.othercom_register(partvo);
	//	return 0;
	// }
	
	// 거래처 정보 등록하기
	@Override
	public int othercomRegister_submit(PartnerVO partvo) {
		int n = dao.othercomRegister_submit(partvo);
		return n;
	}

	
	
	
}	
	
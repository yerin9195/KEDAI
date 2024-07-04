package com.spring.app.company.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.spring.app.company.model.CompanyDAO;
@Service
public class CompanyService_imple implements CompanyService{
	
	@Autowired
	private CompanyDAO dao;
	
	// 거래처 사업자등록번호 이미 있는지 중복확인
	@Override
	public String partnerNoDuplicateCheck(String partnerNo) {
		
		String searchPartnerNo = dao.partnerNoDuplicateCheck(partnerNo);
		
		return searchPartnerNo;
	}

	
	
	
}	
	
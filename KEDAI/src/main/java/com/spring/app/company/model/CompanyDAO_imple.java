package com.spring.app.company.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import com.spring.app.company.service.CompanyService;

@Repository
public class CompanyDAO_imple implements CompanyDAO{
	
	@Autowired
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;
	
	
	
	
	// 거래처 사업자등록번호 이미 있는지 중복확인
	@Override
	public String partnerNoDuplicateCheck(String partnerNo) {
		String searchPartnerNo = sqlsession.selectOne("company.partnerNoDuplicateCheck", partnerNo);
		
		return searchPartnerNo;
	}

	
	
}

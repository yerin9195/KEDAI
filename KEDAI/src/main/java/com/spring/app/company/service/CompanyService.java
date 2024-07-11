package com.spring.app.company.service;

import java.util.List;

import com.spring.app.domain.PartnerVO;

public interface CompanyService {
	
	// 거래처 사업자등록번호 이미 있는지 중복확인
	String partnerNoDuplicateCheck(String partner_no);
	
	// 거래처 정보 등록하기
	int othercomRegister_submit(PartnerVO partvo);
	
	// 거래처 정보 가져오기
	List<PartnerVO> otherCom_list_select();
	
	// 거래처 상세보기 팝업 어떤것 클릭했는지 알아오기 
	List<PartnerVO> partnerPopupClick(PartnerVO patvo);
	
	
	


}

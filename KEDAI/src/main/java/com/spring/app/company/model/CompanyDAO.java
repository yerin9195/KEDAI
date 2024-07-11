package com.spring.app.company.model;

import java.util.List;

import com.spring.app.domain.PartnerVO;

public interface CompanyDAO {
	
	// 거래처 사업자등록번호 이미 있는지 중복확인
	String partnerNoDuplicateCheck(String partner_no);

	// 거래처 정보 등록하기
	int othercomRegister_submit(PartnerVO partvo);
	
	// 거래처 정보 가져오기
	List<PartnerVO> otherCom_list_select();

	// 거래처 상세보기 어떤거 선택했는지 알아오기
	List<PartnerVO> partnerPopupClick(String partner_name);

	PartnerVO otherCom_get_select(String partner_no);
	
	
	

}

package com.spring.app.company.model;

import java.util.List;

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
	@Override
	public int othercomRegister_submit(PartnerVO partvo) {
		int n = sqlsession.insert("company.othercomRegister_submit",partvo);
		return n;
	}
	
	// 거래처 정보 등록하기
	@Override
	public int othercomModify_submit(PartnerVO partvo) {
		int n = sqlsession.update("company.othercomModify_submit",partvo);
		return n;
	}
	
	// 거래처 정보  조회하기
	@Override
	public List<PartnerVO> otherCom_list_select() {
		List<PartnerVO> partnervoList = sqlsession.selectList("company.otherCom_list_select");
		
		return partnervoList;
	}
	
	@Override
	public PartnerVO otherCom_get_select(String partner_no) {
		PartnerVO partnerVO = sqlsession.selectOne("company.otherCom_get_select", partner_no);
		
		return partnerVO;
	}

	// 거래처 상세보기 어떤거 선택했는지 알아오기
	@Override
	public List<PartnerVO> partnerPopupClick(String partner_name) {
		List<PartnerVO> partnervoList = sqlsession.selectList("company.partnerPopupClick", partner_name);
	//	System.out.println("asd" + partnervoList.toString());
		return partnervoList;
	}

	// 삭제할 거래처 사업자 번호 알아오기
	@Override
	public int delPartnerNo(String partner_no) {
		
		int n = sqlsession.delete("company.delPartnerNo",partner_no);
		return n;
	}


	
	
	
	
	
	
	
	
	
}

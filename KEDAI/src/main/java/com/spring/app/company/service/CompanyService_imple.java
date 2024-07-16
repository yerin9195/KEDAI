package com.spring.app.company.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.spring.app.company.model.CompanyDAO;
import com.spring.app.domain.MemberVO;
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
	
	// 거래처 정보 등록하기
	@Override
	public int othercomRegister_submit(PartnerVO partvo) {
		int n = dao.othercomRegister_submit(partvo);
		return n;
	}

	// 거래처 정보 수정하기
	@Override
	public int othercomModify_submit(PartnerVO partvo) {
		int n = dao.othercomModify_submit(partvo);
		return n;
	}

	// 거래처 정보 가져오기
	@Override
	public List<PartnerVO> otherCom_list_select() {
		List<PartnerVO> partnervoList = dao.otherCom_list_select();
		return partnervoList;
	}

	// 거래처 상세보기 팝업 어떤것 클릭했는지 알아오기 
	@Override
	public PartnerVO otherCom_get_select(String partner_no) {
		PartnerVO parterVO = dao.otherCom_get_select(partner_no);
		
		return parterVO;
	}
	
	// 거래처 상세보기 팝업 어떤것 클릭했는지 알아오기 
	@Override
	public List<PartnerVO> partnerPopupClick(PartnerVO partvo) {
	//	System.out.println("test " +partvo.getPartner_name());
		List<PartnerVO> partnervoList = dao.partnerPopupClick(partvo.getPartner_name());
		return partnervoList;
	}
	
	// 거래처 삭제하기 
	@Override
	public int delPartnerNo(String partner_no, String rootPath) {
		PartnerVO partnerVO = dao.otherCom_get_select(partner_no);
		// file delete
		String path = getPartnerImagePath(rootPath);
		new File(path + File.separator + partnerVO.getImgfilename()).delete();

		
		int n = dao.delPartnerNo(partner_no);
		
		return n;
	}

	@Override
	public String getPartnerImagePath(String rootPath) {
		String path = rootPath+"resources"+File.separator+"files";
		// System.out.println(path);
		// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\resources\files
					
		return path;
	}


	



	
	
	
}	
	
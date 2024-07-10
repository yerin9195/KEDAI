package com.spring.app.company.controller;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.AES256;
import com.spring.app.common.FileManager;
import com.spring.app.company.service.CompanyService;
import com.spring.app.domain.PartnerVO;

@Controller
public class CompanyController {
	
	@Autowired
	private CompanyService service;
	
	@Autowired
	private AES256 aes256;
	
	@Autowired
	private FileManager fileManager;
	
	// 거래처 사업자등록번호 이미 있는지 중복확인
	@ResponseBody
	@PostMapping(value="/partnerNoCheck.kedai", produces="text/plain;charset=UTF-8")
	public String partnerNoDuplicateCheck(HttpServletRequest request) {
		
		String partner_no = request.getParameter("partner_no");
		System.out.println("확인용 partner_no : " + partner_no);
		
		String searchPartnerNo = service.partnerNoDuplicateCheck(partner_no);
		
		boolean isExists = false;
		
		if(searchPartnerNo != null) {
			isExists = true;
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("isExists", isExists);
		
		return jsonObj.toString();
		
	} // end of public String partnerNoDuplicateCheck()--------------------------------------

	
	
	// 거래처 정보 등록하기
	@PostMapping("othercom_register.kedai")
	public ModelAndView othercomRegister_submit(ModelAndView mav, PartnerVO partvo, MultipartHttpServletRequest mrequest) {
		
		MultipartFile attach = partvo.getAttach();
		
		String imgfilename = "";
		String originalFilename ="";
		
		if(attach != null) {	// 첨부파일이 있는 경우
			
			// WAS의 webapp 의 절대 경로 알아오기
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
			// System.out.println(root);
			// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\
			
			String path = root+"resources"+File.separator+"files";
			// System.out.println(path);
			// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\resources\files
			
			// 파일 첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 업로드
			imgfilename = "";	// WAS(톰캣)의 디스크에 저장될 파일명
			byte[] bytes = null;		// 첨부파일의 내용물을 담는 것
			
			
			try {
				bytes = attach.getBytes();	// 첨부파일의 내용물을 읽어오는 것
				
				originalFilename = attach.getOriginalFilename();		// 첨부파일명의 파일명
				System.out.println("originalFilename"+originalFilename);
				imgfilename = fileManager.doFileUpload(bytes, originalFilename, path);
				System.out.println("imgfilename" +imgfilename);
				partvo.setImgfilename(imgfilename);
				partvo.setOriginalfilename(originalFilename);
			} catch (Exception e) {
				e.printStackTrace();
			}
 			
			
		} // end of if(attach != null) {}--------------------------------------------------------------
		
		try {
			int n = service.othercomRegister_submit(partvo);
		
			if(n == 1) {
				String message = "거래처가 정상적으로 등록되었습니다!";
				String loc = mrequest.getContextPath()+"/othercom_list.kedai";
				
				mav.addObject("message",message);
				mav.addObject("loc", loc);
				System.out.println("n"+ n);
				mav.setViewName("msg");
			}
			
		} catch (Exception e) {
			String message = "거래처 등록을 실패하였습니다. \n 다시 등록하여야 합니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
		}
		return mav;
		
	}
	
	
	// end of public ModelAndView othercomRegister_submit(ModelAndView mav, PartnerVO partvo, MultipartHttpServletRequest mrequest) {}-----------------------------------------------------
	
	
	
	// 거래처 정보 조회하기 #######################################################
	@RequestMapping(value="/othercom_list.kedai")
	public ModelAndView otherCom_list_select(ModelAndView mav) {
		
		List<PartnerVO> partnervoList = service.otherCom_list_select(); 
		
		/*
		 * for(PartnerVO partvo : partnervoList) { System.out.println("partner_No : " +
		 * partvo.getPartner_no()); System.out.println("PARTNER_TYPE : " +
		 * partvo.getPartner_type()); System.out.println("PARTNER_NAME : " +
		 * partvo.getPartner_name()); System.out.println("PARTNER_URL : " +
		 * partvo.getPartner_url()); System.out.println("PARTNER_POSTCODE : " +
		 * partvo.getPartner_postcode()); System.out.println("PARTNER_ADDRESS : " +
		 * partvo.getPartner_address()); System.out.println("PARTNER_DETAILADDRESS : " +
		 * partvo.getPartner_detailaddress());
		 * System.out.println("PARTNER_EXTRAADDRESS : " +
		 * partvo.getPartner_extraaddress()); System.out.println("PART_EMP_NAME : " +
		 * partvo.getPart_emp_name()); System.out.println("PART_EMP_TEL : " +
		 * partvo.getPart_emp_tel()); System.out.println("PART_EMP_EMAIL : " +
		 * partvo.getPart_emp_email()); System.out.println("PART_EMP_DEPT : " +
		 * partvo.getPart_emp_dept()); System.out.println("ORIGINALFILENAME : " +
		 * partvo.getOriginalfilename()); System.out.println("PART_EMP_RANK : " +
		 * partvo.getPart_emp_rank()); }
		*/
		
		mav.addObject("partnervoList",partnervoList);
		
		mav.setViewName("tiles1/company/othercom_list.tiles");
		
		return mav;
	}
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	//////////////////////////////////////////////////////////////////////////

	
	
	
	
	
	@GetMapping(value="/employee.kedai")
	public ModelAndView employee(ModelAndView mav) {
		
		mav.setViewName("tiles1/company/employee.tiles");
		
		return mav;
	}
	
	@GetMapping(value="/employeeDetail.kedai")
	public ModelAndView employeeDetail(ModelAndView mav) {
		
		mav.setViewName("tiles1/company/employeeDetail.tiles");
		
		return mav;
	}
	
	
	
}

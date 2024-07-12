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
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
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
	
	@Autowired
	private ObjectMapper objectMapper;
	
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

	// 거래처 정보 등록하기 시작 
	@GetMapping(value="/othercom_register.kedai")	// http://localhost:9099/KEDAI/othercom_list.kedai
	public ModelAndView other_comRegister(ModelAndView mav) {
			
		mav.setViewName("tiles1/company/othercom_register.tiles");
		
		return mav;
	}
	
	// 거래처 정보 등록하기 넘겨주기 
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
	
	
	// 거래처 수정하기 
	@GetMapping(value="/othercom_modify.kedai")	// http://localhost:9099/KEDAI/othercom_list.kedai
	public ModelAndView other_comModify(@RequestParam("partner_no") String partnerNo, ModelAndView mav) {
		PartnerVO partnerVO = service.otherCom_get_select(partnerNo);
			
		mav.setViewName("tiles1/company/othercom_register.tiles");
		mav.addObject("partvo", partnerVO);
		
		return mav;
	}
	
	
	
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
	
	// 거래처 상세보기 팝업 어떤것 클릭했는지 알아오기 
	@ResponseBody
	@GetMapping(value="/partnerPopupClick.kedai", produces="text/plain;charset=UTF-8")
	public String otherCom_get_select(String partner_no) throws JsonProcessingException {
	
		PartnerVO partnerVO = service.otherCom_get_select(partner_no);
		
		String jsonString = objectMapper.writeValueAsString(partnerVO); // toObject => PartnerVO partnerVO = objectMapper.readValue(jsonString, PartnerVO.class)
	
		
		
		return jsonString;
	} // end of public String partnerPopupClick(HttpServletRequest request) {
	
	// 거래처 상세보기 팝업 어떤것 클릭했는지 알아오기 
	@ResponseBody
	@PostMapping(value="/partnerPopupClick.kedai", produces="text/plain;charset=UTF-8")
	public String partnerPopupClick(PartnerVO partvo) {
	
		List<PartnerVO> partnervoList = service.partnerPopupClick(partvo); 
		
		JSONArray jsonArr = new JSONArray();
		
		if(partnervoList != null) {
			
			for(PartnerVO pvo:partnervoList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("partner_no",pvo.getPartner_no());
				jsonObj.put("partner_name",pvo.getPartner_name());
				jsonObj.put("partner_type",pvo.getPartner_type());
				jsonObj.put("partner_url",pvo.getPartner_url());
				jsonObj.put("partner_postcode",pvo.getPartner_postcode());
				jsonObj.put("partner_address",pvo.getPartner_address());
				jsonObj.put("partner_detailaddress",pvo.getPartner_detailaddress());
				jsonObj.put("partner_extraaddress",pvo.getPartner_extraaddress());
				jsonObj.put("imgfilename",pvo.getImgfilename());
				jsonObj.put("originalfilename", pvo.getOriginalfilename());
				jsonObj.put("part_emp_name",pvo.getPart_emp_name());
				jsonObj.put("part_emp_tel",pvo.getPart_emp_tel());
				jsonObj.put("part_emp_email",pvo.getPart_emp_email());
				jsonObj.put("part_emp_dept",pvo.getPart_emp_dept());
				jsonObj.put("part_emp_rank",pvo.getPart_emp_rank());
				
				
				jsonArr.put(jsonObj);
			}// end of for()------------------------------------------------
		
		}
		
		String jsonString = jsonArr.toString();
		
		
		return jsonString;
		
		
		
	} // end of public String partnerPopupClick(HttpServletRequest request) {
	
	
	
	
	
	
	
	
	
	
	
	
	// 페이지바 만들기
	
	
	
	
	
	
	
	
	
	
	
	
	

	
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

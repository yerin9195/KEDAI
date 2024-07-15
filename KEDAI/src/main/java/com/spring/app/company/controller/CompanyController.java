package com.spring.app.company.controller;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.spring.app.domain.MemberVO;
import com.spring.app.domain.PartnerVO;

import jdk.nashorn.api.scripting.JSObject;

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
	public ModelAndView othercomRegister_submit(PartnerVO partvo, @RequestParam("is_modify") Boolean isModify, ModelAndView mav, MultipartHttpServletRequest mrequest) {
		
		// 이미 파 업로드
		imageFileUpload(partvo, mrequest);
		
		try {
			int n = (isModify != true) ? 
					service.othercomRegister_submit(partvo) // 등록 때  
					: service.othercomModify_submit(partvo); // 수정  
			if(n == 1) {
				setModelView(mav, "거래처가 정상적으로 " + ((isModify != true)? "등록" : "수정") + "되었습니다!", 
						mrequest.getContextPath()+"/othercom_list.kedai");
			}
		} catch (Exception e) {
			setModelView(mav, "거래처 " + ((isModify != true)? "등록" : "수정") + "을 실패하였습니다.", "javascript:history.back()");
		}
		
		return mav;
	}

	private void setModelView(ModelAndView mav, String message, String loc) {
		mav.addObject("message",message);
		mav.addObject("loc", loc);
		mav.setViewName("msg");
	}

	private void imageFileUpload(PartnerVO partvo, MultipartHttpServletRequest mrequest) {
		MultipartFile attach = partvo.getAttach();
		
		String imgfilename = "";
		String originalFilename ="";
		
		if(attach != null) {	// 첨부파일이 있는 경우
			
			// WAS의 webapp 의 절대 경로 알아오기
			String root = mrequest.getSession().getServletContext().getRealPath("/");
			// System.out.println(root);
			// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\
			
			String path = service.getPartnerImagePath(root);
			
			// 파일 첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 업로드
			imgfilename = "";	// WAS(톰캣)의 디스크에 저장될 파일명
			byte[] bytes = null;		// 첨부파일의 내용물을 담는 것
			
			
			try {
				bytes = attach.getBytes();	// 첨부파일의 내용물을 읽어오는 것
				
				originalFilename = attach.getOriginalFilename();		// 첨부파일명의 파일명
				/* System.out.println("originalFilename"+originalFilename); */
				imgfilename = fileManager.doFileUpload(bytes, originalFilename, path);
				/* System.out.println("imgfilename" +imgfilename); */
				partvo.setImgfilename(imgfilename);
				partvo.setOriginalfilename(originalFilename);
			} catch (Exception e) {
				e.printStackTrace();
			}
 			
			
		} // end of if(attach != null) {}--------------------------------------------------------------
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
	
	
	// 거래처 삭제하기 // 
	@ResponseBody
	@PostMapping(value="/company/delPartner_com.kedai" , produces="text/plain;charset=UTF-8")
	public String delPartner_com(HttpServletRequest request) throws Throwable{
		
		// WAS의 webapp 의 절대 경로 알아오기
		String rootPath = request.getSession().getServletContext().getRealPath("/");
		// System.out.println(root);
		// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\

		
		String partner_no = request.getParameter("partner_no");
		// System.out.println("partner_no : " + partner_no); 
		int n = service.delPartnerNo(partner_no, rootPath);
		// System.out.println("n : " + n );
		JSONObject jsObj = new JSONObject();
		
		jsObj.put("n", n);
		
		
		return jsObj.toString();
		
	}
	
	
	/*
	 * // 거래처 삭제는 성공함 ==> 첨부파일 삭제 실패
	 *  
	 * // 거래처 등록 첨부파일 삭제하기 //
	 * 
	 * @PostMapping(value =
	 * "/company/delPart_comImagefile.kedai",produces="text/plain;charset=UTF-8")
	 * public ModelAndView delPart_comImagefile(ModelAndView mav, HttpServletRequest
	 * request) {
	 * 
	 * String parter_no = request.getParameter("partner_no");
	 * Map<String,String>paraMap = new HashMap<>();
	 * paraMap.put("parter_no",parter_no);
	 * 
	 * PartnerVO partvo = service.getDelPart_comImagefile(paraMap);
	 * 
	 * String fileName = partvo.getOriginalfilename(); if(fileName != null &&
	 * !"".contentEquals(fileName)) { // WAS 의 webapp 의 절대경로 알아오기 HttpSession
	 * session = request.getSession(); String root =
	 * session.getServletContext().getRealPath("/"); //
	 * C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.
	 * core\tmp0\wtpwebapps\KEDAI\
	 * 
	 * String path = root+"resources"+File.separator+"files"; //
	 * C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.
	 * core\tmp0\wtpwebapps\KEDAI\resources\files
	 * 
	 * paraMap.put("path", path); paraMap.put("fileName", fileName); }
	 * 
	 * int n = service.delPartnerNo(partner_no)
	 * 
	 * return mav;
	 * 
	 * }
	 */
	
	
	
	
	
}

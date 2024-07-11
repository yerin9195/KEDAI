package com.spring.app.company.controller;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

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
			String newFileName = "";	// WAS(톰캣)의 디스크에 저장될 파일명
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
		
	/*	
		String partner_no = mrequest.getParameter("partner_no");
		String partner_type = mrequest.getParameter("partner_type");
		String partner_name = mrequest.getParameter("partner_name");
		String partner_url = mrequest.getParameter("partner_url");
		
		String partner_postcode = mrequest.getParameter("partner_postcode");
		String partner_address = mrequest.getParameter("partner_address");
		String partner_detailaddress = mrequest.getParameter("partner_detailaddress");
		String partner_extraaddress = mrequest.getParameter("partner_extraaddress");
		
		
		String part_emp_name = mrequest.getParameter("part_emp_name");
		String part_emp_tel = mrequest.getParameter("part_emp_tel");
		String part_emp_email = mrequest.getParameter("part_emp_email");
		String part_emp_dept = mrequest.getParameter("part_emp_dept");
		
		partvo.setPartner_no(mrequest.getParameter(partner_no));
		partvo.setPartner_type(mrequest.getParameter(partner_type));
		partvo.setPartner_name(mrequest.getParameter(partner_name));
		partvo.setPartner_url(mrequest.getParameter(partner_url));
		
		partvo.setPartner_postcode(mrequest.getParameter(partner_postcode));
		partvo.setPartner_address(mrequest.getParameter(partner_address));
		partvo.setPartner_detailaddress(mrequest.getParameter(partner_detailaddress));
		partvo.setPartner_extraaddress(mrequest.getParameter(partner_extraaddress));
		
		
		partvo.setPart_emp_name(mrequest.getParameter(part_emp_name));
		partvo.setPart_emp_tel(mrequest.getParameter(part_emp_tel));
		partvo.setPart_emp_email(mrequest.getParameter(part_emp_email));
		partvo.setPart_emp_dept(mrequest.getParameter(part_emp_dept));
	*/	
		System.out.println("_______________ 컨트롤로에서 실행함 _________________");
		
	    System.out.println("partner_no: " +  partvo.getPartner_no());
        System.out.println("partner_type: " + partvo.getPartner_type());
        System.out.println("partner_name: " + partvo.getPartner_name());
        System.out.println("partner_url: " +  partvo.getPartner_url());
        System.out.println("partner_postcode: " + partvo.getPartner_postcode());
        System.out.println("partner_address: " + partvo.getPartner_address());
        System.out.println("partner_detailaddress: " + partvo.getPartner_detailaddress());
        System.out.println("partner_extraaddresss: " + partvo.getPartner_extraaddress());
        System.out.println("imgfilename: " + partvo.getImgfilename());
        System.out.println("originalfilename: " + partvo.getOriginalfilename());
        System.out.println("part_emp_name: " + partvo.getPart_emp_name());
        System.out.println("part_emp_tel: " + partvo.getPart_emp_tel());
        System.out.println("part_emp_email: " + partvo.getPart_emp_email());
        System.out.println("part_emp_dept: " + partvo.getPart_emp_dept());
		
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
	
	
	// ==== 사진 파일 업로드 하는 방법(imgfilename + nanotime)
	
	
	
	
	
	
	/*
	 * public ModelAndView other_comRegister_submit(@ModelAttribute PartnerVO
	 * partvo, ModelAndView mav, MultipartHttpServletRequest mrequest) {
	 * partvo.getPartner_no(); partvo.getPart_emp_email();
	 * 
	 * String imageFile = partvo.getImgfilename();
	 * 
	 * try { String ext = imageFile.getOriginalFilename().substring(
	 * imageFile.getOriginalFilename().lastIndexOf("."));
	 * Files.copy(imageFile.getInputStream(),
	 * Paths.get("C:\\SW\\cdn\\" + imageFile.getOriginalFilename() + "_" +
	 * System.nanoTime() + ext), StandardCopyOption.REPLACE_EXISTING); } catch
	 * (IOException e) { // TODO Auto-generated catch block e.printStackTrace(); }
	 * 
	 * return mav;
	 * 
	 * 
	 * 
	 * }
	 */
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	//////////////////////////////////////////////////////////////////////////
		
	@GetMapping(value="/othercom_register.kedai")	// http://localhost:9099/KEDAI/othercom_list.kedai
	public ModelAndView other_comRegister(ModelAndView mav) {
		
		mav.setViewName("tiles1/company/othercom_register.tiles");
		
		return mav;
	}
	
	
	
	
	
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
	
	@GetMapping(value="/othercom_list.kedai")
	public ModelAndView otherCom_list(ModelAndView mav) {
		
		mav.setViewName("tiles1/company/othercom_list.tiles");
		
		return mav;
	}
	
}

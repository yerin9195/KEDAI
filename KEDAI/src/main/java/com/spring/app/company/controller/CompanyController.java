package com.spring.app.company.controller;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import javax.servlet.http.HttpServletRequest;

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
import com.spring.app.company.service.CompanyService;
import com.spring.app.domain.PartnerVO;

@Controller
public class CompanyController {
	
	@Autowired
	private CompanyService service;
	
	@Autowired
	private AES256 aes256;
	
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
	
	public static class OtherCom {
		
	}
	
	@PostMapping(path = "othercom_register.kedai", consumes = { MediaType.MULTIPART_FORM_DATA_VALUE })
	public ModelAndView other_comRegister_submit(@ModelAttribute PartnerVO partvo, ModelAndView mav, MultipartHttpServletRequest mrequest) {
		partvo.getPartner_no();
		partvo.getPart_emp_email();
		
		MultipartFile imageFile = partvo.getImgfilename();
		
		try {
			String ext = imageFile.getOriginalFilename().substring(
					imageFile.getOriginalFilename().lastIndexOf("."));
			Files.copy(imageFile.getInputStream(), 
					Paths.get("C:\\SW\\cdn\\" + imageFile.getOriginalFilename() + "_" + System.nanoTime() + ext), 
					StandardCopyOption.REPLACE_EXISTING);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return mav;
		
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*
	 * private String extractFileName(String )
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

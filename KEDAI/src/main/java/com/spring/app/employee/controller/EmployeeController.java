package com.spring.app.employee.controller;

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
import com.spring.app.employee.service.EmployeeService;

import jdk.nashorn.api.scripting.JSObject;

@Controller
public class EmployeeController {
	
	@Autowired
	private EmployeeService service;
	
	@Autowired
	private ObjectMapper objectMapper;
	
	
	//////////////////////////////////////////////////////////////////////////
	// 사원리스트  
	@GetMapping(value="/employee.kedai") 
	public ModelAndView employee_select(ModelAndView mav) {
		 
	 
		 List<MemberVO> membervoList = service.employee_list_select();
	 	 mav.addObject("membervoList",membervoList);
	 	 mav.setViewName("tiles1/employee/employee.tiles");
	 	 
	 	 return mav;
	}
	
	@GetMapping(value="/employeeDetail.kedai")
	public ModelAndView employeeDetail(ModelAndView mav) {
		
		mav.setViewName("tiles1/employee/employeeDetail.tiles");
		
		return mav;
	}
	
	
	
}

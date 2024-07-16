package com.spring.app.employee.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.app.domain.MemberVO;
import com.spring.app.employee.service.EmployeeService;



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
	
		List<Map<String,String>> employeeList_select = service.employeeList();
		
		
		mav.setViewName("tiles1/employee/employee.tiles");
		
		return mav; 
	}

	// 직원 상세보기 팝업 어떤것 클릭했는지 알아오기
	@ResponseBody
	@GetMapping(value="/employeeDetail_select.kedai",produces = "text/plain;charset=UTF-8")
	public String employeeDetail_select(String empid) throws JsonProcessingException {
		
		MemberVO mvo = service.employeeDetail_select(empid);
		
		String jsonString = objectMapper.writeValueAsString(mvo);
		
		return jsonString;
	} // end of public String employeeDetail_select(String empid) throws JsonProcessingException {}------------------------
	
}

package com.spring.app.employee.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

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
	
		
		
		List<MemberVO> membervoList = service.employee_list_select();
		
		mav.addObject("membervoList",membervoList);
		mav.setViewName("tiles1/employee/employee.tiles");
		
		return mav; 
	}

	/*
	 * @GetMapping(value="/employeeDetail.kedai") public ModelAndView
	 * employeeDetail(ModelAndView mav) {
	 * 
	 * mav.setViewName("tiles1/employee/employeeDetail.tiles");
	 * 
	 * return mav; }
	 */
	
	
	
}

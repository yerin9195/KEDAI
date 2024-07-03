package com.spring.app.company.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CompanyController {

		
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

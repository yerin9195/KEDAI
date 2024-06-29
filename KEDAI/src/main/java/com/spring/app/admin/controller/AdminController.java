package com.spring.app.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.admin.service.AdminService;

@Controller 
public class AdminController {

	@Autowired
	private AdminService service;
	
	@GetMapping("/register.kedai")
	public ModelAndView register(ModelAndView mav) { // http://localhost:9099/KEDAI/register.kedai
		
		mav.setViewName("tiles1/register.tiles"); 
		
		return mav;
	}
	
}

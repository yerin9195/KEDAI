package com.spring.app.member.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.member.service.MemberService;

@Controller 
public class MemberController {

	@Autowired
	private MemberService service;
	
	@RequestMapping(value = "login.kedai") 
	public String login(HttpServletRequest request) { // http://localhost:9099/final_project/login.kedai
		
		return "login";
	}
	
	@GetMapping("/") 
	public ModelAndView home(ModelAndView mav) { 
		
		mav.setViewName("redirect:/index.kedai");
		
		return mav;
	}	
	
	@GetMapping("/index.kedai")
	public ModelAndView index(ModelAndView mav) { // http://localhost:9099/final_project/index.kedai
		
		mav.setViewName("tiles1/index.tiles"); 
		
		return mav;
	}
	
	@GetMapping("/register.kedai")
	public ModelAndView register(ModelAndView mav) { // http://localhost:9099/final_project/register.kedai
		
		mav.setViewName("tiles1/register.tiles"); 
		
		return mav;
	}
	
}

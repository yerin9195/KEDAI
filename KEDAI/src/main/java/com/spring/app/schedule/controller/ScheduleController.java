package com.spring.app.schedule.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.schedule.service.ScheduleService;

@Controller
public class ScheduleController {
	
	// Type에 따라 알아서 Bean 을 주입해준다.
	@Autowired
	private ScheduleService service;

	
	@GetMapping("/scheduler/main.kedai")
	public ModelAndView showSchedule(ModelAndView mav) { 
		
		mav.setViewName("tiles1/scheduler/main.tiles");
		// /WEB-INF/views/tiles/tiles1/content/approval/main.jsp
	//	/WEB-INF/views/tiles/tiles1/content/approval/main.tiles.jsp 페이지를 만들어야 한다.
		
		return mav;
	}
}

package com.spring.app.approval.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller 
public class ApprovalController {
	
	@GetMapping(value = "/approval.kedai")
	public ModelAndView approval(ModelAndView mav) {
		mav.setViewName("tiles1/approval/main.tiles");
		// /WEB-INF/views/tiles/tiles1/content/approval/main.jsp
	//	/WEB-INF/views/tiles/tiles1/content/approval/main.tiles.jsp 페이지를 만들어야 한다.
		return mav;
	}
	
	@GetMapping(value = "/approval/newdoc.kedai")
	public ModelAndView mom(ModelAndView mav, HttpServletRequest request ) {
		
		String doc_type = request.getParameter("doc_type");
		System.out.println(doc_type);
		
		if(doc_type.equals("newdayoff")) {
			mav.setViewName("tiles1/approval/newdayoff.tiles");
		}
		else if(doc_type.equals("newmeeting")){
			mav.setViewName("tiles1/approval/newmeeting.tiles");
		}
		
	//	/WEB-INF/views/tiles/tiles1/content/approval/newdoc.jsp 페이지를 만들어야 한다.
		return mav;
	}
	
 //  	<definition name="*/*/*/*.tiles" extends="layout-tiles">
//  	<put-attribute name="content" value="/WEB-INF/views/tiles/{1}/content/{2}/{3}/{4}.jsp"/>
//	</definition>

}

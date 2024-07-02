package com.spring.app.approval.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller 
@RequestMapping(value="/approval/*") // 이렇게 하면 @GetMapping("/approval/newdoc.kedai")에서 /approval를 빼도 됨. /approval 가 붙는 효과가 있음.
public class ApprovalController {
	
	@GetMapping(value = "main.kedai")
	public ModelAndView approval(ModelAndView mav) {
		mav.setViewName("tiles1/approval/main.tiles");
		// /WEB-INF/views/tiles/tiles1/content/approval/main.jsp
	//	/WEB-INF/views/tiles/tiles1/content/approval/main.tiles.jsp 페이지를 만들어야 한다.
		return mav;
	}
	
	@GetMapping(value = "newdoc.kedai")
	public ModelAndView mom(ModelAndView mav, HttpServletRequest request ) {
		
		String doc_type = request.getParameter("doc_type");
	//	System.out.println(" doc_type " + doc_type);
		
		if(doc_type.equals("newdayoff")) {
			mav.setViewName("tiles1/approval/newdayoff.tiles");
		}
		else if(doc_type.equals("newmeeting")){
			mav.setViewName("tiles1/approval/newmeeting.tiles");
		}
		
	//	/WEB-INF/views/tiles/tiles1/content/approval/newdoc.jsp 페이지를 만들어야 한다.
		return mav;
	}
	
	
	@PostMapping(value = "newDocEnd.kedai")
	public ModelAndView newDocEnd(ModelAndView mav) {
		
		
		mav.setViewName("tiles1/approval/newDocEnd.tiles");
		
		return mav;
	}

	
 //  	<definition name="*/*/*/*.tiles" extends="layout-tiles">
//  	<put-attribute name="content" value="/WEB-INF/views/tiles/{1}/content/{2}/{3}/{4}.jsp"/>
//	</definition>

}

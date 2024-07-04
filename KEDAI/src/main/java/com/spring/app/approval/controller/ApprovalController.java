package com.spring.app.approval.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.approval.service.ApprovalService;
import com.spring.app.domain.MemberVO;

@Controller 
@RequestMapping(value="/approval/*") // 이렇게 하면 @GetMapping("/approval/newdoc.kedai")에서 /approval를 빼도 됨. /approval 가 붙는 효과가 있음.
public class ApprovalController {
	
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private ApprovalService service;
	
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
		
		Map<String, String> paraMap = new HashMap<>();
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		paraMap.put("dept_code", loginuser.getFk_dept_code());
		
		Date now = new Date(); // 현재시각
		SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd");
		String str_now = sdfmt.format(now); // "2024-07-04"
		String dept_name = service.getDeptNumber(paraMap);
		mav.addObject("str_now", str_now);
		mav.addObject("dept_name", dept_name);
		
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

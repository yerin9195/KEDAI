package com.spring.app.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.admin.service.AdminService;
import com.spring.app.domain.DeptVO;
import com.spring.app.domain.MemberVO;

@Controller 
public class AdminController {

	@Autowired
	private AdminService service;
	
	@ResponseBody
	@GetMapping("/admin/register.kedai")
	public ModelAndView register(ModelAndView mav, HttpServletRequest request) { // http://localhost:9099/KEDAI/admin/register.kedai
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(loginuser != null && "admin".equals(loginuser.getNickname())) {
			List<DeptVO> deptList = service.dept_select();
			
			JSONArray jsonArr = new JSONArray(); // []
			
			// DB 에서 select 해온 값이 없다면 null 을 반환한다.
			if(deptList != null) {
				for(DeptVO vo : deptList) {
					JSONObject jsonObj = new JSONObject();       // {}
					jsonObj.put("dept_code", vo.getDept_code()); // {"dept_code":"100"}
					jsonObj.put("dept_name", vo.getDept_name()); // {"dept_code":"100", "dept_name":"인사부"}
	
					jsonArr.put(jsonObj); // [{"dept_code":"100", "dept_name":"인사부"}]
				} // end of for ----------
			}
		}
		
		
		mav.setViewName("tiles1/admin/register.tiles"); 
		
		return mav;
	}
	
}

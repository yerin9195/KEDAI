package com.spring.app.member.controller;

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

import com.spring.app.common.Sha256;
import com.spring.app.domain.MemberVO;
import com.spring.app.member.service.MemberService;

@Controller 
public class MemberController {

	@Autowired
	private MemberService service;
	
	@GetMapping("/") 
	public ModelAndView home(ModelAndView mav) { // http://localhost:9099/KEDAI/

		mav.setViewName("redirect:/login.kedai");

		return mav;
	}	

	@RequestMapping("login.kedai") 
	public String login(HttpServletRequest request) { // http://localhost:9099/KEDAI/login.kedai

		return "login";
	}

	// 로그인 처리하기
	@PostMapping("/loginEnd.kedai")
	public ModelAndView loginEnd(ModelAndView mav, HttpServletRequest request) { 

		String empid = request.getParameter("empid");
		String pwd = request.getParameter("pwd");

		String clientip = request.getRemoteAddr();

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("empid", empid);
		paraMap.put("pwd", Sha256.encrypt(pwd));
		paraMap.put("clientip", clientip);
		
		MemberVO loginuser = service.getLoginMember(paraMap);
		
		if(loginuser == null) { // 로그인이 실패한 경우
			String message = "아이디 또는 암호가 일치하지 않습니다.\\n다시 시도해주세요.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
		}
		else { // 로그인이 성공한 경우
			HttpSession session = request.getSession();
			session.setAttribute("loginuser", loginuser);
			
			if(loginuser.isRequirePwdChange() == true) {
				String message = "비밀번호를 변경하신지 3개월이 지났습니다.\\n비밀번호를 변경하는 페이지로 이동합니다.";
				String loc = request.getContextPath()+"/index.kedai"; // 비밀번호 변경하는 페이지 만들기!!!
               
				mav.addObject("message", message);
				mav.addObject("loc", loc);
               
				mav.setViewName("msg");
			}
			else {
				String goBackURL = (String)session.getAttribute("goBackURL");
				
				if(goBackURL != null) {
					mav.setViewName("redirect:" + goBackURL);
					session.removeAttribute("goBackURL");
				}
				else {
					mav.setViewName("redirect:/index.kedai"); 
				}
			}
			
		}

		return mav;
	}	
	
	// 아이디 찾기
	@RequestMapping("/login/idFind.kedai")
	public String idFind(HttpServletRequest request) { // http://localhost:9099/KEDAI/login/idFind.kedai

		String name = request.getParameter("name");
		String email = request.getParameter("email");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("name", name);
		paraMap.put("email", email);
/*		
		String id = service.idFind(paraMap);
		
		if(id != null) {
			request.setAttribute("id", id);
		}
		else {
			request.setAttribute("id", "존재하지 않습니다.");
		}
		
		request.setAttribute("name", name);
		request.setAttribute("email", email);
	*/
		return "idFind";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@GetMapping("/register.kedai")
	public ModelAndView register(ModelAndView mav) { // http://localhost:9099/KEDAI/register.kedai
		
		mav.setViewName("tiles1/register.tiles"); 
		
		return mav;
	}
	
	@GetMapping("/index.kedai")
	public ModelAndView index(ModelAndView mav) { // http://localhost:9099/KEDAI/index.kedai
		
		mav.setViewName("tiles1/index.tiles"); 
		
		return mav;
	}
	
}

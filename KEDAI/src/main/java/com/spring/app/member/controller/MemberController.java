package com.spring.app.member.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.AES256;
import com.spring.app.common.GoogleMail;
import com.spring.app.common.Sha256;
import com.spring.app.domain.MemberVO;
import com.spring.app.member.service.MemberService;

@Controller 
public class MemberController {

	@Autowired
	private MemberService service;
	
	@Autowired
	private AES256 aES256;

	@GetMapping("/") 
	public ModelAndView home(ModelAndView mav) { // http://localhost:9099/KEDAI/

		mav.setViewName("redirect:/login.kedai");

		return mav;
	}	

	@RequestMapping("/login.kedai") 
	public String login(HttpServletRequest request) { // http://localhost:9099/KEDAI/login.kedai

		return "login";
	}
	
	@GetMapping("/index.kedai")
	public ModelAndView index(ModelAndView mav) { // http://localhost:9099/KEDAI/index.kedai
		
		mav.setViewName("tiles1/index.tiles"); 
		
		return mav;
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
					mav.setViewName("redirect:"+goBackURL);
					session.removeAttribute("goBackURL");
				}
				else {
					mav.setViewName("redirect:/index.kedai"); 
				}
			}
		}

		return mav;
	}	
	
	// 로그아웃 처리하기
	@GetMapping("/logout.kedai")
	public ModelAndView logout(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();	
		session.invalidate();
		
		String message = "정상적으로 로그아웃 되었습니다.";
		String loc = request.getContextPath()+"/login.kedai";
       
		mav.addObject("message", message);
		mav.addObject("loc", loc);
       
		mav.setViewName("msg");
		
		return mav;	
	}
	
	// 아이디 & 비밀번호 찾기 페이지 이동
	@GetMapping("/login/idPwdFind.kedai")
	public String idPwdFind(HttpServletRequest request) { 
		
		String method = request.getMethod();
		request.setAttribute("method", method);
		
		return "idPwdFind";
	}
	
	// 아이디 찾기
	@PostMapping("/login/idFind.kedai")
	public String idFind(HttpServletRequest request) { 

		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("name", name);
		
			try {
				paraMap.put("email", aES256.encrypt(email));
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			}
			
			String empId = service.idFind(paraMap);
			
			if(empId != null) {
				request.setAttribute("empid", empId);
			}
			else {
				request.setAttribute("empid", "존재하지 않습니다.");
			}
			
			request.setAttribute("name", name);
			request.setAttribute("email", email);
		}

		request.setAttribute("method", method);		
	
		return "idPwdFind";
	}
	
	// 비밀번호 찾기
	@PostMapping("/login/pwdFind.kedai")
	public String pwdFind(HttpServletRequest request) {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			String empid = request.getParameter("empid");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("empid", empid);
			paraMap.put("name", name);
			
			try {
				paraMap.put("email", aES256.encrypt(email));
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			}
			
			String empPwd = service.pwdFind(paraMap);
			
			boolean isEmpExist = false;
			boolean sendMailSuccess = false;

			if(empPwd != null) {
				isEmpExist = true;
			}
			
			if(isEmpExist) { 
				// 인증코드 생성하기
				Random rnd = new Random();
				String certification_code = "";

				char randchar = ' ';
				for (int i=0; i<5; i++) {
					randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
					certification_code += randchar;
				} // end of for ---------- 

				int randnum = 0;
				for (int i=0; i<7; i++) {
					randnum = rnd.nextInt(9 - 0 + 1) + 0;
					certification_code += randnum;
				} // end of for ---------- 
				
				GoogleMail mail = new GoogleMail();
	            
	            try {
		            mail.send_certification_code(empid, name, email, certification_code);
		            sendMailSuccess = true; 
		            
		            // session 불러오기
		            HttpSession session = request.getSession();
		            session.setAttribute("certification_code", certification_code);
		            
	            } catch(Exception e) { 
	                e.printStackTrace();
	                sendMailSuccess = false;
	            }
				
			}
			
			request.setAttribute("isEmpExist", isEmpExist);
			request.setAttribute("sendMailSuccess", sendMailSuccess);
			request.setAttribute("empid", empid);
			request.setAttribute("name", name);
			request.setAttribute("email", email);
		}
		
		request.setAttribute("method", method);	
		
		return "idPwdFind";
	}
	
	// 인증코드 발송
	@PostMapping("/login/verifyCertification.kedai")
	public ModelAndView verifyCertification(ModelAndView mav, HttpServletRequest request) {
		
		String method = request.getMethod();
		String empid = request.getParameter("empid");
		
		if("POST".equalsIgnoreCase(method)) {
			String userCertificationCode = request.getParameter("userCertificationCode");
			
			HttpSession session = request.getSession();
			String certification_code = (String)session.getAttribute("certification_code");
			
			String message = "";
			String loc = "";
			
			if(userCertificationCode.equals(certification_code)) {
				message = "인증이 성공되었습니다.\\n비밀번호를 변경해주세요.";
				loc = request.getContextPath()+"/login/pwdUpdateEnd.kedai?empid="+empid;	
			}
			else {
				message = "발급된 인증코드가 아닙니다.\\n인증코드를 다시 발급받으세요.";
				loc = request.getContextPath()+"/login/pwdFind.kedai";	
			}
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
	       
			mav.setViewName("msg");
			session.removeAttribute("certification_code");
		}
		
		return mav;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

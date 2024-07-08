package com.spring.app.member.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.AES256;
import com.spring.app.common.FileManager;
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
	
	@Autowired
	private FileManager fileManager;

	@GetMapping("/") 
	public ModelAndView home(ModelAndView mav) { // http://localhost:9099/KEDAI/

		mav.setViewName("redirect:/login.kedai");

		return mav;
	}	

	@RequestMapping("/login.kedai") 
	public String login(HttpServletRequest request) { 

		return "login";
	}
	
	@GetMapping("/index.kedai")
	public ModelAndView requiredLogin_index(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

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
				String loc = request.getContextPath()+"/login/pwdUpdateEnd.kedai?empid="+empid;
               
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
		session.invalidate(); // WAS 메모리 상에서 session 에 저장된 모든 데이터 삭제하기
		
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

				// 랜덤한 문자 생성
				char randchar = ' ';
				for (int i=0; i<5; i++) {
					randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
					certification_code += randchar;
				} // end of for ---------- 

				// 랜덤한 정수 생성
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
			
			// 세션에 저장된 인증코드 삭제하기
			session.removeAttribute("certification_code");
		}
		
		return mav;
	}
	
	// 비밀번호 변경하기
	@GetMapping("/login/pwdUpdateEnd.kedai")
	public ModelAndView pwdUpdateEnd(ModelAndView mav, HttpServletRequest request) {
		
		String method = request.getMethod();
		String empid = request.getParameter("empid");
		
		if("POST".equalsIgnoreCase(method)) {
			
			String new_pwd = request.getParameter("pwd");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("empid", empid);
			paraMap.put("new_pwd", Sha256.encrypt(new_pwd));
			
			int n = 0;
			
			try {
				n = service.pwdUpdateEnd(paraMap);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			String message = "";
			String loc = "";
			
			if(n == 1) {
				message = empid+" 님의 비밀번호가 변경되었습니다.\\n다시 로그인 해주세요.";
                loc = request.getContextPath()+"/login.kedai";
			}
			else {
				message = "SQL구문 오류가 발생되어 비밀번호 변경을 할 수 없습니다.\\n다시 시도해주세요.";
                loc = request.getContextPath()+"/login/pwdFind.kedai";
			}
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
	       
			mav.setViewName("msg");
		}
		else { // "GET" 방식인 경우
			mav.addObject("method", method);
			mav.addObject("empid", empid);
		
			mav.setViewName("pwdUpdate");
		}
		
		return mav;
	}
	
	// 나의 정보 수정하기 페이지 이동
	@GetMapping("/member/memberEdit.kedai")
	public ModelAndView memberEdit(ModelAndView mav) {
		
		mav.setViewName("tiles1/member/memberEdit.tiles");
		
		return mav;
	}
	
	// 나의 정보 수정하기
	@PostMapping("/member/memberEditEnd.kedai")
	public ModelAndView memberEditEnd(ModelAndView mav, MemberVO mvo, MultipartHttpServletRequest mrequest) {	

		Map<String, String> paraMap = new HashMap<>();
		
		MultipartFile attach = mvo.getAttach();
		
		if(attach != null) { // 첨부파일이 있는 경우
			
			// WAS 의 webapp 의 절대경로 알아오기
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/"); 
			// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\
			
			String path = root+"resources"+File.separator+"files";
			// C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\resources\files
			
			// 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
			String newFileName = ""; // WAS(톰캣)의 디스크에 저장될 파일명
			byte[] bytes = null;     // 첨부파일의 내용물을 담는 것
			
			try {
				bytes = attach.getBytes(); // 첨부파일의 내용물을 읽어오는 것
				
				String originalFilename = attach.getOriginalFilename(); // 첨부파일명의 파일명
				
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path); // 첨부되어진 파일을 업로드
				
				paraMap.put("imgfilename", newFileName);
				paraMap.put("orgimgfilename", originalFilename);
				
			} catch (Exception e) {
				e.printStackTrace(); 
			}
			
		} // end of if(attach != null) ----------
		
		String empid = mrequest.getParameter("empid");
		String pwd = Sha256.encrypt(mrequest.getParameter("pwd"));
		String name = mrequest.getParameter("name");
		String nickname = mrequest.getParameter("nickname");
		String email = "";
		try {
			email = aES256.encrypt(mrequest.getParameter("email"));
		} catch (UnsupportedEncodingException | GeneralSecurityException e1) {
			e1.printStackTrace();
		}
		String hp1 = mrequest.getParameter("hp1");
		String hp2 = mrequest.getParameter("hp2");
		String hp3 = mrequest.getParameter("hp3");
		String mobile = hp1 + hp2 + hp3;
		try {
			mobile = aES256.encrypt(mobile);
		} catch (UnsupportedEncodingException | GeneralSecurityException e1) {
			e1.printStackTrace();
		}
		String postcode = mrequest.getParameter("postcode");
		String address = mrequest.getParameter("address");
		String detailaddress = mrequest.getParameter("detailaddress");
		String extraaddress = mrequest.getParameter("extraaddress");
		
		paraMap.put("empid", empid);
		paraMap.put("pwd", pwd);
		paraMap.put("name", name);
		paraMap.put("nickname", nickname);
		paraMap.put("email", email);
		paraMap.put("mobile", mobile);
		paraMap.put("postcode", postcode);
		paraMap.put("address", address);
		paraMap.put("detailaddress", detailaddress);
		paraMap.put("extraaddress", extraaddress);
		
		try {
			int n = service.memberEditEnd(paraMap);
			
			if(n == 1) {
				String message = name+"님의 정보가 정상적으로 수정되었습니다.";
				String loc = mrequest.getContextPath()+"/index.kedai";
	           
				mav.addObject("message", message);
				mav.addObject("loc", loc);
	           
				mav.setViewName("msg"); 
			}
			
		} catch (Exception e) {
			String message = "나의 정보 수정이 실패하였습니다.\\n다시 시도해주세요.";
			String loc = "javascript:history.back()";
           
			mav.addObject("message", message);
			mav.addObject("loc", loc);
           
			mav.setViewName("msg"); 
		}
		
		return mav;
	}
	
	
	
	
	
	
	
	
}

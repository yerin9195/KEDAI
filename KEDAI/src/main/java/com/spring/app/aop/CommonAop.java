package com.spring.app.aop;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import com.spring.app.common.MyUtil;

//==== #53. 공통관심사 클래스(Aspect 클래스) 생성하기 ==== //
//AOP(Aspect Oriented Programming)

@Aspect    
@Component
public class CommonAop {

	// ===== Before Advice(보조업무) 만들기 ====== // "주 업무를 하기 전에 ~~"
	@Pointcut("execution(public * com.spring.app..*Controller.requiredLogin_*(..) )") 
	public void requiredLogin() {}
	
	// 로그인 유무 검사를 하는 메소드
	@Before("requiredLogin()")
	public void loginCheck(JoinPoint joinpoint) {
		
		HttpServletRequest request = (HttpServletRequest)joinpoint.getArgs()[0];  
		HttpServletResponse response = (HttpServletResponse)joinpoint.getArgs()[1];
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginuser") == null) { // 로그인을 하지 않은 경우
			String message = "로그인이 필요한 페이지입니다.\\n로그인 후 이용해주세요.";
			String loc = request.getContextPath()+"/login.kedai";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			// 로그인 성공 후 로그인 하기 전 페이지로 돌아가기
			String url = MyUtil.getCurrentURL(request);
			session.setAttribute("goBackURL", url);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
			try {
				dispatcher.forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		
		}
		
	}
	
	///////////////////////////////////////////////////////////////
	
	
	
	
	
}

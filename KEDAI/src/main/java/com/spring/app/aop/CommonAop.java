package com.spring.app.aop;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.spring.app.board.service.BoardService;
import com.spring.app.common.MyUtil;

// ==== #53. 공통관심사 클래스(Aspect 클래스) 생성하기 ==== //
// AOP(Aspect Oriented Programming)
@Aspect    
@Component
public class CommonAop {

	// === Pointcut(주업무)을 설정해야 한다. === //
	//     Pointcut 이란 공통관심사<예: 로그인 유무검사>를 필요로 하는 메소드를 말한다.  

	// ==== Before Advice(보조업무) 만들기 ==== // "주 업무를 하기 전에 ~~"
	@Pointcut("execution(public * com.spring.app..*Controller.requiredLogin_*(..) )") 
	public void requiredLogin() {} // 밑의 두개에 해당하는 가상의 메소드 즉 주업무(pointcut)!! pointcut을 선언만 해준것!{}
//	com.spring.app.board.controller.BoardController.requiredLogin_add(ModelandView mav)
//	com.spring.app.employees.controller.EmpController.requiredLogin_empList()

	// 공통인 부분 com.spring.app.  이후에는 경로가 아무거나 다 들어온다.
	//..은   	com.spring.app.board.controller.BoardController   이 두개 다 허용된다는 의미이다.  --> 즉, 있든지 없든지 상관없이 다 허용
    //		com.spring.app.EmpController
	// 해당 메소드 두개 중 파라미터가 하나는 없고 하나는 있으므로 (..) 라고 작성한다.
	
	// === Before Advice(공통관심사, 보조업무)를 구현한다. === //
	@Before("requiredLogin()")				// 보조업무1
	public void loginCheck(JoinPoint joinpoint) {				// 로그인 유무 검사를 하는 메소드(보조업무1) - 왼쪽 화살표 체크
		// JoinPoint joinpoint 는 포인트컷(주업무 - requiredLogin) 되어진 주업무의 메소드이다. 즉 메소드 requiredLogin을 파라미터로 잡는것이다.
		// 주업무 전 하고있는 보조업무1
        
		// 로그인 유무를 확인하기 위해서는 request를 통해 session 을 얻어와야 한다.
		HttpServletRequest request = (HttpServletRequest) joinpoint.getArgs()[0]; 				//  request 세팅
		// 주업무 메소드에 있는 해당 파라미터를 가리킨다. 즉 여기서는 --> request [0]을 붙여주면 첫번째 파라미터를 얻어오는 것
		// 강제 형변환하여 request에 넣는다.
		HttpServletResponse response = (HttpServletResponse) joinpoint.getArgs()[1];			//  response 세팅
		// 주업무 메소드에 있는 해당 파라미터를 가리킨다. 즉 여기서는 --> response [1]을 붙여주면 첫번째 파라미터를 얻어오는 것 
		// 강제 형변환하여 response에 넣는다.
		
//		#1-2. !!!이때 중요한것은 [0]로 순서를 지정해주었기 때문에 각각 보조업무의 메소드의 파라미터의 순서도 중요하다!!!
		
		HttpSession session = request.getSession();
		if(session.getAttribute("loginuser") == null) {
		// 정상적으로 로그인이 되어지면 session에 loginuser가 들어와있다. 
		// (session.setAttribute("loginuser",loginuser); k - loginuser v - loginuser)
			 
			 String message = "로그인이 필요한 페이지입니다.\\n로그인 후 이용해주세요.";
	         String loc = request.getContextPath()+"/login.kedai";		// 로그인 페이지를 loc에 넣어준다
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);							// 주소 값을 넘겨주고  controller에서 이동시켜준다.
		 
	         // >>> 로그인 성공후 로그인 하기 전 페이지로 돌아가는 작업 만들기  //
	         String url = MyUtil.getCurrentURL(request);			// 주업무에 있는 request 즉 각 컨트롤러의 parameter
	         session.setAttribute("goBackURL", url);  				// 세션에  url정보를 저장시켜둔다. ( 돌아갈 정보 )
	         
	         // alert 떠야한다. but controller가 아니기 때문에 Mapping이 안된다. --> 해결방법: .getRequestDispatcher()
	         RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
	         
	         try {			// catch할 것이 두개이상 있는 경우 multi로 하여 한번에 catch해줄수 있다.
				dispatcher.forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
	         
		}
		
	}
	
	///////////////////////////////////////////////////////////////
	
	// ==== After Advice(보조업무) 만들기 ==== // "주 업무를 한 후에 ~~"
	@Pointcut("execution(public * com.spring.app..*Controller.pointPlus_*(..) )") 
	public void pointPlus() {}
	
	@Autowired
	private BoardService service;
	
	// After Advice(공통관심사, 보조업무)를 구현
	// 사원의 포인트를 특정점수(예: 100점, 200점, 300점) 만큼 증가시키는 메소드
	@SuppressWarnings("unchecked")
	@After("pointPlus()")
	public void pointPlus(JoinPoint joinpoint) {
		
		Map<String, String> paraMap = (Map<String, String>)joinpoint.getArgs()[0];
		
		service.pointPlus(paraMap);
	}
	
	///////////////////////////////////////////////////////////////
	
}

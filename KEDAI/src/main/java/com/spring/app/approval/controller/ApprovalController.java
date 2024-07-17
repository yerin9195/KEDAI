package com.spring.app.approval.controller;

import java.io.File;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.approval.service.ApprovalService;

import com.spring.app.common.FileManager;
import com.spring.app.domain.ApprovalVO;
import com.spring.app.domain.DeptVO;
import com.spring.app.domain.DocVO;
import com.spring.app.domain.MemberVO;
import com.spring.app.domain.MinutesVO;

@Controller 
//@RequestMapping(value="/approval/*") // 이렇게 하면 @GetMapping("/approval/newdoc.kedai")에서 /approval를 빼도 됨. /approval 가 붙는 효과가 있음.
public class ApprovalController {
	
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private ApprovalService service;
	
	@Autowired
	private FileManager fileManager;
	
	@GetMapping(value = "/approval/main.kedai")
	public ModelAndView approval(ModelAndView mav) {
		mav.setViewName("tiles1/approval/main.tiles");
		// /WEB-INF/views/tiles/tiles1/content/approval/main.jsp
	//	/WEB-INF/views/tiles/tiles1/content/approval/main.tiles.jsp 페이지를 만들어야 한다.
		return mav;
	}
	
	@GetMapping(value = "/approval/newdoc.kedai")
	public ModelAndView mom(ModelAndView mav, HttpServletRequest request ) {
		
		String doctype_code = request.getParameter("doctype_code");

		Map<String, String> paraMap = new HashMap<>();
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		paraMap.put("dept_code", loginuser.getFk_dept_code());
		
		Date now = new Date(); // 현재시각
		SimpleDateFormat sdfmt = new SimpleDateFormat("yyyy-MM-dd");
		String str_now = sdfmt.format(now); // "2024-07-04"
		String dept_name = service.getDeptNumber(paraMap); // DB에서 부서번호 구해오기
		mav.addObject("str_now", str_now);
		mav.addObject("dept_name", dept_name);
		
	//	List<Map<String, String>> allEmployeeList = service.allEmployeeList(loginuser.getEmpid());
		
		
		
		List<DeptVO> allDeptList = service.allDeptList();
		
		/*
		 * List<Map<String, String>> numByDept = service.numByDept(); // 각 부서별 당 인원수
		 * 가져오기
		 */		
	//	mav.addObject("allEmployeeList", allEmployeeList);
		mav.addObject("allDeptList", allDeptList);
		
		
		if(doctype_code.equals("100")) {
			mav.setViewName("tiles1/approval/newdayoff.tiles");
		}
		else if(doctype_code.equals("101")){
			
			mav.setViewName("tiles1/approval/newmeeting.tiles");
		}
			
		//	/WEB-INF/views/tiles/tiles1/content/approval/newdoc.jsp 페이지를 만들어야 한다.

		/*else {
		
			if(doctype_code.equals("100")) {
				mav.setViewName("tiles1/approval/newdayoff.tiles");
			}
			else if(doctype_code.equals("101")){
				
				mav.setViewName("tiles1/approval/newmeeting.tiles");
			}		
		}*/
		
		return mav;
	}
	
	
	
	 /*
    @ResponseBody 란?
	  메소드에 @ResponseBody Annotation이 되어 있으면 return 되는 값은 View 단 페이지를 통해서 출력되는 것이 아니라 
	 return 되어지는 값 그 자체를 웹브라우저에 바로 직접 쓰여지게 하는 것이다. 일반적으로 JSON 값을 Return 할때 많이 사용된다.
	 
	  >>> 스프링에서 json 또는 gson을 사용한 ajax 구현시 데이터를 화면에 출력해 줄때 한글로 된 데이터가 '?'로 출력되어 한글이 깨지는 현상이 있다. 
               이것을 해결하는 방법은 @RequestMapping 어노테이션의 속성 중 produces="text/plain;charset=UTF-8" 를 사용하면 
               응답 페이지에 대한 UTF-8 인코딩이 가능하여 한글 깨짐을 방지 할 수 있다. <<< 
  */ 
	@ResponseBody
	@PostMapping(value="/approval/deptEmpListJSON.kedai",  produces="text/plain;charset=UTF-8")
	public String deptEmpListJSON(HttpServletRequest request ){
				// @RequestParam은 request.getParameter()와 같은 것이다. defaultValue는 파라미터의 초기값을 설정해 줄 수 있는 것을 말한다. 위의 내용은 null대신 ""을 설정한 것이다. 
				//  form태그의 name값을 꼭 String 이름 이런 식으로 넣어주어야 한다.
		
		String dept_code = request.getParameter("dept_code");
		String loginuser_id = request.getParameter("loginuser_id");
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("dept_code", dept_code);
		paraMap.put("loginuser_id", loginuser_id);
				
		List<Map<String,String>> deptEmpList = service.deptEmpList(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		if(deptEmpList != null) {
			for(Map<String,String> map : deptEmpList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("empid", map.get("empid"));
				jsonObj.put("name", map.get("name"));
				jsonObj.put("fk_dept_code", map.get("fk_dept_code"));
				jsonObj.put("dept_name", map.get("dept_name"));
				jsonObj.put("job_code", map.get("job_code"));
				jsonObj.put("job_name", map.get("job_name"));

				jsonArr.put(jsonObj);
			}// end of for---------------
			
		//	System.out.println(jsonArr.toString());
			
		}
		
		return jsonArr.toString();
		
	}
	
 //  	<definition name="*/*/*/*.tiles" extends="layout-tiles">
//  	<put-attribute name="content" value="/WEB-INF/views/tiles/{1}/content/{2}/{3}/{4}.jsp"/>
//	</definition>

//mav.setViewName("tiles1/approval/newDocEnd.tiles");
	//	return mav;

	
	
	// === #54.게시판 글쓰기 완료 요청 === // 
	// ===== #104. After Advice를 사용하기====//  pointPlus_addEnd 메소드의  파라미터에 Map<String, String> paraMap 추가함.
	@PostMapping("/approval/newDocEnd.kedai")
	public ModelAndView newDocEnd(ModelAndView mav, DocVO docvo, HttpServletRequest request) { 
		// @RequestParam("files") MultipartFile[] files는 "files"라는 이름으로 전송된 파일들을 배열 형태로 받아옵니다.
//	public ModelAndView pointPlus_addEnd(Map<String, String> paraMap, ModelAndView mav, BoardVO boardvo) { // <== After Advice를 사용한 후
// ===#170.-2 첨부 파일 추가하기 위에 위의 public ModelAndView pointPlus_addEnd(Map<String, String> paraMap, ModelAndView mav, BoardVO boardvo) 를 주석처리 하고
	// 파라미터에 MultipartHttpServletRequest mrequest를 추가한다.
//	public ModelAndView pointPlus_addEnd(Map<String, String> paraMap, ModelAndView mav, MinutesVO minutesVO, DocVO docVO, MultipartHttpServletRequest mrequest) { // <== After Advice를 사용한 후
		/*
	       form 태그의 name 명과  BoardVO 의 필드명이 같다라면 
	       request.getParameter("form 태그의 name명"); 을 사용하지 않더라도
	           자동적으로 BoardVO boardvo 에 set 되어진다.
	   */
		
		/* === #171. 파일첨부가 된 글쓰기 이므로  
		          먼저 위의  public ModelAndView pointPlus_addEnd(Map<String,String> paraMap, ModelAndView mav, BoardVO boardvo) { 을 
		          주석처리 한 이후에 아래와 같이 한다.
		    MultipartHttpServletRequest mrequest 를 사용하기 위해서는 
		          먼저 /board/src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml 에서     
		    #21 파일업로드 및 파일다운로드에 필요한 의존객체 설정하기 를 해두어야 한다.  
		 
		 */
		/*
	        웹페이지에 요청 form이 enctype="multipart/form-data" 으로 되어있어서 Multipart 요청(파일처리 요청)이 들어올때 
	        컨트롤러에서는 HttpServletRequest 대신 MultipartHttpServletRequest 인터페이스를 사용해야 한다.
	     MultipartHttpServletRequest 인터페이스는 HttpServletRequest 인터페이스와  MultipartRequest 인터페이스를 상속받고있다.
	           즉, 웹 요청 정보를 얻기 위한 getParameter()와 같은 메소드와 Multipart(파일처리) 관련 메소드를 모두 사용가능하다.     
		 */
		
		// === 사용자가 쓴 글에 파일이 첨부되어 있는 것인지,  아니면 파일첨부가 안된 것인지 구분을 지어주어야 한다. ===
		// ===#173. !!! 첨부파일이 있는 경우 작업 시작!!! === 
		
	//	int n = service.add(boardvo); // <== 파일첨부가 없는 글쓰기
		
		// === #176. 파일 첨부가 있는 글쓰기 또는 파일 첨부가 없는 글쓰기로 나뉘어서 service 호출하기 시작==
		// 먼저 위의 int n = service.add(boardvo); 부분을 주석처리하고 아래와 같이 한다.
		
		Map<String, String> docSeq = new HashMap<>();
		
		docSeq = service.getDocSeq();			
		String fk_doc_no = "KD-"+ request.getParameter("fk_doctype_code") + "-" + docSeq.get("doc_noSeq");
		
		docvo.setDoc_no(fk_doc_no);
		
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("docvo", docvo); 
		//기안 종류 코드, 기안자 사원 아이디, 기안문서 제목, 기안문서내용, 서류 작성일자
		

//		docInfoMap.put("doctype_code", doctype_code);
		
		
		paraMap.put("fk_doc_no", fk_doc_no);
		paraMap.put("meeting_date", request.getParameter("meeting_date"));
		paraMap.put("attendees", request.getParameter("attendees"));
		paraMap.put("host_dept", request.getParameter("host_dept"));
		
		paraMap.put("approval_no", docSeq.get("approval_noSeq"));
		paraMap.put("empId1", request.getParameter("level_no_1"));
		paraMap.put("empId2", request.getParameter("level_no_2"));
		paraMap.put("empId3", request.getParameter("level_no_3"));


		int n = 0;
		
		
	//	if(attach.isEmpty()) {
			// 파일첨부가 없는 경우라면
			n = service.noFile_doc(paraMap); // <== 파일첨부가 없는 글쓰기
			
			System.out.println("확인용 n"+n);
//		}
	//	else {
			// 파일첨부가 있는 경우라면
		//	n = service.add_withFile(boardvo);
	//	}
		
	// === 파일첨부가 있는 글쓰기 또는 파일첨부가 없는 글쓰기로 나뉘어서 service 호출하기 끝 === //
		
		if(n==1) {
			mav.setViewName("redirect:/newDocEnd.action");
		    //  /list.action 페이지로 redirect(페이지이동)해라는 말이다.
		}
		else {
			mav.setViewName("board/error/add_error.tiles1");
			//  /WEB-INF/views/tiles1/board/error/add_error.jsp 파일을 생성한다.
		}
		
		// ===== #104. After Advice 를 사용하기 ====== //
		//             글쓰기를 한 이후에는 회원의 포인트를 100점 증가 
	//	paraMap.put("userid", boardvo.getFk_userid());
	//	paraMap.put("point", "100");
		
		return mav;
	}
	
}

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
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.approval.service.ApprovalService;
import com.spring.app.common.FileManager;
import com.spring.app.domain.DeptVO;
import com.spring.app.domain.MemberVO;

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
		
		String doc_type = request.getParameter("doc_type");

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
		
		
		if(doc_type.equals("newdayoff")) {
			mav.setViewName("tiles1/approval/newdayoff.tiles");
		}
		else if(doc_type.equals("newmeeting")){
			
			mav.setViewName("tiles1/approval/newmeeting.tiles");
		}
			
		//	/WEB-INF/views/tiles/tiles1/content/approval/newdoc.jsp 페이지를 만들어야 한다.

		else {
		
			if(doc_type.equals("newdayoff")) {
				mav.setViewName("tiles1/approval/newdayoff.tiles");
			}
			else if(doc_type.equals("newmeeting")){
				
				mav.setViewName("tiles1/approval/newmeeting.tiles");
			}		
		}
		return mav;
	}
	
	
	@PostMapping(value = "/approval/newDocEnd.kedai")
	public ModelAndView newDocEnd(ModelAndView mav) {
		
		
		mav.setViewName("tiles1/approval/newDocEnd.tiles");
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

	/*
	// 스마트에디터 => 드래그앤드롭을 이용한 다중 사진 파일 업로드
	   @PostMapping("/image/multiplePhotoUpload.kedai")
	   public void multiplePhotoUpload(HttpServletRequest request, HttpServletResponse response) {
	      
	      // WAS 의 webapp 의 절대경로 알아오기
	      HttpSession session = request.getSession();
	      String root = session.getServletContext().getRealPath("/"); 
	      // C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\
	      
	      String path = root+"resources"+File.separator+"photo_upload";
	      // C:\NCS\workspace_spring_framework\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\KEDAI\resources\photo_upload
	      
	      File dir = new File(path);
	      
	      if(!dir.exists()) { // 폴더가 없는 경우
	         dir.mkdirs(); // 서브 폴더 만들기
	      }
	      
	      try {
	         String filename = request.getHeader("file-name");
	         // 네이버 스마트에디터를 사용한 파일업로드 시 멀티파일업로드는 파일명이 header 속에 담겨져 넘어오게 되어있다. 
	         
	         InputStream is = request.getInputStream(); 
	         // is 는 네이버 스마트 에디터를 사용하여 사진첨부하기 된 이미지 파일이다.
	         
	         String newFilename = fileManager.doFileUpload(is, filename, path);
	         
	         String ctxPath = request.getContextPath(); //  /KEDAI
	         
	         String strURL = "";
	         strURL += "&bNewLine=true&sFileName="+newFilename; 
	         strURL += "&sFileURL="+ctxPath+"/resources/photo_upload/"+newFilename;
	         
	         // 웹브라우저 상에 사진 이미지를 쓰기
	         PrintWriter out = response.getWriter();
	         out.print(strURL);
	         
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      
	   }
*/
}

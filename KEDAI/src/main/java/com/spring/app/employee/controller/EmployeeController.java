package com.spring.app.employee.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.app.domain.MemberVO;
import com.spring.app.employee.service.EmployeeService;



@Controller
public class EmployeeController {
	
	@Autowired
	private EmployeeService service;
	

	

	//////////////////////////////////////////////////////////////////////////
	// 사원리스트  
	@RequestMapping(value="/employee.kedai") 
	public ModelAndView employeelist_select(
			@RequestParam(required = false) String searchType, 
			@RequestParam(required = false) String searchWord, 
			@RequestParam(required = false, defaultValue="0") Integer pageNumber, 
			@RequestParam(required = false, defaultValue="10") Integer pageSize,
			ModelAndView mav) {
		Pageable pageable = PageRequest.of(pageNumber, pageSize); 
		
		// System.out.println("searchType:" + searchType + ", searchWord: " + searchWord +
		//", pageNumber: " + pageNumber + ", pageSize:" + pageSize);
		
		Page<Map<String,String>> pagedResult = service.employeeList(searchType, searchWord, pageable);
		// System.out.println("page : " + page);
		
//		pagedResult.getTotalPages()
		mav.addObject("pagedResult", pagedResult);
		mav.addObject("employeeList", pagedResult.getContent());
		// mav.addObject("employeeList",employeeList);
		mav.addObject("searchType", searchType);
		mav.addObject("searchWord", searchWord);
		mav.setViewName("tiles1/employee/employee.tiles");
		
		return mav;
	}

	
	
	@ResponseBody
	@GetMapping(value="/employeeDetail.kedai",produces = "text/plain;charset=UTF-8")
	public String employeeDetailJSON(HttpServletRequest request) {
		
		String empid = request.getParameter("empid");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("empid", empid);
		
		List<Map<String, String>> empDetailList = service.empDetailList(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		if(empDetailList != null) {
			for(Map<String, String> map : empDetailList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("empid", map.get("empid"));
				jsonObj.put("name", map.get("name"));
				jsonObj.put("nickname", map.get("nickname"));
				jsonObj.put("mobile", map.get("mobile"));
				jsonObj.put("email", map.get("email"));
				jsonObj.put("postcode", map.get("postcode"));
				jsonObj.put("address", map.get("address"));
				jsonObj.put("detailaddress", map.get("detailaddress"));
				jsonObj.put("extraaddress", map.get("extraaddress"));
				jsonObj.put("imgfilename", map.get("imgfilename"));
				jsonObj.put("orgimgfilename", map.get("orgimgfilename"));
				jsonObj.put("hire_date", map.get("hire_date"));
				jsonObj.put("salary", map.get("salary"));
				jsonObj.put("point", map.get("point"));
				jsonObj.put("fk_dept_code", map.get("fk_dept_code"));
				jsonObj.put("dept_code", map.get("dept_code"));
				jsonObj.put("dept_name", map.get("dept_name"));
				jsonObj.put("fk_job_code", map.get("fk_job_code"));
				jsonObj.put("job_code", map.get("job_code"));
				jsonObj.put("job_name", map.get("job_name"));
				jsonObj.put("dept_tel", map.get("dept_tel"));

				jsonArr.put(jsonObj);
			}// end of for---------------
			
			// System.out.println(jsonArr.toString());
			
		}
		
		return jsonArr.toString();
	}
	
	// 검색어 입력 시 자동글 완성하기
	@ResponseBody
	@GetMapping(value="/employee/wordSearchShowJSON.kedai", produces="text/plain;charset=UTF-8")
	public String wordSearchShowJSON (HttpServletRequest request) {
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		List<String> wordList = service.wordSearchShowJSON(paraMap);
		
		JSONArray jsonArr = new JSONArray(); // []
		
		if(wordList != null) {
			for(String word : wordList) {
				JSONObject jsonObj = new JSONObject();
				
				jsonObj.put("word", word);
				
				jsonArr.put(jsonObj); // [{}, {}, {}]
			} // end of for ----------
		}
		
		return jsonArr.toString();
	}
	
	// ==== #222. (웹채팅관련4) ==== //
	@GetMapping("/chatting/multichat.kedai")
	public String requiredLogin_multichat(HttpServletRequest request, HttpServletResponse response) {
		
		return "multichat";
	}
	
	@ResponseBody
	@GetMapping("/chatting/multichatLoginEmpList.kedai")
	public ModelAndView multichatLogin_EmpList(ModelAndView mav, HttpServletRequest request) {
		
		String login_empid = request.getParameter("loginuser");
		
		Map<String, String> paraMap = new HashMap<>();
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		//paraMap.put("");// 로그인되어있는 직원들의 사진, 이름 직위 부서 가져오면됨.
		
		
		
		
		
		
		
		
		
		return mav;
		
	}
	
}

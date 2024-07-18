package com.spring.app.employee.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
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
	
	@Autowired
	private ObjectMapper objectMapper;
	
	
	//////////////////////////////////////////////////////////////////////////
	// 사원리스트  
	@GetMapping(value="/employee.kedai") 
	public ModelAndView employeelist_select(ModelAndView mav) {
	
		List<Map<String,String>> employeeList = service.employeeList();
		// System.out.println("222employeeList : " + employeeList);
		
		mav.addObject("employeeList", employeeList);
		mav.setViewName("tiles1/employee/employee.tiles");
		
		return mav;
	}
/*
	// 직원 상세보기 팝업 어떤것 클릭했는지 알아오기
	@ResponseBody
	@GetMapping(value="/employeeDetail.kedai",produces = "text/plain;charset=UTF-8")
	public ModelAndView employeeDetail(@RequestParam String empid) throws JsonProcessingException {
		System.out.println("empid : " + empid);
		
		List<Map<String,Object>> empDetail= service.empDetail(empid);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("empDetail",empDetail);
		
		System.out.println("empDetail : " + empDetail);
		mav.setViewName("tiles1/employee/employee.tiles");
		
		return mav;
		
	} // end of public String employeeDetail_select(String empid) throws JsonProcessingException {}------------------------
	*/
	
	
	@ResponseBody
	@GetMapping(value="/employeeDetail.kedai",produces = "text/plain;charset=UTF-8")
	public String employeeDetailJSON(HttpServletRequest request) {
		
		String empid = request.getParameter("empid");
		
		Map<String,Object> paraMap = new HashMap<>();
		paraMap.put("empid", empid);
		
		List<Map<String,Object>> empDetailList = service.empDetailList(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		if(empDetailList != null) {
			for(Map<String,Object> map : empDetailList) {
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
			
			System.out.println(jsonArr.toString());
			
		}
		
		return jsonArr.toString();
	}
}

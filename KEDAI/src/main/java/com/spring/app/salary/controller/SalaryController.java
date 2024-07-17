package com.spring.app.salary.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.app.domain.MemberVO;
import com.spring.app.domain.SalaryVO;
import com.spring.app.member.service.MemberService;
import com.spring.app.reservation.service.RoomService;

@Controller
public class SalaryController {
	
	@Autowired
	private RoomService service;
	
	@GetMapping(value = "/pay_stub.kedai")  // http://localhost:8090/board/pay_stub.action
	public String pay_stub(HttpServletRequest request) {
		
		return "tiles1/pay_stub/pay_stub.tiles";
	}
	
	@GetMapping(value = "/pay_stub_admin.kedai")  // http://localhost:8090/board/pay_stub.action
	public String pay_stub_admin(HttpServletRequest request) {
		
		return "tiles1/pay_stub/pay_stub_admin.tiles";
	}
	
	@GetMapping(value = "/memberView.kedai", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberView(HttpSession session){
		
		List<MemberVO> memberList = service.memberListView();
		
		JSONArray jsonArr = new JSONArray(); //  [] 
		
		if(memberList != null) {
			for(MemberVO vo : memberList) {
				JSONObject jsonObj = new JSONObject();     // {}
				if("2010001-001".equals(vo.getEmpid())) {
					continue;
				}
				 
				jsonObj.put("empid", vo.getEmpid());         
				jsonObj.put("name", vo.getName());         
				jsonObj.put("fk_dept_code", vo.getFk_dept_code());
				jsonObj.put("salary", vo.getSalary());  
				
				jsonArr.put(jsonObj); // [{"no":"101", "name":"이순신", "writeday":"2024-06-11 17:27:09"}]
			}// end of for------------------------
		}
		//	System.out.println(jsonArr.toString());
		return jsonArr.toString(); // "[{"no":"101", "name":"이순신", "writeday":"2024-06-11 17:27:09"}]" 
		                           // 또는 "[]"
		
	}
	
	
	@PostMapping(value = "/salaryCal.kedai", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String salaryCal(@RequestParam("workday") int workday, @RequestParam("empid[]") List<String> empidList, HttpSession session) {
	    if (empidList.isEmpty()) {
	        return "{\"error\": \"No member found in session\"}";
	    }
	    
	    String empid = empidList.get(0); // 여기서는 첫 번째 사원의 empid만 사용하는 예시
	    
	    MemberVO membervo = (MemberVO) session.getAttribute("memberVO_" + empid);
	   
	    SalaryVO salaryvo = new SalaryVO();
	    salaryvo.setFk_empid(membervo.getEmpid());
	    salaryvo.setWork_day(workday);
	    salaryvo.setWork_day_plus(workday);  // 예시로 동일하게 설정
	    salaryvo.setBase_salary(membervo.getSalary());
	    
	    
	    int n = 0;
	    try {

		    System.out.println("Workday: " + salaryvo.getWork_day());
		    System.out.println("EmpID: " + salaryvo.getFk_empid());
		    System.out.println("Salary: " + salaryvo.getBase_salary());
	        n = service.salaryCal(salaryvo);
	    } catch(Throwable e) {
	        e.printStackTrace();
	    }
	    
	    JSONObject jsonObj = new JSONObject(); 
	    jsonObj.put("n", n);
	    jsonObj.put("empid", membervo.getEmpid());
	    jsonObj.put("base_salary", membervo.getSalary());
	    jsonObj.put("work_day", workday);
	    
	    System.out.println(jsonObj.toString());
	    
	    return jsonObj.toString(); 
	}
	
	
}

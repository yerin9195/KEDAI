package com.spring.app.salary.controller;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;

//import java.util.List;

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
import com.spring.app.salary.service.SalaryService;
//import com.spring.app.reservation.service.RoomService2;

@Controller
public class SalaryController {
	
	@Autowired
	private SalaryService service;
	
	@GetMapping(value = "/pay_stub.kedai")
	public String empmanager_pay_stub(HttpServletRequest request) {
		
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
	public String salaryCal(@RequestParam("workday") int workday, 
	                        @RequestParam("empid") List<String> empidList, 
	                        @RequestParam("memberSalary") String memberSalary) {
	    if (empidList == null || empidList.isEmpty()) {
	        return "{\"error\": \"No employee IDs provided\"}";
	    }
	    
	    List<JSONObject> result = new ArrayList<>();
	    for(int i = 0; i < empidList.size(); i++) {
	        SalaryVO salaryvo = new SalaryVO();
	        salaryvo.setFk_empid(empidList.get(i));
	        salaryvo.setWork_day(workday);
	        salaryvo.setWork_day_plus(workday);
	        salaryvo.setBase_salary(memberSalary);

	        int n = 0;
	        try {
	            n = service.salaryCal(salaryvo);
	        } catch(Throwable e) {
	            e.printStackTrace();
	        }
	        
	        JSONObject jsonObj = new JSONObject(); 
	        jsonObj.put("n", n);
	        jsonObj.put("empid", salaryvo.getFk_empid());
	        jsonObj.put("base_salary", salaryvo.getBase_salary());
	        jsonObj.put("work_day", salaryvo.getWork_day());
	        
	        result.add(jsonObj);
	    }
	    return result.toString();
	}

	
	@PostMapping(value = "/getEmployee.kedai", produces = "application/json;charset=UTF-8") 
	@ResponseBody
	public String getEmployee(@RequestParam String empid) {
	    // JSON 객체 생성
	    JSONObject jsonObj = new JSONObject();
	    
	    if (empid != null && !empid.isEmpty()) {
	        // Employee 객체를 데이터베이스에서 가져오기
	        MemberVO employee = service.getEmployeeById(empid);
	    
	        if (employee != null) {
	            jsonObj.put("empid", employee.getEmpid());
	            jsonObj.put("name", employee.getName());
	            jsonObj.put("job_name", employee.getJob_name());
	            jsonObj.put("department_name", employee.getDept_name());
	            jsonObj.put("hire_date", employee.getHire_date());
	        } else {
	            jsonObj.put("error", "Employee not found");
	        }
	    } else {
	        jsonObj.put("error", "Employee ID is missing");
	    }
	    
	    return jsonObj.toString(); // JSON 형식의 문자열 반환
	}
	
	 @PostMapping(value = "/getSalaryDetails.kedai", produces = "application/json;charset=UTF-8")
	    @ResponseBody
	    public String getSalaryDetailsByDate(
	        @RequestParam(name = "yearMonth") String yearMonth, 
	        @RequestParam(name = "empid") String empid) {

	        // JSON 객체 생성
	        JSONObject jsonObj = new JSONObject();
	        
	        if (yearMonth != null && !yearMonth.isEmpty() && empid != null && !empid.isEmpty()) {
	            // 연도와 월 및 직원 ID를 기준으로 데이터베이스에서 가져오기
	            List<SalaryVO> salaryDetailsList = service.getSalaryDetailsById(yearMonth, empid);
	            
	            if (salaryDetailsList != null && !salaryDetailsList.isEmpty()) {
	                // 데이터가 여러 개일 경우, 첫 번째 데이터만 사용하거나 로직에 맞게 조정
	                SalaryVO salaryDetails = salaryDetailsList.get(0);

	                // 숫자 포맷팅을 위한 DecimalFormat 객체 생성
	                DecimalFormat decimalFormat = new DecimalFormat("#,###");

	                // 숫자 문자열로 변환
	                String baseSalary = decimalFormat.format(Double.parseDouble(salaryDetails.getBase_salary()));
	                String mealAllowance = decimalFormat.format(Double.parseDouble(salaryDetails.getMeal_pay()));
	                String annualAllowance = decimalFormat.format(Double.parseDouble(salaryDetails.getAnnual_pay()));
	                String overtimeAllowance = decimalFormat.format(Double.parseDouble(salaryDetails.getOvertime_pay()));

	                // 공제 항목 데이터
	                String incomeTax = decimalFormat.format(Double.parseDouble(salaryDetails.getIncome_tax()));
	                String localIncomeTax = decimalFormat.format(Double.parseDouble(salaryDetails.getLocal_income_tax()));
	                String pension = decimalFormat.format(Double.parseDouble(salaryDetails.getNational_pen()));
	                String healthInsurance = decimalFormat.format(Double.parseDouble(salaryDetails.getHealth_ins()));
	                String employmentInsurance = decimalFormat.format(Double.parseDouble(salaryDetails.getEmployment_ins()));

	                double totalIncome = Double.parseDouble(salaryDetails.getBase_salary()) +
	                                     Double.parseDouble(salaryDetails.getMeal_pay()) +
	                                     Double.parseDouble(salaryDetails.getAnnual_pay()) +
	                                     Double.parseDouble(salaryDetails.getOvertime_pay());
	                double totalDeduction = Double.parseDouble(salaryDetails.getIncome_tax()) +
	                                        Double.parseDouble(salaryDetails.getLocal_income_tax()) +
	                                        Double.parseDouble(salaryDetails.getNational_pen()) +
	                                        Double.parseDouble(salaryDetails.getHealth_ins()) +
	                                        Double.parseDouble(salaryDetails.getEmployment_ins());
	                double netPay = totalIncome - totalDeduction;

	                // 포맷팅된 숫자를 JSON 객체에 추가
	                jsonObj.put("base_salary", baseSalary);
	                jsonObj.put("meal_allowance", mealAllowance);
	                jsonObj.put("annual_allowance", annualAllowance);
	                jsonObj.put("overtime_allowance", overtimeAllowance);

	                jsonObj.put("income_tax", incomeTax);
	                jsonObj.put("local_income_tax", localIncomeTax);
	                jsonObj.put("pension", pension);
	                jsonObj.put("health_insurance", healthInsurance);
	                jsonObj.put("employment_insurance", employmentInsurance);

	                jsonObj.put("total_income", decimalFormat.format(totalIncome));
	                jsonObj.put("total_deduction", decimalFormat.format(totalDeduction));
	                jsonObj.put("net_pay", decimalFormat.format(netPay));
	            } else {
	                jsonObj.put("error", "Salary details not found");
	            }
	        } else {
	            jsonObj.put("error", "Employee ID is missing");
	        }
        
        return jsonObj.toString(); // JSON 형식의 문자열 반환
    }
}
package com.spring.app.employee.service;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.MemberVO;
import com.spring.app.domain.PartnerVO;

public interface EmployeeService {
	
	// 직원정보 가져오기
	List<Map<String, String>> employeeList();
	
	// 클릭한 직원 상세 정보 가져오기
	Map<String, String> empDetail(String empid);
	

	
}

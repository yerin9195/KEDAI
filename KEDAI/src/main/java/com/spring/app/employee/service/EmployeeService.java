package com.spring.app.employee.service;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.MemberVO;
import com.spring.app.domain.PartnerVO;

public interface EmployeeService {
	
	// 직원정보 가져오기
	List<Map<String, String>> employeeList();
	

	// 직원정보 상세보기 팝업 어떤것 클릭했는지 알아오기(직원 아이디로 가져오기)
	MemberVO employeeDetail_select(String empid);

}

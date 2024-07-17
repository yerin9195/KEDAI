package com.spring.app.employee.model;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.MemberVO;
import com.spring.app.domain.PartnerVO;

public interface EmployeeDAO {
	
	
	// 직원 정보 가져오기
	List<Map<String, String>> employeeList();
	
	
	// 직원정보 상세보기 팝업 어떤것 클릭했는지 알아오기(직원 아이디로 가져오기)
	Map<String, String> empDetail(String empid);
	
}

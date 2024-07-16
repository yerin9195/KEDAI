package com.spring.app.employee.model;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.MemberVO;
import com.spring.app.domain.PartnerVO;

public interface EmployeeDAO {
	
	
	
	
	// 직원 정보 가져오기
	List<Map<String, String>> employeeList();
	
	// 직원 상세정ㅂ 가져오기 어떤것 클릭했는지 알아오기
		MemberVO employeeDetail_select(String empid);

}

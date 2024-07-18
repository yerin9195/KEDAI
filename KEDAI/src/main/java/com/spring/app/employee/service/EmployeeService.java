package com.spring.app.employee.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.app.domain.MemberVO;
import com.spring.app.domain.PartnerVO;

public interface EmployeeService {
	
	// 직원정보 가져오기
	//Page<Map<String,String>> employeeList(String searchType, String searchWord, Pageable pageable);
	List<Map<String,String>> employeeList(String searchType, String searchWord);
	// 클릭한 직원 상세 정보 가져오기
	List<Map<String, String>> empDetailList (Map<String, String> paraMap);

	
	
	
	
	

	
}

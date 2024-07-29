package com.spring.app.employee.service;

import java.util.List;

import com.spring.app.domain.MemberVO;
import com.spring.app.domain.PartnerVO;

public interface EmployeeService {
	// 직원정보 가져오기
	List<MemberVO> employee_list_select();


}

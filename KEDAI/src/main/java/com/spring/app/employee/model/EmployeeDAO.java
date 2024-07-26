package com.spring.app.employee.model;

import java.util.List;

import com.spring.app.domain.MemberVO;
import com.spring.app.domain.PartnerVO;

public interface EmployeeDAO {
	
	// 직원 정보 가져오기
	List<MemberVO> employee_list_select();

}

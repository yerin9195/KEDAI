package com.spring.app.employee.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.spring.app.company.service.CompanyService;
import com.spring.app.domain.MemberVO;
import com.spring.app.domain.PartnerVO;

@Repository
public class EmployeeDAO_imple implements EmployeeDAO {
	
	@Autowired
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;
	
	/*
	 * // 직원정보 가져오기
	 * 
	 * @Override public List<MemberVO> employee_list_select() {
	 * 
	 * List<MemberVO> membervoList =
	 * sqlsession.selectList("employee.employee_list_select");
	 * System.out.println("membervoList : " + membervoList);
	 * 
	 * return membervoList; }
	 */
	// 직원 상세보기 가져오기 
	@Override
	public MemberVO employeeDetail_select(String empid) {
		
		MemberVO mvo = sqlsession.selectOne("employee.employeeDetail_select", empid);
		
		
		return mvo;
	}

	@Override
	public List<Map<String, String>> employeeList() {
		// TODO Auto-generated method stub
		return null;
	}


	
	
	
	
}

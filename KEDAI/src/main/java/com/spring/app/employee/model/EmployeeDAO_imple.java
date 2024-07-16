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
	
	// 직원정보 가져오기
	@Override
	public List<Map<String, String>> employeeList() {
		
		List<Map<String, String>> employeeList = sqlsession.selectList("employee.employeeList");
		// System.out.println("111employeeList : " + employeeList);
		return employeeList;
	}
	
	// 직원정보 상세보기 팝업 어떤것 클릭했는지 알아오기(직원 아이디로 가져오기)
	@Override
	public Map<String, String> empDetail(String empid) {
		Map<String, String> empDetail = sqlsession.selectOne("employee.empDetail", empid);
		
		return empDetail;
	}

	
	
	
	
	
	/*
	 * @Override public Map<String, String> empDetail_map(String empid) {
	 * Map<String, String> employeeDetail_select =
	 * sqlsession.selectOne("employee.empDetail_map", empid); return
	 * employeeDetail_select; }
	 */
	
	
	
	

	
	
}

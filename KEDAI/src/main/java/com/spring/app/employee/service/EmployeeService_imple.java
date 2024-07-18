package com.spring.app.employee.service;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.common.AES256;
import com.spring.app.domain.MemberVO;
import com.spring.app.employee.model.EmployeeDAO;
@Service
public class EmployeeService_imple implements EmployeeService{
	
	@Autowired
	private EmployeeDAO dao;
	
	@Autowired
    private AES256 aES256;
	
	
	// 직원정보 가져오기
	@Override
	public List<Map<String, String>> employeeList() {
		
		List<Map<String,String>> employeeList = dao.employeeList();
		
		employeeList.forEach( map -> {
			
			try {			
				map.put("email",(aES256.decrypt(map.get("email"))));   // 복호화되어진 email 을 넣어준다.
				map.put("mobile",(aES256.decrypt(map.get("mobile")))); // 복호화되어진 mobile 을 넣어준다.
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			} 
		});
		
		
		
		return employeeList;
	}

	// 직원정보 상세보기 팝업 어떤것 클릭했는지 알아오기(직원 아이디로 가져오기)
	@Override
	public List<Map<String, Object>> empDetailList (Map<String, Object> paraMap) {
		
		List<Map<String,Object>> empDetailList = dao.empDetailList(paraMap);
		
		return empDetailList;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*
	 * 
	 * // 직원정보 가져오기
	 * 
	 * @Override public List<MemberVO> employee_list_select() { List<MemberVO>
	 * membervoList = dao.employee_list_select();
	 * 
	 * membervoList.forEach(membervo -> { try {
	 * membervo.setEmail(aES256.decrypt(membervo.getEmail())); // 복호화되어진 email 을
	 * 넣어준다. membervo.setMobile(aES256.decrypt(membervo.getMobile())); // 복호화되어진
	 * mobile 을 넣어준다. } catch (UnsupportedEncodingException |
	 * GeneralSecurityException e) { e.printStackTrace(); } });
	 * 
	 * return membervoList; }
	 */





	



















	

	
/*
			try {			
				membervo.setEmail(aES256.decrypt(membervo.getEmail()));   // 복호화되어진 email 을 넣어준다.
				membervo.setMobile(aES256.decrypt(membervo.getMobile())); // 복호화되어진 mobile 을 넣어준다.
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			} 

 */

	
	
	
	
	
	
	
	
	
	
/*
 * // 직원 상세보기 팝업 어떤것 클릭했는지 알아오기
 * 
 * @Override public MemberVO employeeDetail_select(String empid) {
 * 
 * MemberVO mvo = dao.employeeDetail_select(empid);
 * 
 * return mvo; }
 */

	
	
}	
	
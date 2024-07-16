package com.spring.app.employee.service;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;

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
	public List<MemberVO> employee_list_select() {
		List<MemberVO> membervoList = dao.employee_list_select();
		
		membervoList.forEach(membervo -> {
			try {			
				membervo.setEmail(aES256.decrypt(membervo.getEmail()));   // 복호화되어진 email 을 넣어준다.
				membervo.setMobile(aES256.decrypt(membervo.getMobile())); // 복호화되어진 mobile 을 넣어준다.
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			} 
		});
		
		return membervoList;
	}

/*
			try {			
				membervo.setEmail(aES256.decrypt(membervo.getEmail()));   // 복호화되어진 email 을 넣어준다.
				membervo.setMobile(aES256.decrypt(membervo.getMobile())); // 복호화되어진 mobile 을 넣어준다.
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			} 

 */



	
	
	
}	
	
package com.spring.app.employee.service;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

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
	public Page<Map<String,String>> employeeList(String searchType, String searchWord, Pageable pageable) {
		Map<String, String> paraMap = new HashedMap<String, String>();
		if (StringUtils.hasText(searchWord)) {
			paraMap.put("searchType", searchType);
			if ("personal-tel".equals(searchType)) {
				try {
					paraMap.put("searchWord", aES256.encrypt(searchWord.replaceAll("-", "")));
				} catch (UnsupportedEncodingException | GeneralSecurityException e) {
					e.printStackTrace();
				}
			} else {
				paraMap.put("searchWord", searchWord);				
			}
		}
			
		 if (Objects.nonNull(pageable)) { 
		 		paraMap.put("page",
		 		String.valueOf(pageable.getPageNumber() + 1)); 
		 		paraMap.put("size",
		 		String.valueOf(pageable.getPageSize()));
		 }
	
		List<Map<String, String>> employeeList = dao.employeeList(paraMap);
		employeeList.forEach( map -> {
			
			try {			
				map.put("email",(aES256.decrypt(map.get("email"))));   // 복호화되어진 email 을 넣어준다.
				map.put("mobile",(aES256.decrypt(map.get("mobile")))); // 복호화되어진 mobile 을 넣어준다.
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			} 
		});

		Long total = dao.employeeListTotal(paraMap);
		Page<Map<String,String>> page = new PageImpl<Map<String,String>>(employeeList, pageable, total);
										
		return page;
	}
	
	
	/*@Override
	public List<Map<String,String>> employeeList(String searchType, String searchWord) {
		Map<String, String> paraMap = new HashMap<String, String>();
		if (StringUtils.hasText(searchWord)) {
			paraMap.put("searchType", searchType);
			if ("personal-tel".equals(searchType)) {
				try {
					paraMap.put("searchWord", aES256.encrypt(searchWord.replaceAll("-", "")));
				} catch (UnsupportedEncodingException | GeneralSecurityException e) {
					e.printStackTrace();
				}
			} else {
				paraMap.put("searchWord", searchWord);				
			}
		}

		List<Map<String, String>> employeeList = dao.employeeList(paraMap);
		employeeList.forEach( map -> {
			
			try {			
				map.put("email",(aES256.decrypt(map.get("email"))));   // 복호화되어진 email 을 넣어준다.
				map.put("mobile",(aES256.decrypt(map.get("mobile")))); // 복호화되어진 mobile 을 넣어준다.
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			} 
		});

		Long total = dao.employeeList(paraMap);
		// List<Map<String,String>> employeeList = dao.employeeList();
		
		return employeeList;
	}
	
	*/
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// 직원정보 상세보기 팝업 어떤것 클릭했는지 알아오기(직원 아이디로 가져오기)
	@Override
	public List<Map<String, String>> empDetailList (Map<String, String> paraMap) {
		
		List<Map<String, String>> empDetailList = dao.empDetailList(paraMap);
		
		empDetailList.forEach( map -> {
			
			try {			
				map.put("email",(aES256.decrypt(map.get("email"))));   // 복호화되어진 email 을 넣어준다.
				map.put("mobile",(aES256.decrypt(map.get("mobile")))); // 복호화되어진 mobile 을 넣어준다.
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			} 
		});
		
		return empDetailList;
	}
	
}	
	
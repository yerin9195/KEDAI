package com.spring.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.spring.app.admin.model.AdminDAO;
import com.spring.app.domain.DeptVO;
import com.spring.app.domain.JobVO;
import com.spring.app.domain.MemberVO;

@Service
public class AdminService_imple implements AdminService {

	@Autowired
	private AdminDAO dao;

	// 부서 목록 조회하기
	@Override
	public List<DeptVO> dept_select() {
		List<DeptVO> deptList = dao.dept_select();
		return deptList;
	}

	// 직급 목록 조회하기
	@Override
	public List<JobVO> job_select() {
		List<JobVO> jobList = dao.job_select();
		return jobList;
	}

	// 아이디중복확인
	@Override
	public String idDuplicateCheck(String empid) {
		String searchId = dao.idDuplicateCheck(empid);
		return searchId;
	}

	// 이메일중복확인
	@Override
	public String emailDuplicateCheck(String email) {
		String searchEmail = dao.emailDuplicateCheck(email);
		return searchEmail;
	}

	// 사원정보 등록하기
	@Override
	public int empRegister(MemberVO mvo) {		
		int n = dao.empRegister(mvo);
		return n;
	}

	///////////////////////////////////////////////////////////////
	
	// 해당 페이지에 접속한 이후에, 페이지에 접속한 페이지URL, 사용자ID, 접속IP주소, 접속시간을 기록으로 DB에 tbl_empManager_accessTime 테이블에 insert 하기  
	@Override
	public void insert_accessTime(Map<String, String> paraMap) {
		dao.insert_accessTime(paraMap);
	}
	
	// 페이지별 사원 접속통계
	@Override
	public String pageurlEmpname() {
		
		List<Map<String, String>> pageurlEmpnameList = dao.pageurlEmpname();
		
		JsonObject jsonObj = new JsonObject(); // {}
		
		JsonArray categories = new JsonArray(); // [] 
		JsonArray series     = new JsonArray(); // []
		
		Gson gson = new Gson();
		
		for(int i=0; i<pageurlEmpnameList.size(); i++) {
			if(i == 0) {
				categories.add(pageurlEmpnameList.get(i).get("pagename"));
			}
			
			if(i > 0 && !pageurlEmpnameList.get(i-1).get("pagename").equals(pageurlEmpnameList.get(i).get("pagename"))) {
				categories.add(pageurlEmpnameList.get(i).get("pagename"));
			}
			
			JsonObject sub_jsonObj = new JsonObject(); // {}
			sub_jsonObj.addProperty("name", pageurlEmpnameList.get(i).get("name"));
	         
			JsonArray data_jsonArr = new JsonArray(); // []
			data_jsonArr.add(pageurlEmpnameList.get(i).get("cnt"));
			sub_jsonObj.addProperty("data", gson.toJson(data_jsonArr));
	         
			series.add(sub_jsonObj);  
			
		} // end of for ----------
		
		jsonObj.addProperty("categories", gson.toJson(categories));
		jsonObj.addProperty("series", gson.toJson(series));
		
		return gson.toJson(jsonObj);
	}

	

	
	
	
}

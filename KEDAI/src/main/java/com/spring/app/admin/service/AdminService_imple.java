package com.spring.app.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

	
	
	
}

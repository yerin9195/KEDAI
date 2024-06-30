package com.spring.app.admin.service;

import java.util.List;

import com.spring.app.domain.DeptVO;
import com.spring.app.domain.JobVO;
import com.spring.app.domain.MemberVO;

public interface AdminService {

	// 부서 목록 조회하기
	List<DeptVO> dept_select();

	// 직급 목록 조회하기
	List<JobVO> job_select();

	// 아이디중복확인
	String idDuplicateCheck(String empid);

	// 이메일중복확인
	String emailDuplicateCheck(String email);

	// 사원정보 등록하기
	int empRegister(MemberVO mvo);

	


}

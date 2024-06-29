package com.spring.app.admin.service;

import java.util.List;

import com.spring.app.domain.DeptVO;
import com.spring.app.domain.JobVO;

public interface AdminService {

	// 부서 목록 조회하기
	List<DeptVO> dept_select();

	// 직급 목록 조회하기
	List<JobVO> job_select();

}

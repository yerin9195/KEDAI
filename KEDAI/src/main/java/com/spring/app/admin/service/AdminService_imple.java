package com.spring.app.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.admin.model.AdminDAO;
import com.spring.app.domain.DeptVO;
import com.spring.app.domain.JobVO;

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
	
}

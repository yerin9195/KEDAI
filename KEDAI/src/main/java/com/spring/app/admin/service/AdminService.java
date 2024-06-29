package com.spring.app.admin.service;

import java.util.List;

import com.spring.app.domain.DeptVO;

public interface AdminService {

	// 부서 목록 조회하기
	List<DeptVO> dept_select();

}

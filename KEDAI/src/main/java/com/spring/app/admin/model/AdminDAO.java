package com.spring.app.admin.model;

import java.util.List;

import com.spring.app.domain.DeptVO;

public interface AdminDAO {

	// 부서 목록 조회하기
	List<DeptVO> dept_select();

}

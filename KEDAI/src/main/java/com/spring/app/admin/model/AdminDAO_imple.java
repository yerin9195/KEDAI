package com.spring.app.admin.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.DeptVO;

@Repository
public class AdminDAO_imple implements AdminDAO {

	@Autowired
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;

	// 부서 목록 조회하기
	@Override
	public List<DeptVO> dept_select() {
		List<DeptVO> deptList = sqlsession.selectList("admin.dept_select");
		return deptList;
	}
	
}

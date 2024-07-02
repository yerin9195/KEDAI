package com.spring.app.admin.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.DeptVO;
import com.spring.app.domain.JobVO;
import com.spring.app.domain.MemberVO;

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

	// 직급 목록 조회하기
	@Override
	public List<JobVO> job_select() {
		List<JobVO> jobList = sqlsession.selectList("admin.job_select");
		return jobList;
	}

	// 아이디중복확인
	@Override
	public String idDuplicateCheck(String empid) {
		String searchId = sqlsession.selectOne("admin.idDuplicateCheck", empid);
		return searchId;
	}

	// 이메일중복확인
	@Override
	public String emailDuplicateCheck(String email) {
		String searchEmail = sqlsession.selectOne("admin.emailDuplicateCheck", email);
		return searchEmail;
	}

	// 사원정보 등록하기
	@Override
	public int empRegister(MemberVO mvo) {
		System.out.println("~~~~DAO " + mvo.getDept_tel());
		int n = sqlsession.insert("admin.empRegister", mvo);
		
		return n;
	}
	
	
	
	
}

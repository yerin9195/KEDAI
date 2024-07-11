package com.spring.app.member.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.MemberVO;
import com.spring.app.domain.SalaryVO;

@Repository
public class MemberDAO_imple implements MemberDAO {

	@Autowired
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;
	
    @Autowired
    private MemberDAO memberDAO;

	@Override
	public MemberVO getLoginMember(Map<String, String> paraMap) {
		MemberVO loginuser = sqlsession.selectOne("member.getLoginMember", paraMap);
		return loginuser;
	}

	@Override
	public void insert_tbl_loginhistory(Map<String, String> paraMap) {
		sqlsession.insert("member.insert_tbl_loginhistory", paraMap);	
	}

	@Override
	public String idFind(Map<String, String> paraMap) {
		String empId = sqlsession.selectOne("member.idFind", paraMap);
		return empId;
	}

	@Override
	public String pwdFind(Map<String, String> paraMap) {
		String empPwd = sqlsession.selectOne("member.pwdFind", paraMap);
		return empPwd;
	}

	@Override
	public int pwdUpdateEnd(Map<String, String> paraMap) {
		int n = sqlsession.update("member.pwdUpdateEnd", paraMap);
		return n;
	}

	//	급여명세서 직원목록 불러오기
	@Override
	public List<MemberVO> memberListView() {
		List<MemberVO> membervoList = sqlsession.selectList("salary.memberListView");
		return membervoList;
	}

    
	//	급여 전체 계산
	@Override
	public int salaryCal(SalaryVO salaryvo) {
		int n = sqlsession.insert("salary.salaryCal", salaryvo);
		return n;
	} 
	
}

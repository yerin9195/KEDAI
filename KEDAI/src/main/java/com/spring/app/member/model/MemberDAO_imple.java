package com.spring.app.member.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.domain.MemberVO;

@Repository
public class MemberDAO_imple implements MemberDAO {

	@Autowired
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;

	@Override
	public MemberVO getLoginMember(Map<String, String> paraMap) {
		MemberVO loginuser = sqlsession.selectOne("member.getLoginMember", paraMap);
		return loginuser;
	}

	@Override
	public void insert_tbl_loginhistory(Map<String, String> paraMap) {
		sqlsession.insert("member.insert_tbl_loginhistory", paraMap);	
	}

	//	급여명세서 직원목록 불러오기
	@Override
	public List<MemberVO> memberListView() {
		List<MemberVO> membervoList = sqlsession.selectList("salary.memberListView");
		return membervoList;
	} 
	
}

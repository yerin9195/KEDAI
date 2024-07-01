package com.spring.app.member.model;

import java.util.Map;

import com.spring.app.domain.MemberVO;

public interface MemberDAO {

	// 로그인 처리하기
	MemberVO getLoginMember(Map<String, String> paraMap);

	// tbl_loginhistory 테이블에 로그인 기록 입력하기
	void insert_tbl_loginhistory(Map<String, String> paraMap);

	// 아이디 찾기
	String idFind(Map<String, String> paraMap);

}

package com.spring.app.member.model;

import java.util.List;
import java.util.Map;

import com.spring.app.domain.MemberVO;

public interface MemberDAO {

	// 로그인 처리하기
	MemberVO getLoginMember(Map<String, String> paraMap);

	// tbl_loginhistory 테이블에 로그인 기록 입력하기
	void insert_tbl_loginhistory(Map<String, String> paraMap);

	//	급여명세서 직원목록 불러오기
	List<MemberVO> memberListView();
	// 아이디 찾기
	String idFind(Map<String, String> paraMap);

	// 비밀번호 찾기
	String pwdFind(Map<String, String> paraMap);

	// 비밀번호 변경하기
	int pwdUpdateEnd(Map<String, String> paraMap);

}
